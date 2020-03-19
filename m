Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70644C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356A62070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="d/REE1y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356A62070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEyqK-0000Iv-7h
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEypb-0008K7-Hi
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEypa-0005LJ-3J
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:19:43 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:45987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jEypZ-0005Jd-MJ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:19:42 -0400
Received: by mail-yb1-xb43.google.com with SMTP id k132so704980ybf.12
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5WD3CSMyIUEckg+6gM4/DAYzUYr32oqzYLGdFdqc6IE=;
 b=d/REE1y7KJnfvG1S49J1wYDLaccgshMPFOHpT4xUoAgMUSPnsOrCiX3t1c1cSHPRvK
 +rDSmG83KH9bLMPsUjbOOCdAcI45aHUwAgTWoCLP2CPfUnDD45nGHYDsxyZK9CJNJLcA
 JrgSTnCV8NRBeeigOvTN/HrBWIqoD0yontbFENS/uwqvaDZo7C7LOiOrW4vDPEGppjcO
 gt7DfJJIL/PggnR9I7/FMkiGatF6oMqJSt9WrY8jScI/1y7O8RKF2NjQ4vvvBF3rTOJf
 liEF5ingcR4VDyiZL3BPvYG0Vco5CAINJkLdslz5T7nx4rmdIZryo6PeRV5xCK37RieH
 KQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5WD3CSMyIUEckg+6gM4/DAYzUYr32oqzYLGdFdqc6IE=;
 b=dPwKYsyPiDZl0C4DkeiYhaXTCrVXWfnWAD8zdMWRwfkJxI12SdIElBF8Cg/ooEohDW
 H8x8/cAwD7LO0wZN1F95psCjuS25MfJHOl+/TtZnoU9bq/+NxMSHxeVcE0PPLqn224Fx
 WEG0uheQE1pjQtrvMzR/IF70dx5KmGCESAjatcmkXrgXtz+Rsti0rt4AwKApmr0zCPXj
 Xqj20fTa6MQ5ZALK4zonGVtBcdVBNyvPmMzCkrmnygCmKAb6nlxVO4y8xcFBsxyjTeDC
 /9BeDP+ckS+dKXDgXGVMlAXbjoeDnDJz2nc4TPR4QCHiiLNYwneZsqv9d6iD5s6Rw1jZ
 M2/w==
X-Gm-Message-State: ANhLgQ2YIyk5PY7TuCtHDyAToEagCQS6KPrw+EWvfY0HB0avY77GBiM2
 3HRxeYrYGMMRy/AshH6gW5qQVj/gaWwS4pxSMmPhyA==
X-Google-Smtp-Source: ADFU+vsQe5o6D+auLdx8dbRSzcgyA1e9lYU35CEmhrH5JgLpaR24N3MyUgPQyNWNtlyOhyIuwCoY5s8qTvPAFpfpHPA=
X-Received: by 2002:a5b:4c9:: with SMTP id u9mr6273579ybp.48.1584638380928;
 Thu, 19 Mar 2020 10:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-8-yuri.benditovich@daynix.com>
 <20200318104826.GF2850@work-vm>
In-Reply-To: <20200318104826.GF2850@work-vm>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 19 Mar 2020 19:19:26 +0200
Message-ID: <CAOEp5Odhjr6h7erYz_VchjRF98-SNt27RW_T_ao7P0nwc-0ebg@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] virtio-net: add migration support for RSS and hash
 report
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cb02fa05a1385fe2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
 quintela@redhat.com, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cb02fa05a1385fe2
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 18, 2020 at 12:48 PM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Yuri Benditovich (yuri.benditovich@daynix.com) wrote:
> > Save and restore RSS/hash report configuration.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index a0614ad4e6..0b058aae9f 100644
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
>
> You need to do something to avoid breaking migration compatibility
> from/to old QEMU's and from/to QEMU's on hosts without the new virtio
> features.
> Probably adding a .needed =   here pointing to a function that
> checks 'enabled' might do it.
>
> Does VMSTATE_STRUCT_TEST(..,..,checker_procedure,...) result the same
thing?

Another question about migration support:
What is expected/required behavior?
Possible cases:
old qemu -> new qemu
new qemu (new feature off) -> old qemu
new qemu (new feature on) -> old qemu


> Dave
>
>
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_BOOL(enabled, VirtioNetRssData),
> > +        VMSTATE_BOOL(redirect, VirtioNetRssData),
> > +        VMSTATE_BOOL(populate_hash, VirtioNetRssData),
> > +        VMSTATE_UINT32(hash_types, VirtioNetRssData),
> > +        VMSTATE_UINT16(indirections_len, VirtioNetRssData),
> > +        VMSTATE_UINT16(default_queue, VirtioNetRssData),
> > +        VMSTATE_UINT8_ARRAY(key, VirtioNetRssData,
> > +                            VIRTIO_NET_RSS_MAX_KEY_SIZE),
> > +        VMSTATE_VARRAY_UINT16_ALLOC(indirections_table,
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
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>

--000000000000cb02fa05a1385fe2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 18, 2020 at 12:48 PM Dr. =
David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com">dgilbert@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">* Yuri Benditovich (<a href=3D"mailto:yuri.benditovich@daynix.com" ta=
rget=3D"_blank">yuri.benditovich@daynix.com</a>) wrote:<br>
&gt; Save and restore RSS/hash report configuration.<br>
&gt; <br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 26 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index a0614ad4e6..0b058aae9f 100644<br>
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
<br>
You need to do something to avoid breaking migration compatibility<br>
from/to old QEMU&#39;s and from/to QEMU&#39;s on hosts without the new virt=
io<br>
features.<br>
Probably adding a .needed =3D=C2=A0 =C2=A0here pointing to a function that<=
br>
checks &#39;enabled&#39; might do it.<br>
<br></blockquote><div>Does VMSTATE_STRUCT_TEST(..,..,checker_procedure,...)=
 result the same thing?<br></div><div><br></div><div>Another question about=
 migration support:<br></div><div><div>What is expected/required behavior?<=
br></div><div>Possible cases:</div><div>old qemu -&gt; new qemu</div><div>n=
ew qemu (new feature off) -&gt; old qemu</div><div>new qemu (new feature on=
) -&gt; old qemu</div><div></div></div><div>=C2=A0<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
Dave<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(enabled, VirtioNetRssData),<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(redirect, VirtioNetRssData),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(populate_hash, VirtioNetRssD=
ata),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(hash_types, VirtioNetRssDa=
ta),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(indirections_len, VirtioNe=
tRssData),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(default_queue, VirtioNetRs=
sData),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(key, VirtioNetRssData=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_RSS_MAX_KEY_SIZE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_VARRAY_UINT16_ALLOC(indirections_=
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
&gt; <br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank">dgilbert@redhat.com</a> / Manchester, UK<br>
<br>
</blockquote></div></div>

--000000000000cb02fa05a1385fe2--

