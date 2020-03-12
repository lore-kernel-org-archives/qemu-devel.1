Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCA6C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99A120578
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="xLQ+NelX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99A120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCIPl-000727-PN
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 03:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jCIP9-0006cD-Ge
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jCIP8-0004kn-2D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:37:19 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:38464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jCIP7-0004k8-I1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:37:18 -0400
Received: by mail-yw1-xc41.google.com with SMTP id 10so4684597ywv.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ik0JRIdlQtDMRuc3c/6+FTs1vJFW8ZTCh/xiJgNRU2s=;
 b=xLQ+NelX19SrBkAlvkWG0HV4vUQDmWIJODzlkGoq2+s5KzVIDXaATYWHJmuYSqlVjJ
 6Z8rfLg5gLJkw34yRKYDmlOTg0/2ydj8++UkyKva8MxbqBlEoNVALAPJyn144N/qvXbU
 mYv+iIjkZJg0cg7EMtzK8r8+NpooL5AKhchPzjlqYybnEC4fNWiPoh04spYe7CwLVyTF
 7suGOWT8bwethf5lwXAyO89U2XE0WLvjwR1EpA5VbtccrK3ij2/QJzPxPGEgdc0m6fOY
 ji6Nr9U0UNKPCIc4879CZITC5FAu7ETs6kQtDoGHY2HvAkpOGL/eCJdlJEyo9Emc1Tyg
 Tj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ik0JRIdlQtDMRuc3c/6+FTs1vJFW8ZTCh/xiJgNRU2s=;
 b=W2wmKnz9d7QT6c6oKfvxIuGaXQ5uFA3m9mfHX1BOPQsAVnVvSx6tcEvB8rpPNQwAH+
 uSiSl8V86ii3CeS4Wt2HUG1O5nD7kI45hcdpssJ1sizaJH2egsqvnyrYO7v8zYzGeZ5U
 QbD4m421ghfE9wmZl1p4EeoKfSwzLpIqt4TlfYJCVOytLSICc6ayqo+v3ycITsAJAvuu
 vc1HNluXOesvzcshIwnp0jQ1IC4sczGlFSQ/+FfGePZXPxOE0VlFV0+/pjKKHOWwi6fX
 5tcBMlH2nATO35Yr5kigMkAmeaO4JhATqWfjf1rSdoD22EXrNHH7Q66Vpnm+U6EqwEno
 3ydg==
X-Gm-Message-State: ANhLgQ08I0uv7rDGpkVw3/3LGNI6TqVXMRaKPT4FS6cLi/QHkfc3+aPi
 tetj+VaM2JHB4P81FkKbv8Eff0/iaiL6afAIg3/E3w==
X-Google-Smtp-Source: ADFU+vtWEX2BhwHWXM+eVr+Eg5zKPN7cKJ9PdC4LIU6EGZ0KZzhI3r6u84O5zeos8YbPLCyocEc+/W5TIZ2ySNgHhbs=
X-Received: by 2002:a5b:50d:: with SMTP id o13mr6547865ybp.366.1583998636048; 
 Thu, 12 Mar 2020 00:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-6-yuri.benditovich@daynix.com>
 <20200311094706-mutt-send-email-mst@kernel.org>
 <CAOEp5OdjP4XsSkyCU0n1YGvyWwayOH5D6iTP-8RRLYfwSJd=7Q@mail.gmail.com>
 <20200311161924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200311161924-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 12 Mar 2020 09:37:06 +0200
Message-ID: <CAOEp5Oe8iwSgSGoPuBWJh_6FvSHMTnhJSLAMCt=vM9azmQfp0g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] virtio-net: add migration support for RSS and hast
 report
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000006eb1205a0a36c01"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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

--00000000000006eb1205a0a36c01
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 11, 2020 at 10:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 11, 2020 at 04:00:44PM +0200, Yuri Benditovich wrote:
> >
> >
> > On Wed, Mar 11, 2020 at 3:48 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Wed, Mar 11, 2020 at 02:35:17PM +0200, Yuri Benditovich wrote:
> >     > Save and restore RSS/hash report configuration.
> >     >
> >     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> >     > ---
> >     >  hw/net/virtio-net.c | 9 +++++++++
> >     >  1 file changed, 9 insertions(+)
> >     >
> >     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >     > index 7b6a929e8c..c8d97d45cd 100644
> >     > --- a/hw/net/virtio-net.c
> >     > +++ b/hw/net/virtio-net.c
> >     > @@ -2869,6 +2869,13 @@ static int virtio_net_post_load_device(void
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
> >     > @@ -3094,6 +3101,8 @@ static const VMStateDescription
> >     vmstate_virtio_net_device = {
> >     >                           vmstate_virtio_net_tx_waiting),
> >     >          VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
> >     >                              has_ctrl_guest_offloads),
> >     > +        VMSTATE_UINT8_ARRAY(rss_data_migration, VirtIONet,
> >     > +                            sizeof(VirtioNetRssData)),
> >     >          VMSTATE_END_OF_LIST()
> >     >     },
> >
> >
> >     I think we should migrate the length too. Avoid arbitrary limits.
> >
> >
> > The length of what?
>
> Of the tables.
> > The structure is fixed-length and the intention is just to
> > keep/restore it.
> > The length of indirection table and the table itself are part of the
> structure.
>
>
> And that's a problem, because
> 1. we are wasting memory for a rarely used feature
> 2. if we want to make the table bigger, we'll need to break
>    migration compatibility
>
> Just allocate these dynamically as needed, and migrate length.
>

Unfortunately, this does not make things much better.
The maximum table size is 128, i.e we have persistent allocation of 256
bytes.
1. Addition of the code to make the allocation dynamic and migrate it will
eat most of this.
2. If we decide to change the maximum size if future, we anyway create
incompatibility. The driver asks what is maximum indirection table size at
the initialization time and the OS provides a table according to this. If
we migrate between two different implementations we find ourselves with
queue mask that is not compatible with maximum size. I'd rather add the
comment "do not change these numbers".
3. Size of key for Toeplitz is always 40

Please confirm you want to make it dynamic anyway





>
>
> >
> >     Yes this means we should allocate the indirection arrays on the fly.
> >     But that's probably a good idea anyway.
> >
> >     >  };
> >     > --
> >     > 2.17.1
> >
> >
>
>

--00000000000006eb1205a0a36c01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2020 at 10:21 PM Mich=
ael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, =
Mar 11, 2020 at 04:00:44PM +0200, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Mar 11, 2020 at 3:48 PM Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Wed, Mar 11, 2020 at 02:35:17PM +0200, Yuri Bend=
itovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Save and restore RSS/hash report configuration=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D=
"mailto:yuri.benditovich@daynix.com" target=3D"_blank">yuri.benditovich@day=
nix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 hw/net/virtio-net.c | 9 +++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virt=
io-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 7b6a929e8c..c8d97d45cd 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/net/virtio-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/net/virtio-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -2869,6 +2869,13 @@ static int virtio_net_p=
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
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -3094,6 +3101,8 @@ static const VMStateDesc=
ription<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmstate_virtio_net_device =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_virtio_net_tx_w=
aiting),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT=
64_TEST(curr_guest_offloads, VirtIONet,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_ctrl_guest_=
offloads),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARR=
AY(rss_data_migration, VirtIONet,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(VirtioNetRssDat=
a)),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_=
OF_LIST()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I think we should migrate the length too. Avoid arb=
itrary limits.<br>
&gt; <br>
&gt; <br>
&gt; The length of what?<br>
<br>
Of the tables.<br>
&gt; The structure is fixed-length and the intention=C2=A0is just to<br>
&gt; keep/restore it.<br>
&gt; The length of indirection table and the table itself are part of the s=
tructure.<br>
<br>
<br>
And that&#39;s a problem, because<br>
1. we are wasting memory for a rarely used feature<br>
2. if we want to make the table bigger, we&#39;ll need to break<br>
=C2=A0 =C2=A0migration compatibility<br>
<br>
Just allocate these dynamically as needed, and migrate length.<br></blockqu=
ote><div><br></div><div>Unfortunately, this does not make things much bette=
r.</div><div>The maximum table size is 128, i.e we have persistent=C2=A0all=
ocation of 256 bytes.</div><div>1. Addition of the code to make the allocat=
ion dynamic and migrate it will eat most of this.</div><div>2. If we decide=
 to change the maximum size if future, we anyway create incompatibility. Th=
e driver asks what is maximum indirection table size at the initialization =
time and the OS provides a table according to this. If we migrate between t=
wo different implementations we find ourselves with queue mask that is not =
compatible with maximum size. I&#39;d rather add the comment &quot;do not c=
hange these numbers&quot;.</div><div>3. Size of key for Toeplitz is always =
40</div><div><br></div><div>Please confirm you want to make it dynamic anyw=
ay</div><div><br></div><div>=C2=A0</div><div><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes this means we should allocate the indirection a=
rrays on the fly.<br>
&gt;=C2=A0 =C2=A0 =C2=A0But that&#39;s probably a good idea anyway.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2.17.1<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000006eb1205a0a36c01--

