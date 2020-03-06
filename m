Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F8CC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C156D2072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="iIgdeKJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C156D2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9eK-0003Eq-1K
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jA9cx-00026i-SJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jA9cw-0004dW-JW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:50:43 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:36298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jA9cw-0004bq-3M
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:50:42 -0500
Received: by mail-yw1-xc44.google.com with SMTP id j71so1678108ywb.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f899HZAUHs3tzjUf5Qt3qj5Infdz7gm2bA+kI05ClJY=;
 b=iIgdeKJhUU/8DgdFDREF8IvQLlzdt8wEtTVkWM6w8LN8nTBofGAqAbvKiOQwFvcnz7
 +VEjU1ajkVR5OmPplFk8rg39VDjHFCyOGfz7+73cNxexGjPyVaEjXV0R+B9vy/OS/8mN
 kDkTI8vLb0KtmOtncHS9Sp6bTTXOc+gNaZJKVhSwrpj7YPx2Bv8DdAuTeez0/jVExq4Y
 h9miDhE9TF82rw/FEeUtTQAFjMawenFwaK6cfR9/1UhnFOEA9DL3mzDllTkx4RillPKW
 4oVqjkZC2ktIFwgLBQlMvJkvED4+Rjl15MGTFuoYy/GTTT7BtUoqO/4Tn49DQWY78KYA
 HIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f899HZAUHs3tzjUf5Qt3qj5Infdz7gm2bA+kI05ClJY=;
 b=lneaGcPTRWzvsbzxgneeYmrXTxG26FwyYdviY/P41x+aVV1jQzDb5+BsN4ANIxZter
 3P3sWtAhfo+rlXzGu4OKRmOKXuPGbfKGPB5mzJybGu7IQYBdjBnBGE0EOhyD/SOreWjv
 NgH0ZnOVCwmM1Tl0AmmeVXJtwAKpHDxPIC4Nz4U6KOgDvQvYx3AcVIJI3DpEbNC7PyBc
 SaTrTur9yoF1moB88421HbZ5jek5x19fqrSCFLxdC00jVRxoaHgqRLpAGu1Y8yfNwBiw
 gvzPUXR+8W55/HVB/Ehl7MCy/od7cGEtRDrygu3HRik1ZGisvY1fNNBt5zg+aK46XfmK
 pe/Q==
X-Gm-Message-State: ANhLgQ1GEOhj6GVkf6oP06W07E5ZzvN7jbvnXl1gbc+ivlgCgkPFGuOU
 SimL1dAKjpZ6k09J/3N3mP42KVODTi6vKijtKu6aXw==
X-Google-Smtp-Source: ADFU+vsUR2E7YWUTY0ozy21yJFi08nyGxwGu9rgwxolPjyOAjZdGinHtDpBaox1Sq7lKByuBTwybmOzpiHjfww7Zds0=
X-Received: by 2002:a0d:ca4e:: with SMTP id m75mr3234561ywd.36.1583488240846; 
 Fri, 06 Mar 2020 01:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <87242152-5823-59a0-b0ce-2aa555559391@redhat.com>
In-Reply-To: <87242152-5823-59a0-b0ce-2aa555559391@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 6 Mar 2020 11:50:30 +0200
Message-ID: <CAOEp5OfPkQsWs=kYzwxHA0t_gv0iFb4OD6Wppde+qo42wr-eGg@mail.gmail.com>
Subject: Re: [PATCH 0/3] reference implementation of RSS
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001a1c8b05a02c9615"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001a1c8b05a02c9615
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2020 at 11:27 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/2/27 =E4=B8=8A=E5=8D=881:48, Yuri Benditovich wrote:
> > Support for VIRTIO_NET_F_RSS feature in QEMU for reference
> > purpose. Implements Toeplitz hash calculation for incoming
> > packets according to configuration provided by driver.
> >
> > This series requires previously submitted and accepted
> > patch to be applied:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06448.html
> >
> > Yuri Benditovich (3):
> >    virtio-net: introduce RSS RX steering feature
> >    virtio-net: implement RSS configuration command
> >    virtio-net: implement RX RSS processing
> >
> >   hw/net/trace-events                         |   3 +
> >   hw/net/virtio-net.c                         | 234
> +++++++++++++++++++-VIRTIO_NET_F_RSS
> >   include/hw/virtio/virtio-net.h              |  12 +
> >   include/standard-headers/linux/virtio_net.h |  37 +++-
> >   4 files changed, 273 insertions(+), 13 deletions(-)
> >
>
> One question before the reviewing.
>
> Do we need to deal with migration (which I think yes)?
>

I think we don't (yet) as this is a reference implementation and the main
goal is to provide the functional reference for hardware solution.
I agree with the general direction that for complete support of RSS and
hash delivery the best way is to do that in kernel using bpf.
For that, IMO, the bpf should be a part of the kernel (it uses skb fields)
and the tap should receive just RSS parameters for it.
At this stage we definitely will need to add migration support and
propagation of RSS parameters.


>
> Thanks
>
>

--0000000000001a1c8b05a02c9615
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, 2020 at 11:27 AM Jason=
 Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/2/27 =E4=B8=8A=E5=8D=881:48, Yuri Benditovich wrote:<br>
&gt; Support for VIRTIO_NET_F_RSS feature in QEMU for reference<br>
&gt; purpose. Implements Toeplitz hash calculation for incoming<br>
&gt; packets according to configuration provided by driver.<br>
&gt;<br>
&gt; This series requires previously submitted and accepted<br>
&gt; patch to be applied:<br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06=
448.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2020-01/msg06448.html</a><br>
&gt;<br>
&gt; Yuri Benditovich (3):<br>
&gt;=C2=A0 =C2=A0 virtio-net: introduce RSS RX steering feature<br>
&gt;=C2=A0 =C2=A0 virtio-net: implement RSS configuration command<br>
&gt;=C2=A0 =C2=A0 virtio-net: implement RX RSS processing<br>
&gt;<br>
&gt;=C2=A0 =C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 234 +++++++++++++++++=
++-VIRTIO_NET_F_RSS<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-net.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +<br>
&gt;=C2=A0 =C2=A0include/standard-headers/linux/virtio_net.h |=C2=A0 37 +++=
-<br>
&gt;=C2=A0 =C2=A04 files changed, 273 insertions(+), 13 deletions(-)<br>
&gt;<br>
<br>
One question before the reviewing.<br>
<br>
Do we need to deal with migration (which I think yes)?<br></blockquote><div=
><br></div><div>I think we don&#39;t (yet) as this is a reference implement=
ation and the main goal is to provide the functional reference for hardware=
 solution.</div><div>I agree with the general direction that for complete s=
upport of RSS and hash delivery the best way is to do that in kernel using =
bpf.</div><div>For that, IMO, the bpf should be a part of the kernel (it us=
es skb fields) and the tap should receive just RSS parameters for it.</div>=
<div>At this stage we definitely will need to add migration support and pro=
pagation of RSS parameters.</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
Thanks<br>
<br>
</blockquote></div></div>

--0000000000001a1c8b05a02c9615--

