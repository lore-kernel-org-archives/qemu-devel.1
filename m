Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB34C2D0EF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 12:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678D621D79
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 12:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPnt89yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678D621D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPmCT-000776-GG
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 08:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jPmBX-0006gW-LR
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 08:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jPmBV-0008AH-Pv
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 08:02:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jPmBU-00085a-7y
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 08:02:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id t63so4479368wmt.3
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 05:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=SlOlS1gFviishPqZ4RS/em4z6I7xVRtjcRu9EuFjdSY=;
 b=hPnt89yzWeJ3VDdi6LdiJukRqi8ZwRCWBH7yrivCIZMzQiuH9WD/ztSiZhzg+iRRpW
 xOmiVwNKLaBzYFp39WjjtBZCNf6sDbghsV5VJEeqzkuXLkecSOUwXVM12WY3fUCs8mvS
 eLA/Si/HO5VcinFuNNa6xZ41zl9gneRDEYAykC1CkKUTgSqZIqBddjNPgqWgvcQV6SXZ
 RPOxStT3FTD1DSYITEx4X4daJW4ea6JBGkqT9VzHMIfS71MI2VDaponmqFMk4qK73e+c
 qkeXlg2EYyAlg9RU17LwTMO4+kwTyzVLSYpipgh5uprLnlImDztiIgwBeS6sIOPM9pTr
 4aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SlOlS1gFviishPqZ4RS/em4z6I7xVRtjcRu9EuFjdSY=;
 b=YOFc03WCkwO1W6MM/D3dfSZAQHMYOMTKt9Lmq7TS4V5JCuQuaaq0LRUJnwMqjmx4FN
 wWdgfqDJWNjFosb/oLOscDOyQf9igrYsZBCz2XQky8o6pl5rN9VRP5oeb2dB0LW+NmR3
 6S3kqRnEfgggTX0TYFmtkW+Ls2Qkk1PoShkUEeSkcDoNw7V9N3YPkDC3LakIOw93piq6
 xKVZ+M8V5nIa7oeXY47Ny+UwAdaOQBAbc7jOOKhtoD/CDoqcmOad+VgaJM/NK2bq+mSw
 IDFxZnTK3g3gPayaWOtZenErk5B/0MTH3JWUA/1xPXfKoSB5KXW9Z6FoGagjfD8O+hgc
 bAVg==
X-Gm-Message-State: AGi0Pubpp26EaYTuAaDMKNklbPTVFA7t/+PN6v6HRHQyd5ARZJ0nNqZO
 On6h9JSQrXw4g7AvYKZKoUs=
X-Google-Smtp-Source: APiQypIVBWUYkad2Z6BhkgtFu3E8CdtTVzPNYsEnOCZ863iibVdSJUmi6Ae5WerTvBt6wh3okrTGOg==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr7628641wmg.1.1587211374399; 
 Sat, 18 Apr 2020 05:02:54 -0700 (PDT)
Received: from [192.168.86.37] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id o129sm5868641wme.16.2020.04.18.05.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2020 05:02:53 -0700 (PDT)
Subject: Re: [PATCH v2] lockable: Replace locks with lock guard macros
To: Simran Singhal <singhalsimran0@gmail.com>, qemu-devel@nongnu.org,
 rkagan@virtuozzo.com
References: <20200402065035.GA15477@simran-Inspiron-5558>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <f0eec74a-387d-79ce-b23f-d7f16747f9ad@gmail.com>
Date: Sat, 18 Apr 2020 15:03:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200402065035.GA15477@simran-Inspiron-5558>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Simran,

On 4/2/20 9:50 AM, Simran Singhal wrote:
> Replace manual lock()/unlock() calls with lock guard macros
> (QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).
>
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
> Changes in v2:
>          -Drop changes in file hw/rdma/rdma_utils.c
>
>   hw/hyperv/hyperv.c     | 15 ++++++-------
>   hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
>   hw/rdma/rdma_rm.c      |  3 +--
>   3 files changed, 33 insertions(+), 35 deletions(-)
>
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 8ca3706f5b..4ddafe1de1 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -15,6 +15,7 @@
>   #include "sysemu/kvm.h"
>   #include "qemu/bitops.h"
>   #include "qemu/error-report.h"
> +#include "qemu/lockable.h"
>   #include "qemu/queue.h"
>   #include "qemu/rcu.h"
>   #include "qemu/rcu_queue.h"
> @@ -491,7 +492,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
>       int ret;
>       MsgHandler *mh;
>   
> -    qemu_mutex_lock(&handlers_mutex);
> +    QEMU_LOCK_GUARD(&handlers_mutex);

It does not passes compilation:
     export ARCH=x86_64
     make docker-image-fedora V=1 NETWORK=1
     make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu NETWORK=1

Error:

  CC      x86_64-softmmu/hw/net/virtio-net.o
/tmp/qemu-test/src/hw/hyperv/hyperv.c:495:5: error: unused variable 
'qemu_lockable_auto__COUNTER__' [-Werror,-Wunused-variable]
     QEMU_LOCK_GUARD(&handlers_mutex);
     ^
/tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from 
macro 'QEMU_LOCK_GUARD'
     g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ = \
                             ^
<scratch space>:24:1: note: expanded from here
qemu_lockable_auto__COUNTER__
^
/tmp/qemu-test/src/hw/hyperv/hyperv.c:568:5: error: unused variable 
'qemu_lockable_auto__COUNTER__' [-Werror,-Wunused-variable]
     QEMU_LOCK_GUARD(&handlers_mutex);
     ^
/tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from 
macro 'QEMU_LOCK_GUARD'
     g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ = \
                             ^
<scratch space>:39:1: note: expanded from here
qemu_lockable_auto__COUNTER__
^
2 errors generated.

I suggest splitting it into an pvrdma path and hyperv patch anyway.
It will be nice to get an ack from the hyperv maintainer, adding Roman.

Thanks,
Marcel


>       QLIST_FOREACH(mh, &msg_handlers, link) {
>           if (mh->conn_id == conn_id) {
>               if (handler) {
> @@ -501,7 +502,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
>                   g_free_rcu(mh, rcu);
>                   ret = 0;
>               }
> -            goto unlock;
> +            return ret;
>           }
>       }
>   
> @@ -515,8 +516,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
>       } else {
>           ret = -ENOENT;
>       }
> -unlock:
> -    qemu_mutex_unlock(&handlers_mutex);
> +
>       return ret;
>   }
>   
> @@ -565,7 +565,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
>       int ret;
>       EventFlagHandler *handler;
>   
> -    qemu_mutex_lock(&handlers_mutex);
> +    QEMU_LOCK_GUARD(&handlers_mutex);
>       QLIST_FOREACH(handler, &event_flag_handlers, link) {
>           if (handler->conn_id == conn_id) {
>               if (notifier) {
> @@ -575,7 +575,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
>                   g_free_rcu(handler, rcu);
>                   ret = 0;
>               }
> -            goto unlock;
> +            return ret;
>           }
>       }
>   
> @@ -588,8 +588,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
>       } else {
>           ret = -ENOENT;
>       }
> -unlock:
> -    qemu_mutex_unlock(&handlers_mutex);
> +
>       return ret;
>   }
>   
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 3dd39fe1a7..db7e5c8be5 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -95,36 +95,36 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>       struct ibv_wc wc[2];
>       RdmaProtectedGSList *cqe_ctx_list;
>   
> -    qemu_mutex_lock(&rdma_dev_res->lock);
> -    do {
> -        ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
> +    WITH_QEMU_LOCK_GUARD(&rdma_dev_res->lock) {
> +        do {
> +            ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
>   
> -        trace_rdma_poll_cq(ne, ibcq);
> +            trace_rdma_poll_cq(ne, ibcq);
>   
> -        for (i = 0; i < ne; i++) {
> -            bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> -            if (unlikely(!bctx)) {
> -                rdma_error_report("No matching ctx for req %"PRId64,
> -                                  wc[i].wr_id);
> -                continue;
> -            }
> +            for (i = 0; i < ne; i++) {
> +                bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> +                if (unlikely(!bctx)) {
> +                    rdma_error_report("No matching ctx for req %"PRId64,
> +                                      wc[i].wr_id);
> +                    continue;
> +                }
>   
> -            comp_handler(bctx->up_ctx, &wc[i]);
> +                comp_handler(bctx->up_ctx, &wc[i]);
>   
> -            if (bctx->backend_qp) {
> -                cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
> -            } else {
> -                cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
> -            }
> +                if (bctx->backend_qp) {
> +                    cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
> +                } else {
> +                    cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
> +                }
>   
> -            rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
> -            rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> -            g_free(bctx);
> -        }
> -        total_ne += ne;
> -    } while (ne > 0);
> -    atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
> -    qemu_mutex_unlock(&rdma_dev_res->lock);
> +                rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
> +                rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> +                g_free(bctx);
> +            }
> +            total_ne += ne;
> +        } while (ne > 0);
> +        atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
> +    }
>   
>       if (ne < 0) {
>           rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 7e9ea283c9..60957f88db 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -147,14 +147,13 @@ static inline void rdma_res_tbl_dealloc(RdmaRmResTbl *tbl, uint32_t handle)
>   {
>       trace_rdma_res_tbl_dealloc(tbl->name, handle);
>   
> -    qemu_mutex_lock(&tbl->lock);
> +    QEMU_LOCK_GUARD(&tbl->lock);
>   
>       if (handle < tbl->tbl_sz) {
>           clear_bit(handle, tbl->bitmap);
>           tbl->used--;
>       }
>   
> -    qemu_mutex_unlock(&tbl->lock);
>   }
>   
>   int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,


