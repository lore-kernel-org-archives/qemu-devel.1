Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A6C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69952206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McRz6+VD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69952206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYSTk-0003VX-6Y
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 07:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYSS5-0002YM-0b
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYSS2-0003dU-1K
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604056809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziR3XALpWw+TcIsZT0WS4Nis8oKHWPGExMFguv5Nllk=;
 b=McRz6+VDgmp9J1vkStSkNphgGgKm+vhB4K7HbbqSn9iwqqnSXjeaYVvQCMZ7G4sj6vh6n2
 HfxUwSsWRJidQ98XRJYxLd5cT+837ZNzjQC34huK2hzDbS8e5ER//Sw5p4ezirkyb/6MUX
 gKcHsJIoRWf/P1/K9sgv43TVYHMa/oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-ONjKRuguN2OOkNy1AY3KFQ-1; Fri, 30 Oct 2020 07:20:07 -0400
X-MC-Unique: ONjKRuguN2OOkNy1AY3KFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3F61007289;
 Fri, 30 Oct 2020 11:20:06 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4F8719656;
 Fri, 30 Oct 2020 11:20:05 +0000 (UTC)
Date: Fri, 30 Oct 2020 07:20:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 19/36] qdev: Move array property creation/registration to
 separate functions
Message-ID: <20201030112005.GO5733@habkost.net>
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-20-ehabkost@redhat.com>
 <CAJ+F1CJmU0G1CJnaj-i1KYCfN_ir+tppcfQESY1xpv50nJAxHg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJmU0G1CJnaj-i1KYCfN_ir+tppcfQESY1xpv50nJAxHg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 02:03:07PM +0400, Marc-André Lureau wrote:
> On Fri, Oct 30, 2020 at 2:17 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > The array property registration code is hard to follow.  Move the
> > two steps into separate functions that have clear
> > responsibilities.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  hw/core/qdev-properties.c | 60 ++++++++++++++++++++++++++-------------
> >  1 file changed, 41 insertions(+), 19 deletions(-)
> >
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index 27c09255d7..1f06dfb5d5 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -588,6 +588,32 @@ typedef struct {
> >      ObjectPropertyRelease *release;
> >  } ArrayElementProperty;
> >
> > +/**
> > + * Create ArrayElementProperty based on array length property
> > + * @array_len_prop (which was previously defined using
> > DEFINE_PROP_ARRAY()).
> > + */
> >
> 
> (some day we will have to clarify our API doc style, but not now ;)

In this specific case, this one was not supposed to be a real doc
comment.  My first version of this commit had a full doc comment,
then I decided it was overkill for an internal static function
and I made it a plain paragraph.  The "/**" and
"@array_len_prop" are leftovers from the old doc comment and I
will remove them if respinning the series.

> 
> +static ArrayElementProperty *array_element_new(Object *obj,

-- 
Eduardo


