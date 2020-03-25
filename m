Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6290C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701B620772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAA9x0+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701B620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3VO-000501-In
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3TN-00023G-QP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3TL-0002XP-8H
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:41:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50525)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3TL-0002X1-15
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3yfDv/wHruiYaBouTn0JiLeSVkSTuoX8Te1eT492Ic=;
 b=RAA9x0+PRQtOykZxRziIG+wKgAsBfmmuf9MX3Xkui4kAbeuVAVqANjEvksNbMDOGb6qWJq
 BGyG4gIcu2TsZxQFi/j7Aaey9Sbz13Gh6LbqSR6+9yYwd3l81RD5aoIB2qU2BmD7oKyEYJ
 WIJF22gW8Fa1zrs2G8rCsM2Skj9Cm4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-WigwnuuIPHWLYbcQ9YzR8A-1; Wed, 25 Mar 2020 06:41:17 -0400
X-MC-Unique: WigwnuuIPHWLYbcQ9YzR8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B7B61005510;
 Wed, 25 Mar 2020 10:41:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B1F05C1A2;
 Wed, 25 Mar 2020 10:41:13 +0000 (UTC)
Message-ID: <20db94c456b684b2b2429c383739b877f7317618.camel@redhat.com>
Subject: Re: [PATCH v6 13/42] nvme: add support for the asynchronous event
 request command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:41:12 +0200
In-Reply-To: <20200316142928.153431-14-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-14-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> Section 5.2 ("Asynchronous Event Request command").
> 
> Mostly imported from Keith's qemu-nvme tree. Modified with a max number
> of queued events (controllable with the aer_max_queued device
> parameter). The spec states that the controller *should* retain
> events, so we do best effort here.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c       | 178 ++++++++++++++++++++++++++++++++++++++++--
>  hw/block/nvme.h       |  14 +++-
>  hw/block/trace-events |   9 +++
>  include/block/nvme.h  |   8 +-
>  4 files changed, 199 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 83ff3fbfb463..ff8975cd6667 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -325,6 +325,85 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
>  }
>  
> +static void nvme_process_aers(void *opaque)
> +{
> +    NvmeCtrl *n = opaque;
> +    NvmeAsyncEvent *event, *next;
> +
> +    trace_nvme_dev_process_aers(n->aer_queued);
> +
> +    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
> +        NvmeRequest *req;
> +        NvmeAerResult *result;
> +
> +        /* can't post cqe if there is nothing to complete */
> +        if (!n->outstanding_aers) {
> +            trace_nvme_dev_no_outstanding_aers();
> +            break;
> +        }
> +
> +        /* ignore if masked (cqe posted, but event not cleared) */
> +        if (n->aer_mask & (1 << event->result.event_type)) {
> +            trace_nvme_dev_aer_masked(event->result.event_type, n->aer_mask);
> +            continue;
> +        }
> +
> +        QTAILQ_REMOVE(&n->aer_queue, event, entry);
> +        n->aer_queued--;
> +
> +        n->aer_mask |= 1 << event->result.event_type;
> +        n->outstanding_aers--;
> +
> +        req = n->aer_reqs[n->outstanding_aers];
> +
> +        result = (NvmeAerResult *) &req->cqe.result;
> +        result->event_type = event->result.event_type;
> +        result->event_info = event->result.event_info;
> +        result->log_page = event->result.log_page;
> +        g_free(event);
> +
> +        req->status = NVME_SUCCESS;
> +
> +        trace_nvme_dev_aer_post_cqe(result->event_type, result->event_info,
> +                                    result->log_page);
> +
> +        nvme_enqueue_req_completion(&n->admin_cq, req);
> +    }
> +}
> +
> +static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
> +                               uint8_t event_info, uint8_t log_page)
> +{
> +    NvmeAsyncEvent *event;
> +
> +    trace_nvme_dev_enqueue_event(event_type, event_info, log_page);
> +
> +    if (n->aer_queued == n->params.aer_max_queued) {
> +        trace_nvme_dev_enqueue_event_noqueue(n->aer_queued);
> +        return;
> +    }
> +
> +    event = g_new(NvmeAsyncEvent, 1);
> +    event->result = (NvmeAerResult) {
> +        .event_type = event_type,
> +        .event_info = event_info,
> +        .log_page   = log_page,
> +    };
> +
> +    QTAILQ_INSERT_TAIL(&n->aer_queue, event, entry);
> +    n->aer_queued++;
> +
> +    nvme_process_aers(n);
> +}
> +
> +static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
> +{
> +    n->aer_mask &= ~(1 << event_type);
> +    if (!QTAILQ_EMPTY(&n->aer_queue)) {
> +        nvme_process_aers(n);
> +    }
> +}
> +
>  static void nvme_rw_cb(void *opaque, int ret)
>  {
>      NvmeRequest *req = opaque;
> @@ -569,8 +648,9 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> -                                uint64_t off, NvmeRequest *req)
> +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> +                                uint32_t buf_len, uint64_t off,
> +                                NvmeRequest *req)
>  {
>      uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> @@ -619,6 +699,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>      smart.power_on_hours[0] =
>          cpu_to_le64((((current_ms - n->starttime_ms) / 1000) / 60) / 60);
>  
> +    if (!rae) {
> +        nvme_clear_events(n, NVME_AER_TYPE_SMART);
> +    }
> +
>      return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
>                               prp2);
>  }
> @@ -643,14 +727,19 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>                               prp2);
>  }
>  
> -static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> -                                uint64_t off, NvmeRequest *req)
> +static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> +                                uint32_t buf_len, uint64_t off,
> +                                NvmeRequest *req)
>  {
>      uint32_t trans_len;
>      uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>      uint8_t errlog[64];
>  
> +    if (!rae) {
> +        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
> +    }
> +
>      if (off > sizeof(errlog)) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> @@ -690,9 +779,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>      switch (lid) {
>      case NVME_LOG_ERROR_INFO:
> -        return nvme_error_info(n, cmd, len, off, req);
> +        return nvme_error_info(n, cmd, rae, len, off, req);
>      case NVME_LOG_SMART_INFO:
> -        return nvme_smart_info(n, cmd, len, off, req);
> +        return nvme_smart_info(n, cmd, rae, len, off, req);
>      case NVME_LOG_FW_SLOT_INFO:
>          return nvme_fw_log_info(n, cmd, len, off, req);
>      default:
> @@ -969,6 +1058,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        result = cpu_to_le32(n->features.async_config);
> +        break;
>      default:
>          trace_nvme_dev_err_invalid_getfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1018,6 +1110,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>              return NVME_INVALID_FIELD | NVME_DNR;
>          }
>  
> +        if (((n->temperature > n->features.temp_thresh_hi) ||
> +            (n->temperature < n->features.temp_thresh_low)) &&
> +            NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPERATURE) {
> +            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
> +                               NVME_AER_INFO_SMART_TEMP_THRESH,
> +                               NVME_LOG_SMART_INFO);
> +        }
> +
>          break;
>      case NVME_VOLATILE_WRITE_CACHE:
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> @@ -1032,6 +1132,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        n->features.async_config = dw11;
> +        break;
>      default:
>          trace_nvme_dev_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1039,6 +1142,25 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> +static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    trace_nvme_dev_aer(nvme_cid(req));
> +
> +    if (n->outstanding_aers > n->params.aerl) {
> +        trace_nvme_dev_aer_aerl_exceeded();
> +        return NVME_AER_LIMIT_EXCEEDED;
> +    }
> +
> +    n->aer_reqs[n->outstanding_aers] = req;
> +    n->outstanding_aers++;
> +
> +    if (!QTAILQ_EMPTY(&n->aer_queue)) {
> +        nvme_process_aers(n);
> +    }
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
>  static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      switch (cmd->opcode) {
> @@ -1060,6 +1182,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_set_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_FEATURES:
>          return nvme_get_feature(n, cmd, req);
> +    case NVME_ADM_CMD_ASYNC_EV_REQ:
> +        return nvme_aer(n, cmd, req);
>      default:
>          trace_nvme_dev_err_invalid_admin_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> @@ -1114,6 +1238,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>          }
>      }
>  
> +    while (!QTAILQ_EMPTY(&n->aer_queue)) {
> +        NvmeAsyncEvent *event = QTAILQ_FIRST(&n->aer_queue);
> +        QTAILQ_REMOVE(&n->aer_queue, event, entry);
> +        g_free(event);
> +    }
> +
> +    n->aer_queued = 0;
> +    n->outstanding_aers = 0;
> +
>      blk_flush(n->conf.blk);
>      n->bar.cc = 0;
>  }
> @@ -1210,6 +1343,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>  
>      nvme_set_timestamp(n, 0ULL);
>  
> +    QTAILQ_INIT(&n->aer_queue);
> +
>      return 0;
>  }
>  
> @@ -1402,6 +1537,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             "completion queue doorbell write"
>                             " for nonexistent queue,"
>                             " sqid=%"PRIu32", ignoring", qid);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                                   NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> +                                   NVME_LOG_ERROR_INFO);
> +            }
> +
>              return;
>          }
>  
> @@ -1412,6 +1554,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             " beyond queue size, sqid=%"PRIu32","
>                             " new_head=%"PRIu16", ignoring",
>                             qid, new_head);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                                   NVME_AER_INFO_ERR_INVALID_DB_VALUE,
> +                                   NVME_LOG_ERROR_INFO);
> +            }
> +
>              return;
>          }
>  
> @@ -1440,6 +1589,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             "submission queue doorbell write"
>                             " for nonexistent queue,"
>                             " sqid=%"PRIu32", ignoring", qid);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                                   NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> +                                   NVME_LOG_ERROR_INFO);
> +            }
> +
>              return;
>          }
>  
> @@ -1450,6 +1606,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             " beyond queue size, sqid=%"PRIu32","
>                             " new_tail=%"PRIu16", ignoring",
>                             qid, new_tail);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                                   NVME_AER_INFO_ERR_INVALID_DB_VALUE,
> +                                   NVME_LOG_ERROR_INFO);
> +            }
> +
>              return;
>          }
>  
> @@ -1553,6 +1716,7 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->temperature = NVME_TEMPERATURE;
>      n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
>      n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
>  }
>  
>  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> @@ -1628,6 +1792,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>       * inconsequential.
>       */
>      id->acl = 3;
> +    id->aerl = n->params.aerl;
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 2;
>  
> @@ -1713,6 +1878,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>      g_free(n->namespaces);
>      g_free(n->cq);
>      g_free(n->sq);
> +    g_free(n->aer_reqs);
>  
>      if (n->params.cmb_size_mb) {
>          g_free(n->cmbuf);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index ebeee2edc4f4..b709a8bb8d40 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -7,17 +7,21 @@
>      DEFINE_PROP_STRING("serial", _state, _props.serial), \
>      DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
>      DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 0), \
> -    DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64)
> +    DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64), \
> +    DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
> +    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, 64)
>  
>  typedef struct NvmeParams {
>      char     *serial;
>      uint32_t num_queues;
>      uint32_t max_ioqpairs;
>      uint32_t cmb_size_mb;
> +    uint8_t  aerl;
> +    uint32_t aer_max_queued;
>  } NvmeParams;
>  
>  typedef struct NvmeAsyncEvent {
> -    QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
> +    QTAILQ_ENTRY(NvmeAsyncEvent) entry;
>      NvmeAerResult result;
>  } NvmeAsyncEvent;
>  
> @@ -104,6 +108,7 @@ typedef struct NvmeCtrl {
>      uint32_t    num_namespaces;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> +    uint8_t     outstanding_aers;
>      uint8_t     *cmbuf;
>      uint64_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
> @@ -111,6 +116,11 @@ typedef struct NvmeCtrl {
>      uint16_t    temperature;
>      uint64_t    starttime_ms;
>  
> +    uint8_t     aer_mask;
> +    NvmeRequest **aer_reqs;
> +    QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
> +    int         aer_queued;
> +
>      NvmeNamespace   *namespaces;
>      NvmeSQueue      **sq;
>      NvmeCQueue      **cq;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 7da088479f39..3952c36774cf 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -47,6 +47,15 @@ nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_
>  nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
>  nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
>  nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
> +nvme_dev_process_aers(int queued) "queued %d"
> +nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
> +nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
> +nvme_dev_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
> +nvme_dev_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +nvme_dev_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +nvme_dev_enqueue_event_noqueue(int queued) "queued %d"
> +nvme_dev_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
> +nvme_dev_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
>  nvme_dev_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_dev_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_dev_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 91fc4738a3e0..f2a8b07c0f2f 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -425,8 +425,8 @@ enum NvmeAsyncEventRequest {
>      NVME_AER_TYPE_SMART                     = 1,
>      NVME_AER_TYPE_IO_SPECIFIC               = 6,
>      NVME_AER_TYPE_VENDOR_SPECIFIC           = 7,
> -    NVME_AER_INFO_ERR_INVALID_SQ            = 0,
> -    NVME_AER_INFO_ERR_INVALID_DB            = 1,
> +    NVME_AER_INFO_ERR_INVALID_DB_REGISTER   = 0,
> +    NVME_AER_INFO_ERR_INVALID_DB_VALUE      = 1,
>      NVME_AER_INFO_ERR_DIAG_FAIL             = 2,
>      NVME_AER_INFO_ERR_PERS_INTERNAL_ERR     = 3,
>      NVME_AER_INFO_ERR_TRANS_INTERNAL_ERR    = 4,
> @@ -717,6 +717,10 @@ typedef struct NvmeFeatureVal {
>  #define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
>  #define NVME_TEMP_TMPTH(temp)  ((temp >>  0) & 0xffff)
>  
> +#define NVME_AEC_SMART(aec)         (aec & 0xff)
> +#define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
> +#define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
> +
>  enum NvmeFeatureIds {
>      NVME_ARBITRATION                = 0x1,
>      NVME_POWER_MANAGEMENT           = 0x2,

Indention issues indeed looks like all fixed,
All other minor changes are OK as well,
So,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky





