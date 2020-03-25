Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414B7C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B77C20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgdDhhUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B77C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Gw-0005Fw-6Q
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3E1-0000KV-L2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Dz-0004uY-Hd
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:25:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Dz-0004tS-EP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585131924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRYGAk3e2TP8ZqBzVwrPspeKTJz/CHQ7sqUOx0rRs4U=;
 b=BgdDhhUAEc9G04mIoh7s7fCZ7bKJh9iUwegyJQhzRPAU0jo5Xdq11I6/iiBP19STOi/dQg
 Ci+oBKJas9C1lu3BH3zQeIlnOG59eZltdjWSfOwSVtW7dZOnAUjvFZRL8LuuAeoHWuDHGK
 /bVSRP8rvl8/u7sZkOjfM8mXW8gAW6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-_Zmk6OJ3Mmi_bQ_SDs97pQ-1; Wed, 25 Mar 2020 06:25:23 -0400
X-MC-Unique: _Zmk6OJ3Mmi_bQ_SDs97pQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07CF81922988;
 Wed, 25 Mar 2020 10:25:20 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE5F15C298;
 Wed, 25 Mar 2020 10:25:17 +0000 (UTC)
Message-ID: <e410cdc76bea164cbe3a00b4b9d67ac62c101ef1.camel@redhat.com>
Subject: Re: [PATCH v5 14/26] nvme: make sure ncqr and nsqr is valid
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Wed, 25 Mar 2020 12:25:16 +0200
In-Reply-To: <20200316074801.3ckjre3i7gzn2cdl@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095224eucas1p10807239f5dc4aa809650c85186c426a8@eucas1p1.samsung.com>
 <20200204095208.269131-15-k.jensen@samsung.com>
 <2c5efa159da9d0a5f128ca85374e457134b55f31.camel@redhat.com>
 <20200316074801.3ckjre3i7gzn2cdl@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 00:48 -0700, Klaus Birkelund Jensen wrote:
> On Feb 12 12:30, Maxim Levitsky wrote:
> > On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> > > 0xffff is not an allowed value for NCQR and NSQR in Set Features on
> > > Number of Queues.
> > > 
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 30c5b3e7a67d..900732bb2f38 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -1133,6 +1133,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> > >          break;
> > >      case NVME_NUMBER_OF_QUEUES:
> > > +        if ((dw11 & 0xffff) == 0xffff || ((dw11 >> 16) & 0xffff) == 0xffff) {
> > > +            return NVME_INVALID_FIELD | NVME_DNR;
> > > +        }
> > 
> > Very minor nitpick: since this spec requirement is not obvious, a quote/reference to the spec
> > would be nice to have here. 
> > 
> 
> Added.
Thanks!
> 
> > > +
> > >          trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
> > >              ((dw11 >> 16) & 0xFFFF) + 1, n->params.num_queues - 1,
> > >              n->params.num_queues - 1);
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> 
> 

Best regards,
	Maxim Levitsky





