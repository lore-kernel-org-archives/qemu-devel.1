Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9FEC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D073C2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFOAmWlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D073C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtyB-0007x8-S9
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kMtuu-0005Kt-4E
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kMtup-0002A8-EK
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:14:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601302446;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mcw5UTFKDFqElU3RM6vRFlJEDwYLMnK7nJc4IXK13g=;
 b=GFOAmWlBjmiMaaPWZhFvN/Yi/fNgHxCInDI5hDZe7V1ZJbYMOhfIePMoyzpxgEmvv4/DSB
 vQG3j+IRvUKD6chCda6khk7EQZLasn5MnrNa5PUfpikRBxpJlMOkM0FM08EeN243JNn9at
 vaUDygTJDLY4FM7dkwTu9/nUDrSrWt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-FvmVHKE9M-un0-BUyRbGcQ-1; Mon, 28 Sep 2020 10:14:02 -0400
X-MC-Unique: FvmVHKE9M-un0-BUyRbGcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CDAF807356;
 Mon, 28 Sep 2020 14:14:00 +0000 (UTC)
Received: from redhat.com (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 214EC5C1BD;
 Mon, 28 Sep 2020 14:13:57 +0000 (UTC)
Date: Mon, 28 Sep 2020 15:13:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David CARLIER <devnexen@gmail.com>
Subject: Re: [PATCH v2 5/8] qemu/bswap: Use compiler __builtin_bswap() on Haiku
Message-ID: <20200928141355.GI2230076@redhat.com>
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-6-philmd@redhat.com>
 <CA+XhMqxdb9Y6HL_0Og4Px5OwdTqK5EKJcnKdafd790nJb8yYEQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+XhMqxdb9Y6HL_0Og4Px5OwdTqK5EKJcnKdafd790nJb8yYEQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Carlo Arenas <carenas@gmail.com>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 03:09:01PM +0100, David CARLIER wrote:
> Unfortunately it breaks the build.

Can you provide details of the errors seen and toolchain versions.

I notice we don't have any CI support for Haiku right now, nor
any recipe in tests/vm/  for enabling users to setup a VM with
Haiku installed. This very much makes Haiku a second class
citizen right now in terms of QEMU's supported platforms, with
no expectation of whether it'll work at any point in time.


> On Mon, 28 Sep 2020 at 14:20, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> >
> > Since commit efc6c070aca ("configure: Add a test for the minimum
> > compiler version") the minimum compiler version required for GCC
> > is 4.8, which supports __builtin_bswap().
> > Remove the Haiku specific ifdef'ry.
> >
> > This reverts commit 652a46ebba970017c7a23767dcc983265cdb8eb7
> > ("bswap.h: Include <endian.h> on Haiku for bswap operations").
> >
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> > Cc: David Carlier <devnexen@gmail.com>
> > Cc: Carlo Arenas <carenas@gmail.com>
> > ---
> >  include/qemu/bswap.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > index 55916670d39..719d620bfe6 100644
> > --- a/include/qemu/bswap.h
> > +++ b/include/qemu/bswap.h
> > @@ -8,8 +8,6 @@
> >  # include <machine/bswap.h>
> >  #elif defined(__FreeBSD__)
> >  # include <sys/endian.h>
> > -#elif defined(__HAIKU__)
> > -# include <endian.h>
> >  #else
> >  #undef  bswap16
> >  #define bswap16(_x) __builtin_bswap16(_x)
> > --
> > 2.26.2
> >
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


