Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04205C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3A020578
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="OZ+7VCXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3A020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsBL-0004U7-T1
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDsAW-00037j-QJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:33:00 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDsAU-000356-9z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=pILq5udIKjxltpvsYkqscsfykS6P7zuC40+ssEQ1sWY=; b=OZ+7VCXJqa7woaoMW5fY+H2e4u
 wa17w+EQrsKruOq+gXtDupwyj1iCUKpQvqc60DVCfJzH0U+GETI2BL9OTqoNKU5NpOodwifIAUqxx
 lNe6jzWrlQYXoLvRQoVBzKugbV6pCWu1Pi7JNi067sxD3dPIgtitslWM3UtJrAWdd/VGmV0SyoKxZ
 lhf/guC82QRbQzPv4tzEZy0tyC5UWQWz8Cl7PrRQm11s/oHaDYMv83Lc1C97ZbykbQYTAewbljdwC
 jcNHkQPDtykFhar3OiUvx0D/Pe0+smGPULXPJs/DRSdvsiCgYlvFlN9FcLLFyYNAZPMgXddU/7jvo
 BqHT+kzQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, berrange@redhat.com
Subject: Re: [PATCH v2 1/1] 9pfs: log warning if msize <= 8192
Date: Thu, 03 Sep 2020 18:32:54 +0200
Message-ID: <2515823.gX3yQePTrF@silver>
In-Reply-To: <20200903180248.6199bb7b@bahia.lan>
References: <cover.1599144062.git.qemu_oss@crudebyte.com>
 <e6fc84845c95816ad5baecb0abd6bfefdcf7ec9f.1599144062.git.qemu_oss@crudebyte.com>
 <20200903180248.6199bb7b@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 10:59:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 3. September 2020 18:02:48 CEST Greg Kurz wrote:
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 7bb994bbf2..99b6f24fd6 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1353,6 +1353,15 @@ static void coroutine_fn v9fs_version(void *opaque)
> > 
> >          goto out;
> >      
> >      }
> > 
> > +    /* 8192 is the default msize of Linux clients */
> > +    if (s->msize <= 8192) {
> 
> I agree that an msize of 8192 suck from a performance standpoint but
> I guess many users are msize agnostic, and they use the default value
> without even knowing it. They might not even care for performance at
> all, otherwise they'd likely ask google and they will eventually land
> on:
> 
> https://wiki.qemu.org/Documentation/9psetup#Performance_Considerations
> 
> But with this patch, they will now get a warning each time they start
> QEMU, maybe freak out and file reports in launchpad. So I suggest you
> turn <= into < to avoid bothering these placid users with a warning.

Mmm, that's actually precisely my intended target group: people who have never 
been aware about the existence of 'msize' before.

I keep '<=' for now, I think the log message is already clear that you simply 
have to make it any 'msize' > 8192 and the warning is gone.

> Anyway, it's your choice :) so if you manage to get the #msize anchor to
> work as expected:

Works now (using raw html anchor instead):
https://wiki.qemu.org/Documentation/9psetup#msize

> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks Greg!

> > +        warn_report_once(
> > +            "9p: degraded performance: a reasonable high msize should be
> > "
> > +            "chosen on client/guest side (chosen msize is <= 8192). See "
> > +            "https://wiki.qemu.org/Documentation/9psetup#msize for
> > details." +        );
> > +    }
> > +
> > 
> >  marshal:
> >      err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
> >      if (err < 0) {

Best regards,
Christian Schoenebeck



