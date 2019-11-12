Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30019C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3CA2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrOcFgDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3CA2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXpC-0008Cb-48
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXjJ-0000S0-Vd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXjD-0004dM-U6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:17 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:36386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iUXjD-0004d5-Ju
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:11 -0500
Received: by mail-il1-x144.google.com with SMTP id s75so15817088ilc.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WjyYD1AdHtZvox932yIBqDnLxlPN7y1NdAcnU4CEz0U=;
 b=YrOcFgDcptvlYb876LlM0OSAPJ1lMKnBt/QcD5ScQ4BRmNI7sZEd01cykDPn9M2uL2
 wQ+cWJQkEyGc5z2PJTpsDo1JhrggG0ahhp5QQdz9CAgIxgJ34XATDSwiWR32YtloKTdj
 NGsVZ5vNzNNpmf9FCS8KMOOYkfkbl8aEK3MUYqpj72wpJtoH+qLYcCLpULZ0W125xl86
 RwzbsA/5DmYoI7DtceNAWyacsQA4yVHg/2gYtzDCUFjslv1gslxL9hlKnrt5OZjxHOF+
 R+N2daHfC0xIsS2bqNgxzW709BPX9tUcKWm6cRJUNhRq/yE5jOyYma6VvzvhsfT9p4QM
 fP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WjyYD1AdHtZvox932yIBqDnLxlPN7y1NdAcnU4CEz0U=;
 b=pDxvouPtxhAxxZZq2y6nx8xAx7/43e/jAUBUTs8g1TLRXGPHV1+xoMWi5QqPNj2mY8
 aHNbbWUfDM1ii0nb1R6eWxHsX9zN8YxpRQrpAj3Uz9IfubtYEIIPVD9QiK4NS5FQFunb
 xzSlpj57Zg+gB+Y9c9N0C0f7DyCsOckvRkJX9gUkVwV1e3VwkxrYHPuHM1OrcWchD82z
 yi85Q5YScltxHSJgSnvzhWAhybUfipq50QyzEyl1Owp4AQwg1L2Pvg85oi20KrxpQbYq
 gCi3c8+WtBnKIWY7FUGv1N/SDlu41uZ8bO7+FF6sduHe3TszFyMNP6orPyrDCQOtfE6K
 G3rg==
X-Gm-Message-State: APjAAAW6luhcMpG4iU4ZhuzpU2k2EdcHIk8J7S0hYaRtg1NyjmxQJMUD
 GaaCxaWYZ+Y/bkaKKI/Lsyl6yWwlVHDa2Tsgp2tKHA==
X-Google-Smtp-Source: APXvYqx3j6TSXJ8aSVa+Q9Z3FHnzQyu8Pe999mlsSzjcZKDan7cLQbCE8LAWhMQ4JjWnm0X0qKm1IcwQyW3DI1qN5uU=
X-Received: by 2002:a92:4010:: with SMTP id n16mr38640263ila.260.1573571110752; 
 Tue, 12 Nov 2019 07:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-10-its@irrelevant.dk>
In-Reply-To: <20191015103900.313928-10-its@irrelevant.dk>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 12 Nov 2019 15:04:59 +0000
Message-ID: <CADSWDzuzDPZdXUi-3e-TbwDy8GcGZPM78cA0fUU84nOj+y3NCA@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] nvme: add support for the asynchronous event
 request command
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On Tue, 15 Oct 2019 at 11:49, Klaus Jensen <its@irrelevant.dk> wrote:
>
> Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> Section 5.2 ("Asynchronous Event Request command").
>
> Mostly imported from Keith's qemu-nvme tree. Modified to not enqueue
> events if something of the same type is already queued (but not cleared
> by the host).
>
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c       | 180 ++++++++++++++++++++++++++++++++++++++++--
>  hw/block/nvme.h       |  13 ++-
>  hw/block/trace-events |   8 ++
>  include/block/nvme.h  |   4 +-
>  4 files changed, 196 insertions(+), 9 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 4412a3bea3bc..5cdee37582f9 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -334,6 +334,46 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
>  }
>
> +static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
> +    uint8_t event_info, uint8_t log_page)
> +{
> +    NvmeAsyncEvent *event;
> +
> +    trace_nvme_enqueue_event(event_type, event_info, log_page);
> +
> +    /*
> +     * Do not enqueue the event if something of this type is already queued.
> +     * This bounds the size of the event queue and makes sure it does not grow
> +     * indefinitely when events are not processed by the host (i.e. does not
> +     * issue any AERs).
> +     */
> +    if (n->aer_mask_queued & (1 << event_type)) {
> +        trace_nvme_enqueue_event_masked(event_type);
> +        return;
> +    }
> +    n->aer_mask_queued |= (1 << event_type);
> +
> +    event = g_new(NvmeAsyncEvent, 1);
> +    event->result = (NvmeAerResult) {
> +        .event_type = event_type,
> +        .event_info = event_info,
> +        .log_page   = log_page,
> +    };
> +
> +    QTAILQ_INSERT_TAIL(&n->aer_queue, event, entry);
> +
> +    timer_mod(n->aer_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> +}
> +
> +static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
> +{
> +    n->aer_mask &= ~(1 << event_type);
> +    if (!QTAILQ_EMPTY(&n->aer_queue)) {
> +        timer_mod(n->aer_timer,
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> +    }
> +}
> +
>  static void nvme_rw_cb(void *opaque, int ret)
>  {
>      NvmeRequest *req = opaque;
> @@ -578,7 +618,7 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>
> -static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd,
> +static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>      uint32_t buf_len, uint64_t off, NvmeRequest *req)
>  {
>      uint32_t trans_len;
> @@ -591,12 +631,16 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd,
>
>      trans_len = MIN(sizeof(*n->elpes) * (n->params.elpe + 1) - off, buf_len);
>
> +    if (!rae) {
> +        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
> +    }
> +
>      return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, prp1,
>          prp2);
>  }
>
> -static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> -    uint64_t off, NvmeRequest *req)
> +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> +    uint32_t buf_len, uint64_t off, NvmeRequest *req)
>  {
>      uint64_t prp1 = le64_to_cpu(cmd->prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->prp2);
> @@ -646,6 +690,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
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
> @@ -698,9 +746,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
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
> @@ -958,6 +1006,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        result = cpu_to_le32(n->features.async_config);
> +        break;
>      default:
>          trace_nvme_err_invalid_getfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -993,6 +1044,12 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      switch (dw10) {
>      case NVME_TEMPERATURE_THRESHOLD:
>          n->features.temp_thresh = dw11;
> +
> +        if (n->features.temp_thresh <= n->temperature) {
> +            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
> +                NVME_AER_INFO_SMART_TEMP_THRESH, NVME_LOG_SMART_INFO);
> +        }
> +
>          break;
>
>      case NVME_VOLATILE_WRITE_CACHE:
> @@ -1008,6 +1065,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        n->features.async_config = dw11;
> +        break;
>      default:
>          trace_nvme_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1016,6 +1076,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>
> +static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    trace_nvme_aer(req->cid);
> +
> +    if (n->outstanding_aers > n->params.aerl) {
> +        trace_nvme_aer_aerl_exceeded();
> +        return NVME_AER_LIMIT_EXCEEDED;
> +    }
> +
> +    n->aer_reqs[n->outstanding_aers] = req;
> +    timer_mod(n->aer_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> +    n->outstanding_aers++;
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
>  static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      switch (cmd->opcode) {
> @@ -1037,12 +1113,60 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_set_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_FEATURES:
>          return nvme_get_feature(n, cmd, req);
> +    case NVME_ADM_CMD_ASYNC_EV_REQ:
> +        return nvme_aer(n, cmd, req);
>      default:
>          trace_nvme_err_invalid_admin_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
>      }
>  }
>
> +static void nvme_process_aers(void *opaque)
> +{
> +    NvmeCtrl *n = opaque;
> +    NvmeAsyncEvent *event, *next;
> +
> +    trace_nvme_process_aers();
> +
> +    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
> +        NvmeRequest *req;
> +        NvmeAerResult *result;
> +
> +        /* can't post cqe if there is nothing to complete */
> +        if (!n->outstanding_aers) {
> +            trace_nvme_no_outstanding_aers();
> +            break;
> +        }
> +
> +        /* ignore if masked (cqe posted, but event not cleared) */
> +        if (n->aer_mask & (1 << event->result.event_type)) {
> +            trace_nvme_aer_masked(event->result.event_type, n->aer_mask);
> +            continue;
> +        }
> +
> +        QTAILQ_REMOVE(&n->aer_queue, event, entry);
> +
> +        n->aer_mask |= 1 << event->result.event_type;
> +        n->aer_mask_queued &= ~(1 << event->result.event_type);
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
> +        trace_nvme_aer_post_cqe(result->event_type, result->event_info,
> +            result->log_page);
> +
> +        nvme_enqueue_req_completion(&n->admin_cq, req);
> +    }
> +}
> +
>  static void nvme_process_sq(void *opaque)
>  {
>      NvmeSQueue *sq = opaque;
> @@ -1092,6 +1216,20 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>          }
>      }
>
> +    if (n->aer_timer) {
> +        timer_del(n->aer_timer);
> +        timer_free(n->aer_timer);
> +        n->aer_timer = NULL;
> +    }
> +
> +    while (!QTAILQ_EMPTY(&n->aer_queue)) {
> +        NvmeAsyncEvent *event = QTAILQ_FIRST(&n->aer_queue);
> +        QTAILQ_REMOVE(&n->aer_queue, event, entry);
> +        g_free(event);
> +    }
> +
> +    n->outstanding_aers = 0;
> +
>      blk_flush(n->conf.blk);
>      n->bar.cc = 0;
>  }
> @@ -1188,6 +1326,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>
>      nvme_set_timestamp(n, 0ULL);
>
> +    n->aer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_aers, n);
> +    QTAILQ_INIT(&n->aer_queue);
> +

Is the timer really needed here ? The CEQ can be posted either when requested
by host through AER, if there are any pending events, or once the
event is triggered
and there are active AER's.

>      return 0;
>  }
>
> @@ -1380,6 +1521,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
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
This one (as well as cases below) might not be entirely right
according to the spec. If given event is enabled for asynchronous
reporting the controller should retain that even. In this case, the event
will be ignored as there is no pending request.

>              return;
>          }
>
> @@ -1390,6 +1538,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
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
> @@ -1418,6 +1572,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
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
> @@ -1428,6 +1589,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
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
> @@ -1524,6 +1691,7 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>      n->temperature = NVME_TEMPERATURE;
>      n->features.temp_thresh = 0x14d;
> +    n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
>  }
>
>  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> @@ -1591,6 +1759,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      id->ver = cpu_to_le32(0x00010201);
>      id->oacs = cpu_to_le16(0);
>      id->acl = 3;
> +    id->aerl = n->params.aerl;

What about the configuration for the asynchronous events ?

BR

Beata


>      id->frmw = 7 << 1;
>      id->lpa = 1 << 2;
>      id->elpe = n->params.elpe;
> @@ -1678,6 +1847,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>      g_free(n->cq);
>      g_free(n->sq);
>      g_free(n->elpes);
> +    g_free(n->aer_reqs);
>
>      if (n->params.cmb_size_mb) {
>          g_free(n->cmbuf);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index fcfd504e3f9f..3fc36f577b46 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -7,17 +7,19 @@
>      DEFINE_PROP_STRING("serial", _state, _props.serial), \
>      DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
>      DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
> -    DEFINE_PROP_UINT8("elpe", _state, _props.elpe, 24)
> +    DEFINE_PROP_UINT8("elpe", _state, _props.elpe, 24), \
> +    DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3)
>
>  typedef struct NvmeParams {
>      char     *serial;
>      uint32_t num_queues;
>      uint32_t cmb_size_mb;
>      uint8_t  elpe;
> +    uint8_t  aerl;
>  } NvmeParams;
>
>  typedef struct NvmeAsyncEvent {
> -    QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
> +    QTAILQ_ENTRY(NvmeAsyncEvent) entry;
>      NvmeAerResult result;
>  } NvmeAsyncEvent;
>
> @@ -89,6 +91,7 @@ typedef struct NvmeCtrl {
>      uint32_t    num_namespaces;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> +    uint8_t     outstanding_aers;
>      uint32_t    cmbsz;
>      uint32_t    cmbloc;
>      uint8_t     *cmbuf;
> @@ -98,6 +101,12 @@ typedef struct NvmeCtrl {
>      uint64_t    starttime_ms;
>      uint16_t    temperature;
>
> +    QEMUTimer   *aer_timer;
> +    uint8_t     aer_mask;
> +    uint8_t     aer_mask_queued;
> +    NvmeRequest **aer_reqs;
> +    QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
> +
>      NvmeNamespace   *namespaces;
>      NvmeSQueue      **sq;
>      NvmeCQueue      **cq;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index a2c7919c861e..6ddb13d34061 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -47,6 +47,14 @@ nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_coun
>  nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
>  nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
>  nvme_get_log(uint16_t cid, uint16_t lid, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx16" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
> +nvme_process_aers(void) "processing aers"
> +nvme_aer(uint16_t cid) "cid %"PRIu16""
> +nvme_aer_aerl_exceeded(void) "aerl exceeded"
> +nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
> +nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
> +nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
>  nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index a088ec7d4e38..7f1832d531f0 100644
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
> --
> 2.23.0
>
>

