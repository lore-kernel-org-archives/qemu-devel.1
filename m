Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF2AC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B909B2467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="nogg1/oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B909B2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBc6g-0001rQ-Tv
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBc5r-0001RP-Lm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBc5q-0003YR-3I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:26:35 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:35388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jBc5p-0003Vb-DA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:26:34 -0400
Received: by mail-yw1-xc42.google.com with SMTP id d79so12062587ywd.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bKHjehYcF28MNisvg/s8AJQS6AdNhmVkrSfCVlvZdUk=;
 b=nogg1/oy/1u2S8NT5N1kzj5NIt/UsvyO4l8EHjKlkMBMwzgiTMNIhiQihe003UIzK4
 ue3+ImTdAxPBQzmRaq84JraVWAPgaiDe0g9vsoi54WrLYsd0DiMfJKZ7glDyCPx8UvKl
 D9nLZw91EAJAM6WZVKay2hG9tKMeuwZKcs29Jojd3ncWd8bPMnnSGgAVekUReV+IxrWe
 suDhyvSZF1Np0cddqMRFYpI/TNsBxB/yaZf8iUTRs3Jzl5N5yeVRmltfniYla2guh9d+
 zDemqzGUBeD9+YzXhECybymdFF2VNcDj9uL4kR3QrP+wSpqq6MY684l2ZAXFlN8Cwr+T
 iqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bKHjehYcF28MNisvg/s8AJQS6AdNhmVkrSfCVlvZdUk=;
 b=gEyXGtZ66JJ0vP+LmCdB2dab5kgfnvs9vlBcQJ+kMUDdcCUzeg6vpTcPkUzAQf0IPI
 RKh3ugq8a0RI7HH/nUOnffIYXUvU0sTrMxDYSA/chZA6kFPUkJDHxBaNqIbAklCsblm5
 ZTzLcVa1GQfbe/5mtWY/t25ZC0F9vmJnfFr/jRGH73Dw1TXGq+zMNyTOb3tq/Hw9lWlc
 Eu8MgJHZE7hilDWtplAXF6RpghzEhHP51mnSSGppahn6KN2FB5gGDUnLrlb7iUISk/UK
 87S3GGQo8yDYUQSyTuKMYppNhJtaY+emtR5pExBUsw01vO/jDowjplVoX3VRNTmV9Fkm
 JwyQ==
X-Gm-Message-State: ANhLgQ35m71VSfAoIMdfSyrfioPjBBwQDUcKfPcGODqXFYXQvG62lh7y
 Xbo4KDUKRHU7QipR4cD8jd2E5+Dy5HUYDZmCy2kUOg==
X-Google-Smtp-Source: ADFU+vs02vLxuLveyZs0TLOH0QRUGWDrS92N2UgjTRI5v1pg9mj4jEYOyCKi6+q7ucUa1+t2e7CwU+4Nr/Un5TYtTVU=
X-Received: by 2002:a25:7747:: with SMTP id s68mr21145416ybc.235.1583835992566; 
 Tue, 10 Mar 2020 03:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
 <20200309083438.2389-5-yuri.benditovich@daynix.com>
 <32451b9c-f10d-d683-24b4-29497e73ca65@redhat.com>
 <20200310021356-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200310021356-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 10 Mar 2020 12:26:22 +0200
Message-ID: <CAOEp5OdsYybEiW9KtaN4oS=qWSe5mvNQgng1ESJGJP_-JY9Bvg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virtio-net: block migration if RSS feature
 negotiated
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b845c205a07d8d53"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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

--000000000000b845c205a07d8d53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

IMO, this does not depend on features of vhost as soon as we're not able to
provide parameters to it.


On Tue, Mar 10, 2020 at 8:17 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Mar 10, 2020 at 11:12:05AM +0800, Jason Wang wrote:
> >
> > On 2020/3/9 =E4=B8=8B=E5=8D=884:34, Yuri Benditovich wrote:
> > > Block migration for reference implementation of
> > > RSS feature in QEMU. When we add support for RSS
> > > on backend side, we'll implement migration of
> > > current RSS settings.
> > >
> > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > ---
> > >   hw/net/virtio-net.c            | 18 ++++++++++++++++++
> > >   include/hw/virtio/virtio-net.h |  1 +
> > >   2 files changed, 19 insertions(+)
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index abc41fdb16..943d1931a2 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -37,6 +37,7 @@
> > >   #include "qapi/qapi-events-migration.h"
> > >   #include "hw/virtio/virtio-access.h"
> > >   #include "migration/misc.h"
> > > +#include "migration/blocker.h"
> > >   #include "standard-headers/linux/ethtool.h"
> > >   #include "sysemu/sysemu.h"
> > >   #include "trace.h"
> > > @@ -627,6 +628,12 @@ static void virtio_net_reset(VirtIODevice *vdev)
> > >       n->announce_timer.round =3D 0;
> > >       n->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
> > > +    if (n->migration_blocker) {
> > > +        migrate_del_blocker(n->migration_blocker);
> > > +        error_free(n->migration_blocker);
> > > +        n->migration_blocker =3D NULL;
> > > +    }
> > > +
> > >       /* Flush any MAC and VLAN filter table state */
> > >       n->mac_table.in_use =3D 0;
> > >       n->mac_table.first_multi =3D 0;
> > > @@ -1003,6 +1010,17 @@ static void
> virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
> > >           vhost_net_ack_features(get_vhost_net(nc->peer), features);
> > >       }
> > > +    if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
> > > +        if (!n->migration_blocker) {
> > > +            error_setg(&n->migration_blocker, "virtio-net: RSS
> negotiated");
> > > +            migrate_add_blocker(n->migration_blocker, &err);
> > > +            if (err) {
> > > +                error_report_err(err);
> > > +                err =3D NULL;
> > > +            }
> > > +        }
> > > +    }
> >
> >
> > It looks to me we should add the blocker unconditionally based on
> > virtio_host_has_feature() instead of depending the negotiated feature
> here.
> >
> > Thanks
>
> I agree, this is a stopgap measure anyway.  If this is merged in its
> current form, there should also be a big TODO here that we must fix this
> ASAP, and maybe a warning produced.
>
>
> >
> > > +
> > >       if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
> > >           memset(n->vlans, 0, MAX_VLAN >> 3);
> > >       } else {
> > > diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
> > > index 45670dd054..fba768ba9b 100644
> > > --- a/include/hw/virtio/virtio-net.h
> > > +++ b/include/hw/virtio/virtio-net.h
> > > @@ -180,6 +180,7 @@ struct VirtIONet {
> > >       virtio_net_conf net_conf;
> > >       NICConf nic_conf;
> > >       DeviceState *qdev;
> > > +    Error *migration_blocker;
> > >       int multiqueue;
> > >       uint16_t max_queues;
> > >       uint16_t curr_queues;
>
>

--000000000000b845c205a07d8d53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">IMO, this does not depend on features of vhost as soon as =
we&#39;re not able to provide parameters to it.<div><br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 1=
0, 2020 at 8:17 AM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com"=
>mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Tue, Mar 10, 2020 at 11:12:05AM +0800, Jason Wang wrote:<=
br>
&gt; <br>
&gt; On 2020/3/9 =E4=B8=8B=E5=8D=884:34, Yuri Benditovich wrote:<br>
&gt; &gt; Block migration for reference implementation of<br>
&gt; &gt; RSS feature in QEMU. When we add support for RSS<br>
&gt; &gt; on backend side, we&#39;ll implement migration of<br>
&gt; &gt; current RSS settings.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.bendit=
ovich@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 18 ++++++++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0include/hw/virtio/virtio-net.h |=C2=A0 1 +<br>
&gt; &gt;=C2=A0 =C2=A02 files changed, 19 insertions(+)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; &gt; index abc41fdb16..943d1931a2 100644<br>
&gt; &gt; --- a/hw/net/virtio-net.c<br>
&gt; &gt; +++ b/hw/net/virtio-net.c<br>
&gt; &gt; @@ -37,6 +37,7 @@<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;qapi/qapi-events-migration.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/virtio/virtio-access.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;migration/misc.h&quot;<br>
&gt; &gt; +#include &quot;migration/blocker.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;standard-headers/linux/ethtool.h&quot;=
<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;trace.h&quot;<br>
&gt; &gt; @@ -627,6 +628,12 @@ static void virtio_net_reset(VirtIODevice *v=
dev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;announce_timer.round =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;status &amp;=3D ~VIRTIO_NET_S_ANN=
OUNCE;<br>
&gt; &gt; +=C2=A0 =C2=A0 if (n-&gt;migration_blocker) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_del_blocker(n-&gt;migration_=
blocker);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(n-&gt;migration_blocker);=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;migration_blocker =3D NULL;<br=
>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Flush any MAC and VLAN filter table =
state */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;mac_table.in_use =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;mac_table.first_multi =3D 0;<br>
&gt; &gt; @@ -1003,6 +1010,17 @@ static void virtio_net_set_features(VirtIO=
Device *vdev, uint64_t features)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_net_ack_features(ge=
t_vhost_net(nc-&gt;peer), features);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0 if (virtio_has_feature(features, VIRTIO_NET_F_RSS)=
) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!n-&gt;migration_blocker) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;n-&gt;=
migration_blocker, &quot;virtio-net: RSS negotiated&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_add_blocker(n-=
&gt;migration_blocker, &amp;err);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_re=
port_err(err);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D =
NULL;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; <br>
&gt; It looks to me we should add the blocker unconditionally based on<br>
&gt; virtio_host_has_feature() instead of depending the negotiated feature =
here.<br>
&gt; <br>
&gt; Thanks<br>
<br>
I agree, this is a stopgap measure anyway.=C2=A0 If this is merged in its<b=
r>
current form, there should also be a big TODO here that we must fix this<br=
>
ASAP, and maybe a warning produced.<br>
<br>
<br>
&gt; <br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (virtio_has_feature(features, VIRTIO=
_NET_F_CTRL_VLAN)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(n-&gt;vlans, 0, MA=
X_VLAN &gt;&gt; 3);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/v=
irtio-net.h<br>
&gt; &gt; index 45670dd054..fba768ba9b 100644<br>
&gt; &gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; &gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; &gt; @@ -180,6 +180,7 @@ struct VirtIONet {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_conf net_conf;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NICConf nic_conf;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceState *qdev;<br>
&gt; &gt; +=C2=A0 =C2=A0 Error *migration_blocker;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int multiqueue;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t max_queues;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t curr_queues;<br>
<br>
</blockquote></div>

--000000000000b845c205a07d8d53--

