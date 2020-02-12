Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B8C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5AB20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwBjdQNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5AB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rIv-0000uj-43
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rHA-0007k3-4w
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rH7-0005aA-Ka
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:37:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55177
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1rH7-0005Zc-Dy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581511073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zM4++EqYdSuJpi0pEXspOL6uB2G3Izh3Nlz4D27H1k8=;
 b=MwBjdQNq41srqFLuqGql/RybnrVuXf0YYGQHOgSBQ5ecAxDwZZDg3nHqoDvR783leZWCOb
 DsOtpF0qPACwaU/pgQZC1Rv1tO35acYPSRNu/aIHiH3Iw4yUmQIa64TIZbUNg2d5FwSRFW
 YwZmOzI2N8KH3EQifMg15YJq723wQ5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-XKAn-WwBMjeHJlWokfQ_9Q-1; Wed, 12 Feb 2020 07:37:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E757E13E4;
 Wed, 12 Feb 2020 12:37:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8877B89F1B;
 Wed, 12 Feb 2020 12:37:45 +0000 (UTC)
Message-ID: <b555347878da8997afd2be5154b4d1606d21a92f.camel@redhat.com>
Subject: Re: [PATCH v5 25/26] nvme: remove redundant NvmeCmd pointer parameter
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 14:37:34 +0200
In-Reply-To: <20200204095208.269131-26-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095231eucas1p1f2b78a655b1a217fe4f7006f79e37f86@eucas1p1.samsung.com>
 <20200204095208.269131-26-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: XKAn-WwBMjeHJlWokfQ_9Q-1
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-02-04 at 10:52 +0100, Klaus Jensen wrote:
> The command struct is available in the NvmeRequest that we generally
> pass around anyway.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 198 ++++++++++++++++++++++++------------------------
>  1 file changed, 98 insertions(+), 100 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index bdef53a590b0..5fe2e2fe1fa9 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -566,16 +566,18 @@ unmap:
>  }
>  
>  static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -    NvmeCmd *cmd, DMADirection dir, NvmeRequest *req)
> +    DMADirection dir, NvmeRequest *req)
>  {
>      uint16_t status = NVME_SUCCESS;
>      size_t bytes;
> +    uint64_t prp1, prp2;
>  
> -    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
> +    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
>      case PSDT_PRP:
> -        status = nvme_map_prp(n, &req->qsg, &req->iov,
> -            le64_to_cpu(cmd->dptr.prp.prp1), le64_to_cpu(cmd->dptr.prp.prp2),
> -            len, req);
> +        prp1 = le64_to_cpu(req->cmd.dptr.prp.prp1);
> +        prp2 = le64_to_cpu(req->cmd.dptr.prp.prp2);
> +
> +        status = nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
>          if (status) {
>              return status;
>          }
> @@ -589,7 +591,7 @@ static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>              return NVME_INVALID_FIELD;
>          }
>  
> -        status = nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, len,
> +        status = nvme_map_sgl(n, &req->qsg, &req->iov, req->cmd.dptr.sgl, len,
>              req);
>          if (status) {
>              return status;
> @@ -632,20 +634,21 @@ static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>      return status;
>  }
>  
> -static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_map(NvmeCtrl *n, NvmeRequest *req)
>  {
>      uint32_t len = req->nlb << nvme_ns_lbads(req->ns);
>      uint64_t prp1, prp2;
>  
> -    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
> +    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
>      case PSDT_PRP:
> -        prp1 = le64_to_cpu(cmd->dptr.prp.prp1);
> -        prp2 = le64_to_cpu(cmd->dptr.prp.prp2);
> +        prp1 = le64_to_cpu(req->cmd.dptr.prp.prp1);
> +        prp2 = le64_to_cpu(req->cmd.dptr.prp.prp2);
>  
>          return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
>      case PSDT_SGL_MPTR_CONTIGUOUS:
>      case PSDT_SGL_MPTR_SGL:
> -        return nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, len, req);
> +        return nvme_map_sgl(n, &req->qsg, &req->iov, req->cmd.dptr.sgl, len,
> +            req);
>      default:
>          return NVME_INVALID_FIELD;
>      }
> @@ -1024,7 +1027,7 @@ static void nvme_aio_cb(void *opaque, int ret)
>      nvme_aio_destroy(aio);
>  }
>  
> -static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeNamespace *ns = req->ns;
>      NvmeAIO *aio = g_new0(NvmeAIO, 1);
> @@ -1040,12 +1043,12 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_NO_COMPLETE;
>  }
>  
> -static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeAIO *aio;
>  
>      NvmeNamespace *ns = req->ns;
> -    NvmeRwCmd *rw = (NvmeRwCmd *) cmd;
> +    NvmeRwCmd *rw = (NvmeRwCmd *) &req->cmd;
>  
>      int64_t offset;
>      size_t count;
> @@ -1081,9 +1084,9 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_NO_COMPLETE;
>  }
>  
> -static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    NvmeRwCmd *rw = (NvmeRwCmd *) cmd;
> +    NvmeRwCmd *rw = (NvmeRwCmd *) &req->cmd;
>      NvmeNamespace *ns = req->ns;
>      int status;
>  
> @@ -1103,7 +1106,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return status;
>      }
>  
> -    status = nvme_map(n, cmd, req);
> +    status = nvme_map(n, req);
>      if (status) {
>          block_acct_invalid(blk_get_stats(ns->blk), acct);
>          return status;
> @@ -1115,12 +1118,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_NO_COMPLETE;
>  }
>  
> -static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    uint32_t nsid = le32_to_cpu(cmd->nsid);
> +    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
>  
>      trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid),
> -        cmd->opcode);
> +        req->cmd.opcode);
>  
>      req->ns = nvme_ns(n, nsid);
>  
> @@ -1128,16 +1131,16 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_nsid_err(n, nsid);
>      }
>  
> -    switch (cmd->opcode) {
> +    switch (req->cmd.opcode) {
>      case NVME_CMD_FLUSH:
> -        return nvme_flush(n, cmd, req);
> +        return nvme_flush(n, req);
>      case NVME_CMD_WRITE_ZEROS:
> -        return nvme_write_zeros(n, cmd, req);
> +        return nvme_write_zeros(n, req);
>      case NVME_CMD_WRITE:
>      case NVME_CMD_READ:
> -        return nvme_rw(n, cmd, req);
> +        return nvme_rw(n, req);
>      default:
> -        trace_nvme_dev_err_invalid_opc(cmd->opcode);
> +        trace_nvme_dev_err_invalid_opc(req->cmd.opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
>      }
>  }
> @@ -1153,10 +1156,10 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
>      }
>  }
>  
> -static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    NvmeDeleteQ *c = (NvmeDeleteQ *)cmd;
> -    NvmeRequest *req, *next;
> +    NvmeDeleteQ *c = (NvmeDeleteQ *) &req->cmd;
> +    NvmeRequest *next;
>      NvmeSQueue *sq;
>      NvmeCQueue *cq;
>      NvmeAIO *aio;
> @@ -1224,10 +1227,10 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
>      n->sq[sqid] = sq;
>  }
>  
> -static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeSQueue *sq;
> -    NvmeCreateSq *c = (NvmeCreateSq *)cmd;
> +    NvmeCreateSq *c = (NvmeCreateSq *) &req->cmd;
>  
>      uint16_t cqid = le16_to_cpu(c->cqid);
>      uint16_t sqid = le16_to_cpu(c->sqid);
> @@ -1262,10 +1265,10 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> -    uint32_t buf_len, uint64_t off, NvmeRequest *req)
> +static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
> +    uint64_t off, NvmeRequest *req)
>  {
> -    uint32_t nsid = le32_to_cpu(cmd->nsid);
> +    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
>  
>      uint32_t trans_len;
>      time_t current_ms;
> @@ -1320,12 +1323,12 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>          nvme_clear_events(n, NVME_AER_TYPE_SMART);
>      }
>  
> -    return nvme_dma(n, (uint8_t *) &smart + off, trans_len, cmd,
> +    return nvme_dma(n, (uint8_t *) &smart + off, trans_len,
>          DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
> -static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> -    uint64_t off, NvmeRequest *req)
> +static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
> +    NvmeRequest *req)
>  {
>      uint32_t trans_len;
>      NvmeFwSlotInfoLog fw_log;
> @@ -1338,16 +1341,16 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>  
>      trans_len = MIN(sizeof(fw_log) - off, buf_len);
>  
> -    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len, cmd,
> +    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
>          DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
> -static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> -    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> -    uint32_t dw12 = le32_to_cpu(cmd->cdw12);
> -    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint32_t dw11 = le32_to_cpu(req->cmd.cdw11);
> +    uint32_t dw12 = le32_to_cpu(req->cmd.cdw12);
> +    uint32_t dw13 = le32_to_cpu(req->cmd.cdw13);
>      uint8_t  lid = dw10 & 0xff;
>      uint8_t  lsp = (dw10 >> 8) & 0xf;
>      uint8_t  rae = (dw10 >> 15) & 0x1;
> @@ -1387,9 +1390,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>          return NVME_SUCCESS;
>      case NVME_LOG_SMART_INFO:
> -        return nvme_smart_info(n, cmd, rae, len, off, req);
> +        return nvme_smart_info(n, rae, len, off, req);
>      case NVME_LOG_FW_SLOT_INFO:
> -        return nvme_fw_log_info(n, cmd, len, off, req);
> +        return nvme_fw_log_info(n, len, off, req);
>      default:
>          trace_nvme_dev_err_invalid_log_page(nvme_cid(req), lid);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1407,9 +1410,9 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
>      }
>  }
>  
> -static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    NvmeDeleteQ *c = (NvmeDeleteQ *)cmd;
> +    NvmeDeleteQ *c = (NvmeDeleteQ *) &req->cmd;
>      NvmeCQueue *cq;
>      uint16_t qid = le16_to_cpu(c->qid);
>  
> @@ -1447,10 +1450,10 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
>      cq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
>  }
>  
> -static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeCQueue *cq;
> -    NvmeCreateCq *c = (NvmeCreateCq *)cmd;
> +    NvmeCreateCq *c = (NvmeCreateCq *) &req->cmd;
>      uint16_t cqid = le16_to_cpu(c->cqid);
>      uint16_t vector = le16_to_cpu(c->irq_vector);
>      uint16_t qsize = le16_to_cpu(c->qsize);
> @@ -1489,18 +1492,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
>  {
>      trace_nvme_dev_identify_ctrl();
>  
> -    return nvme_dma(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl), cmd,
> +    return nvme_dma(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl),
>          DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
> -static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeIdNs *id_ns, inactive = { 0 };
> -    uint32_t nsid = le32_to_cpu(cmd->nsid);
> +    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
>      NvmeNamespace *ns = nvme_ns(n, nsid);
>  
>      trace_nvme_dev_identify_ns(nsid);
> @@ -1517,15 +1520,14 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          id_ns = &ns->id_ns;
>      }
>  
> -    return nvme_dma(n, (uint8_t *) id_ns, sizeof(NvmeIdNs), cmd,
> +    return nvme_dma(n, (uint8_t *) id_ns, sizeof(NvmeIdNs),
>          DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
> -static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeRequest *req)
>  {
>      static const int data_len = 4 * KiB;
> -    uint32_t min_nsid = le32_to_cpu(cmd->nsid);
> +    uint32_t min_nsid = le32_to_cpu(req->cmd.nsid);
>      uint32_t *list;
>      uint16_t ret;
>      int i, j = 0;
> @@ -1542,14 +1544,13 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
>              break;
>          }
>      }
> -    ret = nvme_dma(n, (uint8_t *) list, data_len, cmd,
> +    ret = nvme_dma(n, (uint8_t *) list, data_len,
>          DMA_DIRECTION_FROM_DEVICE, req);
>      g_free(list);
>      return ret;
>  }
>  
> -static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
>  {
>      static const int len = 4096;
>  
> @@ -1560,7 +1561,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
>          uint8_t nid[16];
>      };
>  
> -    uint32_t nsid = le32_to_cpu(cmd->nsid);
> +    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
>  
>      struct ns_descr *list;
>      uint16_t ret;
> @@ -1582,34 +1583,33 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
>      list->nidl = 0x10;
>      *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
>  
> -    ret = nvme_dma(n, (uint8_t *) list, len, cmd, DMA_DIRECTION_FROM_DEVICE,
> -        req);
> +    ret = nvme_dma(n, (uint8_t *) list, len, DMA_DIRECTION_FROM_DEVICE, req);
>      g_free(list);
>      return ret;
>  }
>  
> -static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    NvmeIdentify *c = (NvmeIdentify *)cmd;
> +    NvmeIdentify *c = (NvmeIdentify *) &req->cmd;
>  
>      switch (le32_to_cpu(c->cns)) {
>      case 0x00:
> -        return nvme_identify_ns(n, cmd, req);
> +        return nvme_identify_ns(n, req);
>      case 0x01:
> -        return nvme_identify_ctrl(n, cmd, req);
> +        return nvme_identify_ctrl(n, req);
>      case 0x02:
> -        return nvme_identify_ns_list(n, cmd, req);
> +        return nvme_identify_ns_list(n, req);
>      case 0x03:
> -        return nvme_identify_ns_descr_list(n, cmd, req);
> +        return nvme_identify_ns_descr_list(n, req);
>      default:
>          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  }
>  
> -static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    uint16_t sqid = le32_to_cpu(cmd->cdw10) & 0xffff;
> +    uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
>  
>      req->cqe.result = 1;
>      if (nvme_check_sqid(n, sqid)) {
> @@ -1659,19 +1659,18 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
>      return cpu_to_le64(ts.all);
>  }
>  
> -static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
>  {
>      uint64_t timestamp = nvme_get_timestamp(n);
>  
> -    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp), cmd,
> +    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp),
>          DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
> -static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> -    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint32_t dw11 = le32_to_cpu(req->cmd.cdw11);
>      uint32_t result;
>  
>      trace_nvme_dev_getfeat(nvme_cid(req), dw10);
> @@ -1717,7 +1716,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          trace_nvme_dev_getfeat_numq(result);
>          break;
>      case NVME_TIMESTAMP:
> -        return nvme_get_feature_timestamp(n, cmd, req);
> +        return nvme_get_feature_timestamp(n, req);
>      case NVME_INTERRUPT_COALESCING:
>          result = cpu_to_le32(n->features.int_coalescing);
>          break;
> @@ -1743,13 +1742,12 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> -    NvmeRequest *req)
> +static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
>  {
>      uint16_t ret;
>      uint64_t timestamp;
>  
> -    ret = nvme_dma(n, (uint8_t *) &timestamp, sizeof(timestamp), cmd,
> +    ret = nvme_dma(n, (uint8_t *) &timestamp, sizeof(timestamp),
>          DMA_DIRECTION_TO_DEVICE, req);
>      if (ret != NVME_SUCCESS) {
>          return ret;
> @@ -1760,12 +1758,12 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeNamespace *ns;
>  
> -    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> -    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint32_t dw11 = le32_to_cpu(req->cmd.cdw11);
>  
>      trace_nvme_dev_setfeat(nvme_cid(req), dw10, dw11);
>  
> @@ -1824,7 +1822,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>              ((n->params.num_queues - 2) << 16));
>          break;
>      case NVME_TIMESTAMP:
> -        return nvme_set_feature_timestamp(n, cmd, req);
> +        return nvme_set_feature_timestamp(n, req);
>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>          n->features.async_config = dw11;
>          break;
> @@ -1843,7 +1841,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
>  {
>      trace_nvme_dev_aer(nvme_cid(req));
>  
> @@ -1862,31 +1860,31 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_NO_COMPLETE;
>  }
>  
> -static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    switch (cmd->opcode) {
> +    switch (req->cmd.opcode) {
>      case NVME_ADM_CMD_DELETE_SQ:
> -        return nvme_del_sq(n, cmd);
> +        return nvme_del_sq(n, req);
>      case NVME_ADM_CMD_CREATE_SQ:
> -        return nvme_create_sq(n, cmd);
> +        return nvme_create_sq(n, req);
>      case NVME_ADM_CMD_GET_LOG_PAGE:
> -        return nvme_get_log(n, cmd, req);
> +        return nvme_get_log(n, req);
>      case NVME_ADM_CMD_DELETE_CQ:
> -        return nvme_del_cq(n, cmd);
> +        return nvme_del_cq(n, req);
>      case NVME_ADM_CMD_CREATE_CQ:
> -        return nvme_create_cq(n, cmd);
> +        return nvme_create_cq(n, req);
>      case NVME_ADM_CMD_IDENTIFY:
> -        return nvme_identify(n, cmd, req);
> +        return nvme_identify(n, req);
>      case NVME_ADM_CMD_ABORT:
> -        return nvme_abort(n, cmd, req);
> +        return nvme_abort(n, req);
>      case NVME_ADM_CMD_SET_FEATURES:
> -        return nvme_set_feature(n, cmd, req);
> +        return nvme_set_feature(n, req);
>      case NVME_ADM_CMD_GET_FEATURES:
> -        return nvme_get_feature(n, cmd, req);
> +        return nvme_get_feature(n, req);
>      case NVME_ADM_CMD_ASYNC_EV_REQ:
> -        return nvme_aer(n, cmd, req);
> +        return nvme_aer(n, req);
>      default:
> -        trace_nvme_dev_err_invalid_admin_opc(cmd->opcode);
> +        trace_nvme_dev_err_invalid_admin_opc(req->cmd.opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
>      }
>  }
> @@ -1919,8 +1917,8 @@ static void nvme_process_sq(void *opaque)
>          req->cqe.cid = cmd.cid;
>          memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
>  
> -        status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
> -            nvme_admin_cmd(n, &cmd, req);
> +        status = sq->sqid ? nvme_io_cmd(n, req) :
> +            nvme_admin_cmd(n, req);
>          if (status != NVME_NO_COMPLETE) {
>              req->status = status;
>              nvme_enqueue_req_completion(cq, req);

Other that line wrapping issues,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



