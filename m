Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6083EC2D0DD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 07:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2647020672
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 07:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="YOeywBh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2647020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imucU-0002bU-7c
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 02:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1imubg-0002AI-JG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1imubf-0005Of-58
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:09:20 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:36357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1imubf-0005OS-06
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:09:19 -0500
Received: by mail-io1-xd43.google.com with SMTP id r13so27410033ioa.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 23:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pUfGEOZubPWzi7339q0Mwt55Ltq2QCLf9l7khOCJ7bk=;
 b=YOeywBh+DmzM0n9AU0FTQXA4quLhIoFFjuN4tkFZNkqARi/hZAhtuWis2IlsvBNC68
 4HdNWTH00llx7atXqmSli65apY91QbEvCnlB0oD2orhbbJjlBSr/WOJXi0AuLccLEPIr
 LUONMZofcOZAFHhOlgcY4akY3YAEANPONojxyaQFBbMGmInR/F4kLJxkITSllbBBl2c0
 SevOzoF6/95oNssdMYMFJPt3SWTkJllTcgTt3libY9j8JjV52slkqj5WJ4ssQZHBk52T
 YD3vqjsQueSBiWeRMijyzTZELyexo6d3VTqMZ+UkxnvNl+fsCjnOj2Cd1fgYzvweo8nQ
 g4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pUfGEOZubPWzi7339q0Mwt55Ltq2QCLf9l7khOCJ7bk=;
 b=loPVsMEBiyYboWlenOVmxFYaWWakL1gR4JIz0mSz2roByRI2EVQCzKAPgNzsx3eSKq
 Noo16AN+qdfisz9BxyGYha2ymkLWNpMN3At9BUlx/cWxCvANmHtyTW8TNQgzlcp2Ywfy
 dhJw/XajHyHYkbCyb2667ugmQgobQ6JASplbqJtJ8AElM2AHr9Z7Vyfej0iRrwzlnl+6
 tfLxeVUTY+2Js9aR/FiVo5QCKKJ3WD3K27IjD0etiXYgYwRh5d1Y9qZD20N0sFFBW0h1
 ji0kN9VFO9FX7Ln0ov3vnxIHgu86WVjxrjVzQEXBmGwoCMnVKxpxW7g4cuou08oYizGE
 SiUw==
X-Gm-Message-State: APjAAAWifSKZpq/qJb6Kq2i/37vHTGB/1Uvmzwce2B4VvozGQr/gaPzR
 EZ0CnS3Qcz0bNnHd46y7MO/AQL7p70WiLt6CBppgFw==
X-Google-Smtp-Source: APXvYqyO3HqVBpW61z1V4lXNpLbKRlIi/jzMtN5OTRIjgu2EeO/PyPQ+ky50gmZ2MbEUH0Sf9zCjCHOnJ5+ZJYAUwp0=
X-Received: by 2002:a6b:ec0f:: with SMTP id c15mr50218412ioh.149.1577948958168; 
 Wed, 01 Jan 2020 23:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
 <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
 <CAOEp5OdDj_=c_75FsM45iQnqDYBPz=Fn48FbR2FHcY=5D3rB-Q@mail.gmail.com>
 <20200101184425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200101184425-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 2 Jan 2020 09:09:04 +0200
Message-ID: <CAOEp5Oefmj5dM5auk1QpQ3F+CeJXQy+0aXJC1VNmUOj1KHp8aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000202d4c059b22df16"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Yan Vugenfirer <yan@daynix.com>, pbonzini@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000202d4c059b22df16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2020 at 1:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Dec 26, 2019 at 11:29:50AM +0200, Yuri Benditovich wrote:
> > On Thu, Dec 26, 2019 at 10:58 AM Jason Wang <jasowang@redhat.com> wrote=
:
> > >
> > >
> > > On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditovich wrote:
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
> > > > Fix leak of region reference that prevents complete
> > > > device deletion on hot unplug.
> > >
> > >
> > > More information is needed here, the bug said only q35 can meet this
> > > issue. What makes q35 different here?
> > >
> >
> > I do not have any ready answer, I did not dig into it too much.
> > Probably Michael Tsirkin or Paolo Bonzini can answer without digging.
>
>
>
> > >
> > > >
> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > ---
> > > >   hw/virtio/virtio.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 04716b5f6c..baadec8abc 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice *vdev, in=
t
> n)
> > > >       vdev->vq[n].vring.num_default =3D 0;
> > > >       vdev->vq[n].handle_output =3D NULL;
> > > >       vdev->vq[n].handle_aio_output =3D NULL;
> > > > +    /*
> > > > +     * with vring.num =3D 0 the queue will be ignored
> > > > +     * in later loops of region cache reset
> > > > +     */
> > >
> > >
> > > I can't get the meaning of this comment.
> > >
> > > Thanks
> > >
> > >
> > > > +    virtio_virtqueue_reset_region_cache(&vdev->vq[n]);
>
>
> Do we need to drop this from virtio_device_free_virtqueues then?
>
>
Not mandatory. Repetitive  virtio_virtqueue_reset_region_cache does not do
anything bad.
Some of virtio devices do not do 'virtio_del_queue' at all. Currently
virtio_device_free_virtqueues resets region cache for them.
IMO, not calling 'virtio_del_queue' is a bug, but not in the scope of
current series, I'll take care of that later.


> > > >       g_free(vdev->vq[n].used_elems);
> > > >   }
> > > >
> > >
>
>

--000000000000202d4c059b22df16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 2, 2020 at 1:50 AM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, De=
c 26, 2019 at 11:29:50AM +0200, Yuri Benditovich wrote:<br>
&gt; On Thu, Dec 26, 2019 at 10:58 AM Jason Wang &lt;<a href=3D"mailto:jaso=
wang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditovich wrote:<br=
>
&gt; &gt; &gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D170=
8480" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show=
_bug.cgi?id=3D1708480</a><br>
&gt; &gt; &gt; Fix leak of region reference that prevents complete<br>
&gt; &gt; &gt; device deletion on hot unplug.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; More information is needed here, the bug said only q35 can meet t=
his<br>
&gt; &gt; issue. What makes q35 different here?<br>
&gt; &gt;<br>
&gt; <br>
&gt; I do not have any ready answer, I did not dig into it too much.<br>
&gt; Probably Michael Tsirkin or Paolo Bonzini can answer without digging.<=
br>
<br>
<br>
<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.b=
enditovich@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt=
;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 =C2=A0hw/virtio/virtio.c | 5 +++++<br>
&gt; &gt; &gt;=C2=A0 =C2=A01 file changed, 5 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; &gt; &gt; index 04716b5f6c..baadec8abc 100644<br>
&gt; &gt; &gt; --- a/hw/virtio/virtio.c<br>
&gt; &gt; &gt; +++ b/hw/virtio/virtio.c<br>
&gt; &gt; &gt; @@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice *v=
dev, int n)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[n].vring.num_default =
=3D 0;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[n].handle_output =3D N=
ULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[n].handle_aio_output =
=3D NULL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* with vring.num =3D 0 the queue will b=
e ignored<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* in later loops of region cache reset<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I can&#39;t get the meaning of this comment.<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 virtio_virtqueue_reset_region_cache(&amp;vdev=
-&gt;vq[n]);<br>
<br>
<br>
Do we need to drop this from virtio_device_free_virtqueues then?<br>
<br></blockquote><div><br></div><div>Not mandatory. Repetitive=C2=A0

virtio_virtqueue_reset_region_cache=C2=A0does not do anything bad.</div><di=
v>Some of virtio devices do not do &#39;virtio_del_queue&#39; at all. Curre=
ntly=C2=A0

virtio_device_free_virtqueues resets region cache for them.</div><div>IMO, =
not calling=20

&#39;virtio_del_queue&#39; is a bug, but not in the scope of current series=
, I&#39;ll take care of that later.<br></div><div>=C2=A0<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(vdev-&gt;vq[n].used_elems);=
<br>
&gt; &gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
<br>
</blockquote></div></div>

--000000000000202d4c059b22df16--

