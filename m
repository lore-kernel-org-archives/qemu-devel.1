Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27052C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B182078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z33hYi5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B182078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLNI-0000Ne-5j
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jjLMD-0008PP-MR
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:26:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37606)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jjLMC-000677-3R
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:26:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id x13so5773554wrv.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KDM3lF1BPi8fNN741qGhpafup+jb+Ob5Ct/1qOrwuKk=;
 b=Z33hYi5uvVfqIc/NJgCQHNyj102vy7GHlEnXMz4v8rxFhljGcP7SRp0CPtm4AG/D+y
 aPSRgVH2bpCh7Mxbv4S30r0kl6RnBiFagveUy43YBrmDAYQ8aa4j5YlHSNOU6LhZKCkl
 mkQarurjeAiU8kq3gTnPHK3QjpJdbEQjCQmD4dZbZxZc79tyf/RpBrcP4HAGGBVrWt+A
 xMIjXDrF1ZXW7DgRsRmLSYUWnqLsJtv/xzTD8hUd/ZmuZ9AJYcK/7asZoDwoeGnBRIOu
 WYK+JmxyTAwoUGpQAhrxOPAcELy99LIDmU8N8byLqq9V3+Qd1jPJ5s6tWgK3ZGaumEtv
 n30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KDM3lF1BPi8fNN741qGhpafup+jb+Ob5Ct/1qOrwuKk=;
 b=ifkZmP9s0HAjNsHyeKKTaxf0GWObUXxQ8YvvJDDFoSvpCm9HZnHu+ZO+vbG8YIevns
 RhIZzebBo2LFYiFfvMiznYWCGPQTOBE0KbuibyWOV4aZLuT/a/bqXQ2wQqXbQUNpfBuO
 LhCYyKiAACCCuDoAbM+x4q34ggtLUC65iI4eSZ0hhpmvgDbNv2aW4n2Bxz2UGjc09V3D
 iqhWBMq+gLHtj/2eDUKDYtSydbRfylHn1s/f38yY7UmEJpM6kYvJ6r4rKR8yQWho0Uz9
 dC7tNFnmPMj8CH4ZcASXVxN6EF61jguBb8fXykMHf/+0hcmbDenSI/f2Fgw0tE1al3Hn
 nFVA==
X-Gm-Message-State: AOAM533bOhVOLhQPh8qbh0LmNsZ/F6lMjr+HdV7CDPaLMHvprJxfAij3
 6BKMkb9ZnKXhM4fJoki/d4ouFN0PW5sR2NVethI=
X-Google-Smtp-Source: ABdhPJy8eod4+y9BVj/S4Md28axzIJYBMSg0HErsSzAtYW8VLlIFe9uwC90dUEP6isrL83011lqsejHi+M2I4Cn8/gs=
X-Received: by 2002:adf:9544:: with SMTP id 62mr8818965wrs.32.1591874805318;
 Thu, 11 Jun 2020 04:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-2-coiby.xu@gmail.com>
In-Reply-To: <20200604233538.256325-2-coiby.xu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jun 2020 15:26:32 +0400
Message-ID: <CAJ+F1CJuKhAxiWaBNWf4kaqyLur8nUm6SocvJ7EhEP6scWpdBQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] Allow vu_message_read to be replaced
To: Coiby Xu <coiby.xu@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004c497d05a7cd3c18"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, bharatlkmlkvm@gmail.com,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004c497d05a7cd3c18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2020 at 3:36 AM Coiby Xu <coiby.xu@gmail.com> wrote:

> Allow vu_message_read to be replaced by one which will make use of the
> QIOChannel functions. Thus reading vhost-user message won't stall the
> guest.
>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  contrib/libvhost-user/libvhost-user-glib.c |  2 +-
>  contrib/libvhost-user/libvhost-user.c      | 11 ++++++-----
>  contrib/libvhost-user/libvhost-user.h      | 21 +++++++++++++++++++++
>  tests/vhost-user-bridge.c                  |  2 ++
>  tools/virtiofsd/fuse_virtio.c              |  4 ++--
>  5 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user-glib.c
> b/contrib/libvhost-user/libvhost-user-glib.c
> index 53f1ca4cdd..0df2ec9271 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.c
> +++ b/contrib/libvhost-user/libvhost-user-glib.c
> @@ -147,7 +147,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket=
,
>      g_assert(dev);
>      g_assert(iface);
>
> -    if (!vu_init(&dev->parent, max_queues, socket, panic, set_watch,
> +    if (!vu_init(&dev->parent, max_queues, socket, panic, NULL, set_watc=
h,
>                   remove_watch, iface)) {
>          return false;
>      }
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index 3bca996c62..0c7368baa2 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -67,8 +67,6 @@
>  /* The version of inflight buffer */
>  #define INFLIGHT_VERSION 1
>
> -#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
> -
>  /* The version of the protocol we support */
>  #define VHOST_USER_VERSION 1
>  #define LIBVHOST_USER_DEBUG 0
> @@ -412,7 +410,7 @@ vu_process_message_reply(VuDev *dev, const
> VhostUserMsg *vmsg)
>          goto out;
>      }
>
> -    if (!vu_message_read(dev, dev->slave_fd, &msg_reply)) {
> +    if (!dev->read_msg(dev, dev->slave_fd, &msg_reply)) {
>          goto out;
>      }
>
> @@ -647,7 +645,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev,
> VhostUserMsg *vmsg)
>      /* Wait for QEMU to confirm that it's registered the handler for the
>       * faults.
>       */
> -    if (!vu_message_read(dev, dev->sock, vmsg) ||
> +    if (!dev->read_msg(dev, dev->sock, vmsg) ||
>          vmsg->size !=3D sizeof(vmsg->payload.u64) ||
>          vmsg->payload.u64 !=3D 0) {
>          vu_panic(dev, "failed to receive valid ack for postcopy
> set-mem-table");
> @@ -1653,7 +1651,7 @@ vu_dispatch(VuDev *dev)
>      int reply_requested;
>      bool need_reply, success =3D false;
>
> -    if (!vu_message_read(dev, dev->sock, &vmsg)) {
> +    if (!dev->read_msg(dev, dev->sock, &vmsg)) {
>          goto end;
>      }
>
> @@ -1704,6 +1702,7 @@ vu_deinit(VuDev *dev)
>          }
>
>          if (vq->kick_fd !=3D -1) {
> +            dev->remove_watch(dev, vq->kick_fd);
>              close(vq->kick_fd);
>              vq->kick_fd =3D -1;
>          }
> @@ -1751,6 +1750,7 @@ vu_init(VuDev *dev,
>          uint16_t max_queues,
>          int socket,
>          vu_panic_cb panic,
> +        vu_read_msg_cb read_msg,
>          vu_set_watch_cb set_watch,
>          vu_remove_watch_cb remove_watch,
>          const VuDevIface *iface)
> @@ -1768,6 +1768,7 @@ vu_init(VuDev *dev,
>
>      dev->sock =3D socket;
>      dev->panic =3D panic;
> +    dev->read_msg =3D read_msg ? read_msg : vu_message_read;
>      dev->set_watch =3D set_watch;
>      dev->remove_watch =3D remove_watch;
>      dev->iface =3D iface;
> diff --git a/contrib/libvhost-user/libvhost-user.h
> b/contrib/libvhost-user/libvhost-user.h
> index f30394fab6..d756da8548 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -30,6 +30,8 @@
>
>  #define VHOST_MEMORY_MAX_NREGIONS 8
>
> +#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
> +
>  typedef enum VhostSetConfigType {
>      VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
>      VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
> @@ -205,6 +207,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
>  typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
>  typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
>                                    int *do_reply);
> +typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg=
);
>  typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool
> started);
>  typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx)=
;
>  typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t
> len);
> @@ -373,6 +376,23 @@ struct VuDev {
>      bool broken;
>      uint16_t max_queues;
>
> +    /* @read_msg: custom method to read vhost-user message
> +     *
> +     * Read data from vhost_user socket fd and fill up
> +     * the passed VhostUserMsg *vmsg struct.
> +     *
> +     * If reading fails, it should close the received set of file
> +     * descriptors as socket message's auxiliary data.
> +     *
> +     * For the details, please refer to vu_message_read in libvhost-user=
.c
> +     * which will be used by default if not custom method is provided wh=
en
> +     * calling vu_init
> +     *
> +     * Returns: true if vhost-user message successfully received,
> +     *          otherwise return false.
> +     *
> +     */
> +    vu_read_msg_cb read_msg;
>      /* @set_watch: add or update the given fd to the watch set,
>       * call cb when condition is met */
>      vu_set_watch_cb set_watch;
> @@ -416,6 +436,7 @@ bool vu_init(VuDev *dev,
>               uint16_t max_queues,
>               int socket,
>               vu_panic_cb panic,
> +             vu_read_msg_cb read_msg,
>               vu_set_watch_cb set_watch,
>               vu_remove_watch_cb remove_watch,
>               const VuDevIface *iface);
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index 6c3d490611..bd43607a4d 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -520,6 +520,7 @@ vubr_accept_cb(int sock, void *ctx)
>                   VHOST_USER_BRIDGE_MAX_QUEUES,
>                   conn_fd,
>                   vubr_panic,
> +                 NULL,
>                   vubr_set_watch,
>                   vubr_remove_watch,
>                   &vuiface)) {
> @@ -573,6 +574,7 @@ vubr_new(const char *path, bool client)
>                       VHOST_USER_BRIDGE_MAX_QUEUES,
>                       dev->sock,
>                       vubr_panic,
> +                     NULL,
>                       vubr_set_watch,
>                       vubr_remove_watch,
>                       &vuiface)) {
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.=
c
> index 3b6d16a041..666945c897 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -980,8 +980,8 @@ int virtio_session_mount(struct fuse_session *se)
>      se->vu_socketfd =3D data_sock;
>      se->virtio_dev->se =3D se;
>      pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
> -    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic,
> fv_set_watch,
> -            fv_remove_watch, &fv_iface);
> +    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
> +            fv_set_watch, fv_remove_watch, &fv_iface);
>
>      return 0;
>  }
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000004c497d05a7cd3c18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 5, 2020 at 3:36 AM Coiby =
Xu &lt;<a href=3D"mailto:coiby.xu@gmail.com">coiby.xu@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Allow vu_mes=
sage_read to be replaced by one which will make use of the<br>
QIOChannel functions. Thus reading vhost-user message won&#39;t stall the<b=
r>
guest.<br>
<br>
Signed-off-by: Coiby Xu &lt;<a href=3D"mailto:coiby.xu@gmail.com" target=3D=
"_blank">coiby.xu@gmail.com</a>&gt;<br></blockquote><div><br></div><div>Rev=
iewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@red=
hat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0contrib/libvhost-user/libvhost-user-glib.c |=C2=A0 2 +-<br>
=C2=A0contrib/libvhost-user/libvhost-user.c=C2=A0 =C2=A0 =C2=A0 | 11 ++++++=
-----<br>
=C2=A0contrib/libvhost-user/libvhost-user.h=C2=A0 =C2=A0 =C2=A0 | 21 ++++++=
+++++++++++++++<br>
=C2=A0tests/vhost-user-bridge.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0tools/virtiofsd/fuse_virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A05 files changed, 32 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-=
user/libvhost-user-glib.c<br>
index 53f1ca4cdd..0df2ec9271 100644<br>
--- a/contrib/libvhost-user/libvhost-user-glib.c<br>
+++ b/contrib/libvhost-user/libvhost-user-glib.c<br>
@@ -147,7 +147,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket,<=
br>
=C2=A0 =C2=A0 =C2=A0g_assert(dev);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(iface);<br>
<br>
-=C2=A0 =C2=A0 if (!vu_init(&amp;dev-&gt;parent, max_queues, socket, panic,=
 set_watch,<br>
+=C2=A0 =C2=A0 if (!vu_init(&amp;dev-&gt;parent, max_queues, socket, panic,=
 NULL, set_watch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_watch=
, iface)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c<br>
index 3bca996c62..0c7368baa2 100644<br>
--- a/contrib/libvhost-user/libvhost-user.c<br>
+++ b/contrib/libvhost-user/libvhost-user.c<br>
@@ -67,8 +67,6 @@<br>
=C2=A0/* The version of inflight buffer */<br>
=C2=A0#define INFLIGHT_VERSION 1<br>
<br>
-#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)<br>
-<br>
=C2=A0/* The version of the protocol we support */<br>
=C2=A0#define VHOST_USER_VERSION 1<br>
=C2=A0#define LIBVHOST_USER_DEBUG 0<br>
@@ -412,7 +410,7 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg=
 *vmsg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!vu_message_read(dev, dev-&gt;slave_fd, &amp;msg_reply))=
 {<br>
+=C2=A0 =C2=A0 if (!dev-&gt;read_msg(dev, dev-&gt;slave_fd, &amp;msg_reply)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -647,7 +645,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg=
 *vmsg)<br>
=C2=A0 =C2=A0 =C2=A0/* Wait for QEMU to confirm that it&#39;s registered th=
e handler for the<br>
=C2=A0 =C2=A0 =C2=A0 * faults.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (!vu_message_read(dev, dev-&gt;sock, vmsg) ||<br>
+=C2=A0 =C2=A0 if (!dev-&gt;read_msg(dev, dev-&gt;sock, vmsg) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsg-&gt;size !=3D sizeof(vmsg-&gt;payloa=
d.u64) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsg-&gt;payload.u64 !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vu_panic(dev, &quot;failed to receive val=
id ack for postcopy set-mem-table&quot;);<br>
@@ -1653,7 +1651,7 @@ vu_dispatch(VuDev *dev)<br>
=C2=A0 =C2=A0 =C2=A0int reply_requested;<br>
=C2=A0 =C2=A0 =C2=A0bool need_reply, success =3D false;<br>
<br>
-=C2=A0 =C2=A0 if (!vu_message_read(dev, dev-&gt;sock, &amp;vmsg)) {<br>
+=C2=A0 =C2=A0 if (!dev-&gt;read_msg(dev, dev-&gt;sock, &amp;vmsg)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1704,6 +1702,7 @@ vu_deinit(VuDev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vq-&gt;kick_fd !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;remove_watch(dev, vq-&gt=
;kick_fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(vq-&gt;kick_fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vq-&gt;kick_fd =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1751,6 +1750,7 @@ vu_init(VuDev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t max_queues,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int socket,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vu_panic_cb panic,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_read_msg_cb read_msg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vu_set_watch_cb set_watch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vu_remove_watch_cb remove_watch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const VuDevIface *iface)<br>
@@ -1768,6 +1768,7 @@ vu_init(VuDev *dev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;sock =3D socket;<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;panic =3D panic;<br>
+=C2=A0 =C2=A0 dev-&gt;read_msg =3D read_msg ? read_msg : vu_message_read;<=
br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;set_watch =3D set_watch;<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;remove_watch =3D remove_watch;<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;iface =3D iface;<br>
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/=
libvhost-user.h<br>
index f30394fab6..d756da8548 100644<br>
--- a/contrib/libvhost-user/libvhost-user.h<br>
+++ b/contrib/libvhost-user/libvhost-user.h<br>
@@ -30,6 +30,8 @@<br>
<br>
=C2=A0#define VHOST_MEMORY_MAX_NREGIONS 8<br>
<br>
+#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)<br>
+<br>
=C2=A0typedef enum VhostSetConfigType {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MASTER =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,<br>
@@ -205,6 +207,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);<br=
>
=C2=A0typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);<b=
r>
=C2=A0typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *do_reply);<br>
+typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);=
<br>
=C2=A0typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool s=
tarted);<br>
=C2=A0typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qi=
dx);<br>
=C2=A0typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_=
t len);<br>
@@ -373,6 +376,23 @@ struct VuDev {<br>
=C2=A0 =C2=A0 =C2=A0bool broken;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t max_queues;<br>
<br>
+=C2=A0 =C2=A0 /* @read_msg: custom method to read vhost-user message<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Read data from vhost_user socket fd and fill up<br>
+=C2=A0 =C2=A0 =C2=A0* the passed VhostUserMsg *vmsg struct.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* If reading fails, it should close the received set o=
f file<br>
+=C2=A0 =C2=A0 =C2=A0* descriptors as socket message&#39;s auxiliary data.<=
br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* For the details, please refer to vu_message_read in =
libvhost-user.c<br>
+=C2=A0 =C2=A0 =C2=A0* which will be used by default if not custom method i=
s provided when<br>
+=C2=A0 =C2=A0 =C2=A0* calling vu_init<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Returns: true if vhost-user message successfully rec=
eived,<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherwise return f=
alse.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 vu_read_msg_cb read_msg;<br>
=C2=A0 =C2=A0 =C2=A0/* @set_watch: add or update the given fd to the watch =
set,<br>
=C2=A0 =C2=A0 =C2=A0 * call cb when condition is met */<br>
=C2=A0 =C2=A0 =C2=A0vu_set_watch_cb set_watch;<br>
@@ -416,6 +436,7 @@ bool vu_init(VuDev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t max_queues,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int socket,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic_cb panic,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vu_read_msg_cb read_msg,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_set_watch_cb set_watch,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_remove_watch_cb remove_=
watch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const VuDevIface *iface);<=
br>
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c<br>
index 6c3d490611..bd43607a4d 100644<br>
--- a/tests/vhost-user-bridge.c<br>
+++ b/tests/vhost-user-bridge.c<br>
@@ -520,6 +520,7 @@ vubr_accept_cb(int sock, void *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_USER_B=
RIDGE_MAX_QUEUES,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conn_fd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vubr_panic,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vubr_set_wat=
ch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vubr_remove_=
watch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vuiface=
)) {<br>
@@ -573,6 +574,7 @@ vubr_new(const char *path, bool client)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 VHOST_USER_BRIDGE_MAX_QUEUES,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev-&gt;sock,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 vubr_panic,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 vubr_set_watch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 vubr_remove_watch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;vuiface)) {<br>
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c<=
br>
index 3b6d16a041..666945c897 100644<br>
--- a/tools/virtiofsd/fuse_virtio.c<br>
+++ b/tools/virtiofsd/fuse_virtio.c<br>
@@ -980,8 +980,8 @@ int virtio_session_mount(struct fuse_session *se)<br>
=C2=A0 =C2=A0 =C2=A0se-&gt;vu_socketfd =3D data_sock;<br>
=C2=A0 =C2=A0 =C2=A0se-&gt;virtio_dev-&gt;se =3D se;<br>
=C2=A0 =C2=A0 =C2=A0pthread_rwlock_init(&amp;se-&gt;virtio_dev-&gt;vu_dispa=
tch_rwlock, NULL);<br>
-=C2=A0 =C2=A0 vu_init(&amp;se-&gt;virtio_dev-&gt;dev, 2, se-&gt;vu_socketf=
d, fv_panic, fv_set_watch,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fv_remove_watch, &amp;fv_iface);=
<br>
+=C2=A0 =C2=A0 vu_init(&amp;se-&gt;virtio_dev-&gt;dev, 2, se-&gt;vu_socketf=
d, fv_panic, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fv_set_watch, fv_remove_watch, &=
amp;fv_iface);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000004c497d05a7cd3c18--

