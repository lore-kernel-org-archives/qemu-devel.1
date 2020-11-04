Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F5C5517A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFE2223AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="0pSjRSjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFE2223AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaL7n-0004IY-0H
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kaL4I-0001sL-7j
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:51:26 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kaL4F-00043m-NT
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:51:25 -0500
Received: by mail-oi1-x243.google.com with SMTP id u127so22601741oib.6
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e6zOySVNI//pwRdTmG+bLBWA3eqm6pW3SRdkfEAK1J4=;
 b=0pSjRSjQ4w1w5xorBkkBC7zkBU8PWPtqIXu5Fc/8Z5qUoq/l+a3zP2mOdT95+1z3br
 NvOLHa+HBksl8E5rJPWAAEXKNe2MaFjbEnTuX8eVn7UVPsm7VQFeLQ91sqGkjqzWVPXt
 C/kfMiaH1agVFJi12/KH/hrCUmFGgBPJOcjrlBGOODEfrOrV8FJOGJ1PUVdUtf0XfwoG
 KY3tV+I3R5jPBXAbgYJxyv0T5ed2zEGtNoJZLPL4hhZ3xV/jy6tAQDjiQtnrp0S07OqJ
 d3hLfEPN0+AroSW8VnaZlURsVrjdIniuLsy/3SC14L4mqOx3i4rYw9K6OoGmQAmkziiO
 AahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e6zOySVNI//pwRdTmG+bLBWA3eqm6pW3SRdkfEAK1J4=;
 b=hZG1/K5SpqNILJZr5Fa69I85Az8Xpbk5CS77Ek96USiKnjPlhcVO9yCcJpOq8FjJ3U
 AsmI0B5I64jQokApGm1XWZrDcNzdIpJAq7RrmTcVhx/1i2Z5N0QuZWiB9xriK+hET8SV
 jTdlTxx5vYbBFOOJLlroH0brODRPYROyABtcoSQTUxYgHeD1oBG8OERtlhJW1wF8CKa1
 VVo+o9mmzD9UoRh526JTGs1dWR27S6eDF1KNpQ8NQmcC0xAN1e4SMP7+5xJzwOizypsf
 hQAjUMqnYfMOfpGsixuwbq/GSfEvKYeBcd33tRNQbJT5cbEiQdpDO7Bele7tW3nPWkcv
 ivFg==
X-Gm-Message-State: AOAM531IWipdL2gxfIB8QFfV/3y566J1PTDiz5dVqRDGqQhkQUjpVyB9
 WN/yWXz4GY55YoiXQqWasz9r4KDdPHO9dL7R4nX/AQ==
X-Google-Smtp-Source: ABdhPJyQ06CV/5KP/9E8PQojFG0noxS7FocCydluSaPmHBregDI8nAsDLkEvhIfPw2L4DHTzDxCtkvNxCrk6R5ZGBkY=
X-Received: by 2002:aca:8c1:: with SMTP id 184mr3057899oii.137.1604505082383; 
 Wed, 04 Nov 2020 07:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <20201102185115.7425-6-andrew@daynix.com>
 <060630f2-d077-7b71-f1d7-86036dd8f38d@redhat.com>
 <CAOEp5Oc7-1Dyj4ryF+S7BVP2YP=0ZrDRN89Qi0jajA3PE0Q6NA@mail.gmail.com>
 <20201104111320.GE565323@redhat.com>
In-Reply-To: <20201104111320.GE565323@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 4 Nov 2020 17:51:10 +0200
Message-ID: <CAOEp5Od3TAj6gijtnaGTXPrEi2uwSP=d==Bd3cDzcgXmiBFBgg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] virtio-net: Added eBPF RSS to virtio-net.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000079e69905b349f3f3"
Received-SPF: none client-ip=2607:f8b0:4864:20::243;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000079e69905b349f3f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2020 at 1:13 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Nov 04, 2020 at 01:07:41PM +0200, Yuri Benditovich wrote:
> > On Wed, Nov 4, 2020 at 5:09 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > >
> > > On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:
> > > > From: Andrew <andrew@daynix.com>
> > > >
> > > > When RSS is enabled the device tries to load the eBPF program
> > > > to select RX virtqueue in the TUN. If eBPF can be loaded
> > > > the RSS will function also with vhost (works with kernel 5.8 and
> later).
> > > > Software RSS is used as a fallback with vhost=3Doff when eBPF can't=
 be
> > > loaded
> > > > or when hash population requested by the guest.
> > > >
> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > > ---
> > > >   hw/net/vhost_net.c             |   2 +
> > > >   hw/net/virtio-net.c            | 120
> +++++++++++++++++++++++++++++++--
> > > >   include/hw/virtio/virtio-net.h |   4 ++
> > > >   net/vhost-vdpa.c               |   2 +
> > > >   4 files changed, 124 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > > index 24d555e764..16124f99c3 100644
> > > > --- a/hw/net/vhost_net.c
> > > > +++ b/hw/net/vhost_net.c
> > > > @@ -71,6 +71,8 @@ static const int user_feature_bits[] =3D {
> > > >       VIRTIO_NET_F_MTU,
> > > >       VIRTIO_F_IOMMU_PLATFORM,
> > > >       VIRTIO_F_RING_PACKED,
> > > > +    VIRTIO_NET_F_RSS,
> > > > +    VIRTIO_NET_F_HASH_REPORT,
> > > >
> > > >       /* This bit implies RARP isn't sent by QEMU out of band */
> > > >       VIRTIO_NET_F_GUEST_ANNOUNCE,
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index 277289d56e..afcc3032ec 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -698,6 +698,19 @@ static void virtio_net_set_queues(VirtIONet *n=
)
> > > >
> > > >   static void virtio_net_set_multiqueue(VirtIONet *n, int
> multiqueue);
> > > >
> > > > +static uint64_t fix_ebpf_vhost_features(uint64_t features)
> > > > +{
> > > > +    /* If vhost=3Don & CONFIG_EBPF doesn't set - disable RSS featu=
re
> */
> > > > +    uint64_t ret =3D features;
> > > > +#ifndef CONFIG_EBPF
> > > > +    virtio_clear_feature(&ret, VIRTIO_NET_F_RSS);
> > > > +#endif
> > > > +    /* for now, there is no solution for populating the hash from
> eBPF
> > > */
> > > > +    virtio_clear_feature(&ret, VIRTIO_NET_F_HASH_REPORT);
> > >
> > >
> > > I think we probably need to to something reverse since RSS is under t=
he
> > > control on qemu cli, disable features like this may break migration.
> > >
> > >
> > How by design we add new features to qemu in light of possible migratio=
n
> to
> > older qemu version when the destination
> > qemu does not support these features?
>
> If the feature affects guest ABI, then we don't want to silently/
> automatically turn on features that have a dependancy on kernel
> features existing. They need to be an opt-in by mgmt app/admin.
>
>
We understand that. But the eBPF itself does not affect the guest ABI.
The 'RSS' feature of virtio-net device already exists (implemented in QEMU,
so it can work in case the vhost is off).
eBPF is able to do the same on TAP/TUN level (so it can do the job also
when vhost is on).
By default it is turned off and requires explicit command line switch
'rss=3Don'


> IOW there needs to be an explicit property that is set to turn on use
> of eBPF. If this property is set, then QEMU must use eBPF or fail
> with an error. If it is unset, then QEMU must never use eBPF.
>
> The mgmt app controlling QEMU will decide whether to use eBPF and
> turn on the property, and will then know not to migrate it to a
> host without eBPF support.
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--00000000000079e69905b349f3f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 4, 2020 at 1:13 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Nov 04, 2020 at 01:07:41PM +0200, Yuri Benditovich wrote:<br>
&gt; On Wed, Nov 4, 2020 at 5:09 AM Jason Wang &lt;<a href=3D"mailto:jasowa=
ng@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:<br=
>
&gt; &gt; &gt; From: Andrew &lt;<a href=3D"mailto:andrew@daynix.com" target=
=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; When RSS is enabled the device tries to load the eBPF progra=
m<br>
&gt; &gt; &gt; to select RX virtqueue in the TUN. If eBPF can be loaded<br>
&gt; &gt; &gt; the RSS will function also with vhost (works with kernel 5.8=
 and later).<br>
&gt; &gt; &gt; Software RSS is used as a fallback with vhost=3Doff when eBP=
F can&#39;t be<br>
&gt; &gt; loaded<br>
&gt; &gt; &gt; or when hash population requested by the guest.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.b=
enditovich@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt=
;<br>
&gt; &gt; &gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andr=
ew@daynix.com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 =C2=A0hw/net/vhost_net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 120 +++++++++++++++++++++++++++++++--<br>
&gt; &gt; &gt;=C2=A0 =C2=A0include/hw/virtio/virtio-net.h |=C2=A0 =C2=A04 +=
+<br>
&gt; &gt; &gt;=C2=A0 =C2=A0net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt;=C2=A0 =C2=A04 files changed, 124 insertions(+), 4 deletions(=
-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c<br>
&gt; &gt; &gt; index 24d555e764..16124f99c3 100644<br>
&gt; &gt; &gt; --- a/hw/net/vhost_net.c<br>
&gt; &gt; &gt; +++ b/hw/net/vhost_net.c<br>
&gt; &gt; &gt; @@ -71,6 +71,8 @@ static const int user_feature_bits[] =3D {=
<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_NET_F_MTU,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_F_IOMMU_PLATFORM,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_F_RING_PACKED,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_RSS,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_HASH_REPORT,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* This bit implies RARP isn&#39;t=
 sent by QEMU out of band */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_NET_F_GUEST_ANNOUNCE,<br>
&gt; &gt; &gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; &gt; &gt; index 277289d56e..afcc3032ec 100644<br>
&gt; &gt; &gt; --- a/hw/net/virtio-net.c<br>
&gt; &gt; &gt; +++ b/hw/net/virtio-net.c<br>
&gt; &gt; &gt; @@ -698,6 +698,19 @@ static void virtio_net_set_queues(VirtI=
ONet *n)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0static void virtio_net_set_multiqueue(VirtIONet =
*n, int multiqueue);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +static uint64_t fix_ebpf_vhost_features(uint64_t features)<=
br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* If vhost=3Don &amp; CONFIG_EBPF doesn&#39;=
t set - disable RSS feature */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t ret =3D features;<br>
&gt; &gt; &gt; +#ifndef CONFIG_EBPF<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 virtio_clear_feature(&amp;ret, VIRTIO_NET_F_R=
SS);<br>
&gt; &gt; &gt; +#endif<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* for now, there is no solution for populati=
ng the hash from eBPF<br>
&gt; &gt; */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 virtio_clear_feature(&amp;ret, VIRTIO_NET_F_H=
ASH_REPORT);<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I think we probably need to to something reverse since RSS is und=
er the<br>
&gt; &gt; control on qemu cli, disable features like this may break migrati=
on.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; How by design we add new features to qemu in light of possible migrati=
on to<br>
&gt; older qemu version when the destination<br>
&gt; qemu does not support these features?<br>
<br>
If the feature affects guest ABI, then we don&#39;t want to silently/<br>
automatically turn on features that have a dependancy on kernel<br>
features existing. They need to be an opt-in by mgmt app/admin.<br>
<br></blockquote><div><br></div><div>We understand that. But the eBPF itsel=
f=C2=A0does not affect the guest ABI.<br></div><div>The &#39;RSS&#39; featu=
re of virtio-net device already exists (implemented in QEMU, so it can work=
 in case the vhost is off).</div><div>eBPF is able to do the same on TAP/TU=
N level (so it can do the job also when vhost is on).</div><div>By default =
it is turned off and requires explicit command line switch &#39;rss=3Don&#3=
9;</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
IOW there needs to be an explicit property that is set to turn on use<br>
of eBPF. If this property is set, then QEMU must use eBPF or fail<br>
with an error. If it is unset, then QEMU must never use eBPF.<br>
<br>
The mgmt app controlling QEMU will decide whether to use eBPF and<br>
turn on the property, and will then know not to migrate it to a<br>
host without eBPF support.<br>
<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--00000000000079e69905b349f3f3--

