Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B2BC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A402082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMa8/tha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A402082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1pAH-0004jE-NM
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 05:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1p9X-0004D7-8N
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1p9U-00018q-2q
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:21:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1p9T-00017D-MH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581502910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6a0w3GKpPtV+iniPqVZJa4Zy3NmWl2mvjrkaAXLmwg=;
 b=FMa8/thaKbyxqk7k8QGfZFh1iFvQcVS9ZnqTldx44Xb6QgjqusreLvjziYxA3cwDFFLV7z
 URk/5Gu9osjG7xm+bogC3aGXt4maU94XPYvp5hO6YqH9ZYehh5MGTbGNPC02oLBrkWiLSB
 +J/kSJTJh3Zf0bQ6cDjDNAt4rN00SfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-fkhp3AVqM0-LGmaDm6SjxA-1; Wed, 12 Feb 2020 05:21:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64A97800D41;
 Wed, 12 Feb 2020 10:21:40 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89B805C11B;
 Wed, 12 Feb 2020 10:21:37 +0000 (UTC)
Message-ID: <babbabaf9e1f2380cb174ffcd0ecc4fa9d4002c2.camel@redhat.com>
Subject: Re: [PATCH v5 11/26] nvme: add support for the asynchronous event
 request command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 12:21:26 +0200
In-Reply-To: <20200204095208.269131-12-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095222eucas1p2a2351bfc0930b3939927e485f1417e29@eucas1p2.samsung.com>
 <20200204095208.269131-12-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: fkhp3AVqM0-LGmaDm6SjxA-1
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

On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> Section 5.2 ("Asynchronous Event Request command").
> 
> Mostly imported from Keith's qemu-nvme tree. Modified with a max number
> of queued events (controllable with the aer_max_queued device
> parameter). The spec states that the controller *should* retain
> events, so we do best effort here.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c       | 167 +++++++++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |  14 +++-
>  hw/block/trace-events |   9 +++
>  include/block/nvme.h  |   8 +-
>  4 files changed, 191 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 468c36918042..a186d95df020 100644
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
> +            result->log_page);
> +
> +        nvme_enqueue_req_completion(&n->admin_cq, req);
> +    }
> +}
> +
> +static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
> +    uint8_t event_info, uint8_t log_page)
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
> @@ -569,8 +648,8 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> -    uint64_t off, NvmeRequest *req)
> +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> +    uint32_t buf_len, uint64_t off, NvmeRequest *req)
>  {
>      uint64_t prp1 = le64_to_cpu(cmd->prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->prp2);
> @@ -619,6 +698,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>      smart.power_on_hours[0] = cpu_to_le64(
>          (((current_ms - n->starttime_ms) / 1000) / 60) / 60);
>  
> +    if (!rae) {
> +        nvme_clear_events(n, NVME_AER_TYPE_SMART);
> +    }
> +
>      return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
>          prp2);
>  }
> @@ -671,13 +754,17 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>      switch (lid) {
>      case NVME_LOG_ERROR_INFO:
> +        if (!rae) {
> +            nvme_clear_events(n, NVME_AER_TYPE_ERROR);
> +        }
> +
>          if (off) {
>              return NVME_INVALID_FIELD | NVME_DNR;
>          }
>  
>          return NVME_SUCCESS;
>      case NVME_LOG_SMART_INFO:
> -        return nvme_smart_info(n, cmd, len, off, req);
> +        return nvme_smart_info(n, cmd, rae, len, off, req);
>      case NVME_LOG_FW_SLOT_INFO:
>          return nvme_fw_log_info(n, cmd, len, off, req);
>      default:
> @@ -954,6 +1041,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        result = cpu_to_le32(n->features.async_config);
> +        break;
>      default:
>          trace_nvme_dev_err_invalid_getfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1003,6 +1093,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>              return NVME_INVALID_FIELD | NVME_DNR;
>          }
>  
> +        if (((n->temperature > n->features.temp_thresh_hi) ||
> +            (n->temperature < n->features.temp_thresh_low)) &&
> +            NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPERATURE) {
> +            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
> +                NVME_AER_INFO_SMART_TEMP_THRESH, NVME_LOG_SMART_INFO);
> +        }
> +
>          break;
>      case NVME_VOLATILE_WRITE_CACHE:
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> @@ -1016,6 +1113,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        n->features.async_config = dw11;
> +        break;
>      default:
>          trace_nvme_dev_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1024,6 +1124,25 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
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
> @@ -1045,6 +1164,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_set_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_FEATURES:
>          return nvme_get_feature(n, cmd, req);
> +    case NVME_ADM_CMD_ASYNC_EV_REQ:
> +        return nvme_aer(n, cmd, req);
>      default:
>          trace_nvme_dev_err_invalid_admin_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> @@ -1099,6 +1220,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
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
> @@ -1195,6 +1325,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>  
>      nvme_set_timestamp(n, 0ULL);
>  
> +    QTAILQ_INIT(&n->aer_queue);
> +
>      return 0;
>  }
>  
> @@ -1387,6 +1519,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             "completion queue doorbell write"
>                             " for nonexistent queue,"
>                             " sqid=%"PRIu32", ignoring", qid);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> +                    NVME_LOG_ERROR_INFO);
> +            }
> +
>              return;
>          }
>  
> @@ -1397,6 +1536,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             " beyond queue size, sqid=%"PRIu32","
>                             " new_head=%"PRIu16", ignoring",
>                             qid, new_head);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                    NVME_AER_INFO_ERR_INVALID_DB_VALUE, NVME_LOG_ERROR_INFO);
> +            }
> +
>              return;
>          }
>  
> @@ -1425,6 +1570,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             "submission queue doorbell write"
>                             " for nonexistent queue,"
>                             " sqid=%"PRIu32", ignoring", qid);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> +                    NVME_LOG_ERROR_INFO);
> +            }
> +
>              return;
>          }
>  
> @@ -1435,6 +1587,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             " beyond queue size, sqid=%"PRIu32","
>                             " new_tail=%"PRIu16", ignoring",
>                             qid, new_tail);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                    NVME_AER_INFO_ERR_INVALID_DB_VALUE, NVME_LOG_ERROR_INFO);
> +            }
> +
>              return;
>          }
>  
> @@ -1531,6 +1689,7 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->temperature = NVME_TEMPERATURE;
>      n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
>      n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
>  }
>  
>  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> @@ -1610,6 +1769,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>       * inconsequential.
>       */
>      id->acl = 3;
> +    id->aerl = n->params.aerl;
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 2;
>  
> @@ -1700,6 +1860,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>      g_free(n->namespaces);
>      g_free(n->cq);
>      g_free(n->sq);
> +    g_free(n->aer_reqs);
>  
>      if (n->params.cmb_size_mb) {
>          g_free(n->cmbuf);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 89b0aafa02a2..1e715ab1d75c 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -6,16 +6,20 @@
>  #define DEFINE_NVME_PROPERTIES(_state, _props) \
>      DEFINE_PROP_STRING("serial", _state, _props.serial), \
>      DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
> -    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
> +    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
> +    DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
> +    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, 64)
>  
>  typedef struct NvmeParams {
>      char     *serial;
>      uint32_t num_queues;
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
> @@ -102,6 +106,7 @@ typedef struct NvmeCtrl {
>      uint32_t    num_namespaces;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> +    uint8_t     outstanding_aers;
>      uint32_t    cmbsz;
>      uint32_t    cmbloc;
>      uint8_t     *cmbuf;
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
> index 9a6055adeb61..a24be047a311 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -386,8 +386,8 @@ enum NvmeAsyncEventRequest {
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
> @@ -640,6 +640,10 @@ typedef struct NvmeFeatureVal {
>  #define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
>  #define NVME_TEMP_TMPTH(temp)  (temp & 0xffff)
>  
> +#define NVME_AEC_SMART(aec)         (aec & 0xff)
> +#define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
> +#define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
> +
>  enum NvmeFeatureIds {
>      NVME_ARBITRATION                = 0x1,
>      NVME_POWER_MANAGEMENT           = 0x2,


Overall looks very good. This feature is very tricky to
get right due to somewhat unclear spec but after reading the
spec again, it looks OK.

I might have missed something though. I cross checked against my
implementation of this and it looks like I misunderstood the spec
in few places back then in my nvme-mdev implementation.

Reminding to fix all the split code line alignment issues (when C statement is split over to next line it should be aligned on first '('). 
There are plenty of these here.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


