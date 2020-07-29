Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FCFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BB52075D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsYI0uRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BB52075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0qHz-0003jT-K2
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0qHI-0002r4-T9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:54:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0qHG-0007zQ-Ly
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596045245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UV86jeIDswDkY1eRWFQhZF59/7LiJqcwv5JZ5aT8NOY=;
 b=WsYI0uRuBrDwML4FMWZb36s6D7+DyztIqWShBG9IaxRNfsHI+FuZnhlNLa2FtdJ5Ggiqcb
 z/t8mHDRSUgWL6d3Xp7dZV8EHUUldfmrupuI4jRYLiKkSyEiIJkEf3Pazdljno+d0G3ca5
 t2ltMVOhpJwCFN5rrEUFvl2ODMjquTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-VZbYaEcvN6Oe--seTJzRvg-1; Wed, 29 Jul 2020 13:54:02 -0400
X-MC-Unique: VZbYaEcvN6Oe--seTJzRvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63F39802B7E;
 Wed, 29 Jul 2020 17:53:49 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC8735DA72;
 Wed, 29 Jul 2020 17:53:41 +0000 (UTC)
Message-ID: <f43637406c06607bb3525b71faf8649f4402b35d.camel@redhat.com>
Subject: Re: [PATCH 13/16] hw/block/nvme: add a namespace reference in
 NvmeRequest
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Date: Wed, 29 Jul 2020 20:53:40 +0300
In-Reply-To: <20200720113748.322965-14-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-14-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:17:30
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Instead of passing around the NvmeNamespace, add it as a member in the
> NvmeRequest structure.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 21 ++++++++++-----------
>  hw/block/nvme.h |  1 +
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 431f26c2f589..54cd20f1ce22 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -211,6 +211,7 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
>  
>  static void nvme_req_clear(NvmeRequest *req)
>  {
> +    req->ns = NULL;
>      memset(&req->cqe, 0x0, sizeof(req->cqe));
>  }
>  
> @@ -610,8 +611,7 @@ static void nvme_rw_cb(void *opaque, int ret)
>      nvme_enqueue_req_completion(cq, req);
>  }
>  
> -static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>           BLOCK_ACCT_FLUSH);
> @@ -620,10 +620,10 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      return NVME_NO_COMPLETE;
>  }
>  
> -static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> +    NvmeNamespace *ns = req->ns;
>      const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
>      const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
>      uint64_t slba = le64_to_cpu(rw->slba);
> @@ -647,10 +647,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      return NVME_NO_COMPLETE;
>  }
>  
> -static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> +    NvmeNamespace *ns = req->ns;
>      uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
>      uint64_t slba = le64_to_cpu(rw->slba);
>  
> @@ -706,7 +706,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>  
>  static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
> -    NvmeNamespace *ns;
>      uint32_t nsid = le32_to_cpu(cmd->nsid);
>  
>      trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req), cmd->opcode);
> @@ -716,15 +715,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return NVME_INVALID_NSID | NVME_DNR;
>      }
>  
> -    ns = &n->namespaces[nsid - 1];
> +    req->ns = &n->namespaces[nsid - 1];
>      switch (cmd->opcode) {
>      case NVME_CMD_FLUSH:
> -        return nvme_flush(n, ns, cmd, req);
> +        return nvme_flush(n, cmd, req);
>      case NVME_CMD_WRITE_ZEROES:
> -        return nvme_write_zeroes(n, ns, cmd, req);
> +        return nvme_write_zeroes(n, cmd, req);
>      case NVME_CMD_WRITE:
>      case NVME_CMD_READ:
> -        return nvme_rw(n, ns, cmd, req);
> +        return nvme_rw(n, cmd, req);
>      default:
>          trace_pci_nvme_err_invalid_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 137cd8c2bf20..586fd3d62700 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -21,6 +21,7 @@ typedef struct NvmeAsyncEvent {
>  
>  typedef struct NvmeRequest {
>      struct NvmeSQueue       *sq;
> +    struct NvmeNamespace    *ns;
>      BlockAIOCB              *aiocb;
>      uint16_t                status;
>      NvmeCqe                 cqe;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


