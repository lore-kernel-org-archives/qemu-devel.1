Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0A0C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38041215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="1/1P7y2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38041215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioOPp-00056e-EB
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 04:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ioOPC-0004fP-5B
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ioOPA-0000Hv-Gh
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:10:34 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ioOP9-0000HI-V1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:10:32 -0500
Received: by mail-io1-xd42.google.com with SMTP id x1so47865582iop.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 01:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FhE3AAcR5EKYvF3qQw7WlFFOh9fsWSP2T/cKE/jbODc=;
 b=1/1P7y2sJiogyWJ5plKXN1Jp8oAOnDZ45LaGItJtWp7W4PnLuzoEN/C1XKTwea4eTF
 SSsWEOK3Q3nGJJ1VhLRg0I7D1LwQ0iVRBQ+a6ENpn4+39Aa2bflAPrRqmT6dJrnwFgV8
 QYVPrJYsBLRHxIqkctyEJIRgJp1duYh6G8crjGuHqpozUQXKXQORtG1IXQIcPNK4hn/m
 QjHgTsk8CIfeNfSKG6fdCaOc1vDeAUHZzKNXa1gI8CG+LxEgZUr2DLaWrLHjtObfgWog
 RirMb3gFPig0tSwkELlywhrMxRzu2BHH/6U/zz5OsBHQwVE5UdrEn4aqCakgcxn/aZqy
 E8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FhE3AAcR5EKYvF3qQw7WlFFOh9fsWSP2T/cKE/jbODc=;
 b=gwSg81Jag+0GTe0XAwBQYDnvq18uGe4qwIIlsCIr+0znEcAeNlVOccvqN+W2Xm+p9+
 a+pSnBGw560udOfCVW3Y1f6uM+Hp/+rQYhlDRWE3lAqEGRonCODK97cCNzV5B7XXty8H
 h3S53awYmtq4vy1eTlj5uyO35IGUId43vkAa0G52/nwiZMaZxnZx/jZoJ7tnDaAWGlN0
 W6V/TckRhgMZcsJJHYB6IiqgV9EubGuGV33ejnvow7eL+zR3u1hOy3yqWy7IDgH/wDWD
 a/fU35HVRcWdwI4XuLjeH6RthZrHp8sbD4MVaoKQJFDo6o/h4NCZESbLlZ+6DlSxvpL2
 /gGA==
X-Gm-Message-State: APjAAAXKG/Mt8Xs3DrIeyqOsg5BQPDukWOZ4gH//9s/O9vvhEquL5mXs
 k0RNXbcvl4tsx4dpCTu9HbGsT7jvYLrwCFUU5/60b9kE
X-Google-Smtp-Source: APXvYqxjIj6CtwKrqZ6yUPQoc8Jn2a0ycw02siQxUZb3PpkCQWAquAKBttYgMe/sLTAbZLjevPt4tHXd0WmcEa8xxJE=
X-Received: by 2002:a02:c942:: with SMTP id u2mr80321978jao.49.1578301830849; 
 Mon, 06 Jan 2020 01:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
 <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
 <CAOEp5OdDj_=c_75FsM45iQnqDYBPz=Fn48FbR2FHcY=5D3rB-Q@mail.gmail.com>
 <20200101184425-mutt-send-email-mst@kernel.org>
 <CAOEp5Oefmj5dM5auk1QpQ3F+CeJXQy+0aXJC1VNmUOj1KHp8aw@mail.gmail.com>
 <20200105063518-mutt-send-email-mst@kernel.org>
 <CAOEp5Of0PYiCu9kPyi7W84ToHrGzTHFkPFBGd0A7AVFkwzVZOg@mail.gmail.com>
In-Reply-To: <CAOEp5Of0PYiCu9kPyi7W84ToHrGzTHFkPFBGd0A7AVFkwzVZOg@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 6 Jan 2020 11:10:18 +0200
Message-ID: <CAOEp5Oec3x71vPVKDcTBWT4TkgrbSbUZmyDkd2bGF84sXEHUyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f9fa83059b7507c6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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

--000000000000f9fa83059b7507c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Michael,
Can you please comment on Jason's question: why we have a problem only with
q35 and not with legacy pc?
If you have a simple answer, it will help us in further work with other hot
plug/unplug problems.

Thanks,
Yuri Benditovich

On Sun, Jan 5, 2020 at 6:21 PM Yuri Benditovich <yuri.benditovich@daynix.co=
m>
wrote:

>
>
> On Sun, Jan 5, 2020 at 1:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>> On Thu, Jan 02, 2020 at 09:09:04AM +0200, Yuri Benditovich wrote:
>> >
>> >
>> > On Thu, Jan 2, 2020 at 1:50 AM Michael S. Tsirkin <mst@redhat.com>
>> wrote:
>> >
>> >     On Thu, Dec 26, 2019 at 11:29:50AM +0200, Yuri Benditovich wrote:
>> >     > On Thu, Dec 26, 2019 at 10:58 AM Jason Wang <jasowang@redhat.com=
>
>> wrote:
>> >     > >
>> >     > >
>> >     > > On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditovich wrote:
>> >     > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
>> >     > > > Fix leak of region reference that prevents complete
>> >     > > > device deletion on hot unplug.
>> >     > >
>> >     > >
>> >     > > More information is needed here, the bug said only q35 can mee=
t
>> this
>> >     > > issue. What makes q35 different here?
>> >     > >
>> >     >
>> >     > I do not have any ready answer, I did not dig into it too much.
>> >     > Probably Michael Tsirkin or Paolo Bonzini can answer without
>> digging.
>> >
>> >
>> >
>> >     > >
>> >     > > >
>> >     > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com=
>
>> >     > > > ---
>> >     > > >   hw/virtio/virtio.c | 5 +++++
>> >     > > >   1 file changed, 5 insertions(+)
>> >     > > >
>> >     > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> >     > > > index 04716b5f6c..baadec8abc 100644
>> >     > > > --- a/hw/virtio/virtio.c
>> >     > > > +++ b/hw/virtio/virtio.c
>> >     > > > @@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice
>> *vdev, int
>> >     n)
>> >     > > >       vdev->vq[n].vring.num_default =3D 0;
>> >     > > >       vdev->vq[n].handle_output =3D NULL;
>> >     > > >       vdev->vq[n].handle_aio_output =3D NULL;
>> >     > > > +    /*
>> >     > > > +     * with vring.num =3D 0 the queue will be ignored
>> >     > > > +     * in later loops of region cache reset
>> >     > > > +     */
>> >     > >
>> >     > >
>> >     > > I can't get the meaning of this comment.
>> >     > >
>> >     > > Thanks
>> >     > >
>> >     > >
>> >     > > > +    virtio_virtqueue_reset_region_cache(&vdev->vq[n]);
>> >
>> >
>> >     Do we need to drop this from virtio_device_free_virtqueues then?
>> >
>> >
>> >
>> > Not mandatory. Repetitive  virtio_virtqueue_reset_region_cache does no=
t
>> do
>> > anything bad.
>> > Some of virtio devices do not do 'virtio_del_queue' at all. Currently
>> > virtio_device_free_virtqueues resets region cache for them.
>> > IMO, not calling 'virtio_del_queue' is a bug, but not in the scope of
>> current
>> > series, I'll take care of that later.
>>
>> Maybe we should just del all queues in virtio_device_unrealize?
>> Will allow us to drop some logic tracking which vqs were created.
>>
>>
> Yes, this is also possible with some rework of
> virtio_device_free_virtqueues.
> virtio-net has some additional operations around queue deletion, it
> deletes queues when switches from single queue to multiple.
>
>
>>
>> >
>> >     > > >       g_free(vdev->vq[n].used_elems);
>> >     > > >   }
>> >     > > >
>> >     > >
>> >
>> >
>>
>>

--000000000000f9fa83059b7507c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Michael,<div>Can you please comment on Jason&#39;s questio=
n: why we have a problem only with q35 and not with legacy pc?</div><div>If=
 you have a simple answer, it will help us in further work with other hot p=
lug/unplug problems.</div><div><br></div><div>Thanks,</div><div>Yuri Bendit=
ovich</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Sun, Jan 5, 2020 at 6:21 PM Yuri Benditovich &lt;<a href=3D"m=
ailto:yuri.benditovich@daynix.com">yuri.benditovich@daynix.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Sun, Jan 5, 2020 at 1:39 PM Michael S. Tsirkin =
&lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Th=
u, Jan 02, 2020 at 09:09:04AM +0200, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Jan 2, 2020 at 1:50 AM Michael S. Tsirkin &lt;<a href=3D"mailt=
o:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Dec 26, 2019 at 11:29:50AM +0200, Yuri Bend=
itovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Thu, Dec 26, 2019 at 10:58 AM Jason Wang &l=
t;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.=
com</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yu=
ri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; <a href=3D"https://bugzilla.redhat.c=
om/show_bug.cgi?id=3D1708480" rel=3D"noreferrer" target=3D"_blank">https://=
bugzilla.redhat.com/show_bug.cgi?id=3D1708480</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; Fix leak of region reference that pr=
events complete<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; device deletion on hot unplug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; More information is needed here, the bug =
said only q35 can meet this<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; issue. What makes q35 different here?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I do not have any ready answer, I did not dig =
into it too much.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Probably Michael Tsirkin or Paolo Bonzini can =
answer without digging.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; Signed-off-by: Yuri Benditovich &lt;=
<a href=3D"mailto:yuri.benditovich@daynix.com" target=3D"_blank">yuri.bendi=
tovich@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0hw/virtio/virtio.c | 5 +=
++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A01 file changed, 5 insert=
ions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; diff --git a/hw/virtio/virtio.c b/hw=
/virtio/virtio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; index 04716b5f6c..baadec8abc 100644<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; --- a/hw/virtio/virtio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; +++ b/hw/virtio/virtio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; @@ -2340,6 +2340,11 @@ void virtio_d=
el_queue(VirtIODevice *vdev, int<br>
&gt;=C2=A0 =C2=A0 =C2=A0n)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;v=
q[n].vring.num_default =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;v=
q[n].handle_output =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;v=
q[n].handle_aio_output =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* with vring.nu=
m =3D 0 the queue will be ignored<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* in later loop=
s of region cache reset<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; I can&#39;t get the meaning of this comme=
nt.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Thanks<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; +=C2=A0 =C2=A0 virtio_virtqueue_rese=
t_region_cache(&amp;vdev-&gt;vq[n]);<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Do we need to drop this from virtio_device_free_vir=
tqueues then?<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Not mandatory. Repetitive=C2=A0 virtio_virtqueue_reset_region_cache=C2=
=A0does not do<br>
&gt; anything bad.<br>
&gt; Some of virtio devices do not do &#39;virtio_del_queue&#39; at all. Cu=
rrently=C2=A0<br>
&gt; virtio_device_free_virtqueues resets region cache for them.<br>
&gt; IMO, not calling &#39;virtio_del_queue&#39; is a bug, but not in the s=
cope of current<br>
&gt; series, I&#39;ll take care of that later.<br>
<br>
Maybe we should just del all queues in virtio_device_unrealize?<br>
Will allow us to drop some logic tracking which vqs were created.<br>
<br></blockquote><div><br></div><div>Yes, this is also possible with some r=
ework of virtio_device_free_virtqueues.</div><div>virtio-net has some addit=
ional operations around queue deletion, it deletes queues when switches fro=
m single queue to multiple.</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(vde=
v-&gt;vq[n].used_elems);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>
</blockquote></div>

--000000000000f9fa83059b7507c6--

