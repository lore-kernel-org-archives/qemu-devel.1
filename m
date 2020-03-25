Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125D5C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCAD206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVmJn5G2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCAD206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3jv-0007Hv-Vq
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3iV-0005Zl-DQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3iU-0001Xh-7D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3iU-0001XM-3v
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdAs4D5H6p2LmwnmJAvi/+zpP9bvny/E7lPhY6MUwCc=;
 b=PVmJn5G2jtN/4t/P+gjmczoCYweW+JwrvqFLNiZMsiikrS/l460tAfW61WaptyPmcjnIcf
 hCQNCLYAz6+pwsqY//ZN25sbH/br2CL6Wom4brdjQe0cdl/BzOsS4+YUD4BFvGay6gc2l0
 qac4LzOsosjWORX252XCBTL++K8rZfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-qftK3qVMPDOZ70p3sPp9PQ-1; Wed, 25 Mar 2020 06:56:54 -0400
X-MC-Unique: qftK3qVMPDOZ70p3sPp9PQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0FA81851C37;
 Wed, 25 Mar 2020 10:56:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3D3B5D9C5;
 Wed, 25 Mar 2020 10:56:50 +0000 (UTC)
Message-ID: <27ff4b99b076e90ee7536a9c9063f10201a66096.camel@redhat.com>
Subject: Re: [PATCH v6 29/42] nvme: refactor request bounds checking
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:56:49 +0200
In-Reply-To: <20200316142928.153431-30-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-30-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index eecfad694bf8..ba520c76bae5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -491,6 +491,20 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
>      }
>  }
>  
> +static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
> +                                         uint64_t slba, uint32_t nlb,
> +                                         NvmeRequest *req)
> +{
> +    uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
> +
> +    if (unlikely(UINT64_MAX - slba < nlb || slba + nlb > nsze)) {
> +        trace_nvme_dev_err_invalid_lba_range(slba, nlb, nsze);
> +        return NVME_LBA_RANGE | NVME_DNR;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
Looks good.

> +
>  static void nvme_rw_cb(void *opaque, int ret)
>  {
>      NvmeRequest *req = opaque;
> @@ -536,10 +550,11 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
>      uint64_t offset = slba << data_shift;
>      uint32_t count = nlb << data_shift;
> +    uint16_t status;
>  
> -    if (unlikely(slba + nlb > ns->id_ns.nsze)) {
> -        trace_nvme_dev_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
> -        return NVME_LBA_RANGE | NVME_DNR;
> +    status = nvme_check_bounds(n, ns, slba, nlb, req);
> +    if (status) {
> +        return status;
>      }
>  
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> @@ -562,13 +577,14 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      uint64_t data_offset = slba << data_shift;
>      int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
>      enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> +    uint16_t status;
>  
>      trace_nvme_dev_rw(is_write ? "write" : "read", nlb, data_size, slba);
>  
> -    if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
> +    status = nvme_check_bounds(n, ns, slba, nlb, req);
> +    if (status) {
>          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> -        trace_nvme_dev_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
> -        return NVME_LBA_RANGE | NVME_DNR;
> +        return status;
>      }
>  
>      if (nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req)) {
Looks good as well, once we get support for discard, it will
use this as well, but for now indeed only write zeros and read/write
need bounds checking on the IO path.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky






