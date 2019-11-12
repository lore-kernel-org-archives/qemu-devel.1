Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF42C17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB382067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWyxzbXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB382067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXpE-0008FX-8N
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXjP-0000aJ-S8
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXjJ-0004iT-Mq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:23 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iUXjJ-0004iG-GS
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:17 -0500
Received: by mail-io1-xd44.google.com with SMTP id j20so18761073ioo.11
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dxIogtbXeGFl/NDHfND5nkbJLOq0qKf03Sbhcho/GuU=;
 b=aWyxzbXvQZqThT/OQlWOAtnJ64zUDnh/yYKD/N7ALDGy0cL5Uykk4eIcMMkiL5r8D9
 Wkhptcyd3TBJ0AVed9CH+y0VYMKoCR3As4cK6CW1bAWO9jbfxBwWgyX/vgRHKdMVXz7F
 Bl0X4BljYDRaJsmwG8hbh2ZS0OWhlcCASRICOWe2BOLMptKtwcgTrWyOrHROQNgupS4U
 U5R9QoTYGdPf1nRh0/kk6X5N3z4tRopDq9zZU9xId8CG9aMkpvHB22c1lnVnYs9os2z2
 kQzJf056Bas0clM6CGiiqI6/DNJL2sp6jMo4Veo+EeVtqX2O9OReBVMl+HWUEQ3hrcXm
 iCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dxIogtbXeGFl/NDHfND5nkbJLOq0qKf03Sbhcho/GuU=;
 b=J4CGkJCm3P/Nhj9Uw+PJYmAntzE3YASDZn6VanAylL9YeKhJJt/uQwWVZ14BTTSCEW
 vHfdJcRWra/i9YgzmInvD1p97tUmrPM/hFcnc5Ak/SyPbjK+0LlJyK771Oy1xaBkg6Rf
 kNfDrrtrFKR0b6UhhMdgDF/nbzVCFr0rJ6r9NTh+I95/zeboUZUKotwxMbiRpNU/BFR8
 1jrHCdh6dYMe21Kq1fH6HqAM03YPECNm6TYstxPewukn5mSNOmKYddksmeilSjeDk6xO
 ZE8q27lXSjBrmv2jfjlBHJuEnMcEBZmHsaegqfTRq6lzV/SiQU+8c80e3/cvebdaiSDc
 9uiA==
X-Gm-Message-State: APjAAAWQEL5bIYlDdwtyC6FlYvpvWz2lO2UdroGA/a85/9tvlrKKp6jL
 baHnaU+norCcQc+PwDSnk9pSBmc1bFalPoMhCM8EILRmJX+ctw==
X-Google-Smtp-Source: APXvYqwfNo+XMGqjhsq/FNfmrNk7Xse9Ko4MSxkTaFgIMOnDWzfFN+oe4vrI2m2NYxhl2k5maa6eZGnhXlAor2MhOss=
X-Received: by 2002:a5e:9741:: with SMTP id h1mr29292008ioq.143.1573571116690; 
 Tue, 12 Nov 2019 07:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-13-its@irrelevant.dk>
In-Reply-To: <20191015103900.313928-13-its@irrelevant.dk>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 12 Nov 2019 15:05:06 +0000
Message-ID: <CADSWDzt-YfwuxmxL=c7qQzac-Xby1azxAsGhAfviSRXz2FkNhg@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] nvme: bump supported specification version to 1.3
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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

On Tue, 15 Oct 2019 at 11:52, Klaus Jensen <its@irrelevant.dk> wrote:
>
> Add the new Namespace Identification Descriptor List (CNS 03h) and track
> creation of queues to enable the controller to return Command Sequence
> Error if Set Features is called for Number of Queues after any queues
> have been created.
>
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c       | 82 +++++++++++++++++++++++++++++++++++--------
>  hw/block/nvme.h       |  1 +
>  hw/block/trace-events |  8 +++--
>  include/block/nvme.h  | 30 +++++++++++++---
>  4 files changed, 100 insertions(+), 21 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index e7d46dcc6afe..1e2320b38b14 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -9,20 +9,22 @@
>   */
>
>  /**
> - * Reference Specification: NVM Express 1.2.1
> + * Reference Specification: NVM Express 1.3d
>   *
>   *   https://nvmexpress.org/resources/specifications/
>   */
>
>  /**
>   * Usage: add options:
> - *      -drive file=<file>,if=none,id=<drive_id>
> - *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
> - *              cmb_size_mb=<cmb_size_mb[optional]>, \
> - *              num_queues=<N[optional]>
> + *     -drive file=<file>,if=none,id=<drive_id>
> + *     -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>
>   *
> - * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
> - * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> + * Advanced optional options:
> + *
> + *   num_queues=<uint32>      : Maximum number of IO Queues.
> + *                              Default: 64
> + *   cmb_size_mb=<uint32>     : Size of Controller Memory Buffer in MBs.
> + *                              Default: 0 (disabled)
>   */
>
>  #include "qemu/osdep.h"
> @@ -345,6 +347,8 @@ static void nvme_post_cqes(void *opaque)
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>  {
>      assert(cq->cqid == req->sq->cqid);
> +
> +    trace_nvme_enqueue_req_completion(req->cid, cq->cqid, req->status);
>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> @@ -530,6 +534,7 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
>      if (sq->sqid) {
>          g_free(sq);
>      }
> +    n->qs_created--;
>  }
>
>  static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
> @@ -596,6 +601,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
>      cq = n->cq[cqid];
>      QTAILQ_INSERT_TAIL(&(cq->sq_list), sq, entry);
>      n->sq[sqid] = sq;
> +    n->qs_created++;
>  }
>
>  static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
> @@ -742,7 +748,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>      uint32_t dw12 = le32_to_cpu(cmd->cdw12);
>      uint32_t dw13 = le32_to_cpu(cmd->cdw13);
> -    uint16_t lid = dw10 & 0xff;
> +    uint8_t  lid = dw10 & 0xff;
> +    uint8_t  lsp = (dw10 >> 8) & 0xf;
>      uint8_t  rae = (dw10 >> 15) & 0x1;
>      uint32_t numdl, numdu;
>      uint64_t off, lpol, lpou;
> @@ -760,7 +767,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>
> -    trace_nvme_get_log(req->cid, lid, rae, len, off);
> +    trace_nvme_get_log(req->cid, lid, lsp, rae, len, off);
>
>      switch (lid) {
>      case NVME_LOG_ERROR_INFO:
> @@ -784,6 +791,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
>      if (cq->cqid) {
>          g_free(cq);
>      }
> +    n->qs_created--;
>  }
>
>  static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
> @@ -824,6 +832,7 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
>      msix_vector_use(&n->parent_obj, cq->vector);
>      n->cq[cqid] = cq;
>      cq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
> +    n->qs_created++;
>  }
>
>  static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
> @@ -897,7 +906,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
>          prp1, prp2);
>  }
>
> -static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
>  {
>      static const int data_len = 4 * KiB;
>      uint32_t min_nsid = le32_to_cpu(c->nsid);
> @@ -907,7 +916,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>      uint16_t ret;
>      int i, j = 0;
>
> -    trace_nvme_identify_nslist(min_nsid);
> +    trace_nvme_identify_ns_list(min_nsid);
>
>      list = g_malloc0(data_len);
>      for (i = 0; i < n->num_namespaces; i++) {
> @@ -924,6 +933,41 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>      return ret;
>  }
>
> +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
> +{
> +    static const int len = 4096;
> +
> +    struct ns_descr {
> +        uint8_t nidt;
> +        uint8_t nidl;
> +        uint8_t rsvd2[2];
> +        uint8_t nid[16];
> +    };
> +
> +    uint32_t nsid = le32_to_cpu(c->nsid);
> +    uint64_t prp1 = le64_to_cpu(c->prp1);
> +    uint64_t prp2 = le64_to_cpu(c->prp2);
> +
> +    struct ns_descr *list;
> +    uint16_t ret;
> +
> +    trace_nvme_identify_ns_descr_list(nsid);
> +
> +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> +        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
In theory this should abort the command for inactive NSIDs as well.
But I guess this will come later on.

> +    list = g_malloc0(len);
> +    list->nidt = 0x3;
> +    list->nidl = 0x10;
> +    *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
> +
Might be worth to add some comment here -> as per the NGUID/EUI64 format.
Also those are not specified currently in the namespace identity data structure.

> +    ret = nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
> +    g_free(list);
> +    return ret;
> +}
> +
>  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>  {
>      NvmeIdentify *c = (NvmeIdentify *)cmd;
> @@ -934,7 +978,9 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>      case 0x01:
>          return nvme_identify_ctrl(n, c);
>      case 0x02:
> -        return nvme_identify_nslist(n, c);
> +        return nvme_identify_ns_list(n, c);
> +    case 0x03:
> +        return nvme_identify_ns_descr_list(n, cmd);
>      default:
>          trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1101,6 +1147,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> +        if (n->qs_created > 2) {
> +            return NVME_CMD_SEQ_ERROR | NVME_DNR;
> +        }
> +
I am not sure this is entirely correct as the spec says:
"if any I/O Submission and/or Completion Queues (...)"
so it might be enough to have a single queue created
for this command to be valid.
Also I think that the condition here is to make sure that the number
of queues requested is being set once at init phase. Currently this will
allow the setting to happen if there is no active queue -> so at any
point of time (provided the condition mentioned). I might be wrong here
but it seems that what we need is a single status saying any queue
has been created prior to the Set Feature command at all


> +        if ((dw11 & 0xffff) == 0xffff || ((dw11 >> 16) & 0xffff) == 0xffff) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
>          trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
>                                  ((dw11 >> 16) & 0xFFFF) + 1,
>                                  n->params.num_queues - 1,
> @@ -1816,7 +1870,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      id->ieee[0] = 0x00;
>      id->ieee[1] = 0x02;
>      id->ieee[2] = 0xb3;
> -    id->ver = cpu_to_le32(0x00010201);
> +    id->ver = cpu_to_le32(0x00010300);
>      id->oacs = cpu_to_le16(0);
>      id->acl = 3;
>      id->aerl = n->params.aerl;
> @@ -1847,7 +1901,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>
> -    n->bar.vs = 0x00010201;
> +    n->bar.vs = 0x00010300;
>      n->bar.intmc = n->bar.intms = 0;
>  }
>
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index d74b0e0f9b2c..3f7bd627e824 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -102,6 +102,7 @@ typedef struct NvmeCtrl {
>      uint16_t    temperature;
>      uint8_t     elp_index;
>      uint64_t    error_count;
> +    uint32_t    qs_created;
>
>      QEMUTimer   *aer_timer;
>      uint8_t     aer_mask;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index a20a68d85d5a..f62fa99dc2cd 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -39,8 +39,9 @@ nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uin
>  nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
>  nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
>  nvme_identify_ctrl(void) "identify controller"
> -nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
> -nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
> +nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
> +nvme_identify_ns_list(uint32_t ns) "nsid %"PRIu32""
> +nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
>  nvme_getfeat(uint32_t fid) "fid 0x%"PRIx32""
>  nvme_setfeat(uint32_t fid, uint32_t val) "fid 0x%"PRIx32" val 0x%"PRIx32""
>  nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
> @@ -48,12 +49,13 @@ nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
>  nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
>  nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
> -nvme_get_log(uint16_t cid, uint16_t lid, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx16" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
> +nvme_get_log(uint16_t cid, uint16_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx16" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
>  nvme_process_aers(void) "processing aers"
>  nvme_aer(uint16_t cid) "cid %"PRIu16""
>  nvme_aer_aerl_exceeded(void) "aerl exceeded"
>  nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
>  nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
>  nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
>  nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
>  nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 9726839f75bb..f0f5728b5ec4 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -550,7 +550,9 @@ typedef struct NvmeIdCtrl {
>      uint32_t    rtd3e;
>      uint32_t    oaes;
>      uint32_t    ctratt;
> -    uint8_t     rsvd255[156];
> +    uint8_t     rsvd111[12];
> +    uint8_t     fguid[16];
> +    uint8_t     rsvd255[128];
>      uint16_t    oacs;
>      uint8_t     acl;
>      uint8_t     aerl;
> @@ -568,9 +570,15 @@ typedef struct NvmeIdCtrl {
>      uint8_t     tnvmcap[16];
>      uint8_t     unvmcap[16];
>      uint32_t    rpmbs;
> -    uint8_t     rsvd319[4];
> +    uint16_t    edstt;
> +    uint8_t     dsto;
> +    uint8_t     fwug;
>      uint16_t    kas;
> -    uint8_t     rsvd511[190];
> +    uint16_t    hctma;
> +    uint16_t    mntmt;
> +    uint16_t    mxtmt;
> +    uint32_t    sanicap;
> +    uint8_t     rsvd511[180];
>      uint8_t     sqes;
>      uint8_t     cqes;
>      uint16_t    maxcmd;
> @@ -678,7 +686,21 @@ typedef struct NvmeIdNs {
>      uint8_t     mc;
>      uint8_t     dpc;
>      uint8_t     dps;
> -    uint8_t     res30[98];
> +    uint8_t     nmic;
> +    uint8_t     rescap;
> +    uint8_t     fpi;
> +    uint8_t     dlfeat;
> +    uint16_t    nawun;
> +    uint16_t    nawupf;
> +    uint16_t    nacwu;
> +    uint16_t    nabsn;
> +    uint16_t    nabo;
> +    uint16_t    nabspf;
> +    uint16_t    noiob;
> +    uint8_t     nvmcap[16];
> +    uint8_t     resv103[40];
> +    uint8_t     nguid[16];
> +    uint64_t    eui64;
>      NvmeLBAF    lbaf[16];
>      uint8_t     res192[192];
>      uint8_t     vs[3712];
> --
> 2.23.0
>
>

Small note: this patch seems to be introducing more changes
than specified in the commit message and especially the subject. Might
be worth to extend it a bit.

BR


Beata

