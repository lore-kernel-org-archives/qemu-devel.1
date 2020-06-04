Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528C4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B1A206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmu9Lp6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B1A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgr4S-00038v-CG
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr3L-0002Tl-Eo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:41:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr3K-0002aX-C0
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:41:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so6422865wru.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JyGeMoO8rRCp8sgHiuENgXDN0sS6FwV7qcTLurSbkSs=;
 b=Jmu9Lp6u02ev/NAtb9McaSOHmYRcOf0rQWJT31CtIpMAExkGSD5/I9lH67Wyluk5Zk
 bGxZXTSP0GeIzSfuxFsQOxfJ84NW3C8nzyiOyEfWh/YSBaOqUO9S8DKlwURnsDZfQce0
 f9Bfbkj6uocnTnCe9ucID4CRGXV6rXj6LLiYENEt5Jg/uRgJW4OezFb6fC+Ng9Mw/2dA
 u46GMLFeOPo3Y1iWaBY5eav8SrNNiSWIBH/mJoeZooRrMZf/ag88YtH/ICvvenyX8EAo
 ulS5fxcMmm8nZcTRtDqZAyiV6oTtUPcSDQhAujQzAoV/M/u9uf3XQMcNjNbbKbQSrU3o
 jWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JyGeMoO8rRCp8sgHiuENgXDN0sS6FwV7qcTLurSbkSs=;
 b=n5ryvjS8iabrYR0wuA/a4sVNSJ41y9gOzj3YfSQ16WfonPE4ZkPVbg9xXtzMhMZq/P
 RjLK6iMDM/YiWO08TvwwPkgrvs1iqegr0pOgQBdB5fTmF/FEu7aYFqbxm9rbcUjepRmZ
 TLF/ZBUkrnvWByXrDgveL4fNpP2rkA21PqoLwzDPuoaakbIXy336nts9eoxdOVT/CVIy
 Z57Arm5UwXCzvHLED30pb3+xBtyBkzjHelPw+c/q0BnX4uvBRi0Y/GDTYn/TRKi5U4yz
 KXBzKSGJavjmmF3wNM+tIKZdkvbdpIMU4pJ6A/haeH5Up83n2t6x/aqeoZhdjS+7zd0c
 9f9g==
X-Gm-Message-State: AOAM532LLQX0TmGTzpZz+3EzbEP+eejRrD6q6s5kb+B2Na99idH98L9a
 +pGW+YspwSzcKs3nO42CbvPkD7/6rsHtPvRG5iw=
X-Google-Smtp-Source: ABdhPJwTRpisA7TzYvH4Z6KVnC8wyUch3b3ic46624uax2K3zVAkCZdjl2GOHRzAB45nQgv4XNC7LfFZ4FcWEa/KWHc=
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr4469060wrt.381.1591281662918; 
 Thu, 04 Jun 2020 07:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
 <1588533678-23450-2-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1588533678-23450-2-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Jun 2020 16:40:51 +0200
Message-ID: <CAJ+F1CJPA4FtsFLxsKJR2vK1YRidTe6g=V21XaMKAL3+byOi-Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] Add helper to populate vhost-user message regions
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: multipart/alternative; boundary="00000000000041867705a743220a"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Raphael Norwitz <raphael.s.norwitz@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000041867705a743220a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 7:00 AM Raphael Norwitz <raphael.norwitz@nutanix.co=
m>
wrote:

> When setting vhost-user memory tables, memory region descriptors must be
> copied from the vhost_dev struct to the vhost-user message. To avoid
> duplicating code in setting the memory tables, we should use a helper to
> populate this field. This change adds this helper.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  hw/virtio/vhost-user.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ec21e8f..2e0552d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -407,6 +407,15 @@ static int vhost_user_set_log_base(struct vhost_dev
> *dev, uint64_t base,
>      return 0;
>  }
>
> +static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
> +                                       struct vhost_memory_region *src)
> +{
> +    assert(src !=3D NULL && dst !=3D NULL);
> +    dst->userspace_addr =3D src->userspace_addr;
> +    dst->memory_size =3D src->memory_size;
> +    dst->guest_phys_addr =3D src->guest_phys_addr;
> +}
> +
>  static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
>                                               struct vhost_dev *dev,
>                                               VhostUserMsg *msg,
> @@ -417,6 +426,7 @@ static int vhost_user_fill_set_mem_table_msg(struct
> vhost_user *u,
>      ram_addr_t offset;
>      MemoryRegion *mr;
>      struct vhost_memory_region *reg;
> +    VhostUserMemoryRegion region_buffer;
>
>      msg->hdr.request =3D VHOST_USER_SET_MEM_TABLE;
>
> @@ -441,12 +451,8 @@ static int vhost_user_fill_set_mem_table_msg(struct
> vhost_user *u,
>                  error_report("Failed preparing vhost-user memory table
> msg");
>                  return -1;
>              }
> -            msg->payload.memory.regions[*fd_num].userspace_addr =3D
> -                reg->userspace_addr;
> -            msg->payload.memory.regions[*fd_num].memory_size =3D
> -                reg->memory_size;
> -            msg->payload.memory.regions[*fd_num].guest_phys_addr =3D
> -                reg->guest_phys_addr;
> +            vhost_user_fill_msg_region(&region_buffer, reg);
> +            msg->payload.memory.regions[*fd_num] =3D region_buffer;
>              msg->payload.memory.regions[*fd_num].mmap_offset =3D offset;
>              fds[(*fd_num)++] =3D fd;
>          } else if (track_ramblocks) {
> --
> 1.8.3.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000041867705a743220a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 21, 2020 at 7:00 AM Rapha=
el Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com">raphael.norwi=
tz@nutanix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">When setting vhost-user memory tables, memory region descript=
ors must be<br>
copied from the vhost_dev struct to the vhost-user message. To avoid<br>
duplicating code in setting the memory tables, we should use a helper to<br=
>
populate this field. This change adds this helper.<br>
<br>
Signed-off-by: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutani=
x.com" target=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br></blockquot=
e><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div>=
<div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/virtio/vhost-user.c | 18 ++++++++++++------<br>
=C2=A01 file changed, 12 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index ec21e8f..2e0552d 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -407,6 +407,15 @@ static int vhost_user_set_log_base(struct vhost_dev *d=
ev, uint64_t base,<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vh=
ost_memory_region *src)<br>
+{<br>
+=C2=A0 =C2=A0 assert(src !=3D NULL &amp;&amp; dst !=3D NULL);<br>
+=C2=A0 =C2=A0 dst-&gt;userspace_addr =3D src-&gt;userspace_addr;<br>
+=C2=A0 =C2=A0 dst-&gt;memory_size =3D src-&gt;memory_size;<br>
+=C2=A0 =C2=A0 dst-&gt;guest_phys_addr =3D src-&gt;guest_phys_addr;<br>
+}<br>
+<br>
=C2=A0static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct vhost_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 VhostUserMsg *msg,<br>
@@ -417,6 +426,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vho=
st_user *u,<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t offset;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *mr;<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_memory_region *reg;<br>
+=C2=A0 =C2=A0 VhostUserMemoryRegion region_buffer;<br>
<br>
=C2=A0 =C2=A0 =C2=A0msg-&gt;hdr.request =3D VHOST_USER_SET_MEM_TABLE;<br>
<br>
@@ -441,12 +451,8 @@ static int vhost_user_fill_set_mem_table_msg(struct vh=
ost_user *u,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(=
&quot;Failed preparing vhost-user memory table msg&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;payload.memory.regions[*=
fd_num].userspace_addr =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;userspace_=
addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;payload.memory.regions[*=
fd_num].memory_size =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;memory_siz=
e;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;payload.memory.regions[*=
fd_num].guest_phys_addr =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg-&gt;guest_phys=
_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user_fill_msg_region(&amp;=
region_buffer, reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;payload.memory.regions[*=
fd_num] =3D region_buffer;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg-&gt;payload.memory.regi=
ons[*fd_num].mmap_offset =3D offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fds[(*fd_num)++] =3D fd;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (track_ramblocks) {<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000041867705a743220a--

