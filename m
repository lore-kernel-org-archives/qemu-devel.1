Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89168C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E71E206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E71E206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9gn-0001DG-9j
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9eI-0005Ve-36
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9eG-0002vQ-To
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:41:17 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9eE-0002tZ-8l; Tue, 31 Mar 2020 01:41:14 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 23B30BF48F;
 Tue, 31 Mar 2020 05:41:13 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:41:09 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 12/42] nvme: add support for the get log page command
Message-ID: <20200331054109.zq6yluixcnpdbust@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-13-its@irrelevant.dk>
 <a7c92a47957a8185a9bd8d7d8b919072d757ff3a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7c92a47957a8185a9bd8d7d8b919072d757ff3a.camel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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

On Mar 25 12:40, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Add support for the Get Log Page command and basic implementations of
> > the mandatory Error Information, SMART / Health Information and Firmware
> > Slot Information log pages.
> > 
> > In violation of the specification, the SMART / Health Information log
> > page does not persist information over the lifetime of the controller
> > because the device has no place to store such persistent state.
> > 
> > Note that the LPA field in the Identify Controller data structure
> > intentionally has bit 0 cleared because there is no namespace specific
> > information in the SMART / Health information log page.
> > 
> > Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> > Section 5.10 ("Get Log Page command").
> > 
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  hw/block/nvme.c       | 138 +++++++++++++++++++++++++++++++++++++++++-
> >  hw/block/nvme.h       |  10 +++
> >  hw/block/trace-events |   2 +
> >  3 files changed, 149 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 64c42101df5c..83ff3fbfb463 100644
> >
> > +static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> > +                                uint64_t off, NvmeRequest *req)
> > +{
> > +    uint32_t trans_len;
> > +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> > +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> > +    uint8_t errlog[64];
> I'll would replace this with sizeof(NvmeErrorLogEntry)
> (and add NvmeErrorLogEntry to the nvme.h), just for the sake of consistency,
> and in case we end up reporting some errors to the log in the future.
> 

NvmeErrorLog is already in nvme.h; Fixed to actually use it.

> 
> > +
> > +    if (off > sizeof(errlog)) {
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> > +    memset(errlog, 0x0, sizeof(errlog));
> > +
> > +    trans_len = MIN(sizeof(errlog) - off, buf_len);
> > +
> > +    return nvme_dma_read_prp(n, errlog, trans_len, prp1, prp2);
> > +}
> Besides this, looks good now.
> 
> 
> Best regards,
> 	Maxim Levitsky
> 


