Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1399C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5707E207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="EkZCcsRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5707E207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomsE-0003Hj-Oc
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iomJr-0001R1-N1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iomJp-0001cW-Ey
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:42:39 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1iomJp-0001bZ-09
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:42:37 -0500
Received: by mail-io1-xd43.google.com with SMTP id b10so52071949iof.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J7B5WcnRyDnnnfho/yUfYWKIYvoHROLyccR4zIOExhM=;
 b=EkZCcsRvyxcDmgDF+Uj1SgCOXmXnVGK587CxfQaDFgj8Odei+2brm9EzkDnXmEF7I5
 rwSG4HPKq/kihFSy9HomtMXTMyDXY11yNHUwIBhXrHe1nYvxrsYSKP/9WjoZgc9f2KK/
 CqyDpS3379txdr83xgDriLVOyn1Yg+wpBM/mNjI9MMmX7zUuKIcVPxo941B3YurMRiIf
 k5nWoFzJGrTrt9Wyl+KNwkSUZimYWVqmbeuGfzHL1TbMcut0YsSZEshopcnzvLfoHaWT
 x54zJBUjFn3Ww8Fvt09P1vXuAu/oIKi+Q8kbsn8DmW4w267IuhJUESOUEdccf2H9rbcr
 yrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J7B5WcnRyDnnnfho/yUfYWKIYvoHROLyccR4zIOExhM=;
 b=I83Ew1Fl5I+w4CDtaVBjK82kPXs6ruKexcLWmLpJTcJI1xD7xlPgR31AT+wmABcqZg
 5klzlTPKfcCqPVArQS7RvDwj1Ymu7fc1CuQE8MecF2/KQqFH7avYQfRLwqFUbPJPg+sB
 m3FDUXsFP6ahwoR3QFJl5q9bfJYS/1qBjExjak+WmqQdhSUM6Ph1lyg5sHWRtDiXuTaE
 P/gTr1bJIPuloI25nvH4Epu8GbZRNPv4JqDzBoXXMH0rezuNtFo9CKg3vIIwjjyoHNna
 Z6KU60PK6ZT4CSWXJ4C71AkcpDNliqZOESZQ7wePLzpitYOkHEsJR3MLSnjcSoOvcOkf
 HIZA==
X-Gm-Message-State: APjAAAXzZOa/m0A700hMh0IcDG5mEhYnnRBCXjM/utyh7SMsp+RbW4yv
 3I+6YnhrrnmgwA0kvrUGkvBdvE8Eg2nJ3r5SuM+mCw==
X-Google-Smtp-Source: APXvYqwyU72FMlFVUKY1sHo40SkYB8LSbyFNC7EBZ6JXmZ/GY3Mzch8qz0s/7/zhac4lpZsvPl/yYvEKsvfsQsJb1Po=
X-Received: by 2002:a02:5b45:: with SMTP id g66mr83796181jab.29.1578393755318; 
 Tue, 07 Jan 2020 02:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
 <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
 <CAOEp5OdDj_=c_75FsM45iQnqDYBPz=Fn48FbR2FHcY=5D3rB-Q@mail.gmail.com>
 <20200101184425-mutt-send-email-mst@kernel.org>
 <CAOEp5Oefmj5dM5auk1QpQ3F+CeJXQy+0aXJC1VNmUOj1KHp8aw@mail.gmail.com>
 <20200105063518-mutt-send-email-mst@kernel.org>
 <CAOEp5Of0PYiCu9kPyi7W84ToHrGzTHFkPFBGd0A7AVFkwzVZOg@mail.gmail.com>
 <CAOEp5Oec3x71vPVKDcTBWT4TkgrbSbUZmyDkd2bGF84sXEHUyQ@mail.gmail.com>
 <20200106044351-mutt-send-email-mst@kernel.org>
 <CAOEp5OfrGDAnpj_8W2GSZV95yzuJ=p3aK5a8qVVV-O6QL6EAQQ@mail.gmail.com>
In-Reply-To: <CAOEp5OfrGDAnpj_8W2GSZV95yzuJ=p3aK5a8qVVV-O6QL6EAQQ@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 7 Jan 2020 12:42:21 +0200
Message-ID: <CAOEp5Off5HxD2_igGF9OhUEp3peOoDL92KNaMTU-mXK1r9EuhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001a0e08059b8a6fa1"
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

--0000000000001a0e08059b8a6fa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2020 at 12:37 PM Yuri Benditovich <
yuri.benditovich@daynix.com> wrote:

>
> On Mon, Jan 6, 2020 at 11:58 AM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>
>> I guess it somehow has to do with the following:
>>
>>     if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
>>         proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON :
>> ON_OFF_AUTO_OFF;
>>     }
>>
>> so by default device on an express port does not have a legacy interface=
.
>>
>> Somehow having a legacy interface fixes things?
>>
>
>
No, transitional virtio-net on q35 behaves exactly as the modern one.


>
>
>> Does enabling legacy on q35 without this patch fix things?
>>
>
>
No, legacy virtio-net on q35 has the same problem.
There is also an additional problem with legacy device unplug on q35, but I
think it is not in the scope of this discussion.


>
>
>> And does disabling legacy on PIIX without this patch break thing?
>>
>
>
No, modern device on PIIX does hot unplug without problems.


>
>
>>
>> How can having a legacy interface fix things if it's not
>> even active? I don't know. Is there a chance windows drivers use the
>> legacy interface on a transitional device by mistake?
>>
>
As far as I can see - no. The driver works with the device depending on
VERSION_1



> I'll recheck it. I do not think we use legacy interface on modern device
> even if it has one.
>
>
>>
>> On Mon, Jan 06, 2020 at 11:10:18AM +0200, Yuri Benditovich wrote:
>> > Michael,
>> > Can you please comment on Jason's question: why we have a problem only
>> with q35
>> > and not with legacy pc?
>> > If you have a simple answer, it will help us in further work with othe=
r
>> hot
>> > plug/unplug problems.
>> >
>> > Thanks,
>> > Yuri Benditovich
>> >
>> > On Sun, Jan 5, 2020 at 6:21 PM Yuri Benditovich <
>> yuri.benditovich@daynix.com>
>> > wrote:
>> >
>> >
>> >
>> >     On Sun, Jan 5, 2020 at 1:39 PM Michael S. Tsirkin <mst@redhat.com>
>> wrote:
>> >
>> >         On Thu, Jan 02, 2020 at 09:09:04AM +0200, Yuri Benditovich
>> wrote:
>> >         >
>> >         >
>> >         > On Thu, Jan 2, 2020 at 1:50 AM Michael S. Tsirkin <
>> mst@redhat.com>
>> >         wrote:
>> >         >
>> >         >     On Thu, Dec 26, 2019 at 11:29:50AM +0200, Yuri
>> Benditovich wrote:
>> >         >     > On Thu, Dec 26, 2019 at 10:58 AM Jason Wang <
>> >         jasowang@redhat.com> wrote:
>> >         >     > >
>> >         >     > >
>> >         >     > > On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditov=
ich wrote:
>> >         >     > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1708=
480
>> >         >     > > > Fix leak of region reference that prevents complet=
e
>> >         >     > > > device deletion on hot unplug.
>> >         >     > >
>> >         >     > >
>> >         >     > > More information is needed here, the bug said only
>> q35 can
>> >         meet this
>> >         >     > > issue. What makes q35 different here?
>> >         >     > >
>> >         >     >
>> >         >     > I do not have any ready answer, I did not dig into it
>> too much.
>> >         >     > Probably Michael Tsirkin or Paolo Bonzini can answer
>> without
>> >         digging.
>> >         >
>> >         >
>> >         >
>> >         >     > >
>> >         >     > > >
>> >         >     > > > Signed-off-by: Yuri Benditovich <
>> >         yuri.benditovich@daynix.com>
>> >         >     > > > ---
>> >         >     > > >   hw/virtio/virtio.c | 5 +++++
>> >         >     > > >   1 file changed, 5 insertions(+)
>> >         >     > > >
>> >         >     > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio=
.c
>> >         >     > > > index 04716b5f6c..baadec8abc 100644
>> >         >     > > > --- a/hw/virtio/virtio.c
>> >         >     > > > +++ b/hw/virtio/virtio.c
>> >         >     > > > @@ -2340,6 +2340,11 @@ void
>> virtio_del_queue(VirtIODevice
>> >         *vdev, int
>> >         >     n)
>> >         >     > > >       vdev->vq[n].vring.num_default =3D 0;
>> >         >     > > >       vdev->vq[n].handle_output =3D NULL;
>> >         >     > > >       vdev->vq[n].handle_aio_output =3D NULL;
>> >         >     > > > +    /*
>> >         >     > > > +     * with vring.num =3D 0 the queue will be ign=
ored
>> >         >     > > > +     * in later loops of region cache reset
>> >         >     > > > +     */
>> >         >     > >
>> >         >     > >
>> >         >     > > I can't get the meaning of this comment.
>> >         >     > >
>> >         >     > > Thanks
>> >         >     > >
>> >         >     > >
>> >         >     > > > +
>> virtio_virtqueue_reset_region_cache(&vdev->vq[n]);
>> >         >
>> >         >
>> >         >     Do we need to drop this from
>> virtio_device_free_virtqueues then?
>> >         >
>> >         >
>> >         >
>> >         > Not mandatory. Repetitive
>> virtio_virtqueue_reset_region_cache does
>> >         not do
>> >         > anything bad.
>> >         > Some of virtio devices do not do 'virtio_del_queue' at all.
>> >         Currently
>> >         > virtio_device_free_virtqueues resets region cache for them.
>> >         > IMO, not calling 'virtio_del_queue' is a bug, but not in the
>> scope of
>> >         current
>> >         > series, I'll take care of that later.
>> >
>> >         Maybe we should just del all queues in virtio_device_unrealize=
?
>> >         Will allow us to drop some logic tracking which vqs were
>> created.
>> >
>> >
>> >
>> >     Yes, this is also possible with some rework of
>> >     virtio_device_free_virtqueues.
>> >     virtio-net has some additional operations around queue deletion, i=
t
>> deletes
>> >     queues when switches from single queue to multiple.
>> >
>> >
>> >
>> >         >
>> >         >     > > >       g_free(vdev->vq[n].used_elems);
>> >         >     > > >   }
>> >         >     > > >
>> >         >     > >
>> >         >
>> >         >
>> >
>> >
>>
>>

--0000000000001a0e08059b8a6fa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 6, 2020 at 12:37 PM Yuri =
Benditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.com">yuri.bendito=
vich@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 6, 2020 at 11:=
58 AM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_b=
lank">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">I guess it somehow has to do with the following:<br>
<br>
=C2=A0 =C2=A0 if (proxy-&gt;disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 proxy-&gt;disable_legacy =3D pcie_port ? ON_OFF=
_AUTO_ON : ON_OFF_AUTO_OFF;<br>
=C2=A0 =C2=A0 }<br>
<br>
so by default device on an express port does not have a legacy interface.<b=
r>
<br>
Somehow having a legacy interface fixes things?<br></blockquote><div><br></=
div></div></div></blockquote><div>=C2=A0=C2=A0</div><div>No, transitional v=
irtio-net on q35 behaves exactly as the modern one.=C2=A0=C2=A0<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_quote"><div></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
Does enabling legacy on q35 without this patch fix things?<br></blockquote>=
<div><br></div></div></div></blockquote><div><br></div><div>No, legacy virt=
io-net on q35 has the same problem.</div><div>There is also an additional p=
roblem with legacy device unplug on q35, but I think it is not in the scope=
 of this discussion.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
And does disabling legacy on PIIX without this patch break thing?<br></bloc=
kquote><div><br></div><div><div></div></div></div></div></blockquote><div>=
=C2=A0</div><div>No, modern device on PIIX does hot unplug without problems=
.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div class=3D"gmail_quote"><div><div><br></div><div></div></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
How can having a legacy interface fix things if it&#39;s not<br>
even active? I don&#39;t know. Is there a chance windows drivers use the<br=
>
legacy interface on a transitional device by mistake?<br></blockquote></div=
></div></blockquote><div><br></div><div>As far as I can see - no. The drive=
r works with the device depending on VERSION_1</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><div><div>I&#39;ll recheck it. I do not think w=
e use legacy interface on modern device even if it has one.</div><div></div=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
On Mon, Jan 06, 2020 at 11:10:18AM +0200, Yuri Benditovich wrote:<br>
&gt; Michael,<br>
&gt; Can you please comment on Jason&#39;s question: why we have a problem =
only with q35<br>
&gt; and not with legacy pc?<br>
&gt; If you have a simple answer, it will help us in further work with othe=
r hot<br>
&gt; plug/unplug problems.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Yuri Benditovich<br>
&gt; <br>
&gt; On Sun, Jan 5, 2020 at 6:21 PM Yuri Benditovich &lt;<a href=3D"mailto:=
yuri.benditovich@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Sun, Jan 5, 2020 at 1:39 PM Michael S. Tsirkin &=
lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&g=
t; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On Thu, Jan 02, 2020 at 09:09:04AM +0=
200, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On Thu, Jan 2, 2020 at 1:50 AM M=
ichael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">m=
st@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Dec 2=
6, 2019 at 11:29:50AM +0200, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Thu, =
Dec 26, 2019 at 10:58 AM Jason Wang &lt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:jasowang@redhat.com=
" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; On =
2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480" rel=3D"=
noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=
=3D1708480</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; Fix leak of region reference that prevents complete<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; device deletion on hot unplug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Mor=
e information is needed here, the bug said only q35 can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meet this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; iss=
ue. What makes q35 different here?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; I do not=
 have any ready answer, I did not dig into it too much.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Probably=
 Michael Tsirkin or Paolo Bonzini can answer without<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0digging.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; Signed-off-by: Yuri Benditovich &lt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:yuri.benditovich@da=
ynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;=C2=A0 =C2=A0hw/virtio/virtio.c | 5 +++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;=C2=A0 =C2=A01 file changed, 5 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; index 04716b5f6c..baadec8abc 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; --- a/hw/virtio/virtio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; +++ b/hw/virtio/virtio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; @@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*vdev, int<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0n)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[n].vring.num_default =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[n].handle_output =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[n].handle_aio_output =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; +=C2=A0 =C2=A0 =C2=A0* with vring.num =3D 0 the queue will be ignored<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; +=C2=A0 =C2=A0 =C2=A0* in later loops of region cache reset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; I c=
an&#39;t get the meaning of this comment.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Tha=
nks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; +=C2=A0 =C2=A0 virtio_virtqueue_reset_region_cache(&amp;vdev-&gt;vq[n]);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Do we need to=
 drop this from virtio_device_free_virtqueues then?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Not mandatory. Repetitive=C2=A0 =
virtio_virtqueue_reset_region_cache=C2=A0does<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; anything bad.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Some of virtio devices do not do=
 &#39;virtio_del_queue&#39; at all.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Currently=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; virtio_device_free_virtqueues re=
sets region cache for them.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; IMO, not calling &#39;virtio_del=
_queue&#39; is a bug, but not in the scope of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; series, I&#39;ll take care of th=
at later.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Maybe we should just del all queues i=
n virtio_device_unrealize?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Will allow us to drop some logic trac=
king which vqs were created.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, this is also possible with some rework of<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_device_free_virtqueues.<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio-net has some additional operations around qu=
eue deletion, it deletes<br>
&gt;=C2=A0 =C2=A0 =C2=A0queues when switches from single queue to multiple.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(vdev-&gt;vq[n].used_elems);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--0000000000001a0e08059b8a6fa1--

