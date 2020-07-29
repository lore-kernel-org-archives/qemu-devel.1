Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1898C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D27D207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAMir9cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D27D207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0jZo-0001ww-LU
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0jYc-0000p6-Vh
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:43:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0jYW-0004F3-EJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596019406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhEi8faKBJjenOK3qNUgTy6liiIwJ4jGmQDIcXrmKBE=;
 b=UAMir9cpcpV0Qh8loTJrQMxbE/6Nsg1Yb59w6joVmLKleqPNKsuPAlV8oLcujx/x27umvX
 kaXPzTogkGhYKyG8V/INPBWm/DVK/A1EQ8ooYGpaQqFTDapC5fDAVbP97mwRK8CJOGqeHT
 YDcaYhR1qCWpOH3sQPQOLWq2ywkHLl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-58wIja4GN-epbyVgwDBJKQ-1; Wed, 29 Jul 2020 06:43:19 -0400
X-MC-Unique: 58wIja4GN-epbyVgwDBJKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 719A98017FB;
 Wed, 29 Jul 2020 10:43:17 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EBD7712FF;
 Wed, 29 Jul 2020 10:43:13 +0000 (UTC)
Message-ID: <233870089fe3b268bfb73cc7c41dc5beecd7904d.camel@redhat.com>
Subject: Re: [PATCH v3 08/18] hw/block/nvme: add support for the
 asynchronous event request command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 29 Jul 2020 13:43:12 +0300
In-Reply-To: <20200706061303.246057-9-its@irrelevant.dk>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-9-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
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
> Add support for the Asynchronous Event Request command. Required for
> compliance with NVMe revision 1.3d. See NVM Express 1.3d, Section 5.2
> ("Asynchronous Event Request command").
> 
> Mostly imported from Keith's qemu-nvme tree. Modified with a max number
> of queued events (controllable with the aer_max_queued device
> parameter). The spec states that the controller *should* retain
> events, so we do best effort here.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c       | 180 ++++++++++++++++++++++++++++++++++++++++--
>  hw/block/nvme.h       |  10 ++-
>  hw/block/trace-events |   9 +++
>  include/block/nvme.h  |   8 +-
>  4 files changed, 198 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7cb3787638f6..80c7285bc1cf 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -356,6 +356,85 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
>  }
>  
> +static void nvme_process_aers(void *opaque)
> +{
> +    NvmeCtrl *n = opaque;
> +    NvmeAsyncEvent *event, *next;
> +
> +    trace_pci_nvme_process_aers(n->aer_queued);
> +
> +    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
> +        NvmeRequest *req;
> +        NvmeAerResult *result;
> +
> +        /* can't post cqe if there is nothing to complete */
> +        if (!n->outstanding_aers) {
> +            trace_pci_nvme_no_outstanding_aers();
> +            break;
> +        }
> +
> +        /* ignore if masked (cqe posted, but event not cleared) */
> +        if (n->aer_mask & (1 << event->result.event_type)) {
> +            trace_pci_nvme_aer_masked(event->result.event_type, n->aer_mask);
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
> +        trace_pci_nvme_aer_post_cqe(result->event_type, result->event_info,
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
> +    trace_pci_nvme_enqueue_event(event_type, event_info, log_page);
> +
> +    if (n->aer_queued == n->params.aer_max_queued) {
> +        trace_pci_nvme_enqueue_event_noqueue(n->aer_queued);
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
> @@ -606,8 +685,9 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
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
> @@ -655,6 +735,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
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
> @@ -681,14 +765,19 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
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
>      NvmeErrorLog errlog;
>  
> +    if (!rae) {
> +        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
> +    }
> +
>      if (off > sizeof(errlog)) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> @@ -729,9 +818,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
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
> @@ -1013,6 +1102,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>              ((n->params.max_ioqpairs - 1) << 16);
>          trace_pci_nvme_getfeat_numq(result);
>          break;
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        result = n->features.async_config;
> +        break;
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
>      default:
> @@ -1064,6 +1156,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>              return NVME_INVALID_FIELD | NVME_DNR;
>          }
>  
> +        if (((n->temperature >= n->features.temp_thresh_hi) ||
> +            (n->temperature <= n->features.temp_thresh_low)) &&
> +            NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPERATURE) {
> +            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
> +                               NVME_AER_INFO_SMART_TEMP_THRESH,
> +                               NVME_LOG_SMART_INFO);
> +        }
> +
>          break;
>      case NVME_VOLATILE_WRITE_CACHE:
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> @@ -1076,6 +1176,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
>                                        ((n->params.max_ioqpairs - 1) << 16));
>          break;
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        n->features.async_config = dw11;
> +        break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
>      default:
> @@ -1085,6 +1188,25 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> +static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    trace_pci_nvme_aer(nvme_cid(req));
> +
> +    if (n->outstanding_aers > n->params.aerl) {
> +        trace_pci_nvme_aer_aerl_exceeded();
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

Looks good so far

> +
>  static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), cmd->opcode);
> @@ -1108,6 +1230,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_set_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_FEATURES:
>          return nvme_get_feature(n, cmd, req);
> +    case NVME_ADM_CMD_ASYNC_EV_REQ:
> +        return nvme_aer(n, cmd, req);
>      default:
>          trace_pci_nvme_err_invalid_admin_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> @@ -1162,6 +1286,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
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
> @@ -1258,6 +1391,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>  
>      nvme_set_timestamp(n, 0ULL);
>  
> +    QTAILQ_INIT(&n->aer_queue);
> +
>      return 0;
>  }
>  
> @@ -1479,6 +1614,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                             "completion queue doorbell write"
>                             " for nonexistent queue,"
>                             " sqid=%"PRIu32", ignoring", qid);
> +
> +            if (n->outstanding_aers) {
> +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> +                                   NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> +                                   NVME_LOG_ERROR_INFO);
> +            }
To be honest I would move the check for outstanding AERs to nvme_enqueue_event.

Also the logic seems a bit off. The code checks that we have outstanding AER requests,
however we do have internal AER queue for this situation.
It seems that SMART events are generated without this check but ERROR events only when
outstanding AERs exist.
Could you explain? I am probably forgot something from the spec which I haven't read for long time.


> +
>              return;
>          }
>  
> @@ -1489,6 +1631,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
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
> @@ -1519,6 +1668,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
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
> @@ -1529,6 +1685,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
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
> @@ -1650,6 +1813,7 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->temperature = NVME_TEMPERATURE;
>      n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
>      n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
>  }
>  
>  static void nvme_init_blk(NvmeCtrl *n, Error **errp)
> @@ -1805,6 +1969,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>       * inconsequential.
>       */
>      id->acl = 3;
> +    id->aerl = n->params.aerl;
Name a tiny bit unclear. I know that this is from the spec but still.

>      id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
>      id->lpa = NVME_LPA_EXTENDED;
>  
> @@ -1879,6 +2044,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>      g_free(n->namespaces);
>      g_free(n->cq);
>      g_free(n->sq);
> +    g_free(n->aer_reqs);
>  
>      if (n->params.cmb_size_mb) {
>          g_free(n->cmbuf);
> @@ -1899,6 +2065,8 @@ static Property nvme_props[] = {
>      DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
>      DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
>      DEFINE_PROP_UINT16("msix_qsize", NvmeCtrl, params.msix_qsize, 65),
> +    DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
So this is number of AERs that we allow the user to be outstanding

> +    DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
And this is the number of AERs that we keep in our internal AER queue untill user posts and AER so that we
can complete it.

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 8228978e93de..1837233617bb 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -9,10 +9,12 @@ typedef struct NvmeParams {
>      uint32_t max_ioqpairs;
>      uint16_t msix_qsize;
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
> @@ -94,6 +96,7 @@ typedef struct NvmeCtrl {
>      uint32_t    num_namespaces;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> +    uint8_t     outstanding_aers;
>      uint8_t     *cmbuf;
>      uint32_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
> @@ -103,6 +106,11 @@ typedef struct NvmeCtrl {
>  
>      HostMemoryBackend *pmrdev;
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
> index 3330d74e48db..091af16ca7d7 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -51,6 +51,15 @@ pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
>  pci_nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
>  pci_nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
> +pci_nvme_process_aers(int queued) "queued %d"
> +pci_nvme_aer(uint16_t cid) "cid %"PRIu16""
> +pci_nvme_aer_aerl_exceeded(void) "aerl exceeded"
> +pci_nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
> +pci_nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +pci_nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +pci_nvme_enqueue_event_noqueue(int queued) "queued %d"
> +pci_nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
> +pci_nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
>  pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
>  pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
>  pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 49ce97ae1ab4..2101292ed5e8 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -597,8 +597,8 @@ enum NvmeAsyncEventRequest {
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
> @@ -899,6 +899,10 @@ typedef struct NvmeFeatureVal {
>  
>  #define NVME_TEMP_TMPTH(temp) ((temp >>  0) & 0xffff)
>  
> +#define NVME_AEC_SMART(aec)         (aec & 0xff)
> +#define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
> +#define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
> +
>  enum NvmeFeatureIds {
>      NVME_ARBITRATION                = 0x1,
>      NVME_POWER_MANAGEMENT           = 0x2,


Best regards,
	Maxim Levitsky


