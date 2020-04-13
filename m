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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687D7C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FEB206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVNbkoi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FEB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNvuA-0004k1-7k
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 06:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jNvt5-0003r2-Iy
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jNvt3-0007p6-NZ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:00:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jNvt3-0007oB-HI
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:00:17 -0400
Received: by mail-ot1-x341.google.com with SMTP id j4so1928606otr.11
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V2FtWkw3+zIOE+sSKjfFtL4cI7YOYZJt13lXvTdFakE=;
 b=SVNbkoi7BqNLal9DY9wvKuerfzmHM/VaZmGyVzRlow9+Qw4r8uFUShiq9DnsldWV5v
 SAjVllq3b0KzORXcaR904znt+qlJo9JQuKwik3s1M8ekJKv+M7N1BH2whO1+EpIWycji
 y5Pyb1OK9pZ3EXV8HC5tz/+D5mDKna0WKzL5CzyCy4ptQP3tBQGDa1O+vq0PcnlPfjNN
 m1TbXh2Pn0NRrWgi+2sUBq+Z3e6rDO2xlGMMekGXg9NbmDT3sXDxdJ13hZqY868Geix5
 j3/ms5F0HLAuLneX3vog5mx1v9X6CvzVx94F69jaVjDpc7FztoVng3rCvpuhlEeiE8Ib
 2vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V2FtWkw3+zIOE+sSKjfFtL4cI7YOYZJt13lXvTdFakE=;
 b=dqOfeYB/rROzrrUcP+8x29P4Ce3gIoyTxrGxhR5q947dPiEFwRfnklyw5Cx42vn9vk
 idFo8zeR+KVI0LyiOV/dCQhXFgCyHR+c6b+klQnfD7sR6ZphjKEZ7cpJU1eEmXC8id0e
 /7Kn5h1RIS47Hl5OgYgmbOebe0F7EVmKU20y7VFmnZIILUvV+QfPYUkesXDvVQAySLda
 RsuFccujQhvJ90G+nVpqIZQ6O5equoLiCVZXXur9tY0a6imHpT/a1m6xUU4s/twRoQZ0
 zPoic6aNQqfOtwmXU86xpianyjPtzZgwII2Ra/3TWYdAEK/GuEwtj5L4JdiZVesR4c4j
 mRTQ==
X-Gm-Message-State: AGi0PuaD4NKbEQGDdAJCNk0N4dlgQyAThUZcQcHGc7yFisLPA+ekNQsh
 vgcAA6IZyz+tUgC3zeLPCIM4HspICUNMBViCBt8=
X-Google-Smtp-Source: APiQypKgR/mVGyOzq4Vg7LTX3wF1S82B/117/JsxWWYnJ6/5g3F8sBreSQCPZzbOsRMQYfbxhlsvYHldx9WbudKnOj4=
X-Received: by 2002:a05:6830:1bef:: with SMTP id
 k15mr13356320otb.372.1586772015194; 
 Mon, 13 Apr 2020 03:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200402065035.GA15477@simran-Inspiron-5558>
In-Reply-To: <20200402065035.GA15477@simran-Inspiron-5558>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Mon, 13 Apr 2020 13:00:04 +0300
Message-ID: <CAMPkWoPWeRzs0ZXcJn+Pz4uHAgkMyNn_fP=Rxvycu4A2UakKvQ@mail.gmail.com>
Subject: Re: [PATCH v2] lockable: Replace locks with lock guard macros
To: Simran Singhal <singhalsimran0@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004e270605a329269e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

--0000000000004e270605a329269e
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2020 at 09:50, Simran Singhal <singhalsimran0@gmail.com>
wrote:

> Replace manual lock()/unlock() calls with lock guard macros
> (QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).
>
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
> Changes in v2:
>         -Drop changes in file hw/rdma/rdma_utils.c
>

So i guess we are expected to see this back soon, right?

Ignore my r-b and t-b for v1, i did not encounter the build errors, this
one is okay too.

For the hw/rdma stuff:

Reviewed-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
Tested-by: Yuval Shaia <yuval.shaia.ml@gmail.com>

Thanks,
Yuval


>
>  hw/hyperv/hyperv.c     | 15 ++++++-------
>  hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
>  hw/rdma/rdma_rm.c      |  3 +--
>  3 files changed, 33 insertions(+), 35 deletions(-)
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
> --
> 2.17.1
>
>

--0000000000004e270605a329269e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 2 Apr 2020 at 09:50, Simran S=
inghal &lt;<a href=3D"mailto:singhalsimran0@gmail.com">singhalsimran0@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Replace manual lock()/unlock() calls with lock guard macros<br>
(QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).<br>
<br>
Signed-off-by: Simran Singhal &lt;<a href=3D"mailto:singhalsimran0@gmail.co=
m" target=3D"_blank">singhalsimran0@gmail.com</a>&gt;<br>
---<br>
Changes in v2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -Drop changes in file hw/rdma/rdma_utils.c<br><=
/blockquote><div><br></div><div>So i guess we are expected to see this back=
 soon, right?</div><div><br></div><div>Ignore my r-b and t-b for v1, i did =
not encounter=C2=A0the build errors, this one is okay too.</div><div><br></=
div><div dir=3D"ltr">For the=C2=A0<span class=3D"gmail-il">hw</span>/<span =
class=3D"gmail-il">rdma</span>=C2=A0stuff:<div><br></div><div>Reviewed-by: =
Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia.ml@gmail.com" target=3D"_blan=
k">yuval.shaia.ml@gmail.com</a>&gt;</div><div>Tested-by: Yuval Shaia &lt;<a=
 href=3D"mailto:yuval.shaia.ml@gmail.com" target=3D"_blank">yuval.shaia.ml@=
gmail.com</a>&gt;=C2=A0<br></div></div><div><br></div><div>Thanks,</div><di=
v>Yuval</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
=C2=A0hw/hyperv/hyperv.c=C2=A0 =C2=A0 =C2=A0| 15 ++++++-------<br>
=C2=A0hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++--------------------=
-<br>
=C2=A0hw/rdma/rdma_rm.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +--<br>
=C2=A03 files changed, 33 insertions(+), 35 deletions(-)<br>
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
-- <br>
2.17.1<br>
<br>
</blockquote></div></div>

--0000000000004e270605a329269e--

