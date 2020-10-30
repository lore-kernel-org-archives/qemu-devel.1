Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8AC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72603221FA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoqQQL3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72603221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRQx-0001J2-4S
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYRPA-000803-Dp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYRP8-00042v-2y
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604052784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oY62YoXE9AmVYXPUv6OCCFXKrrPYh7T4yypoLyLnfB8=;
 b=BoqQQL3XXAdzqAiHoTR2bNbs8RYCHMtkYo0mveZp648t3FyZp8e3XS3bon/vXNzflTLVjb
 z6n4Rv0hWjDYQhy/7aA5anc/gEeGZfHR0NL3g21KuK8QQs4t7LMrrJLFU+BioKvjRjuOlu
 rR8M8CgrsUt+SYMr1VYHaQdLu55LD0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-6LK2LX7ZPGqXzuXMsHlK3A-1; Fri, 30 Oct 2020 06:13:02 -0400
X-MC-Unique: 6LK2LX7ZPGqXzuXMsHlK3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2248318B9EDB;
 Fri, 30 Oct 2020 10:13:01 +0000 (UTC)
Received: from redhat.com (ovpn-113-50.ams2.redhat.com [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 299AD5DA2A;
 Fri, 30 Oct 2020 10:12:58 +0000 (UTC)
Date: Fri, 30 Oct 2020 10:12:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 19/36] qdev: Move array property creation/registration to
 separate functions
Message-ID: <20201030101256.GH99222@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-20-ehabkost@redhat.com>
 <CAJ+F1CJmU0G1CJnaj-i1KYCfN_ir+tppcfQESY1xpv50nJAxHg@mail.gmail.com>
 <CAJ+F1C+vhmBOW9u8SspnHa-wgu6+F75PoQHbfJu7btZxKoLi7Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+vhmBOW9u8SspnHa-wgu6+F75PoQHbfJu7btZxKoLi7Q@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 02:10:26PM +0400, Marc-André Lureau wrote:
> On Fri, Oct 30, 2020 at 2:03 PM Marc-André Lureau <
> marcandre.lureau@gmail.com> wrote:
> 
> >
> >
> > On Fri, Oct 30, 2020 at 2:17 AM Eduardo Habkost <ehabkost@redhat.com>
> > wrote:
> >
> >> The array property registration code is hard to follow.  Move the
> >> two steps into separate functions that have clear
> >> responsibilities.
> >>
> >> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >> ---
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Cc: qemu-devel@nongnu.org
> >> ---
> >>  hw/core/qdev-properties.c | 60 ++++++++++++++++++++++++++-------------
> >>  1 file changed, 41 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> >> index 27c09255d7..1f06dfb5d5 100644
> >> --- a/hw/core/qdev-properties.c
> >> +++ b/hw/core/qdev-properties.c
> >> @@ -588,6 +588,32 @@ typedef struct {
> >>      ObjectPropertyRelease *release;
> >>  } ArrayElementProperty;
> >>
> >> +/**
> >> + * Create ArrayElementProperty based on array length property
> >> + * @array_len_prop (which was previously defined using
> >> DEFINE_PROP_ARRAY()).
> >> + */
> >>
> >
> > (some day we will have to clarify our API doc style, but not now ;)
> >
> >
> Actually, I didn't realize but we do use kerneldoc in sphinx nowadays.
> 
> Peter, shouldn't you have updated CODING_STYLE.rst to say explicitly that
> our C API should be documented with it?
> 
> How do we enforce or check the comment style across the code base, or
> per-files (without necessarily including it in the generated manual/doc)?

I'd say we should include it in the generated developer docs, and enforce
whatever level of error checking is availble at build times.

I'll happily update any API docs in code I'm subsys maintainer for, if we
actually generate and validate at build time.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


