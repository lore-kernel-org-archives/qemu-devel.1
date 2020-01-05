Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DD3C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CD42085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="EpOSJ0GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CD42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io8Z9-00055C-DA
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 11:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1io8YS-0004Ym-1L
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 11:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1io8YP-0003Wa-Qe
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 11:15:03 -0500
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35]:33472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1io8YP-0003Vv-Dm
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 11:15:01 -0500
Received: by mail-io1-xd35.google.com with SMTP id z8so46288006ioh.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QCqxL2EP5mtzbZDElWHnLV17EtM+09Z0FwCXpPxBWgQ=;
 b=EpOSJ0GWAdQROZK0/ZCIf2xCxBlVzBuOuom3xm17yHDijS2nvVlgb10wxszthlNWbW
 x3bHsdRLYM6qNDwFO/IC4Cgr1oliPBC/u7P4m3fjUyRq2ZC23Xi9aBiaBseGeF18Ka61
 wtYbAiG3PYcOBxI/H5YNKtLa2E4PRnxQ9bndCgmN7t5QtJHt5+TTTjdly/4pYXLpuIfB
 Ce9xOtSVFjwm8a64oxCvhtJqY0i2o27svwfHe5uln37Wi4cQvlo5b5QsOzCOCylU045x
 aPtk69Jqy4WJxXWkNaYoQ6PFxcJ3pSmtD+6lWYKIdTGpw5bBWkgolspPTGgrooU+hDW/
 a4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QCqxL2EP5mtzbZDElWHnLV17EtM+09Z0FwCXpPxBWgQ=;
 b=QtU+HP1KaD0rz6o8F+oFc1Mrdx+uUHPECPa7McU/wZPRv7rbpwvImNck6B4Tu/rZ7t
 RUK+mDkhv9rZH9b0ZCaTZGBb0zzs4cun/4c+Co/objPOyBQaZ4P7t9hnQm+/fS3mzL5P
 Pd1oWpp6yMygCmtzbz8Dd1CwYqbqodxhWXO2u4czgi4ETo6OJ7+vIDQTqlpjrMqhbxAa
 Hh4T3aOc7aWpNycegXIVhRVjIyPQQ2P4yh30h+PypkX+ZSMMm+KtsOItjrXWOJ8xdxQk
 vbCpMXABLPkCOv0KuKgv+wHTDGnzOOiv8/5R2VW+U6E/hTiKeg8sHoFyc+CDriQO+J2i
 zVvg==
X-Gm-Message-State: APjAAAVXXelmMBOEuGOJbULPRJEgJtWS8Uj+02vjo1yljix4wbVlG203
 efA6OxIPP++w3w6UYxnttfW8e5auLBtDp4TQBCBErg==
X-Google-Smtp-Source: APXvYqyUfBHZui+nW8bGPiIeIFvbTeklg3I6N0fDoTNKy84JqCTaitrjhbBCnhjjTybxh12nOVdrRD/Rzq+qwTnk04w=
X-Received: by 2002:a6b:ed17:: with SMTP id n23mr58838264iog.99.1578240900014; 
 Sun, 05 Jan 2020 08:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
 <20200105071859-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200105071859-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun, 5 Jan 2020 18:14:45 +0200
Message-ID: <CAOEp5OeQx+6MsXPHCrQqo6a7fAo2Lzhd62qAMMY_d9+cgExM=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000373941059b66d8c3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d35
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000373941059b66d8c3
Content-Type: text/plain; charset="UTF-8"

On Sun, Jan 5, 2020 at 2:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Dec 26, 2019 at 06:36:48AM +0200, Yuri Benditovich wrote:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1708480
> > Fix leak of region reference that prevents complete
> > device deletion on hot unplug.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>
> I rebased this on top of my tree.
>
> Got this:
>
>
> commit f3dee6a062c1f4445768296ee39070bab9863372
> Author: Yuri Benditovich <yuri.benditovich@daynix.com>
> Date:   Thu Dec 26 06:36:48 2019 +0200
>
>     virtio: reset region cache when on queue deletion
>
>     https://bugzilla.redhat.com/show_bug.cgi?id=1708480
>     Fix leak of region reference that prevents complete
>     device deletion on hot unplug.
>
>     Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     Message-Id: <20191226043649.14481-2-yuri.benditovich@daynix.com>
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 95d8ff8508..7b861e0ca0 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2344,6 +2344,7 @@ void virtio_delete_queue(VirtQueue *vq)
>      vq->handle_aio_output = NULL;
>      g_free(vq->used_elems);
>      vq->used_elems = NULL;
> +    virtio_virtqueue_reset_region_cache(vq);
>  }
>
>  void virtio_del_queue(VirtIODevice *vdev, int n)
>
> Can you confirm pls?
>

Yes, it is

--000000000000373941059b66d8c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 5, 2020 at 2:22 PM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, De=
c 26, 2019 at 06:36:48AM +0200, Yuri Benditovich wrote:<br>
&gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?=
id=3D1708480</a><br>
&gt; Fix leak of region reference that prevents complete<br>
&gt; device deletion on hot unplug.<br>
&gt; <br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
<br>
I rebased this on top of my tree.<br>
<br>
Got this:<br>
<br>
<br>
commit f3dee6a062c1f4445768296ee39070bab9863372<br>
Author: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.com"=
 target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Thu Dec 26 06:36:48 2019 +0200<br>
<br>
=C2=A0 =C2=A0 virtio: reset region cache when on queue deletion<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1708=
480" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_=
bug.cgi?id=3D1708480</a><br>
=C2=A0 =C2=A0 Fix leak of region reference that prevents complete<br>
=C2=A0 =C2=A0 device deletion on hot unplug.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.be=
nditovich@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;=
<br>
=C2=A0 =C2=A0 Message-Id: &lt;<a href=3D"mailto:20191226043649.14481-2-yuri=
.benditovich@daynix.com" target=3D"_blank">20191226043649.14481-2-yuri.bend=
itovich@daynix.com</a>&gt;<br>
<br>
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
index 95d8ff8508..7b861e0ca0 100644<br>
--- a/hw/virtio/virtio.c<br>
+++ b/hw/virtio/virtio.c<br>
@@ -2344,6 +2344,7 @@ void virtio_delete_queue(VirtQueue *vq)<br>
=C2=A0 =C2=A0 =C2=A0vq-&gt;handle_aio_output =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_free(vq-&gt;used_elems);<br>
=C2=A0 =C2=A0 =C2=A0vq-&gt;used_elems =3D NULL;<br>
+=C2=A0 =C2=A0 virtio_virtqueue_reset_region_cache(vq);<br>
=C2=A0}<br>
<br>
=C2=A0void virtio_del_queue(VirtIODevice *vdev, int n)<br>
<br>
Can you confirm pls?<br></blockquote><div><br></div><div>Yes, it is=C2=A0</=
div></div></div>

--000000000000373941059b66d8c3--

