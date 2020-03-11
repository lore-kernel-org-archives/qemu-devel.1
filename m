Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C1C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E088C2233D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="AvzTtbmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E088C2233D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2Gb-0001a6-2G
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC1uw-0005UY-2f
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC1ur-0007hn-1K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:01:01 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:46788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jC1uq-0007gC-P2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:56 -0400
Received: by mail-yw1-xc43.google.com with SMTP id x5so2019725ywb.13
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HIG716SZxyszUpfHsVm68ZH7oL3O9ksUR8vF/Yefa3A=;
 b=AvzTtbmiHn0EObZ9sbCe8j4aAL/i/L8EynxtYfnJjarQJlM6OyxnBq7n2o8fyyxVCz
 tkUesP+KkoJTDbxp9lLIjYcYJlmCtzHdbOWNBMoDFL990BJgyV3Ij+Url41uLShqgVZ9
 Aqqr6mFLNE1/Wvuzqk06DJr6H5r0117MYA7jC7FQdfBul5UUVXhI0VrHyrGsnLDAxnFw
 FhpOPd9AJp5RVon8WR25H8M0aMacVMXFXxYgLayqfKuE+xI0tDB6YRiRYJSK1oA4p/zb
 Tr/YhaW9XJNfLfWr1MxE0JgpWGbgU1K7lYh9mu7pyyWEy8f+YS03nMQUExd98hdU7yR5
 a+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HIG716SZxyszUpfHsVm68ZH7oL3O9ksUR8vF/Yefa3A=;
 b=VghmsNr8+n5XecXeIOZ5c8TDF8wxSDOuezsR0Qpqo+k4ouS0VUd6M6w6N++DoHAl+u
 xysGT1DldLJxM4F0qdNuX+Xo5q96fI183zvgGfkhOEaV1j8QCwZZU4dH0YSEGOxGUg4U
 PJOOV8G1UnUBRU16/4IMxNg8mQnlq0WX9uThpNykgQXeGQGJIRmK82kVPXPOoPiZWBxk
 tYHMpb1Faj80OxqyyUJlPencJ9KIkNB2xdoJgcmD4IP5gg/VdvankYvposekhq49Ubn6
 zQnitJ1Rc32Ga3OZJQN7n8KkD4hlhUAUpR8wRXaU2VlohuRi+QIomyeBL9WoD024szAY
 DBrw==
X-Gm-Message-State: ANhLgQ2G57cIFLPJY+0Vnu4zJL9CWlJ9ePqPGKD2FCTa2IOGPSIRQxei
 0ZwIlVIoNt9cjXO4js30Lte6C8uEmBVkyUbdboHbEw==
X-Google-Smtp-Source: ADFU+vsmFMrvTYIhzFjAkkw/M0KGCwedECtVF4oZVUhqMPxe7iyAK9s0OQT6liUTcbRMkBqLKrS0x5/B4mAnKKbrpeI=
X-Received: by 2002:a0d:ca4e:: with SMTP id m75mr3402341ywd.36.1583935254760; 
 Wed, 11 Mar 2020 07:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-6-yuri.benditovich@daynix.com>
 <20200311094706-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200311094706-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 11 Mar 2020 16:00:44 +0200
Message-ID: <CAOEp5OdjP4XsSkyCU0n1YGvyWwayOH5D6iTP-8RRLYfwSJd=7Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] virtio-net: add migration support for RSS and hast
 report
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000035213305a094aaf4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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

--00000000000035213305a094aaf4
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 11, 2020 at 3:48 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 11, 2020 at 02:35:17PM +0200, Yuri Benditovich wrote:
> > Save and restore RSS/hash report configuration.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  hw/net/virtio-net.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 7b6a929e8c..c8d97d45cd 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -2869,6 +2869,13 @@ static int virtio_net_post_load_device(void
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
> > @@ -3094,6 +3101,8 @@ static const VMStateDescription
> vmstate_virtio_net_device = {
> >                           vmstate_virtio_net_tx_waiting),
> >          VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
> >                              has_ctrl_guest_offloads),
> > +        VMSTATE_UINT8_ARRAY(rss_data_migration, VirtIONet,
> > +                            sizeof(VirtioNetRssData)),
> >          VMSTATE_END_OF_LIST()
> >     },
>
>
> I think we should migrate the length too. Avoid arbitrary limits.
>

The length of what? The structure is fixed-length and the intention is just
to keep/restore it.
The length of indirection table and the table itself are part of the
structure.


> Yes this means we should allocate the indirection arrays on the fly.
> But that's probably a good idea anyway.
>
> >  };
> > --
> > 2.17.1
>
>

--00000000000035213305a094aaf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2020 at 3:48 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, M=
ar 11, 2020 at 02:35:17PM +0200, Yuri Benditovich wrote:<br>
&gt; Save and restore RSS/hash report configuration.<br>
&gt; <br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 7b6a929e8c..c8d97d45cd 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -2869,6 +2869,13 @@ static int virtio_net_post_load_device(void *op=
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
&gt; @@ -3094,6 +3101,8 @@ static const VMStateDescription vmstate_virtio_n=
et_device =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_virtio_net_tx_waiting),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64_TEST(curr_guest_offlo=
ads, VirtIONet,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_ctrl_guest_offloads),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(rss_data_migration, V=
irtIONet,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(VirtioNetRssData)),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt;=C2=A0 =C2=A0 =C2=A0},<br>
<br>
<br>
I think we should migrate the length too. Avoid arbitrary limits.<br></bloc=
kquote><div><br></div><div>The length of what? The structure is fixed-lengt=
h and the intention=C2=A0is just to keep/restore it.</div><div>The length o=
f indirection table and the table itself are part of the structure.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Yes this means we should allocate the indirection arrays on the fly.<br>
But that&#39;s probably a good idea anyway.<br>
<br>
&gt;=C2=A0 };<br>
&gt; -- <br>
&gt; 2.17.1<br>
<br>
</blockquote></div></div>

--00000000000035213305a094aaf4--

