Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5BBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7620A206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTnO4lOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7620A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgr53-0003wL-PT
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr49-000349-S2
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:41:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr48-0002fX-RN
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:41:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so6408875wrp.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Jt0ZfUR6BjlQFL1qbh8ufBy9MfSmcmwgSrxyPRsFAA=;
 b=nTnO4lOt0SCtHc8Icyfjz4OHylpQPUQsz94dD6lZp7wDbvEkZd0R4laPb9QXzD9TRd
 F2l+0VHaMt2c4J7tmoGwtgpT2v/OXi2oMOooYB5RTyu/wM2G4Z+pVTlzVqJupnJXpTbQ
 KcCvZRO1xmhvWcS5N2TnHCBCcJX1ekyRDyw9Mqa7xCDwesfmGxj/oJENIgjh2E/EmUCQ
 m3CyJMFb+wgKeTWSG/11W1mLDVFHULFDUbtyX3+301WkehIR4+/bcIa1aalXsAVQIi96
 WJntV8VdzdifrWh6HhAFs4HcPFK7etm+tAHQXsz2cfiqYtcfwpVIa7nmiATWqRGtlqZ8
 aFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Jt0ZfUR6BjlQFL1qbh8ufBy9MfSmcmwgSrxyPRsFAA=;
 b=F0ZyPpxjIPpDI97jo6wjilRMDNZdAu7wwibvafe6UkyfPr+tbaeCpFxv66bGcdgmpL
 RDELYnT9zVJKEM6EtVAwE4qprGuDJ32ngpxlm2Q+c7VOvAOCZbe7jXh5+k4hZ/qtOX8w
 02X8L8NMKfNKaA/kzcRpLvTyGtH7SNfEQM/VD0a7pAa5xqHnPE0DhFq2cabGxe876J+/
 HXcp6Dn/KAbS6x33PUq/1uB5FeUjacg+XHoB/kidgjo9uTbu/D/6Yu7mab1y0LTMDb+E
 hlvJvkX6IrDzrLCLcEnK5is7MJsRFiQActa4GBT/hi9HWYPvJyATZIV/tCWXHrN8WHDU
 tVjQ==
X-Gm-Message-State: AOAM531bs5nrzT27qsZvLm0mUB7Nc9JxLORBp4x7Dr6KabfE/zPmhbo6
 iKst+KSx9e2SaI6vII0oXL3gv/V6atfj/2DKJBk=
X-Google-Smtp-Source: ABdhPJyUfhtDdB2aUQ30jwj+6To00PlDsBNCkiD+0peUgQl9OM3l9LCAKhZRmQjsARkMUROZ3EBh1/YbD9KPeEjT8vQ=
X-Received: by 2002:a5d:4282:: with SMTP id k2mr4678682wrq.196.1591281715375; 
 Thu, 04 Jun 2020 07:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
 <1588533678-23450-3-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1588533678-23450-3-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Jun 2020 16:41:43 +0200
Message-ID: <CAJ+F1C+JWxUF_aVT4jQE6Q2KbR_+bNgF2AkYWMe5RYb-LEV+QQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] Add vhost-user helper to get MemoryRegion data
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: multipart/alternative; boundary="00000000000061f43105a74325b4"
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

--00000000000061f43105a74325b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 21, 2020 at 7:00 AM Raphael Norwitz <raphael.norwitz@nutanix.co=
m>
wrote:

> When setting the memory tables, qemu uses a memory region's userspace
> address to look up the region's MemoryRegion struct. Among other things,
> the MemoryRegion contains the region's offset and associated file
> descriptor, all of which need to be sent to the backend.
>
> With VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, this logic will be
> needed in multiple places, so before feature support is added it
> should be moved to a helper function.
>
> This helper is also used to simplify the vhost_user_can_merge()
> function.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  hw/virtio/vhost-user.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 2e0552d..442b0d6 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -407,6 +407,18 @@ static int vhost_user_set_log_base(struct vhost_dev
> *dev, uint64_t base,
>      return 0;
>  }
>
> +static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t
> *offset,
> +                                            int *fd)
> +{
> +    MemoryRegion *mr;
> +
> +    assert((uintptr_t)addr =3D=3D addr);
> +    mr =3D memory_region_from_host((void *)(uintptr_t)addr, offset);
> +    *fd =3D memory_region_get_fd(mr);
> +
> +    return mr;
> +}
> +
>  static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
>                                         struct vhost_memory_region *src)
>  {
> @@ -433,10 +445,7 @@ static int vhost_user_fill_set_mem_table_msg(struct
> vhost_user *u,
>      for (i =3D 0; i < dev->mem->nregions; ++i) {
>          reg =3D dev->mem->regions + i;
>
> -        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
> -        mr =3D memory_region_from_host((void
> *)(uintptr_t)reg->userspace_addr,
> -                                     &offset);
> -        fd =3D memory_region_get_fd(mr);
> +        mr =3D vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd)=
;
>          if (fd > 0) {
>              if (track_ramblocks) {
>                  assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
> @@ -1551,13 +1560,9 @@ static bool vhost_user_can_merge(struct vhost_dev
> *dev,
>  {
>      ram_addr_t offset;
>      int mfd, rfd;
> -    MemoryRegion *mr;
> -
> -    mr =3D memory_region_from_host((void *)(uintptr_t)start1, &offset);
> -    mfd =3D memory_region_get_fd(mr);
>
> -    mr =3D memory_region_from_host((void *)(uintptr_t)start2, &offset);
> -    rfd =3D memory_region_get_fd(mr);
> +    (void)vhost_user_get_mr_data(start1, &offset, &mfd);
> +    (void)vhost_user_get_mr_data(start2, &offset, &rfd);
>
>      return mfd =3D=3D rfd;
>  }
> --
> 1.8.3.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000061f43105a74325b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 21, 2020 at 7:00 AM Rap=
hael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com">raphael.nor=
witz@nutanix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">When setting the memory tables, qemu uses a memory region&#=
39;s userspace<br>
address to look up the region&#39;s MemoryRegion struct. Among other things=
,<br>
the MemoryRegion contains the region&#39;s offset and associated file<br>
descriptor, all of which need to be sent to the backend.<br>
<br>
With VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, this logic will be<br>
needed in multiple places, so before feature support is added it<br>
should be moved to a helper function.<br>
<br>
This helper is also used to simplify the vhost_user_can_merge()<br>
function.<br>
<br>
Signed-off-by: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutani=
x.com" target=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br></blockquot=
e><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div>=
<div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/virtio/vhost-user.c | 25 +++++++++++++++----------<br>
=C2=A01 file changed, 15 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 2e0552d..442b0d6 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -407,6 +407,18 @@ static int vhost_user_set_log_base(struct vhost_dev *d=
ev, uint64_t base,<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *off=
set,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int *fd)<br>
+{<br>
+=C2=A0 =C2=A0 MemoryRegion *mr;<br>
+<br>
+=C2=A0 =C2=A0 assert((uintptr_t)addr =3D=3D addr);<br>
+=C2=A0 =C2=A0 mr =3D memory_region_from_host((void *)(uintptr_t)addr, offs=
et);<br>
+=C2=A0 =C2=A0 *fd =3D memory_region_get_fd(mr);<br>
+<br>
+=C2=A0 =C2=A0 return mr;<br>
+}<br>
+<br>
=C2=A0static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct v=
host_memory_region *src)<br>
=C2=A0{<br>
@@ -433,10 +445,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vh=
ost_user *u,<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; dev-&gt;mem-&gt;nregions; ++i) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D dev-&gt;mem-&gt;regions + i;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert((uintptr_t)reg-&gt;userspace_addr =3D=
=3D reg-&gt;userspace_addr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mr =3D memory_region_from_host((void *)(uintpt=
r_t)reg-&gt;userspace_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;offset);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D memory_region_get_fd(mr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mr =3D vhost_user_get_mr_data(reg-&gt;userspac=
e_addr, &amp;offset, &amp;fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (track_ramblocks) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(*fd_nu=
m &lt; VHOST_MEMORY_MAX_NREGIONS);<br>
@@ -1551,13 +1560,9 @@ static bool vhost_user_can_merge(struct vhost_dev *d=
ev,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t offset;<br>
=C2=A0 =C2=A0 =C2=A0int mfd, rfd;<br>
-=C2=A0 =C2=A0 MemoryRegion *mr;<br>
-<br>
-=C2=A0 =C2=A0 mr =3D memory_region_from_host((void *)(uintptr_t)start1, &a=
mp;offset);<br>
-=C2=A0 =C2=A0 mfd =3D memory_region_get_fd(mr);<br>
<br>
-=C2=A0 =C2=A0 mr =3D memory_region_from_host((void *)(uintptr_t)start2, &a=
mp;offset);<br>
-=C2=A0 =C2=A0 rfd =3D memory_region_get_fd(mr);<br>
+=C2=A0 =C2=A0 (void)vhost_user_get_mr_data(start1, &amp;offset, &amp;mfd);=
<br>
+=C2=A0 =C2=A0 (void)vhost_user_get_mr_data(start2, &amp;offset, &amp;rfd);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0return mfd =3D=3D rfd;<br>
=C2=A0}<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000061f43105a74325b4--

