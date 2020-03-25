Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF54FC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0E5206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xx86HSFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0E5206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3id-0005Lt-Q6
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3hZ-0004EE-K2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3hX-0000LY-DS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3hX-0000LF-8D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=695n3Z9YstznB3CkFL2iIZwl932CZ2GayYul42m2DVY=;
 b=Xx86HSFIXP+Gv5KwAsAaR3fZOAqvEel70i6+H9G1V2cMB7DE0i5DV43GA7026DJ71Bb/+j
 DDiX1uLAysRGFq0L+2P1kU0gEQi8i0KOJseSYPJo99FiPGZtURE5etaSEn/65SGFa4ZGiG
 lirQyJ2BZzlDxS7CaKK/X1scqCc/7gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-KiCah2XaPtOHTdIh1SyZew-1; Wed, 25 Mar 2020 06:55:57 -0400
X-MC-Unique: KiCah2XaPtOHTdIh1SyZew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8FD9DB20;
 Wed, 25 Mar 2020 10:55:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 606DB5D9C5;
 Wed, 25 Mar 2020 10:55:53 +0000 (UTC)
Message-ID: <8d842c0eae8f8be685d6fe196bc97eb998dc114a.camel@redhat.com>
Subject: Re: [PATCH v6 26/42] nvme: pass request along for tracing
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:55:52 +0200
In-Reply-To: <20200316142928.153431-27-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-27-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
>  hw/block/nvme.c       | 67 +++++++++++++++++++++++++------------------
>  hw/block/trace-events |  2 +-
>  2 files changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 809d00443369..3e9c2ed434c2 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -202,14 +202,18 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
> -                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
> +static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> +                             uint64_t prp1, uint64_t prp2, uint32_t len,
> +                             NvmeRequest *req)
>  {
>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
>      trans_len = MIN(len, trans_len);
>      int num_prps = (len >> n->page_bits) + 1;
>      uint16_t status;
>  
> +    trace_nvme_dev_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
> +                           num_prps);
> +
>      if (unlikely(!prp1)) {
>          trace_nvme_dev_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -300,13 +304,14 @@ unmap:
>  }
>  
>  static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -                             uint64_t prp1, uint64_t prp2, DMADirection dir)
> +                             uint64_t prp1, uint64_t prp2, DMADirection dir,
> +                             NvmeRequest *req)
>  {
>      QEMUSGList qsg;
>      QEMUIOVector iov;
>      uint16_t status = NVME_SUCCESS;
>  
> -    status = nvme_map_prp(&qsg, &iov, prp1, prp2, len, n);
> +    status = nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
>      if (status) {
>          return status;
>      }
> @@ -547,7 +552,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>  
> -    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
> +    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req)) {
>          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> @@ -771,7 +776,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>      }
>  
>      return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, prp2,
> -                        DMA_DIRECTION_FROM_DEVICE);
> +                        DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> @@ -791,7 +796,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>      trans_len = MIN(sizeof(fw_log) - off, buf_len);
>  
>      return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, prp2,
> -                        DMA_DIRECTION_FROM_DEVICE);
> +                        DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> @@ -816,7 +821,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>      trans_len = MIN(sizeof(errlog) - off, buf_len);
>  
>      return nvme_dma_prp(n, errlog, trans_len, prp1, prp2,
> -                        DMA_DIRECTION_FROM_DEVICE);
> +                        DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -952,7 +957,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
> +                                   NvmeRequest *req)
>  {
>      uint64_t prp1 = le64_to_cpu(c->prp1);
>      uint64_t prp2 = le64_to_cpu(c->prp2);
> @@ -960,10 +966,11 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
>      trace_nvme_dev_identify_ctrl();
>  
>      return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
> -                        prp2, DMA_DIRECTION_FROM_DEVICE);
> +                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
> -static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
> +                                 NvmeRequest *req)
>  {
>      NvmeNamespace *ns;
>      uint32_t nsid = le32_to_cpu(c->nsid);
> @@ -980,10 +987,11 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
>      ns = &n->namespaces[nsid - 1];
>  
>      return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
> -                        prp2, DMA_DIRECTION_FROM_DEVICE);
> +                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
> -static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
> +                                     NvmeRequest *req)
>  {
>      static const int data_len = NVME_IDENTIFY_DATA_SIZE;
>      uint32_t min_nsid = le32_to_cpu(c->nsid);
> @@ -1006,12 +1014,13 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>          }
>      }
>      ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
> -                       DMA_DIRECTION_FROM_DEVICE);
> +                       DMA_DIRECTION_FROM_DEVICE, req);
>      g_free(list);
>      return ret;
>  }
>  
> -static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
> +                                            NvmeRequest *req)
>  {
>      uint32_t nsid = le32_to_cpu(c->nsid);
>      uint64_t prp1 = le64_to_cpu(c->prp1);
> @@ -1042,24 +1051,24 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
>      stl_be_p(ns_descr + sizeof(*ns_descr), nsid);
>  
>      ret = nvme_dma_prp(n, (uint8_t *) list, NVME_IDENTIFY_DATA_SIZE, prp1,
> -                       prp2, DMA_DIRECTION_FROM_DEVICE);
> +                       prp2, DMA_DIRECTION_FROM_DEVICE, req);
>      g_free(list);
>      return ret;
>  }
>  
> -static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      NvmeIdentify *c = (NvmeIdentify *)cmd;
>  
>      switch (le32_to_cpu(c->cns)) {
>      case NVME_ID_CNS_NS:
> -        return nvme_identify_ns(n, c);
> +        return nvme_identify_ns(n, c, req);
>      case NVME_ID_CNS_CTRL:
> -        return nvme_identify_ctrl(n, c);
> +        return nvme_identify_ctrl(n, c, req);
>      case NVME_ID_CNS_NS_ACTIVE_LIST:
> -        return nvme_identify_nslist(n, c);
> +        return nvme_identify_nslist(n, c, req);
>      case NVME_ID_CNS_NS_DESCR_LIST:
> -        return nvme_identify_ns_descr_list(n, c);
> +        return nvme_identify_ns_descr_list(n, c, req);
>      default:
>          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1118,7 +1127,8 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
>      return cpu_to_le64(ts.all);
>  }
>  
> -static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> +                                           NvmeRequest *req)
>  {
>      uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> @@ -1126,7 +1136,7 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>      uint64_t timestamp = nvme_get_timestamp(n);
>  
>      return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
> -                        prp2, DMA_DIRECTION_FROM_DEVICE);
> +                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
>  }
>  
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -1178,7 +1188,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          trace_nvme_dev_getfeat_numq(result);
>          break;
>      case NVME_TIMESTAMP:
> -        return nvme_get_feature_timestamp(n, cmd);
> +        return nvme_get_feature_timestamp(n, cmd, req);
>      case NVME_INTERRUPT_COALESCING:
>          result = cpu_to_le32(n->features.int_coalescing);
>          break;
> @@ -1204,7 +1214,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> +                                           NvmeRequest *req)
>  {
>      uint16_t ret;
>      uint64_t timestamp;
> @@ -1212,7 +1223,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>  
>      ret = nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
> -                       prp2, DMA_DIRECTION_TO_DEVICE);
> +                       prp2, DMA_DIRECTION_TO_DEVICE, req);
>      if (ret != NVME_SUCCESS) {
>          return ret;
>      }
> @@ -1283,7 +1294,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>                                        ((n->params.max_ioqpairs - 1) << 16));
>          break;
>      case NVME_TIMESTAMP:
> -        return nvme_set_feature_timestamp(n, cmd);
> +        return nvme_set_feature_timestamp(n, cmd, req);
>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>          n->features.async_config = dw11;
>          break;
> @@ -1334,7 +1345,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      case NVME_ADM_CMD_CREATE_CQ:
>          return nvme_create_cq(n, cmd);
>      case NVME_ADM_CMD_IDENTIFY:
> -        return nvme_identify(n, cmd);
> +        return nvme_identify(n, cmd, req);
>      case NVME_ADM_CMD_ABORT:
>          return nvme_abort(n, cmd, req);
>      case NVME_ADM_CMD_SET_FEATURES:
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index adf11313f956..e31e652fa04e 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -33,7 +33,7 @@ nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
>  nvme_dev_irq_pin(void) "pulsing IRQ pin"
>  nvme_dev_irq_masked(void) "IRQ is masked"
>  nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> -nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1
> 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
> +nvme_dev_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64"
> num_prps %d"
>  nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
>  nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16",
> qflags=%"PRIu16""
>  nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16",
> qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"


Another very easy to review patch

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




