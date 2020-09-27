Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8021AC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256A623718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Bhlitspe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256A623718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVdT-0002T3-72
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangguoqing.kernel@bytedance.com>)
 id 1kMVcN-00018K-H2
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:17:27 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangguoqing.kernel@bytedance.com>)
 id 1kMVcI-0006jP-Pr
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:17:24 -0400
Received: by mail-qt1-x841.google.com with SMTP id v54so6104847qtj.7
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z1GUAq+ti25UnL/dTTl3O28NWch1eXaZ2DLFfmxfgwk=;
 b=Bhlitspe4kEGPDJtMklUNAS1TFBmIGAuLU66Wz7gph92ECaQRGNUlgc6aYutvpXoDu
 sulpILali+S3fKeHpij2uqaMbcbtH73J1UDHyIln7nAXM3zLjpIC2Vur+ipdaL9rK3ql
 UBA8AkJ5VQ3JIFqgkEdihLZU2GP6RrY7KwMkX4D0hrnlKm/o0pk0yvzs22cd7pQwfzUn
 g4Chc/NSu1i2tHsKz6QfbDfJLxRFBDpFy3C7QJtlqFYBgVLU6srC2c2ruEX4NfqsFj37
 py7G37FZVdymrX3U0vzXYQARtBLxeCRzMThvoEVEoHIijpyF043XsVxbut92wzaap6ZB
 p6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z1GUAq+ti25UnL/dTTl3O28NWch1eXaZ2DLFfmxfgwk=;
 b=r7PlYhTL1ZlOHrYsKcKZIc7OM5W+2n29emXEYf7pb0VVKfY/wDF0EB7S5+SY8TvZqo
 9UjKUPPbpI1ebi7ZeCXobonSTSDqtxB97ej84nJ1lMTja+7YcNb18mWFV8OfhRffB+kV
 RUMyxaHQm8sGYRDBD+fhTXYPfKaOwmXzd+F8QfX3OiMezPYEAuP4FxKbwti+aVXTrIdA
 C2xKdQm3X1HRY/ovcExeQ2BnCI7dipKUEC0YeLqk4onJrtU0DSeIV9JWxk9URYeU4gI0
 lpiMhcm/tDqW9TFZxQEUomFcuhfn8srQKjcTbc8u2ICofPDq+lgacXbW9XLVf8CRP6zT
 EpWg==
X-Gm-Message-State: AOAM531je+rUfCZ+LvhQld8htQfmgZCY3eOF8YWq5y/A59UzxCvoEICK
 ceXIJOgjeDoIWlFFh5OmBjAepO8pyz5fmYq3gDSaYw==
X-Google-Smtp-Source: ABdhPJyg48ZF0m7355V+Wk0ld0fK8lSefESwLpt4278izTimKTbDYfzNcvAdNtpCTuYoVEh8/5zTdRWHGb7VgiCLkzg=
X-Received: by 2002:ac8:474a:: with SMTP id k10mr8180516qtp.115.1601209040866; 
 Sun, 27 Sep 2020 05:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200918111632.37354-1-zhangguoqing.kernel@bytedance.com>
In-Reply-To: <20200918111632.37354-1-zhangguoqing.kernel@bytedance.com>
From: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>
Date: Sun, 27 Sep 2020 20:17:10 +0800
Message-ID: <CAP+YVmQMQ-zk59bdR5Wz4h-2QmOygS_DGnMOYwwLstVwcdWq2g@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-3d: fix abnormal display after a warm reboot
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000017b2aa05b04a88cc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=zhangguoqing.kernel@bytedance.com; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Qi Liu <liuqi.16@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000017b2aa05b04a88cc
Content-Type: text/plain; charset="UTF-8"

hello Gerd and Michael   Michael S. Tsirkin

ping

http://patchwork.ozlabs.org/project/qemu-devel/list/?series=202680

On Fri, Sep 18, 2020 at 7:16 PM Guoqing Zhang <
zhangguoqing.kernel@bytedance.com> wrote:

> When resetting virtio-gpu, virgl_renderer_reset() should be
> called to ensure that the virglrenderer status is correct.
>
> Signed-off-by: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>
> Reviewed-by: Qi Liu<liuqi.16@bytedance.com>
> ---
>  hw/display/virtio-gpu-3d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 96621576c2..1bd33d7aed 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -595,7 +595,7 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>  {
>      int i;
>
> -    /* virgl_renderer_reset() ??? */
> +    virgl_renderer_reset();
>      for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
>          if (i != 0) {
>              dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
> --
> 2.24.3 (Apple Git-128)
>
>

--00000000000017b2aa05b04a88cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>hello=C2=A0Gerd and Michael=C2=A0 =
=C2=A0Michael S. Tsirkin=C2=A0</div><div><br></div>ping<div><br></div><div>=
<a href=3D"http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D20=
2680">http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D202680<=
/a><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, Sep 18, 2020 at 7:16 PM Guoqing Zhang &lt;<a href=3D"m=
ailto:zhangguoqing.kernel@bytedance.com">zhangguoqing.kernel@bytedance.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">W=
hen resetting virtio-gpu, virgl_renderer_reset() should be<br>
called to ensure that the virglrenderer status is correct.<br>
<br>
Signed-off-by: Guoqing Zhang &lt;<a href=3D"mailto:zhangguoqing.kernel@byte=
dance.com" target=3D"_blank">zhangguoqing.kernel@bytedance.com</a>&gt;<br>
Reviewed-by: Qi Liu&lt;<a href=3D"mailto:liuqi.16@bytedance.com" target=3D"=
_blank">liuqi.16@bytedance.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-3d.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c<br>
index 96621576c2..1bd33d7aed 100644<br>
--- a/hw/display/virtio-gpu-3d.c<br>
+++ b/hw/display/virtio-gpu-3d.c<br>
@@ -595,7 +595,7 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
-=C2=A0 =C2=A0 /* virgl_renderer_reset() ??? */<br>
+=C2=A0 =C2=A0 virgl_renderer_reset();<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; g-&gt;parent_obj.conf.max_outputs;=
 i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpy_gfx_replace_surface(g-&=
gt;parent_obj.scanout[i].con, NULL);<br>
-- <br>
2.24.3 (Apple Git-128)<br>
<br>
</blockquote></div></div>

--00000000000017b2aa05b04a88cc--

