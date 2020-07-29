Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF69C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E1D206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH1Ek5kJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E1D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0jHX-0002Lt-E8
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0jGE-0001Zz-Bq
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:24:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0jGB-0001ar-Kr
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596018269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqrfYWXUO1P/BhbL7xonNC5v0VDRbG83EKDbbPQT5Es=;
 b=UH1Ek5kJEvGXAs8P5WRZkhvQglt3Kz1iEKdoaoXmi909eVuIu5BgBV/P5UFidoqhcJdt00
 a1WPH4zfuLxrw6o2Nim/pG5s46qZHt6NBrwSE8GjIZm4oz2g/PEwwTrc6b5k2F/QKSzOtH
 lcaY54KpAE8j3aFvRHb+YiUPwNLeLEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-tZckU2w_OxipmD1magtZiw-1; Wed, 29 Jul 2020 06:24:27 -0400
X-MC-Unique: tZckU2w_OxipmD1magtZiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2163780183C;
 Wed, 29 Jul 2020 10:24:26 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27D1C60CD1;
 Wed, 29 Jul 2020 10:24:22 +0000 (UTC)
Message-ID: <83668810d0578034fd094623ed39cf4a2bcc9abc.camel@redhat.com>
Subject: Re: [PATCH v3 07/18] hw/block/nvme: add support for the get log
 page command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 29 Jul 2020 13:24:21 +0300
In-Reply-To: <20200706061303.246057-8-its@irrelevant.dk>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-8-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.74; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:09:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add support for the Get Log Page command and basic implementations of
> the mandatory Error Information, SMART / Health Information and Firmware
> Slot Information log pages.
> 
> In violation of the specification, the SMART / Health Information log
> page does not persist information over the lifetime of the controller
> because the device has no place to store such persistent state.
> 
> Note that the LPA field in the Identify Controller data structure
> intentionally has bit 0 cleared because there is no namespace specific
> information in the SMART / Health information log page.
> 
> Required for compliance with NVMe revision 1.3d. See NVM Express 1.3d,
> Section 5.14 ("Get Log Page command").
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c       | 140 +++++++++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |   2 +
>  hw/block/trace-events |   2 +
>  include/block/nvme.h  |   8 ++-
>  4 files changed, 149 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index b6bc75eb61a2..7cb3787638f6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -606,6 +606,140 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>  
> +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> +                                uint64_t off, NvmeRequest *req)
> +{
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> +    uint32_t nsid = le32_to_cpu(cmd->nsid);
> +
> +    uint32_t trans_len;
> +    time_t current_ms;
> +    uint64_t units_read = 0, units_written = 0;
> +    uint64_t read_commands = 0, write_commands = 0;
> +    NvmeSmartLog smart;
> +    BlockAcctStats *s;
> +
> +    if (nsid && nsid != 0xffffffff) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
Correct.
> +
> +    s = blk_get_stats(n->conf.blk);
> +
> +    units_read = s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> +    units_written = s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
> +    read_commands = s->nr_ops[BLOCK_ACCT_READ];
> +    write_commands = s->nr_ops[BLOCK_ACCT_WRITE];
> +
> +    if (off > sizeof(smart)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    trans_len = MIN(sizeof(smart) - off, buf_len);
> +
> +    memset(&smart, 0x0, sizeof(smart));
> +
> +    smart.data_units_read[0] = cpu_to_le64(units_read / 1000);
> +    smart.data_units_written[0] = cpu_to_le64(units_written / 1000);
Tiny nitpick - the spec asks the value to be rounded up

> +    smart.host_read_commands[0] = cpu_to_le64(read_commands);
> +    smart.host_write_commands[0] = cpu_to_le64(write_commands);
> +
> +    smart.temperature = cpu_to_le16(n->temperature);
> +
> +    if ((n->temperature >= n->features.temp_thresh_hi) ||
> +        (n->temperature <= n->features.temp_thresh_low)) {
> +        smart.critical_warning |= NVME_SMART_TEMPERATURE;
> +    }
> +
> +    current_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    smart.power_on_hours[0] =
> +        cpu_to_le64((((current_ms - n->starttime_ms) / 1000) / 60) / 60);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> +                             prp2);
> +}
> +
> +static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> +                                 uint64_t off, NvmeRequest *req)
> +{
> +    uint32_t trans_len;
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> +    NvmeFwSlotInfoLog fw_log = {
> +        .afi = 0x1,
> +    };
> +
> +    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');

I always thought that firmware log can be just zeroed out, but this is correct
now that I checked the spec again.
> +
> +    if (off > sizeof(fw_log)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    trans_len = MIN(sizeof(fw_log) - off, buf_len);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> +                             prp2);
> +}
> +
> +static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> +                                uint64_t off, NvmeRequest *req)
> +{
> +    uint32_t trans_len;
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> +    NvmeErrorLog errlog;
> +
> +    if (off > sizeof(errlog)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    memset(&errlog, 0x0, sizeof(errlog));
> +
> +    trans_len = MIN(sizeof(errlog) - off, buf_len);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2);
Looks good.
> +}
> +
> +static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> +    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> +    uint32_t dw12 = le32_to_cpu(cmd->cdw12);
> +    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
> +    uint8_t  lid = dw10 & 0xff;
> +    uint8_t  lsp = (dw10 >> 8) & 0xf;
> +    uint8_t  rae = (dw10 >> 15) & 0x1;
> +    uint32_t numdl, numdu;
> +    uint64_t off, lpol, lpou;
> +    size_t   len;
> +
Nitpick: don't we want to check NSID=0 || NSID=0xFFFFFFFF here too?

> +    numdl = (dw10 >> 16);
> +    numdu = (dw11 & 0xffff);
> +    lpol = dw12;
> +    lpou = dw13;
> +
> +    len = (((numdu << 16) | numdl) + 1) << 2;
> +    off = (lpou << 32ULL) | lpol;
> +
> +    if (off & 0x3) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
Looks OK
> +
> +    trace_pci_nvme_get_log(nvme_cid(req), lid, lsp, rae, len, off);
> +
> +    switch (lid) {
> +    case NVME_LOG_ERROR_INFO:
> +        return nvme_error_info(n, cmd, len, off, req);
> +    case NVME_LOG_SMART_INFO:
> +        return nvme_smart_info(n, cmd, len, off, req);
> +    case NVME_LOG_FW_SLOT_INFO:
> +        return nvme_fw_log_info(n, cmd, len, off, req);
> +    default:
> +        trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +}
> +
>  static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
>  {
>      n->cq[cq->cqid] = NULL;
> @@ -960,6 +1094,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_del_sq(n, cmd);
>      case NVME_ADM_CMD_CREATE_SQ:
>          return nvme_create_sq(n, cmd);
> +    case NVME_ADM_CMD_GET_LOG_PAGE:
> +        return nvme_get_log(n, cmd, req);
>      case NVME_ADM_CMD_DELETE_CQ:
>          return nvme_del_cq(n, cmd);
>      case NVME_ADM_CMD_CREATE_CQ:
> @@ -1511,7 +1647,9 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>      n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
>      n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> +    n->temperature = NVME_TEMPERATURE;
>      n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
> +    n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>  }
>  
>  static void nvme_init_blk(NvmeCtrl *n, Error **errp)
> @@ -1668,7 +1806,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>       */
>      id->acl = 3;
>      id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
> -    id->lpa = 1 << 0;
> +    id->lpa = NVME_LPA_EXTENDED;
>  
>      /* recommended default value (~70 C) */
>      id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index e3a2c907e210..8228978e93de 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -98,6 +98,8 @@ typedef struct NvmeCtrl {
>      uint32_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
>      uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
> +    uint64_t    starttime_ms;
> +    uint16_t    temperature;
>  
>      HostMemoryBackend *pmrdev;
>  
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index c40c0d2e4b28..3330d74e48db 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -45,6 +45,7 @@ pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
>  pci_nvme_identify_ctrl(void) "identify controller"
>  pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
> +pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
>  pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
> @@ -94,6 +95,7 @@ pci_nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating completi
>  pci_nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=0x%"PRIx16""
>  pci_nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=0x%"PRIx32""
>  pci_nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx32""
> +pci_nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
>  pci_nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
>  pci_nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
>  pci_nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index d639e8bbee92..49ce97ae1ab4 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -704,9 +704,9 @@ typedef struct NvmeErrorLog {
>      uint8_t     resv[35];
>  } NvmeErrorLog;
>  
> -typedef struct NvmeSmartLog {
> +typedef struct QEMU_PACKED NvmeSmartLog {
>      uint8_t     critical_warning;
> -    uint8_t     temperature[2];
> +    uint16_t    temperature;
>      uint8_t     available_spare;
>      uint8_t     available_spare_threshold;
>      uint8_t     percentage_used;
> @@ -846,6 +846,10 @@ enum NvmeIdCtrlFrmw {
>      NVME_FRMW_SLOT1_RO = 1 << 0,
>  };
>  
> +enum NvmeIdCtrlLpa {
> +    NVME_LPA_EXTENDED = 1 << 2,
> +};
> +
>  #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
>  #define NVME_CTRL_SQES_MAX(sqes) (((sqes) >> 4) & 0xf)
>  #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)

Other than few nitpicks that don't matter much,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



