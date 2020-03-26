Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276C3C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB5520409
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="oGNMKNHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB5520409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHRjT-0007PM-2Y
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 08:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jHRin-0006wS-1n
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jHRil-0003QW-LS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:34:52 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:35989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jHRil-0003QG-Bl
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:34:51 -0400
Received: by mail-yb1-xb44.google.com with SMTP id i4so3133275ybl.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MKuU34msXkQYhHVXqRbsAI2o1jxhxXNMBLDeGnNMG/0=;
 b=oGNMKNHbhS9OzsFSOokYPh60/BS+sgYZzfPOEnfKTj0Sd3npMKeeiemv3zhndq2xEp
 EJbbNju9Cbf67AChCswOIXSxj0i2914xpUPf5yrrXT/+4FXp69mxmGj47Pe8tio+L6SV
 on4lzNl+V0O4zGTSJxJKwKq6MGT8fbnv+59BLP+pNwPX/nJcd84sd03gOY+GqU5Qj4eC
 ioA+cdXLs4Jt8/Y983FP8O8Tm4Ydu3RydY0jskMnSL+OZB8kXebUHEEq+LBUrmzdULEp
 prbgOgOn5cSksA7THXPDyACCbX4MG2kDevoHREpfvSgPi5YSGmD3+9dsnp8Ibj5PPmDT
 eAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MKuU34msXkQYhHVXqRbsAI2o1jxhxXNMBLDeGnNMG/0=;
 b=ayuhfB+cz/vRrGdxl1bYLCEqXSddEruxgxE78Rgv+bb55K2L1rb6hXSlRo6v6hwN75
 oSk29Nb7tNgQv/T5+aczwDE2UZlrLsXbTXH29LQ23vtT9tQqrqlZ9qhlQP2reduNYxxj
 OKG8CTVFkcaTG1F/yj8CA2Nn2fcMh2FzkvwI5TSZehbug2g9aLIlJBuY2nFvl1/yjiN0
 tkvbQKVrt0tB0x8MZz9Fgi8rGWfvBYc4dtYhq+onhsd1YwM2D6H+IYrmv7eZvr3HuaQA
 683+UeY1+yVWCG5HWIqb9d4slnvhUcRvHql8lDgTj6W4lJgYd+jdR7mI+kjAWHIUtlp2
 xOPA==
X-Gm-Message-State: ANhLgQ3mttO+vXtyNI1FKJ6IRGJCqNke8fsRhY+kfar9U2sax7VnUQzi
 cAStc8pTFyICp2+BDnl/zRjepH/p7j6cQa3G2OI58tJbcZ0=
X-Google-Smtp-Source: ADFU+vus2+9FlQhdljT6kFV/Vpc+MpcvjXIo5gHI5GpkhujTD0ima3EajGtEap0XmKF5w/QHYgCicXtoykjCdGvs9vI=
X-Received: by 2002:a25:b8c9:: with SMTP id g9mr13743187ybm.265.1585226090198; 
 Thu, 26 Mar 2020 05:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200320115751.19446-1-yuri.benditovich@daynix.com>
 <20200320115751.19446-8-yuri.benditovich@daynix.com>
In-Reply-To: <20200320115751.19446-8-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 26 Mar 2020 14:34:39 +0200
Message-ID: <CAOEp5OcZXEXx0gXZTUOvEbH8dteu5S9fzCFJiTGVZkJGyGrv0A@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] virtio-net: add migration support for RSS and hash
 report
To: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, quintela@redhat.com, dgilbert@redhat.com
Content-Type: multipart/alternative; boundary="000000000000fecbce05a1c135bf"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fecbce05a1c135bf
Content-Type: text/plain; charset="UTF-8"

ping

On Fri, Mar 20, 2020 at 1:58 PM Yuri Benditovich <
yuri.benditovich@daynix.com> wrote:

> Save and restore RSS/hash report configuration.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a0614ad4e6..7de7587abd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void
> *opaque, int version_id)
>          }
>      }
>
> +    if (n->rss_data.enabled) {
> +        trace_virtio_net_rss_enable(n->rss_data.hash_types,
> +                                    n->rss_data.indirections_len,
> +                                    sizeof(n->rss_data.key));
> +    } else {
> +        trace_virtio_net_rss_disable();
> +    }
>      return 0;
>  }
>
> @@ -3019,6 +3026,32 @@ static const VMStateDescription
> vmstate_virtio_net_has_vnet = {
>      },
>  };
>
> +static bool virtio_net_rss_needed(void *opaque)
> +{
> +    return VIRTIO_NET(opaque)->rss_data.enabled;
> +}
> +
> +static const VMStateDescription vmstate_virtio_net_rss = {
> +    .name      = "virtio-net-device/rss",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = virtio_net_rss_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(rss_data.enabled, VirtIONet),
> +        VMSTATE_BOOL(rss_data.redirect, VirtIONet),
> +        VMSTATE_BOOL(rss_data.populate_hash, VirtIONet),
> +        VMSTATE_UINT32(rss_data.hash_types, VirtIONet),
> +        VMSTATE_UINT16(rss_data.indirections_len, VirtIONet),
> +        VMSTATE_UINT16(rss_data.default_queue, VirtIONet),
> +        VMSTATE_UINT8_ARRAY(rss_data.key, VirtIONet,
> +                            VIRTIO_NET_RSS_MAX_KEY_SIZE),
> +        VMSTATE_VARRAY_UINT16_ALLOC(rss_data.indirections_table,
> VirtIONet,
> +                                    rss_data.indirections_len, 0,
> +                                    vmstate_info_uint16, uint16_t),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_virtio_net_device = {
>      .name = "virtio-net-device",
>      .version_id = VIRTIO_NET_VM_VERSION,
> @@ -3069,6 +3102,10 @@ static const VMStateDescription
> vmstate_virtio_net_device = {
>                              has_ctrl_guest_offloads),
>          VMSTATE_END_OF_LIST()
>     },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_virtio_net_rss,
> +        NULL
> +    }
>  };
>
>  static NetClientInfo net_virtio_info = {
> --
> 2.17.1
>
>

--000000000000fecbce05a1c135bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Mar 20, 2020 at 1:58 PM Yuri Benditovich &lt;<=
a href=3D"mailto:yuri.benditovich@daynix.com">yuri.benditovich@daynix.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sa=
ve and restore RSS/hash report configuration.<br>
<br>
Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@dayn=
ix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
---<br>
=C2=A0hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 37 insertions(+)<br>
<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index a0614ad4e6..7de7587abd 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void *opaque,=
 int version_id)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (n-&gt;rss_data.enabled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_net_rss_enable(n-&gt;rss_data.has=
h_types,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.indirec=
tions_len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(n-&gt;rss_data.=
key));<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_net_rss_disable();<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
@@ -3019,6 +3026,32 @@ static const VMStateDescription vmstate_virtio_net_h=
as_vnet =3D {<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0};<br>
<br>
+static bool virtio_net_rss_needed(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 return VIRTIO_NET(opaque)-&gt;rss_data.enabled;<br>
+}<br>
+<br>
+static const VMStateDescription vmstate_virtio_net_rss =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =3D &quot;virtio-net-device/rss&qu=
ot;,<br>
+=C2=A0 =C2=A0 .version_id =3D 1,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
+=C2=A0 =C2=A0 .needed =3D virtio_net_rss_needed,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(rss_data.enabled, VirtIONet),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(rss_data.redirect, VirtIONet),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(rss_data.populate_hash, VirtIONet=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rss_data.hash_types, VirtIONet)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(rss_data.indirections_len, Virt=
IONet),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(rss_data.default_queue, VirtION=
et),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(rss_data.key, VirtIONet,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_RSS_MAX_KEY_SIZE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_VARRAY_UINT16_ALLOC(rss_data.indirecti=
ons_table, VirtIONet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rss_data.indirections_=
len, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_info_uint16, u=
int16_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 },<br>
+};<br>
+<br>
=C2=A0static const VMStateDescription vmstate_virtio_net_device =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D &quot;virtio-net-device&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.version_id =3D VIRTIO_NET_VM_VERSION,<br>
@@ -3069,6 +3102,10 @@ static const VMStateDescription vmstate_virtio_net_d=
evice =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has_ctrl_guest_offloads),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 .subsections =3D (const VMStateDescription * []) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vmstate_virtio_net_rss,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0};<br>
<br>
=C2=A0static NetClientInfo net_virtio_info =3D {<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--000000000000fecbce05a1c135bf--

