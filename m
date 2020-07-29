Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2322083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqqC0pYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2322083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0qyU-0001jJ-NS
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 14:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0qvz-0000gY-HA
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 14:36:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0qvx-0005vv-8k
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 14:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596047767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSOB7S00BD11NeCb5AHMg7YQYvymzFC2+tsmAl/IwoI=;
 b=WqqC0pYMWPpEXha0D6cn98m+hQwe3+Wsc0bycExiVMGG/3I7LVY/YP0BYQHI800JQHvmQ4
 oR3G2DHhB5Di21fmNOH5+U6yK+u41kyVTnNP9yc+dHRq3ANkIr2K3XcF8QTs6HA5qxUtJd
 vp5QC2BSfzRunjul+cHfUwEXEsCTc/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-7223JW_KNTW2L5mcSMn3zw-1; Wed, 29 Jul 2020 14:36:05 -0400
X-MC-Unique: 7223JW_KNTW2L5mcSMn3zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78F5E1923763;
 Wed, 29 Jul 2020 18:36:03 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E57C710001B3;
 Wed, 29 Jul 2020 18:36:00 +0000 (UTC)
Message-ID: <47387e8e919876ace9474a5ccc8f315d70c18723.camel@redhat.com>
Subject: Re: [PATCH v3 07/18] hw/block/nvme: add support for the get log
 page command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 29 Jul 2020 21:35:59 +0300
In-Reply-To: <20200729114427.GA159410@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-8-its@irrelevant.dk>
 <83668810d0578034fd094623ed39cf4a2bcc9abc.camel@redhat.com>
 <20200729114427.GA159410@apples.localdomain>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-29 at 13:44 +0200, Klaus Jensen wrote:
> On Jul 29 13:24, Maxim Levitsky wrote:
> > On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Add support for the Get Log Page command and basic implementations of
> > > the mandatory Error Information, SMART / Health Information and Firmware
> > > Slot Information log pages.
> > > 
> > > In violation of the specification, the SMART / Health Information log
> > > page does not persist information over the lifetime of the controller
> > > because the device has no place to store such persistent state.
> > > 
> > > Note that the LPA field in the Identify Controller data structure
> > > intentionally has bit 0 cleared because there is no namespace specific
> > > information in the SMART / Health information log page.
> > > 
> > > Required for compliance with NVMe revision 1.3d. See NVM Express 1.3d,
> > > Section 5.14 ("Get Log Page command").
> > > 
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > Acked-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >  hw/block/nvme.c       | 140 +++++++++++++++++++++++++++++++++++++++++-
> > >  hw/block/nvme.h       |   2 +
> > >  hw/block/trace-events |   2 +
> > >  include/block/nvme.h  |   8 ++-
> > >  4 files changed, 149 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index b6bc75eb61a2..7cb3787638f6 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -606,6 +606,140 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
> > >      return NVME_SUCCESS;
> > >  }
> > >  
> > > +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> > > +                                uint64_t off, NvmeRequest *req)
> > > +{
> > > +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> > > +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> > > +    uint32_t nsid = le32_to_cpu(cmd->nsid);
> > > +
> > > +    uint32_t trans_len;
> > > +    time_t current_ms;
> > > +    uint64_t units_read = 0, units_written = 0;
> > > +    uint64_t read_commands = 0, write_commands = 0;
> > > +    NvmeSmartLog smart;
> > > +    BlockAcctStats *s;
> > > +
> > > +    if (nsid && nsid != 0xffffffff) {
> > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > Correct.
> > > +
> > > +    s = blk_get_stats(n->conf.blk);
> > > +
> > > +    units_read = s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> > > +    units_written = s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
> > > +    read_commands = s->nr_ops[BLOCK_ACCT_READ];
> > > +    write_commands = s->nr_ops[BLOCK_ACCT_WRITE];
> > > +
> > > +    if (off > sizeof(smart)) {
> > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > > +
> > > +    trans_len = MIN(sizeof(smart) - off, buf_len);
> > > +
> > > +    memset(&smart, 0x0, sizeof(smart));
> > > +
> > > +    smart.data_units_read[0] = cpu_to_le64(units_read / 1000);
> > > +    smart.data_units_written[0] = cpu_to_le64(units_written / 1000);
> > Tiny nitpick - the spec asks the value to be rounded up
> > 
> 
> Ouch. You are correct. I'll swap that for a DIV_ROUND_UP.
Not a big deal though as these values don't matter much to anybody since we don't have
way of storing them permanently.

> 
> > > +static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > +{
> > > +    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> > > +    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> > > +    uint32_t dw12 = le32_to_cpu(cmd->cdw12);
> > > +    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
> > > +    uint8_t  lid = dw10 & 0xff;
> > > +    uint8_t  lsp = (dw10 >> 8) & 0xf;
> > > +    uint8_t  rae = (dw10 >> 15) & 0x1;
> > > +    uint32_t numdl, numdu;
> > > +    uint64_t off, lpol, lpou;
> > > +    size_t   len;
> > > +
> > Nitpick: don't we want to check NSID=0 || NSID=0xFFFFFFFF here too?
> > 
> 
> The spec lists Get Log Page with "Yes" under "Namespace Identifier Used"
> but no log pages in v1.3 or v1.4 are namespace specific so we expect
> NSID to always be 0 or 0xffffffff. But, there are TPs that have
> namespace specific log pages (i.e. TP 4053 Zoned Namepaces). So, it is
> not invalid to have NSID set to something.
> 
> So, I think we have to defer handling of NSID values to the individual
> log pages (like we do for the SMART page).
Ah, OK.

> 


Best regards,
	Maxim Levitsky


