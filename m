Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23323C2D0DD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 06:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D445B2053B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 06:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="sHREuGSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D445B2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imuLr-0008Bg-W1
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 01:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1imuLG-0007kR-E5
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 01:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1imuLF-0000jP-5D
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 01:52:22 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1imuLE-0000j8-Su
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 01:52:21 -0500
Received: by mail-io1-xd41.google.com with SMTP id i11so37398816ioi.12
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 22:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YDBWSMCEbUKVxD/aXrvWJYYnrpdv/8h4uRyORHdMRzo=;
 b=sHREuGSGAvxpAnAV/UHRaz5d6M4vKsN7lFDkjqx7vi/eAeAHxlod5LO7k13nctIpx6
 KTZRRbKt9DQ6Xmk2cT3yNi1C7Rhrc2uhMltc7t3qS1EEsyD4AtkZETTODx5gv88KWBL4
 A/JKidZNvmbSlykLKUEO8bRCHoLXnCHFyXx93O8JVz3XuOupfZnWsCYhj35GTVSxQ7eO
 nPtvSUbicB9wA94NCwSckVmOjhx5wxMu0ULGTEko2lCNWYQiWqFnTksVcQQU7u4D6RG7
 SAMaeteTbYFUGk+plqv0Pu+IdDXshQxOYogQbuGlxtOqoA7Ke45BP3DDNeBZ1t/HrcbE
 wPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YDBWSMCEbUKVxD/aXrvWJYYnrpdv/8h4uRyORHdMRzo=;
 b=Z4YWNPikawvRmWQWcFIzMZX/vjvGrfzudUqR4FTG/neEpl57V0WFzASwR7CoKPx9jl
 uebFm+I5CfAKwDYgr4zwhf10hy1aFB2e6Vtm+F5wjQaq26+Lq+0DYQeaJk9me2oFLnyn
 3RfsT8g/nATQ4rFL0Kjhsaj2vhZMsJBnlaX6LsTVRzz/OeA/DIf+yHtCYoO053Babhud
 tjuEITe0PGb9G1QAddMGEFMxeQW/+5Vo0xEzSyVEjNNq/NqmNvSy7ZDoKOblqY8wFEdM
 BUaoOUt1e/BGlyAuRnFO9T9ul7pM38s4bWskn5/R5bFgSXaV5A4E/z29cqzHMB1lfgWo
 9pUw==
X-Gm-Message-State: APjAAAVe1CQ7s2e4Gv048uf3knnkHJ5W/VpO1v0yy0km1qcP1fO2UaZH
 RGNbO8XCiwmkGOmVIKAmABXOVUqDYfsodEgWTI6C/Q==
X-Google-Smtp-Source: APXvYqxAmyBj5/odEXMpJFu5sjwfU8KIDB1T6zhE6kEWqvqp1JczBTDbQlNo7+0RbMIiJnfoGOKEwCdn6SzIaUI22DI=
X-Received: by 2002:a6b:7119:: with SMTP id q25mr50100557iog.148.1577947939519; 
 Wed, 01 Jan 2020 22:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-3-yuri.benditovich@daynix.com>
 <20200101184128-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200101184128-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 2 Jan 2020 08:52:05 +0200
Message-ID: <CAOEp5Odp0YPoccXVhwcR1pqzSKZErgKTcKneLgJcs8frYNzZSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: delete also control queue when TX/RX
 deleted
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000068ddeb059b22a213"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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

--00000000000068ddeb059b22a213
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 2, 2020 at 1:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Dec 26, 2019 at 06:36:49AM +0200, Yuri Benditovich wrote:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1708480
> > If the control queue is not deleted together with TX/RX, it
> > later will be ignored in freeing cache resources and hot
> > unplug will not be completed.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  hw/net/virtio-net.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index db3d7c38e6..f325440d01 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3101,7 +3101,8 @@ static void
> virtio_net_device_unrealize(DeviceState *dev, Error **errp)
> >      for (i = 0; i < max_queues; i++) {
> >          virtio_net_del_queue(n, i);
> >      }
> > -
> > +    /* delete also control vq */
> > +    virtio_del_queue(vdev, max_queues * 2);
> >      qemu_announce_timer_del(&n->announce_timer, false);
> >      g_free(n->vqs);
> >      qemu_del_nic(n->nic);
>
> Do we need to limit this to when ctrl vq exists?
>

ctrl vq always exists (we _add_ it unconditionally).
we may suggest respective feature or not, but the initialized queue
structure present.


>
> > --
> > 2.17.1
>
>

--00000000000068ddeb059b22a213
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 2, 2020 at 1:43 AM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, De=
c 26, 2019 at 06:36:49AM +0200, Yuri Benditovich wrote:<br>
&gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?=
id=3D1708480</a><br>
&gt; If the control queue is not deleted together with TX/RX, it<br>
&gt; later will be ignored in freeing cache resources and hot<br>
&gt; unplug will not be completed.<br>
&gt; <br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index db3d7c38e6..f325440d01 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -3101,7 +3101,8 @@ static void virtio_net_device_unrealize(DeviceSt=
ate *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; max_queues; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_del_queue(n, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 /* delete also control vq */<br>
&gt; +=C2=A0 =C2=A0 virtio_del_queue(vdev, max_queues * 2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_announce_timer_del(&amp;n-&gt;announce_timer,=
 false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(n-&gt;vqs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_del_nic(n-&gt;nic);<br>
<br>
Do we need to limit this to when ctrl vq exists?<br></blockquote><div><br><=
/div><div>ctrl vq always exists (we _add_ it unconditionally).</div><div>we=
 may suggest respective feature or not, but the initialized queue structure=
 present.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
&gt; -- <br>
&gt; 2.17.1<br>
<br>
</blockquote></div></div>

--00000000000068ddeb059b22a213--

