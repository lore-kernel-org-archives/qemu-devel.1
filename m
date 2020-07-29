Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C3FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC47206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="NeYalzW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC47206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mHP-0002KK-EP
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0mGd-0001oi-Rf; Wed, 29 Jul 2020 09:37:12 -0400
Received: from charlie.dont.surf ([128.199.63.193]:33852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0mGa-0002RJ-3e; Wed, 29 Jul 2020 09:37:11 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id E48DBBF616;
 Wed, 29 Jul 2020 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596029825;
 bh=jKvMYJo5eHMH7vKzomBmDrBlTJQOFiZJw5HgUk49Ux0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NeYalzW5VXzegmYs8nBacPuuOYN5yLMl1YdsVpdZTzal4beDSsYGMuxW/zfMN8EEq
 tn9lDJPLy0PqauUFgUk61QgOUN8wJAddxBk+e8cqk7qpOXKiL7THjmWXtsGBdt2K9W
 T48oBVEqvp5Kh2S9DmVY9BCdh2SWleaxsBKgX8LaT/UYOB6Tb3T+D58Y6Z2I804hRB
 zisiWoupiHY5JSgyNX6YhqPLbCsQ09Hsak4pnDYFUv1cAMeuJWuxsHEjNNFH9zjmCn
 mF6fZmePy5c1m+pQLe6s/aWFDwmge++lPiT5nTOqSRFHCo9R7sAHmAZQw25NmPY4oY
 kZ9V3xvOzDYRA==
Date: Wed, 29 Jul 2020 15:37:03 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 08/18] hw/block/nvme: add support for the asynchronous
 event request command
Message-ID: <20200729133703.GB159410@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-9-its@irrelevant.dk>
 <233870089fe3b268bfb73cc7c41dc5beecd7904d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <233870089fe3b268bfb73cc7c41dc5beecd7904d.camel@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 07:44:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 29 13:43, Maxim Levitsky wrote:
> On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Add support for the Asynchronous Event Request command. Required for
> > compliance with NVMe revision 1.3d. See NVM Express 1.3d, Section 5.2
> > ("Asynchronous Event Request command").
> > 
> > Mostly imported from Keith's qemu-nvme tree. Modified with a max number
> > of queued events (controllable with the aer_max_queued device
> > parameter). The spec states that the controller *should* retain
> > events, so we do best effort here.
> > 
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > ---
> >  hw/block/nvme.c       | 180 ++++++++++++++++++++++++++++++++++++++++--
> >  hw/block/nvme.h       |  10 ++-
> >  hw/block/trace-events |   9 +++
> >  include/block/nvme.h  |   8 +-
> >  4 files changed, 198 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 7cb3787638f6..80c7285bc1cf 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -356,6 +356,85 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
> >      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> >  }
> >  
> > +static void nvme_process_aers(void *opaque)
> > +{
> > +    NvmeCtrl *n = opaque;
> > +    NvmeAsyncEvent *event, *next;
> > +
> > +    trace_pci_nvme_process_aers(n->aer_queued);
> > +
> > +    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
> > +        NvmeRequest *req;
> > +        NvmeAerResult *result;
> > +
> > +        /* can't post cqe if there is nothing to complete */
> > +        if (!n->outstanding_aers) {
> > +            trace_pci_nvme_no_outstanding_aers();
> > +            break;
> > +        }
> > +
> > +        /* ignore if masked (cqe posted, but event not cleared) */
> > +        if (n->aer_mask & (1 << event->result.event_type)) {
> > +            trace_pci_nvme_aer_masked(event->result.event_type, n->aer_mask);
> > +            continue;
> > +        }
> > +
> > +        QTAILQ_REMOVE(&n->aer_queue, event, entry);
> > +        n->aer_queued--;
> > +
> > +        n->aer_mask |= 1 << event->result.event_type;
> > +        n->outstanding_aers--;
> > +
> > +        req = n->aer_reqs[n->outstanding_aers];
> > +
> > +        result = (NvmeAerResult *) &req->cqe.result;
> > +        result->event_type = event->result.event_type;
> > +        result->event_info = event->result.event_info;
> > +        result->log_page = event->result.log_page;
> > +        g_free(event);
> > +
> > +        req->status = NVME_SUCCESS;
> > +
> > +        trace_pci_nvme_aer_post_cqe(result->event_type, result->event_info,
> > +                                    result->log_page);
> > +
> > +        nvme_enqueue_req_completion(&n->admin_cq, req);
> > +    }
> > +}
> > +
> > +static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
> > +                               uint8_t event_info, uint8_t log_page)
> > +{
> > +    NvmeAsyncEvent *event;
> > +
> > +    trace_pci_nvme_enqueue_event(event_type, event_info, log_page);
> > +
> > +    if (n->aer_queued == n->params.aer_max_queued) {
> > +        trace_pci_nvme_enqueue_event_noqueue(n->aer_queued);
> > +        return;
> > +    }
> > +
> > +    event = g_new(NvmeAsyncEvent, 1);
> > +    event->result = (NvmeAerResult) {
> > +        .event_type = event_type,
> > +        .event_info = event_info,
> > +        .log_page   = log_page,
> > +    };
> > +
> > +    QTAILQ_INSERT_TAIL(&n->aer_queue, event, entry);
> > +    n->aer_queued++;
> > +
> > +    nvme_process_aers(n);
> > +}
> > +
> > +static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
> > +{
> > +    n->aer_mask &= ~(1 << event_type);
> > +    if (!QTAILQ_EMPTY(&n->aer_queue)) {
> > +        nvme_process_aers(n);
> > +    }
> > +}
> > +
> >  static void nvme_rw_cb(void *opaque, int ret)
> >  {
> >      NvmeRequest *req = opaque;
> > @@ -606,8 +685,9 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
> >      return NVME_SUCCESS;
> >  }
> >  
> > -static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> > -                                uint64_t off, NvmeRequest *req)
> > +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> > +                                uint32_t buf_len, uint64_t off,
> > +                                NvmeRequest *req)
> >  {
> >      uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> >      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> > @@ -655,6 +735,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> >      smart.power_on_hours[0] =
> >          cpu_to_le64((((current_ms - n->starttime_ms) / 1000) / 60) / 60);
> >  
> > +    if (!rae) {
> > +        nvme_clear_events(n, NVME_AER_TYPE_SMART);
> > +    }
> > +
> >      return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> >                               prp2);
> >  }
> > @@ -681,14 +765,19 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> >                               prp2);
> >  }
> >  
> > -static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> > -                                uint64_t off, NvmeRequest *req)
> > +static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> > +                                uint32_t buf_len, uint64_t off,
> > +                                NvmeRequest *req)
> >  {
> >      uint32_t trans_len;
> >      uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> >      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> >      NvmeErrorLog errlog;
> >  
> > +    if (!rae) {
> > +        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
> > +    }
> > +
> >      if (off > sizeof(errlog)) {
> >          return NVME_INVALID_FIELD | NVME_DNR;
> >      }
> > @@ -729,9 +818,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  
> >      switch (lid) {
> >      case NVME_LOG_ERROR_INFO:
> > -        return nvme_error_info(n, cmd, len, off, req);
> > +        return nvme_error_info(n, cmd, rae, len, off, req);
> >      case NVME_LOG_SMART_INFO:
> > -        return nvme_smart_info(n, cmd, len, off, req);
> > +        return nvme_smart_info(n, cmd, rae, len, off, req);
> >      case NVME_LOG_FW_SLOT_INFO:
> >          return nvme_fw_log_info(n, cmd, len, off, req);
> >      default:
> > @@ -1013,6 +1102,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >              ((n->params.max_ioqpairs - 1) << 16);
> >          trace_pci_nvme_getfeat_numq(result);
> >          break;
> > +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> > +        result = n->features.async_config;
> > +        break;
> >      case NVME_TIMESTAMP:
> >          return nvme_get_feature_timestamp(n, cmd);
> >      default:
> > @@ -1064,6 +1156,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >              return NVME_INVALID_FIELD | NVME_DNR;
> >          }
> >  
> > +        if (((n->temperature >= n->features.temp_thresh_hi) ||
> > +            (n->temperature <= n->features.temp_thresh_low)) &&
> > +            NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPERATURE) {
> > +            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
> > +                               NVME_AER_INFO_SMART_TEMP_THRESH,
> > +                               NVME_LOG_SMART_INFO);
> > +        }
> > +
> >          break;
> >      case NVME_VOLATILE_WRITE_CACHE:
> >          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> > @@ -1076,6 +1176,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >          req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
> >                                        ((n->params.max_ioqpairs - 1) << 16));
> >          break;
> > +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> > +        n->features.async_config = dw11;
> > +        break;
> >      case NVME_TIMESTAMP:
> >          return nvme_set_feature_timestamp(n, cmd);
> >      default:
> > @@ -1085,6 +1188,25 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >      return NVME_SUCCESS;
> >  }
> >  
> > +static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > +{
> > +    trace_pci_nvme_aer(nvme_cid(req));
> > +
> > +    if (n->outstanding_aers > n->params.aerl) {
> > +        trace_pci_nvme_aer_aerl_exceeded();
> > +        return NVME_AER_LIMIT_EXCEEDED;
> > +    }
> > +
> > +    n->aer_reqs[n->outstanding_aers] = req;
> > +    n->outstanding_aers++;
> > +
> > +    if (!QTAILQ_EMPTY(&n->aer_queue)) {
> > +        nvme_process_aers(n);
> > +    }
> > +
> > +    return NVME_NO_COMPLETE;
> > +}
> 
> Looks good so far
> 
> > +
> >  static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  {
> >      trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), cmd->opcode);
> > @@ -1108,6 +1230,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >          return nvme_set_feature(n, cmd, req);
> >      case NVME_ADM_CMD_GET_FEATURES:
> >          return nvme_get_feature(n, cmd, req);
> > +    case NVME_ADM_CMD_ASYNC_EV_REQ:
> > +        return nvme_aer(n, cmd, req);
> >      default:
> >          trace_pci_nvme_err_invalid_admin_opc(cmd->opcode);
> >          return NVME_INVALID_OPCODE | NVME_DNR;
> > @@ -1162,6 +1286,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
> >          }
> >      }
> >  
> > +    while (!QTAILQ_EMPTY(&n->aer_queue)) {
> > +        NvmeAsyncEvent *event = QTAILQ_FIRST(&n->aer_queue);
> > +        QTAILQ_REMOVE(&n->aer_queue, event, entry);
> > +        g_free(event);
> > +    }
> > +
> > +    n->aer_queued = 0;
> > +    n->outstanding_aers = 0;
> > +
> >      blk_flush(n->conf.blk);
> >      n->bar.cc = 0;
> >  }
> > @@ -1258,6 +1391,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
> >  
> >      nvme_set_timestamp(n, 0ULL);
> >  
> > +    QTAILQ_INIT(&n->aer_queue);
> > +
> >      return 0;
> >  }
> >  
> > @@ -1479,6 +1614,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
> >                             "completion queue doorbell write"
> >                             " for nonexistent queue,"
> >                             " sqid=%"PRIu32", ignoring", qid);
> > +
> > +            if (n->outstanding_aers) {
> > +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> > +                                   NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> > +                                   NVME_LOG_ERROR_INFO);
> > +            }
> To be honest I would move the check for outstanding AERs to nvme_enqueue_event.
> 
> Also the logic seems a bit off. The code checks that we have outstanding AER requests,
> however we do have internal AER queue for this situation.
> It seems that SMART events are generated without this check but ERROR events only when
> outstanding AERs exist.
> Could you explain? I am probably forgot something from the spec which I haven't read for long time.
> 

I'm pretty sure this has been mentioned before, but I can't find it
anywhere, maybe it was an internal review...

Anyway, I'm interpreting the AER logic as a special case for doorbell writes:

NVM Express v1.3d, Section 4.1 state: "If host software writes an
invalid value to the Submission Queue Tail Doorbell or Completion Queue
Head Doorbell regiter and an Asynchronous Event Request command is
outstanding, then an asynchronous event is posted to the Admin
Completion Queue with a status code of Invalid Doorbell Write Value."

> 
> > +
> >              return;
> >          }
> >  
> > @@ -1489,6 +1631,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
> >                             " beyond queue size, sqid=%"PRIu32","
> >                             " new_head=%"PRIu16", ignoring",
> >                             qid, new_head);
> > +
> > +            if (n->outstanding_aers) {
> > +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> > +                                   NVME_AER_INFO_ERR_INVALID_DB_VALUE,
> > +                                   NVME_LOG_ERROR_INFO);
> > +            }
> > +
> >              return;
> >          }
> >  
> > @@ -1519,6 +1668,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
> >                             "submission queue doorbell write"
> >                             " for nonexistent queue,"
> >                             " sqid=%"PRIu32", ignoring", qid);
> > +
> > +            if (n->outstanding_aers) {
> > +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> > +                                   NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> > +                                   NVME_LOG_ERROR_INFO);
> > +            }
> > +
> >              return;
> >          }
> >  
> > @@ -1529,6 +1685,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
> >                             " beyond queue size, sqid=%"PRIu32","
> >                             " new_tail=%"PRIu16", ignoring",
> >                             qid, new_tail);
> > +
> > +            if (n->outstanding_aers) {
> > +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> > +                                   NVME_AER_INFO_ERR_INVALID_DB_VALUE,
> > +                                   NVME_LOG_ERROR_INFO);
> > +            }
> > +
> >              return;
> >          }
> >  
> > @@ -1650,6 +1813,7 @@ static void nvme_init_state(NvmeCtrl *n)
> >      n->temperature = NVME_TEMPERATURE;
> >      n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
> >      n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> > +    n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
> >  }
> >  
> >  static void nvme_init_blk(NvmeCtrl *n, Error **errp)
> > @@ -1805,6 +1969,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
> >       * inconsequential.
> >       */
> >      id->acl = 3;
> > +    id->aerl = n->params.aerl;
> Name a tiny bit unclear. I know that this is from the spec but still.
> 

Yes I know, but I really prefer the spec names if possible (makes it
easy to look them up).

> >      id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
> >      id->lpa = NVME_LPA_EXTENDED;
> >  
> > @@ -1879,6 +2044,7 @@ static void nvme_exit(PCIDevice *pci_dev)
> >      g_free(n->namespaces);
> >      g_free(n->cq);
> >      g_free(n->sq);
> > +    g_free(n->aer_reqs);
> >  
> >      if (n->params.cmb_size_mb) {
> >          g_free(n->cmbuf);
> > @@ -1899,6 +2065,8 @@ static Property nvme_props[] = {
> >      DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
> >      DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
> >      DEFINE_PROP_UINT16("msix_qsize", NvmeCtrl, params.msix_qsize, 65),
> > +    DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
> So this is number of AERs that we allow the user to be outstanding

Yeah, and per the spec, 0's based.

> 
> > +    DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
> And this is the number of AERs that we keep in our internal AER queue untill user posts and AER so that we
> can complete it.
> 

Correct.



