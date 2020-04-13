Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6114AC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 09:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14688206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 09:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot1KbWz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14688206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNvCt-0007LX-1x
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 05:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jNvB1-00067L-0t
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 05:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jNvAy-0003Q2-KD
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 05:14:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jNvAy-0003OA-E1
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 05:14:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id i27so5561089ota.7
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kYAM7PlZDHl7Wwe2gCX+OZrDZmyk/z/ltRLBPUWK0sw=;
 b=Ot1KbWz4Qnj99WoL9dmaqF0JZBRI8kpYViG6/K5qBlOeWxVMtDWFxtltnVg+60OZ4f
 frrVFBtHqVN3zdl3QLMRsdOKJEMBmymgP0og813H0k0+U7xKsEvzEyxjSlDIyfdzfPZw
 g2BToKn+2fWZ4cESM9+OsuGC8IwgxqhHDLJmBN1gFXtRfBbQoJKQxEpHlLxCNs5+9V/Z
 FXCyrfZQkgter+EVAgjDag9BgxeR5RT0v6pclYEcHQldZ+oHFeex+TqlIlkQS9AHNC2C
 Zi3yD93XoCUmUVLvDfnLtBA4b2h8ksNekBJYBh+aZSWfjrfOJ3topEXQ449xCnDf7DdB
 60Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kYAM7PlZDHl7Wwe2gCX+OZrDZmyk/z/ltRLBPUWK0sw=;
 b=nc7o7WLuAVF99YhVBjCDQYdIwY2LLJQc14tx9U2SvAMlYSv1eldXwZvlS+5Vqo/AS2
 ZIhIODOlOWQP/jxHGzrqLItBQT5hi44eLGzA79cXGYiSd2RGRXYCqEZq0fsfhjAx28Qf
 FhzcZBaBQvevVlWN6/h/a4DIl0sdvi4kMm7RejbJXNFN2v/diAH/ryiv9s5R/sEd2hkK
 EAro5J9T1bU9gcDmtNz7CC3Lq9pnwwownMkLeUWMPw+CpY0DdN3GV206n6wfUmV7ooAj
 xz15ViY5KQ3ICvsiIbSOJGX8hwpl1PjD3ozI10ucjxirmZyLvIGnX8ufcaYSXKigAWxL
 eFyw==
X-Gm-Message-State: AGi0PubaQ29NGgJVrqPJ6IWY56IfPDx/r9i6EBmYXI4ZM986Q0hB6PVq
 EPqFmzmytt2lr/p5IaSVfFkfORKnsI/6frOOHNw=
X-Google-Smtp-Source: APiQypIkoQEcYlO0UjnRJvXQZ+zeNfUW2+E3agHSInJhRLCmjcPabGlyXE7shGk9UVOzGl9xpzsHmoIB2s5Mbs93QgY=
X-Received: by 2002:a9d:423:: with SMTP id 32mr4046461otc.334.1586769281744;
 Mon, 13 Apr 2020 02:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200401162023.GA15912@simran-Inspiron-5558>
In-Reply-To: <20200401162023.GA15912@simran-Inspiron-5558>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Mon, 13 Apr 2020 12:14:30 +0300
Message-ID: <CAMPkWoMNjWuVKtHsk3s6S=EXdQZ_LmdsAi4xSbjUQcyN1oLDkA@mail.gmail.com>
Subject: Re: [PATCH] lockable: Replace locks with lock guard macros
To: Simran Singhal <singhalsimran0@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000061046c05a32883dc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000061046c05a32883dc
Content-Type: text/plain; charset="UTF-8"

For the hw/rdma stuff:

Reviewed-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
Tested-by: Yuval Shaia <yuval.shaia.ml@gmail.com>

Thanks,
Yuval

On Wed, 1 Apr 2020 at 19:20, Simran Singhal <singhalsimran0@gmail.com>
wrote:

> Replace manual lock()/unlock() calls with lock guard macros
> (QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).
>
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>  hw/hyperv/hyperv.c     | 15 ++++++-------
>  hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
>  hw/rdma/rdma_rm.c      |  3 +--
>  hw/rdma/rdma_utils.c   | 15 +++++--------
>  4 files changed, 39 insertions(+), 44 deletions(-)
>
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 8ca3706f5b..4ddafe1de1 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -15,6 +15,7 @@
>  #include "sysemu/kvm.h"
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
> +#include "qemu/lockable.h"
>  #include "qemu/queue.h"
>  #include "qemu/rcu.h"
>  #include "qemu/rcu_queue.h"
> @@ -491,7 +492,7 @@ int hyperv_set_msg_handler(uint32_t conn_id,
> HvMsgHandler handler, void *data)
>      int ret;
>      MsgHandler *mh;
>
> -    qemu_mutex_lock(&handlers_mutex);
> +    QEMU_LOCK_GUARD(&handlers_mutex);
>      QLIST_FOREACH(mh, &msg_handlers, link) {
>          if (mh->conn_id == conn_id) {
>              if (handler) {
> @@ -501,7 +502,7 @@ int hyperv_set_msg_handler(uint32_t conn_id,
> HvMsgHandler handler, void *data)
>                  g_free_rcu(mh, rcu);
>                  ret = 0;
>              }
> -            goto unlock;
> +            return ret;
>          }
>      }
>
> @@ -515,8 +516,7 @@ int hyperv_set_msg_handler(uint32_t conn_id,
> HvMsgHandler handler, void *data)
>      } else {
>          ret = -ENOENT;
>      }
> -unlock:
> -    qemu_mutex_unlock(&handlers_mutex);
> +
>      return ret;
>  }
>
> @@ -565,7 +565,7 @@ static int set_event_flag_handler(uint32_t conn_id,
> EventNotifier *notifier)
>      int ret;
>      EventFlagHandler *handler;
>
> -    qemu_mutex_lock(&handlers_mutex);
> +    QEMU_LOCK_GUARD(&handlers_mutex);
>      QLIST_FOREACH(handler, &event_flag_handlers, link) {
>          if (handler->conn_id == conn_id) {
>              if (notifier) {
> @@ -575,7 +575,7 @@ static int set_event_flag_handler(uint32_t conn_id,
> EventNotifier *notifier)
>                  g_free_rcu(handler, rcu);
>                  ret = 0;
>              }
> -            goto unlock;
> +            return ret;
>          }
>      }
>
> @@ -588,8 +588,7 @@ static int set_event_flag_handler(uint32_t conn_id,
> EventNotifier *notifier)
>      } else {
>          ret = -ENOENT;
>      }
> -unlock:
> -    qemu_mutex_unlock(&handlers_mutex);
> +
>      return ret;
>  }
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 3dd39fe1a7..db7e5c8be5 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -95,36 +95,36 @@ static int rdma_poll_cq(RdmaDeviceResources
> *rdma_dev_res, struct ibv_cq *ibcq)
>      struct ibv_wc wc[2];
>      RdmaProtectedGSList *cqe_ctx_list;
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
> +                rdma_protected_gslist_remove_int32(cqe_ctx_list,
> wc[i].wr_id);
> +                rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> +                g_free(bctx);
> +            }
> +            total_ne += ne;
> +        } while (ne > 0);
> +        atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
> +    }
>
>      if (ne < 0) {
>          rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 7e9ea283c9..60957f88db 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -147,14 +147,13 @@ static inline void rdma_res_tbl_dealloc(RdmaRmResTbl
> *tbl, uint32_t handle)
>  {
>      trace_rdma_res_tbl_dealloc(tbl->name, handle);
>
> -    qemu_mutex_lock(&tbl->lock);
> +    QEMU_LOCK_GUARD(&tbl->lock);
>
>      if (handle < tbl->tbl_sz) {
>          clear_bit(handle, tbl->bitmap);
>          tbl->used--;
>      }
>
> -    qemu_mutex_unlock(&tbl->lock);
>  }
>
>  int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev
> *backend_dev,
> diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
> index 73f279104c..ef43606c84 100644
> --- a/hw/rdma/rdma_utils.c
> +++ b/hw/rdma/rdma_utils.c
> @@ -71,18 +71,17 @@ void rdma_protected_qlist_destroy(RdmaProtectedQList
> *list)
>
>  void rdma_protected_qlist_append_int64(RdmaProtectedQList *list, int64_t
> value)
>  {
> -    qemu_mutex_lock(&list->lock);
> +    QEMU_LOCK_GUARD(&list->lock);
>      qlist_append_int(list->list, value);
> -    qemu_mutex_unlock(&list->lock);
>  }
>
>  int64_t rdma_protected_qlist_pop_int64(RdmaProtectedQList *list)
>  {
>      QObject *obj;
>
> -    qemu_mutex_lock(&list->lock);
> -    obj = qlist_pop(list->list);
> -    qemu_mutex_unlock(&list->lock);
> +    WITH_QEMU_LOCK_GUARD(&list->lock) {
> +        obj = qlist_pop(list->list);
> +    }
>
>      if (!obj) {
>          return -ENOENT;
> @@ -107,15 +106,13 @@ void
> rdma_protected_gslist_destroy(RdmaProtectedGSList *list)
>  void rdma_protected_gslist_append_int32(RdmaProtectedGSList *list,
>                                          int32_t value)
>  {
> -    qemu_mutex_lock(&list->lock);
> +    QEMU_LOCK_GUARD(&list->lock);
>      list->list = g_slist_prepend(list->list, GINT_TO_POINTER(value));
> -    qemu_mutex_unlock(&list->lock);
>  }
>
>  void rdma_protected_gslist_remove_int32(RdmaProtectedGSList *list,
>                                          int32_t value)
>  {
> -    qemu_mutex_lock(&list->lock);
> +    QEMU_LOCK_GUARD(&list->lock);
>      list->list = g_slist_remove(list->list, GINT_TO_POINTER(value));
> -    qemu_mutex_unlock(&list->lock);
>  }
> --
> 2.17.1
>
>

--00000000000061046c05a32883dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">For the hw/rdma stuff:<div><br></div><div=
>Reviewed-by: Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia.ml@gmail.com">y=
uval.shaia.ml@gmail.com</a>&gt;</div><div>Tested-by: Yuval Shaia &lt;<a hre=
f=3D"mailto:yuval.shaia.ml@gmail.com">yuval.shaia.ml@gmail.com</a>&gt;=C2=
=A0<br></div></div><div><br></div><div>Thanks,</div><div>Yuval</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 1 Apr=
 2020 at 19:20, Simran Singhal &lt;<a href=3D"mailto:singhalsimran0@gmail.c=
om">singhalsimran0@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Replace manual lock()/unlock() calls with lock =
guard macros<br>
(QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).<br>
<br>
Signed-off-by: Simran Singhal &lt;<a href=3D"mailto:singhalsimran0@gmail.co=
m" target=3D"_blank">singhalsimran0@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/hyperv/hyperv.c=C2=A0 =C2=A0 =C2=A0| 15 ++++++-------<br>
=C2=A0hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++--------------------=
-<br>
=C2=A0hw/rdma/rdma_rm.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +--<br>
=C2=A0hw/rdma/rdma_utils.c=C2=A0 =C2=A0| 15 +++++--------<br>
=C2=A04 files changed, 39 insertions(+), 44 deletions(-)<br>
<br>
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c<br>
index 8ca3706f5b..4ddafe1de1 100644<br>
--- a/hw/hyperv/hyperv.c<br>
+++ b/hw/hyperv/hyperv.c<br>
@@ -15,6 +15,7 @@<br>
=C2=A0#include &quot;sysemu/kvm.h&quot;<br>
=C2=A0#include &quot;qemu/bitops.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
+#include &quot;qemu/lockable.h&quot;<br>
=C2=A0#include &quot;qemu/queue.h&quot;<br>
=C2=A0#include &quot;qemu/rcu.h&quot;<br>
=C2=A0#include &quot;qemu/rcu_queue.h&quot;<br>
@@ -491,7 +492,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandl=
er handler, void *data)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0MsgHandler *mh;<br>
<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;handlers_mutex);<br>
+=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;handlers_mutex);<br>
=C2=A0 =C2=A0 =C2=A0QLIST_FOREACH(mh, &amp;msg_handlers, link) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mh-&gt;conn_id =3D=3D conn_id) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (handler) {<br>
@@ -501,7 +502,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandl=
er handler, void *data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free_rcu(mh=
, rcu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unlock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -515,8 +516,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandl=
er handler, void *data)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOENT;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-unlock:<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;handlers_mutex);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
@@ -565,7 +565,7 @@ static int set_event_flag_handler(uint32_t conn_id, Eve=
ntNotifier *notifier)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0EventFlagHandler *handler;<br>
<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;handlers_mutex);<br>
+=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;handlers_mutex);<br>
=C2=A0 =C2=A0 =C2=A0QLIST_FOREACH(handler, &amp;event_flag_handlers, link) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (handler-&gt;conn_id =3D=3D conn_id) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (notifier) {<br>
@@ -575,7 +575,7 @@ static int set_event_flag_handler(uint32_t conn_id, Eve=
ntNotifier *notifier)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free_rcu(ha=
ndler, rcu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unlock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -588,8 +588,7 @@ static int set_event_flag_handler(uint32_t conn_id, Eve=
ntNotifier *notifier)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOENT;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-unlock:<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;handlers_mutex);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c<br>
index 3dd39fe1a7..db7e5c8be5 100644<br>
--- a/hw/rdma/rdma_backend.c<br>
+++ b/hw/rdma/rdma_backend.c<br>
@@ -95,36 +95,36 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_r=
es, struct ibv_cq *ibcq)<br>
=C2=A0 =C2=A0 =C2=A0struct ibv_wc wc[2];<br>
=C2=A0 =C2=A0 =C2=A0RdmaProtectedGSList *cqe_ctx_list;<br>
<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;rdma_dev_res-&gt;lock);<br>
-=C2=A0 =C2=A0 do {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ne =3D ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);<=
br>
+=C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;rdma_dev_res-&gt;lock) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ne =3D ibv_poll_cq(ibcq, ARRAY_S=
IZE(wc), wc);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_rdma_poll_cq(ne, ibcq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_rdma_poll_cq(ne, ibcq);<br=
>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ne; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bctx =3D rdma_rm_get_cqe_ctx(rdm=
a_dev_res, wc[i].wr_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(!bctx)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_error_report(=
&quot;No matching ctx for req %&quot;PRId64,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wc[i].wr_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ne; i++) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bctx =3D rdma_rm_g=
et_cqe_ctx(rdma_dev_res, wc[i].wr_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(!bctx=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma=
_error_report(&quot;No matching ctx for req %&quot;PRId64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wc[i].wr_id);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cont=
inue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 comp_handler(bctx-&gt;up_ctx, &a=
mp;wc[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 comp_handler(bctx-=
&gt;up_ctx, &amp;wc[i]);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bctx-&gt;backend_qp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cqe_ctx_list =3D &=
amp;bctx-&gt;backend_qp-&gt;cqe_ctx_list;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cqe_ctx_list =3D &=
amp;bctx-&gt;backend_srq-&gt;cqe_ctx_list;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bctx-&gt;backe=
nd_qp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cqe_=
ctx_list =3D &amp;bctx-&gt;backend_qp-&gt;cqe_ctx_list;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cqe_=
ctx_list =3D &amp;bctx-&gt;backend_srq-&gt;cqe_ctx_list;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_protected_gslist_remove_int=
32(cqe_ctx_list, wc[i].wr_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_rm_dealloc_cqe_ctx(rdma_dev=
_res, wc[i].wr_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(bctx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ne +=3D ne;<br>
-=C2=A0 =C2=A0 } while (ne &gt; 0);<br>
-=C2=A0 =C2=A0 atomic_sub(&amp;rdma_dev_res-&gt;stats.missing_cqe, total_ne=
);<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;rdma_dev_res-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_protected_gsl=
ist_remove_int32(cqe_ctx_list, wc[i].wr_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_rm_dealloc_cq=
e_ctx(rdma_dev_res, wc[i].wr_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(bctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ne +=3D ne;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (ne &gt; 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_sub(&amp;rdma_dev_res-&gt;stats.missing=
_cqe, total_ne);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ne &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdma_error_report(&quot;ibv_poll_cq fail,=
 rc=3D%d, errno=3D%d&quot;, ne, errno);<br>
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c<br>
index 7e9ea283c9..60957f88db 100644<br>
--- a/hw/rdma/rdma_rm.c<br>
+++ b/hw/rdma/rdma_rm.c<br>
@@ -147,14 +147,13 @@ static inline void rdma_res_tbl_dealloc(RdmaRmResTbl =
*tbl, uint32_t handle)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0trace_rdma_res_tbl_dealloc(tbl-&gt;name, handle);<br>
<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;tbl-&gt;lock);<br>
+=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;tbl-&gt;lock);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (handle &lt; tbl-&gt;tbl_sz) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(handle, tbl-&gt;bitmap);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tbl-&gt;used--;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;tbl-&gt;lock);<br>
=C2=A0}<br>
<br>
=C2=A0int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *ba=
ckend_dev,<br>
diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c<br>
index 73f279104c..ef43606c84 100644<br>
--- a/hw/rdma/rdma_utils.c<br>
+++ b/hw/rdma/rdma_utils.c<br>
@@ -71,18 +71,17 @@ void rdma_protected_qlist_destroy(RdmaProtectedQList *l=
ist)<br>
<br>
=C2=A0void rdma_protected_qlist_append_int64(RdmaProtectedQList *list, int6=
4_t value)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;list-&gt;lock);<br>
+=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;list-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0qlist_append_int(list-&gt;list, value);<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;list-&gt;lock);<br>
=C2=A0}<br>
<br>
=C2=A0int64_t rdma_protected_qlist_pop_int64(RdmaProtectedQList *list)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QObject *obj;<br>
<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;list-&gt;lock);<br>
-=C2=A0 =C2=A0 obj =3D qlist_pop(list-&gt;list);<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;list-&gt;lock);<br>
+=C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;list-&gt;lock) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D qlist_pop(list-&gt;list);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!obj) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOENT;<br>
@@ -107,15 +106,13 @@ void rdma_protected_gslist_destroy(RdmaProtectedGSLis=
t *list)<br>
=C2=A0void rdma_protected_gslist_append_int32(RdmaProtectedGSList *list,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t32_t value)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;list-&gt;lock);<br>
+=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;list-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0list-&gt;list =3D g_slist_prepend(list-&gt;list, GINT_T=
O_POINTER(value));<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;list-&gt;lock);<br>
=C2=A0}<br>
<br>
=C2=A0void rdma_protected_gslist_remove_int32(RdmaProtectedGSList *list,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t32_t value)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;list-&gt;lock);<br>
+=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;list-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0list-&gt;list =3D g_slist_remove(list-&gt;list, GINT_TO=
_POINTER(value));<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;list-&gt;lock);<br>
=C2=A0}<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div></div>

--00000000000061046c05a32883dc--

