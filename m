Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E752C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F8020663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="TcPGgRrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F8020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0Sw-0004be-2v
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jT0RN-00036e-OL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jT0RM-0004G4-Qv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:52:41 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30]:45649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jT0RM-0004Fg-9R
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:52:40 -0400
Received: by mail-yb1-xb30.google.com with SMTP id p7so6997915ybo.12
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Om/bZVryo7HNAO8clrWaNrMp9tOHsgri2oq16l2420w=;
 b=TcPGgRrtaPg/k4Js5dyCRZ/VfoZh5UOhLc8glUv/d5m3pBwXwjaUo6VLYN9IHa/AyG
 mIQ1dFQ8HBDvwkeJyZn+rysCzEHTQNfgZdP9jv8RPGFIg+lgmEpYI4FC7PyMugGSgOvY
 9fG+OtdZmewE6Cm6zyJzwWkKttOkvIDjwDOLq8RULVttodNq32VZAaeap69BJIEjRqzo
 FLL9jPD2E7OmOT8Eq//pQJfp0g/VxNXe20NQIKjo8nc9hynZ4zqVcrm2qotSo+xLcXcO
 IcHFn6ibq/u1CXHfn3iwvgzjown7kafBT2tmbQtihoTMWcfsUaLaTEQ0UcBFZw7QcNPk
 vN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Om/bZVryo7HNAO8clrWaNrMp9tOHsgri2oq16l2420w=;
 b=WhJMbcR/R0+38SJs3zx/QPIOpbU0UQhlq5QebBY/D5WzFcDHqJWl9/dpvxXcHIZCAb
 QYVSUTwT7T4UVdEVmUC6a4DyIeKCuoAeDzzYjKVwNB4cTdaxsYvU9huWtmxKXHKvafpL
 XAx3NTezCZGTkb79dBvQgihKcNWZlLSR+tu8QuaeqPDPC0Dwjqg2WKmMF1Re4uzSchMI
 EtXzKnXk9J0jjMKzueJXb4Hl4SZdHGpmqr85y2xchrPCU7iTm72V5hnFQE+lvx1AwtW8
 fv1eJKZYNz8AtWr13e9UrTGPT1wQMVXTjbSzoGOPnZOiZ8s+jsEdKeZhl9phGGPkKk9D
 /5Sw==
X-Gm-Message-State: AGi0PuY4EVZuWmIxtNYY9k/ShN4Svq6DmD8+ZJP/9nLDK4pNArI0/WI1
 l53lr1aepczK/KEY5fpQSOswGNN747T6M/P2dDnS6A==
X-Google-Smtp-Source: APiQypKTeVYgLcJr+x+p9d0TzObe2SgRFPZOMqNJJhplgb70ib16gXeQW34UZ0yNejmQMvvZyz/FIj4yJoJcq+oruCM=
X-Received: by 2002:a25:bacd:: with SMTP id a13mr36204466ybk.461.1587981157977; 
 Mon, 27 Apr 2020 02:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200427093345.4111acd9.cohuck@redhat.com>
 <8a559698-fb15-1f38-2fad-ee5db27f81f4@redhat.com>
 <20200427111029.703f8703.cohuck@redhat.com>
 <20200427051713-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200427051713-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 27 Apr 2020 12:52:26 +0300
Message-ID: <CAOEp5OdSnxMO-BY+8NLwntjpr3CGvfh0ECHHB0w7PVAZ7OArog@mail.gmail.com>
Subject: Re: VIRTIO_NET_HDR_F_RSC_INFO in virtio-net vs headers update
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d4f06605a442ac12"
Received-SPF: none client-ip=2607:f8b0:4864:20::b30;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-yb1-xb30.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::b30
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
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d4f06605a442ac12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'd suggest to do the single change in virtio-net.c with RSC definitions
from updated linux headers.
I can send respective patch if you want

On Mon, Apr 27, 2020 at 12:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Apr 27, 2020 at 11:10:29AM +0200, Cornelia Huck wrote:
> > On Mon, 27 Apr 2020 16:41:30 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > >
> > > On 2020/4/27 =E4=B8=8B=E5=8D=883:33, Cornelia Huck wrote:
> > > > Hi,
> > > >
> > > > I'm currently trying to prepare a linux-headers update to 5.7-rc3,
> > > > which adds the definition of VIRTIO_NET_HDR_F_RSC_INFO.
> > > >
> > > > Unfortunately, this breaks the build of virtio-net, because now
> > > > virtio_net_rsc_ext_num_{packets,dupacks} are undefined (they are
> > > > guarded by existence of VIRTIO_NET_HDR_F_RSC_INFO).
> > > >
> > > > What is the right way to fix this? Remove the constants that are no=
w
> > > > provided by the header and keep the definitions of
> > > > virtio_net_rsc_ext_num_{packets,dupacks}?
> > >
> > >
> > > We probably need to add a version of the above function when
> > > VIRTIO_NET_HDR_F_RSC_INFO is defined as attached.
> > >
> > > But I fail to understand why we need a fallback when
> > > VIRTIO_NET_HDR_F_RSC_INFO is not defined.
> >
> > Yes, the current code in virtio-net looks a bit odd, which is why I
> > asked.
> >
> > I see two options:
> > - do the change you proposed, do the headers update, and then rip out
> >    the compat handling
> > - do the above in a single step
> >
> > I'd prefer the second option.
>
> Slight preference for 1st one but both are ok.
>
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > [I'd like to queue a headers update as soon as possible, as the who=
le
> > > > s390 protected virt stuff depends on it...]
> > > >
> > > >
>
>

--000000000000d4f06605a442ac12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;d suggest to do the single change in virtio-net.c wi=
th RSC definitions from updated linux headers.<div>I can send respective pa=
tch if you=C2=A0want</div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, Apr 27, 2020 at 12:18 PM Michael S. Tsirk=
in &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Apr 27, 2020=
 at 11:10:29AM +0200, Cornelia Huck wrote:<br>
&gt; On Mon, 27 Apr 2020 16:41:30 +0800<br>
&gt; Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank=
">jasowang@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; On 2020/4/27 =E4=B8=8B=E5=8D=883:33, Cornelia Huck wrote:<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;m currently trying to prepare a linux-headers update t=
o 5.7-rc3,<br>
&gt; &gt; &gt; which adds the definition of VIRTIO_NET_HDR_F_RSC_INFO.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Unfortunately, this breaks the build of virtio-net, because =
now<br>
&gt; &gt; &gt; virtio_net_rsc_ext_num_{packets,dupacks} are undefined (they=
 are<br>
&gt; &gt; &gt; guarded by existence of VIRTIO_NET_HDR_F_RSC_INFO).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; What is the right way to fix this? Remove the constants that=
 are now<br>
&gt; &gt; &gt; provided by the header and keep the definitions of<br>
&gt; &gt; &gt; virtio_net_rsc_ext_num_{packets,dupacks}?<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; We probably need to add a version of the above function when <br>
&gt; &gt; VIRTIO_NET_HDR_F_RSC_INFO is defined as attached.<br>
&gt; &gt; <br>
&gt; &gt; But I fail to understand why we need a fallback when <br>
&gt; &gt; VIRTIO_NET_HDR_F_RSC_INFO is not defined.<br>
&gt; <br>
&gt; Yes, the current code in virtio-net looks a bit odd, which is why I<br=
>
&gt; asked.<br>
&gt; <br>
&gt; I see two options:<br>
&gt; - do the change you proposed, do the headers update, and then rip out<=
br>
&gt;=C2=A0 =C2=A0 the compat handling<br>
&gt; - do the above in a single step<br>
&gt; <br>
&gt; I&#39;d prefer the second option.<br>
<br>
Slight preference for 1st one but both are ok.<br>
<br>
&gt; &gt; <br>
&gt; &gt; Thanks<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [I&#39;d like to queue a headers update as soon as possible,=
 as the whole<br>
&gt; &gt; &gt; s390 protected virt stuff depends on it...]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
<br>
</blockquote></div>

--000000000000d4f06605a442ac12--

