Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1B4C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F972072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpaIh53y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F972072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDIS-00036c-Ji
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDF2-00071S-Rf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDF1-0007NA-OK
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:31:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJDF1-0007Mu-Kk
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585647087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhk5XI8LB/TdNnB5g4bRKGIVSbLNlAEUuuHT21wDbTA=;
 b=bpaIh53yEDvnDwaPApwIFmDUfeZ/WubOqB4zVfvY/EO0uwEEOgKTOfgvnTdnnFt0mxE1ex
 RsRFdFtErSxbAWa4GhMGyiLCEA/OAlttrLBgel1i/pfLia0GVlB/CraRWEEEmmjmzLq7ny
 FX145gD2QKLWG+SoSSY1Y7jCA5TCl6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-rJKyQ86DNjmCpTTfmga88g-1; Tue, 31 Mar 2020 05:31:23 -0400
X-MC-Unique: rJKyQ86DNjmCpTTfmga88g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988E88017CC;
 Tue, 31 Mar 2020 09:31:21 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 707AF96F88;
 Tue, 31 Mar 2020 09:31:19 +0000 (UTC)
Message-ID: <82ecfc61d2676ce9abd3c741c3408fa567c20495.camel@redhat.com>
Subject: Re: [PATCH v6 19/42] nvme: enforce valid queue creation sequence
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 12:31:18 +0300
In-Reply-To: <20200331054157.p42lqssgc2c5uurl@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-20-its@irrelevant.dk>
 <250f6a203ee6db8f8f6b7232e555758a0a4be3a4.camel@redhat.com>
 <20200331054157.p42lqssgc2c5uurl@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 07:41 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:43, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Support returning Command Sequence Error if Set Features on Number of
> > > Queues is called after queues have been created.
> > > 
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme.c | 7 +++++++
> > >  hw/block/nvme.h | 1 +
> > >  2 files changed, 8 insertions(+)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 007f8817f101..b40d27cddc46 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -881,6 +881,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
> > >      cq = g_malloc0(sizeof(*cq));
> > >      nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
> > >          NVME_CQ_FLAGS_IEN(qflags));
> > > +
> > > +    n->qs_created = true;
> > 
> > Very minor nitpick, maybe it is worth mentioning in a comment,
> > why this is only needed in CQ creation, as you explained to me.
> > 
> 
> Added.

Thanks a lot!
> 
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 
> > 
> > 
> > 
> 
> 

Best regards,
	Maxim Levitsky


