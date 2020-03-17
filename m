Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C95C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802D620674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="WhKP5eJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802D620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE7J2-0005K0-K0
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 04:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jE7IA-0004UP-2F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jE7I8-0005KX-Ka
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:09:38 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:42478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jE7I8-0005Gy-3F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:09:36 -0400
Received: by mail-qk1-x744.google.com with SMTP id e11so30934539qkg.9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 01:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R7O/YtBJ7Gm8alpDgN1jogT888z0TznkhWkXpf3tXRE=;
 b=WhKP5eJ6IiTjeI6Azj5cUphruNd9nx/jIgaAMIkss9Xvcj9uSEU5pZUffDv1oTT7v1
 3UBiCHmlon5kPZb7XwEMXXZl2t0It0Ao2mvbU0klC1pHWvDZ688R7JBnWAVoI0mE9CLI
 s9RN9CRKfRxAA0QZMxhaqpK6PAPJQmkbH8vf951VzMmNm6XSEUWxvV1vw+r82u4tI27g
 U96PU04ABbxdkJL9rUl/GeAnbERsJUsCeF9tYlTnTsw0sx3+KBPEh1KLbuXASXPtx/5l
 jog48iXxqWUJ+KkHZLJFJ16QgVvARpgM8ejGW1HTgsc14lHsahfD7fL412Ao+kz2oxno
 RXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R7O/YtBJ7Gm8alpDgN1jogT888z0TznkhWkXpf3tXRE=;
 b=TQCKNWRCNe5f0z0WUNPfFgZty5T3fpav39wDCK07Ao8VMpsHZWBl0ppWnOpGdRgM9F
 AR86L3GkVYc9Ywve6ksbKOQ1XqULL/nN6fDEtQpEZLFEPwyw5G/BSYuDBdjuua55Wx0l
 GWGscsg1EQ7YtwKVsLsjx8kk0jiqhJZvK3jbI4n8z8urW2yLVZd4dFs56msfK7cHy9O3
 5sprslOQHfk8jXMCmZXmWf0vmrPHh3BIVJnyggGWAfMpj6OrH3UnO8O4HyY8jHc+xDZv
 pXCHSqBJguikSVfXtETZyYUPxKRJ8VzBvFO9gfFE2wHAnuI3LfGC1zU7eq1QGb2CmafD
 r/TA==
X-Gm-Message-State: ANhLgQ0mM1T3YKEpc4N6XCT64Mcu4gctVaVG8LDGSlmInTumSEEoLN2m
 yTiUHwSr784Nhk16l86KtIowK+OiWrwkLMcKTJH6WQ==
X-Google-Smtp-Source: ADFU+vvu/7z6d+2qto0VbsziNXz0zyZyGlqAJwgqI95ieX/vlEy2TscL1j+zYxoL0GEpU2XYJkoGG2hbw/wcMeLnrJM=
X-Received: by 2002:a25:dc07:: with SMTP id y7mr5908955ybe.48.1584432574991;
 Tue, 17 Mar 2020 01:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200316100933.11499-1-yuri.benditovich@daynix.com>
 <20200316100933.11499-7-yuri.benditovich@daynix.com>
 <20200316190407-mutt-send-email-mst@kernel.org>
 <CAOEp5OfLAU1oyj=75K6CFPSH_YXz+mZsbSLRZ=LEMRcTvUdetA@mail.gmail.com>
 <20200317023032-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200317023032-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 17 Mar 2020 10:09:22 +0200
Message-ID: <CAOEp5Ocau5mfBi+wQro9mub6jOmhuriyFHbj-p9+Cmm01czt6w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] virtio-net: add migration support for RSS and hash
 report
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cda18f05a10874b0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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

--000000000000cda18f05a10874b0
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 17, 2020 at 8:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Mar 17, 2020 at 07:48:55AM +0200, Yuri Benditovich wrote:
> >
> >
> > On Tue, Mar 17, 2020 at 1:05 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Mon, Mar 16, 2020 at 12:09:33PM +0200, Yuri Benditovich wrote:
> >     > Save and restore RSS/hash report configuration.
> >     >
> >     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> >     > ---
> >     >  hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
> >     >  1 file changed, 26 insertions(+)
> >     >
> >     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >     > index a0614ad4e6..f343762a0f 100644
> >     > --- a/hw/net/virtio-net.c
> >     > +++ b/hw/net/virtio-net.c
> >     > @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void
> >     *opaque, int version_id)
> >     >          }
> >     >      }
> >     >
> >     > +    if (n->rss_data.enabled) {
> >     > +        trace_virtio_net_rss_enable(n->rss_data.hash_types,
> >     > +                                    n->rss_data.indirections_len,
> >     > +                                    sizeof(n->rss_data.key));
> >     > +    } else {
> >     > +        trace_virtio_net_rss_disable();
> >     > +    }
> >     >      return 0;
> >     >  }
> >     >
> >     > @@ -3019,6 +3026,24 @@ static const VMStateDescription
> >     vmstate_virtio_net_has_vnet = {
> >     >      },
> >     >  };
> >     >
> >     > +static const VMStateDescription vmstate_rss = {
> >     > +    .name      = "vmstate_rss",
> >     > +    .fields = (VMStateField[]) {
> >     > +        VMSTATE_BOOL(enabled, VirtioNetRssData),
> >     > +        VMSTATE_BOOL(redirect, VirtioNetRssData),
> >     > +        VMSTATE_BOOL(populate_hash, VirtioNetRssData),
> >     > +        VMSTATE_UINT32(hash_types, VirtioNetRssData),
> >     > +        VMSTATE_UINT32(indirections_len, VirtioNetRssData),
> >
> >
> >     Why is this UINT32? Shouldn't it be UINT16?
> >
> >
> > It is UINT32 in the _internal_ structure to use
> VMSTATE_VARRAY_UINT32_ALLOC.
> > Otherwise I need to invent additional macro for the same operation with
> UINT16
> > length.
> >
>
> It's not internal - it's exposed as part of the migration stream format.
> Adding VMSTATE_VARRAY_UINT16_ALLOC is as easy as:
>
>
IMO, reuse existing (and widely used) is always better than create a new,
even if it is simple to create a new.
But if you find it mandatory, I'll add a new.

Are there some notes to other patches in the batch?



> -->
>
> vmstate: add VMSTATE_VARRAY_UINT16_ALLOC
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> --
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 30667631bc..b0b89c6fe5 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;
>      .offset     = vmstate_offset_pointer(_state, _field, _type),     \
>  }
>
> +#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version,
> _info, _type) {\
> +    .name       = (stringify(_field)),                               \
> +    .version_id = (_version),                                        \
> +    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
> +    .info       = &(_info),                                          \
> +    .size       = sizeof(_type),                                     \
> +    .flags      = VMS_VARRAY_UINT16|VMS_POINTER|VMS_ALLOC,           \
> +    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
> +}
> +
>  #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num,
> _version, _info, _type) {\
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
>
>

--000000000000cda18f05a10874b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 17, 2020 at 8:33 AM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, M=
ar 17, 2020 at 07:48:55AM +0200, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Mar 17, 2020 at 1:05 AM Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Mar 16, 2020 at 12:09:33PM +0200, Yuri Bend=
itovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Save and restore RSS/hash report configuration=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D=
"mailto:yuri.benditovich@daynix.com" target=3D"_blank">yuri.benditovich@day=
nix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 hw/net/virtio-net.c | 26 +++++++++++++++=
+++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 26 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virt=
io-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index a0614ad4e6..f343762a0f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/net/virtio-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/net/virtio-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -2842,6 +2842,13 @@ static int virtio_net_p=
ost_load_device(void<br>
&gt;=C2=A0 =C2=A0 =C2=A0*opaque, int version_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 if (n-&gt;rss_data.enabled) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_net_=
rss_enable(n-&gt;rss_data.hash_types,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 n-&gt;rss_data.indirections_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sizeof(n-&gt;rss_data.key));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_net_=
rss_disable();<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -3019,6 +3026,24 @@ static const VMStateDes=
cription<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmstate_virtio_net_has_vnet =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +static const VMStateDescription vmstate_rss =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =3D &=
quot;vmstate_rss&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(enab=
led, VirtioNetRssData),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(redi=
rect, VirtioNetRssData),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(popu=
late_hash, VirtioNetRssData),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(ha=
sh_types, VirtioNetRssData),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(in=
directions_len, VirtioNetRssData),<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why is this UINT32? Shouldn&#39;t it be UINT16?<br>
&gt; <br>
&gt; <br>
&gt; It is UINT32 in the _internal_ structure to use VMSTATE_VARRAY_UINT32_=
ALLOC.<br>
&gt; Otherwise I need to invent additional macro for the same operation wit=
h UINT16<br>
&gt; length.<br>
&gt; =C2=A0<br>
<br>
It&#39;s not internal - it&#39;s exposed as part of the migration stream fo=
rmat.<br>
Adding VMSTATE_VARRAY_UINT16_ALLOC is as easy as:<br>
<br></blockquote><div><br></div><div>IMO, reuse existing (and widely used) =
is always better than create a new, even if it is simple to create a new.</=
div><div>But if you find it mandatory, I&#39;ll add a new.</div><div><br></=
div><div>Are there some notes to other patches in the batch?=C2=A0</div><di=
v><br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
--&gt;<br>
<br>
vmstate: add VMSTATE_VARRAY_UINT16_ALLOC<br>
<br>
Signed-off-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" tar=
get=3D"_blank">mst@redhat.com</a>&gt;<br>
<br>
--<br>
<br>
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h<br>
index 30667631bc..b0b89c6fe5 100644<br>
--- a/include/migration/vmstate.h<br>
+++ b/include/migration/vmstate.h<br>
@@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;<br>
=C2=A0 =C2=A0 =C2=A0.offset=C2=A0 =C2=A0 =C2=A0=3D vmstate_offset_pointer(_=
state, _field, _type),=C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0}<br>
<br>
+#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version, =
_info, _type) {\<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (stringify(_field)),=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 .version_id =3D (_version),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 .num_offset =3D vmstate_offset_value(_state, _field_num, uin=
t16_t),\<br>
+=C2=A0 =C2=A0 .info=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &amp;(_info),=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 .size=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D sizeof(_type),=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =3D VMS_VARRAY_UINT16|VMS_POINTER=
|VMS_ALLOC,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 .offset=C2=A0 =C2=A0 =C2=A0=3D vmstate_offset_pointer(_state=
, _field, _type),=C2=A0 =C2=A0 =C2=A0\<br>
+}<br>
+<br>
=C2=A0#define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _ver=
sion, _info, _type) {\<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (stringify(_field))=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0.version_id =3D (_version),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
<br>
</blockquote></div></div>

--000000000000cda18f05a10874b0--

