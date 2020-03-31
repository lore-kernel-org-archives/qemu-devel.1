Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14735C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39FA2078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YriIJjTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39FA2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIC9-0002Jx-0L
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJIB6-0000dm-E9
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJIB5-0006Xl-87
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:47:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJIB5-0006XF-30
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBeic82H6SAvBap9vxuDFo4fPiiyYLB468IXhKm3wvw=;
 b=YriIJjTVViGY8PRlJKxcCcBy3NX6+NWrQpdccfUfapH++uZj0I1FKYC1L1QOdJcn/HJqPM
 wlice2CiDMQT87Uch7bhIBj+vtz/eWtVFvSgEram4AJnkTOG8w/F23nA+L5hm9AIOuOQVI
 dFN9/K4R6wYyGPOGQTHb8gE2mWKR7LQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-T1G_mljjM7uWn1gMmd7UVA-1; Tue, 31 Mar 2020 10:47:38 -0400
X-MC-Unique: T1G_mljjM7uWn1gMmd7UVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91BF2107B11B;
 Tue, 31 Mar 2020 14:47:37 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47DB08EA1A;
 Tue, 31 Mar 2020 14:47:34 +0000 (UTC)
Message-ID: <d0d2b91f321c97d9d029e478a0f9724de738efbd.camel@redhat.com>
Subject: Re: [PATCH v6 12/42] nvme: add support for the get log page command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 17:47:33 +0300
In-Reply-To: <20200331124944.qbyu4qzivdjm5ms2@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-13-its@irrelevant.dk>
 <a7c92a47957a8185a9bd8d7d8b919072d757ff3a.camel@redhat.com>
 <20200331054109.zq6yluixcnpdbust@apples.localdomain>
 <4107ea7ca5b4810d1d5d9e498fbd336a17a57936.camel@redhat.com>
 <20200331124944.qbyu4qzivdjm5ms2@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Tue, 2020-03-31 at 14:49 +0200, Klaus Birkelund Jensen wrote:
> On Mar 31 12:45, Maxim Levitsky wrote:
> > On Tue, 2020-03-31 at 07:41 +0200, Klaus Birkelund Jensen wrote:
> > > On Mar 25 12:40, Maxim Levitsky wrote:
> > > > On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> > > > > From: Klaus Jensen <k.jensen@samsung.com>
> > > > > 
> > > > > Add support for the Get Log Page command and basic implementations of
> > > > > the mandatory Error Information, SMART / Health Information and Firmware
> > > > > Slot Information log pages.
> > > > > 
> > > > > In violation of the specification, the SMART / Health Information log
> > > > > page does not persist information over the lifetime of the controller
> > > > > because the device has no place to store such persistent state.
> > > > > 
> > > > > Note that the LPA field in the Identify Controller data structure
> > > > > intentionally has bit 0 cleared because there is no namespace specific
> > > > > information in the SMART / Health information log page.
> > > > > 
> > > > > Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> > > > > Section 5.10 ("Get Log Page command").
> > > > > 
> > > > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > > > Acked-by: Keith Busch <kbusch@kernel.org>
> > > > > ---
> > > > >  hw/block/nvme.c       | 138 +++++++++++++++++++++++++++++++++++++++++-
> > > > >  hw/block/nvme.h       |  10 +++
> > > > >  hw/block/trace-events |   2 +
> > > > >  3 files changed, 149 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > > > index 64c42101df5c..83ff3fbfb463 100644
> > > > > 
> > > > > +static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> > > > > +                                uint64_t off, NvmeRequest *req)
> > > > > +{
> > > > > +    uint32_t trans_len;
> > > > > +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> > > > > +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> > > > > +    uint8_t errlog[64];
> > > > 
> > > > I'll would replace this with sizeof(NvmeErrorLogEntry)
> > > > (and add NvmeErrorLogEntry to the nvme.h), just for the sake of consistency,
> > > > and in case we end up reporting some errors to the log in the future.
> > > > 
> > > 
> > > NvmeErrorLog is already in nvme.h; Fixed to actually use it.
> > 
> > True that! I'll would rename it to NvmeErrorLogEntry to be honest
> > (in that patch that added many nvme spec changes) but I don't mind
> > keeping it as is as well.
> > 
> 
>  
> It is used in the block driver (block/nvme.c) as well, and I'd rather
> not involved that too much in this series.

All right, this can always be done later.
Best regards,
	Maxim Levitsky
> 



