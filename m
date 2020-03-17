Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888C3C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C29F20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="pBHkirdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C29F20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE56z-0007dA-Hi
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jE56E-0007DL-6a
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jE56C-00008t-Vf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:49:10 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jE56C-0008VI-Ik
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:49:08 -0400
Received: by mail-qk1-x742.google.com with SMTP id h14so30588348qke.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U2LDGD5lpx/cCE5pWRoOPwbkAmvzPZv/Zf/ncg5S0FU=;
 b=pBHkirdI6G0oo6Sq4nXhJgzqa6LBIFPYoBetRDFwxB2vClUXSgN4DfYcHWskqzMnIZ
 Lis4knl4JD43dZMFQAJiyMxNvd6S7seAGAqAN5J8wcKteB6Rm7Uj4NW1QMcTRadL4H1f
 fkste0bbPE19cIt1IKCRI4wdQUcPi7NcM299rN5mz3itz/2uUn6r0938SZc1vufG2Z/V
 k7ILWyWRDp+TLKR/pUtq5nW6Ni+RZVrYhbltCLd/umWPKMo4eYInbdC4jfUpUd0B2gPG
 SLz91zdzeBTuGQW0+HJvSSnQXJH72/cmam1cNBa/jf2OdPnLY93TxU2EnjWt2JaI64Iz
 VbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U2LDGD5lpx/cCE5pWRoOPwbkAmvzPZv/Zf/ncg5S0FU=;
 b=AJlUB4+rrSnNILte7sdLAEfpOzROb4zHL4gxj7VYEBDa/pYDLZmdm+X4eJob767tr6
 3ywORZmYx8OJijPLm5uyeAqt/VFUn4aYZEqsea992Erl55a9gnUsYlaL131PaxFOkivS
 rS+hk4IET/wqUjsQsvf6C6rt23taEXaz3gVnQpNsCGd0XpUhKkXgcL80wHsgYyXD5439
 70GA3huVdrA158kbFBIcwOgEaYBp4wjRAi8EFBhnXFyM+Z3s0vea+/UNm0Jx9szYr+Yo
 vJhrMC6OJOwNcMC2O2j1t7WDlgjL+fB9GwD7CmrnzsZEx/5POeI9LZ9kqAFozziq7FO9
 nFyw==
X-Gm-Message-State: ANhLgQ3aFhxV+KUUqCaMMiUCY3aGnuQ3CRbfQdORemghUPJ3XK5Jf7ZA
 WR8jntkQxXt/7qqFNutrX7TqbFCDdJR6HiRXzUfdJA==
X-Google-Smtp-Source: ADFU+vtKKoVEc/SBXHcK9k9GHIoQqZLtWTto6NMAckmyLV2Eixsp6gh7oMT/xuXBi7JnmlUkY7KUra7DHqMzdXALwM4=
X-Received: by 2002:a25:244f:: with SMTP id k76mr5119746ybk.235.1584424147393; 
 Mon, 16 Mar 2020 22:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200316100933.11499-1-yuri.benditovich@daynix.com>
 <20200316100933.11499-7-yuri.benditovich@daynix.com>
 <20200316190407-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200316190407-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 17 Mar 2020 07:48:55 +0200
Message-ID: <CAOEp5OfLAU1oyj=75K6CFPSH_YXz+mZsbSLRZ=LEMRcTvUdetA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] virtio-net: add migration support for RSS and hash
 report
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007ab06b05a1067eb2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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

--0000000000007ab06b05a1067eb2
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 17, 2020 at 1:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Mar 16, 2020 at 12:09:33PM +0200, Yuri Benditovich wrote:
> > Save and restore RSS/hash report configuration.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index a0614ad4e6..f343762a0f 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void
> *opaque, int version_id)
> >          }
> >      }
> >
> > +    if (n->rss_data.enabled) {
> > +        trace_virtio_net_rss_enable(n->rss_data.hash_types,
> > +                                    n->rss_data.indirections_len,
> > +                                    sizeof(n->rss_data.key));
> > +    } else {
> > +        trace_virtio_net_rss_disable();
> > +    }
> >      return 0;
> >  }
> >
> > @@ -3019,6 +3026,24 @@ static const VMStateDescription
> vmstate_virtio_net_has_vnet = {
> >      },
> >  };
> >
> > +static const VMStateDescription vmstate_rss = {
> > +    .name      = "vmstate_rss",
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_BOOL(enabled, VirtioNetRssData),
> > +        VMSTATE_BOOL(redirect, VirtioNetRssData),
> > +        VMSTATE_BOOL(populate_hash, VirtioNetRssData),
> > +        VMSTATE_UINT32(hash_types, VirtioNetRssData),
> > +        VMSTATE_UINT32(indirections_len, VirtioNetRssData),
>
>
> Why is this UINT32? Shouldn't it be UINT16?
>

It is UINT32 in the _internal_ structure to use VMSTATE_VARRAY_UINT32_ALLOC.
Otherwise I need to invent additional macro for the same operation with
UINT16 length.


>
> > +        VMSTATE_UINT16(default_queue, VirtioNetRssData),
> > +        VMSTATE_UINT8_ARRAY(key, VirtioNetRssData,
> > +                            VIRTIO_NET_RSS_MAX_KEY_SIZE),
> > +        VMSTATE_VARRAY_UINT32_ALLOC(indirections_table,
> VirtioNetRssData,
> > +                                    indirections_len, 0,
> > +                                    vmstate_info_uint16, uint16_t),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> >  static const VMStateDescription vmstate_virtio_net_device = {
> >      .name = "virtio-net-device",
> >      .version_id = VIRTIO_NET_VM_VERSION,
> > @@ -3067,6 +3092,7 @@ static const VMStateDescription
> vmstate_virtio_net_device = {
> >                           vmstate_virtio_net_tx_waiting),
> >          VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
> >                              has_ctrl_guest_offloads),
> > +        VMSTATE_STRUCT(rss_data, VirtIONet, 1, vmstate_rss,
> VirtioNetRssData),
> >          VMSTATE_END_OF_LIST()
> >     },
> >  };
> > --
> > 2.17.1
>
>

--0000000000007ab06b05a1067eb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 17, 2020 at 1:05 AM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, M=
ar 16, 2020 at 12:09:33PM +0200, Yuri Benditovich wrote:<br>
&gt; Save and restore RSS/hash report configuration.<br>
&gt; <br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 26 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index a0614ad4e6..f343762a0f 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void *op=
aque, int version_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;rss_data.enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_net_rss_enable(n-&gt;rss_dat=
a.hash_types,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.ind=
irections_len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(n-&gt;rss_d=
ata.key));<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_net_rss_disable();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -3019,6 +3026,24 @@ static const VMStateDescription vmstate_virtio_=
net_has_vnet =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; +static const VMStateDescription vmstate_rss =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =3D &quot;vmstate_rss&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(enabled, VirtioNetRssData),<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(redirect, VirtioNetRssData),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(populate_hash, VirtioNetRssD=
ata),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(hash_types, VirtioNetRssDa=
ta),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(indirections_len, VirtioNe=
tRssData),<br>
<br>
<br>
Why is this UINT32? Shouldn&#39;t it be UINT16?<br></blockquote><div><br></=
div><div>It is UINT32 in the _internal_ structure to use VMSTATE_VARRAY_UIN=
T32_ALLOC.</div><div>Otherwise I need to invent additional macro for the sa=
me operation with UINT16 length.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(default_queue, VirtioNetRs=
sData),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(key, VirtioNetRssData=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_RSS_MAX_KEY_SIZE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_VARRAY_UINT32_ALLOC(indirections_=
table, VirtioNetRssData,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indirections_len, =
0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_info_uint1=
6, uint16_t),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 static const VMStateDescription vmstate_virtio_net_device =3D {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 .name =3D &quot;virtio-net-device&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .version_id =3D VIRTIO_NET_VM_VERSION,<br>
&gt; @@ -3067,6 +3092,7 @@ static const VMStateDescription vmstate_virtio_n=
et_device =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_virtio_net_tx_waiting),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64_TEST(curr_guest_offlo=
ads, VirtIONet,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_ctrl_guest_offloads),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_STRUCT(rss_data, VirtIONet, 1, vm=
state_rss, VirtioNetRssData),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 };<br>
&gt; -- <br>
&gt; 2.17.1<br>
<br>
</blockquote></div></div>

--0000000000007ab06b05a1067eb2--

