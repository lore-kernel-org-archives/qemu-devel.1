Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1426C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A9520732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vguzii/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A9520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGGI-0006N8-KN
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFGFU-0005ao-BE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFGFS-000793-TC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:55:36 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jFGFS-00075f-Kx
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:55:34 -0400
Received: by mail-oi1-x242.google.com with SMTP id d63so6147671oig.6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2v1VP1pn6KKeVELtTQGZhYsszk2I5oz59zd85NU98wg=;
 b=Vguzii/O5sgHZEtp/By5FynG5S8vjLsHugwDFsg6VMSCPJnQf0IzUW9c09eRSUfLfi
 si4dWg8dx4kt75PrDhkjBgyDHp43rp0clzosNPztHqQ09u+OtF7l8bCL5leCDtlJt8gH
 QRBo9dgHdx4tsF7+fWOC6UqUgHS3yNQ0qc4SacEmq2bSnaaiKGJANlemHXnu6crTRbqN
 XK/znHYWzr7RU17D2R10Wt9C3h0SXU7G2/xoGYTnREavs6R4Tm2Ud08iDRZar4Nd4/qB
 TqtvOTTauN7Ziqi/KAAHRlj/q8CunCsL2mG4zA/J2gYbsjWwfKd3Qmx8Mu2mHEEnfPXS
 5G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2v1VP1pn6KKeVELtTQGZhYsszk2I5oz59zd85NU98wg=;
 b=uXaZ4/GWg8Y0RY8w3MS235O5W/f6PQpQBuC4kKECHAseZCG2N8v+BNoDRqEGGc8gLJ
 +J/YjenTU4wJdRszGZivrjPRu7z+seo/aNfMEyWGmlAeEvwVkx2xuky6vH/sMpLWXuAw
 09BK0Af1kr3h83ggRLTiJG2UFdVtzqGbKgXiVaYbfDPPtitrgXJo+9Q/q0P7URfIsBKr
 IyQqMWBYnSp4pxSizD/uq/V93Sdu3dovcsMbzqqFWgpiY6lAdeLxDuu8jgjEwInGnKgJ
 iZl1WfI7o4WD7mxuu8iKZhI166lTy4FtN7h9EOMPXaKbacNldYno6dL1d8hcRK/VbGsO
 8sZQ==
X-Gm-Message-State: ANhLgQ3Fc0x1UEsAjq4PfGJcFIxDGltlbjJf/vw5r4zGunVKy4kx4rFZ
 e5Ha/g1rw6pu7YoFCd7bpu5IgL5J+5YIvC9Zc+I=
X-Google-Smtp-Source: ADFU+vveHpzCdf1GYjieQ21T8xSh4zB0vaOy7DMD6SgDP+q8UHsdBeF+/1EthTmsyGo/8ABjC6Wlp/YK+K8m9NoTzR4=
X-Received: by 2002:aca:56c2:: with SMTP id k185mr5761709oib.141.1584705333710; 
 Fri, 20 Mar 2020 04:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-3-stefanha@redhat.com>
In-Reply-To: <20200316160702.478964-3-stefanha@redhat.com>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Fri, 20 Mar 2020 13:55:22 +0200
Message-ID: <CAMPkWoMFD+-zbt1Xb-0M-MQWJ_QonQxUkJWBRoLUdJzfC49VfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/rdma: avoid suspicious strncpy() use
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007d536905a147f6c2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007d536905a147f6c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Mar 2020 at 18:07, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1) with sanitizers enabled
> reports the following error:
>
>   CC      x86_64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
> In file included from /usr/include/string.h:495,
>                  from include/qemu/osdep.h:101,
>                  from hw/rdma/vmw/pvrdma_dev_ring.c:16:
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98pvrdma_ring_init=E2=80=99 at hw/rdma/vmw/pvrdma=
_dev_ring.c:33:5:
> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_st=
rncpy=E2=80=99
> specified bound 32 equals destination size [-Werror=3Dstringop-truncation=
]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos
> (__dest));
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Use pstrcpy() instead of strncpy().  It is guaranteed to NUL-terminate
> strings.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/rdma/vmw/pvrdma_dev_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.=
c
> index d7bc7f5ccc..74b8fa834c 100644
> --- a/hw/rdma/vmw/pvrdma_dev_ring.c
> +++ b/hw/rdma/vmw/pvrdma_dev_ring.c
> @@ -14,6 +14,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "hw/pci/pci.h"
>  #include "cpu.h"
>
> @@ -30,8 +31,7 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name=
,
> PCIDevice *dev,
>      int i;
>      int rc =3D 0;
>
> -    strncpy(ring->name, name, MAX_RING_NAME_SZ);
> -    ring->name[MAX_RING_NAME_SZ - 1] =3D 0;
> +    pstrcpy(ring->name, MAX_RING_NAME_SZ, name);
>      ring->dev =3D dev;
>      ring->ring_state =3D ring_state;
>      ring->max_elems =3D max_elems;
> --
> 2.24.1
>
>
Thanks,

Reviewed-by: Yuval Shaia <yuval.shaia.ml.gmail.com>

--0000000000007d536905a147f6c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 16 Mar 2020 at 18:=
07, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1) with sanitizers enabled<b=
r>
reports the following error:<br>
<br>
=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 x86_64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o<=
br>
In file included from /usr/include/string.h:495,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from include/=
qemu/osdep.h:101,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from hw/rdma/=
vmw/pvrdma_dev_ring.c:16:<br>
In function =E2=80=98strncpy=E2=80=99,<br>
=C2=A0 =C2=A0 inlined from =E2=80=98pvrdma_ring_init=E2=80=99 at hw/rdma/vm=
w/pvrdma_dev_ring.c:33:5:<br>
/usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_strn=
cpy=E2=80=99 specified bound 32 equals destination size [-Werror=3Dstringop=
-truncation]<br>
=C2=A0 106 |=C2=A0 =C2=A0return __builtin___strncpy_chk (__dest, __src, __l=
en, __bos (__dest));<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
Use pstrcpy() instead of strncpy().=C2=A0 It is guaranteed to NUL-terminate=
<br>
strings.<br>
<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank">stefanha@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/rdma/vmw/pvrdma_dev_ring.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c<=
br>
index d7bc7f5ccc..74b8fa834c 100644<br>
--- a/hw/rdma/vmw/pvrdma_dev_ring.c<br>
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c<br>
@@ -14,6 +14,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;cpu.h&quot;<br>
<br>
@@ -30,8 +31,7 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name, =
PCIDevice *dev,<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0int rc =3D 0;<br>
<br>
-=C2=A0 =C2=A0 strncpy(ring-&gt;name, name, MAX_RING_NAME_SZ);<br>
-=C2=A0 =C2=A0 ring-&gt;name[MAX_RING_NAME_SZ - 1] =3D 0;<br>
+=C2=A0 =C2=A0 pstrcpy(ring-&gt;name, MAX_RING_NAME_SZ, name);<br>
=C2=A0 =C2=A0 =C2=A0ring-&gt;dev =3D dev;<br>
=C2=A0 =C2=A0 =C2=A0ring-&gt;ring_state =3D ring_state;<br>
=C2=A0 =C2=A0 =C2=A0ring-&gt;max_elems =3D max_elems;<br>
-- <br>
2.24.1<br>
<br></blockquote><div><br></div><div>Thanks,</div><div><br></div><div>Revie=
wed-by: Yuval Shaia &lt;<a href=3D"http://yuval.shaia.ml.gmail.com">yuval.s=
haia.ml.gmail.com</a>&gt;=C2=A0=C2=A0</div><div>=C2=A0</div></div></div>

--0000000000007d536905a147f6c2--

