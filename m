Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6F9C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8511B24670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt55Mpmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8511B24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFTN-0001HR-6D
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idEk2-0007Ut-I9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idEk0-00081X-Gv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:37:58 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1idEk0-0007xg-6n
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:37:56 -0500
Received: by mail-oi1-x243.google.com with SMTP id c16so6353378oic.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qqHQFGsq3lWFxbbLvuL3KHO6aL2HjEUdApWcm/vQ/u0=;
 b=jt55MpmfVJ9IfJe14p9S3zLQ+AeGc8yiD8xw/85UoiBVGihkV1ZaiL8lJFC13EJIJo
 iTC9LStfvclwgYGIuwvDoLQ/R/flF8p8mueiS9uRYLCM7LbQgjuJHtdLDsIK5Vz1OcRi
 MTeVTc/ClDP7CQq2te3+2MGdIdR2a8ElkxjAfympQXiTQLFKRCmtvV3vwLP9asJPMMQ2
 XuX5vot/srMvCp/0IaQfhGCkBgtEEWuFNJ5dH4i9tOEkCZPK1ZaLWcpWnjBWe/a4SaLs
 5gq5ml5CwbzhOuQ4jmzgvY/N+gNaPPu/Jl8ek5x3cNg6jveVoujYvQQJ24wnDoctMDdw
 6FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qqHQFGsq3lWFxbbLvuL3KHO6aL2HjEUdApWcm/vQ/u0=;
 b=Q5jyG5F2pnOEKAPoW8jTlVOx+0+4GfSB23jrHb0cB3AyPFkyrPH4yXbdMa3aN05T97
 ifQM5y7lgquW3BQ7bjPyD419TQcCNDeCVTmcQDRfK0o5+T5jLXYaAjHbaivp7RY5ivXh
 LqUKAG6SnwlnJ6r5YyTtJBwyhZ7KfsvtNWMehaUo1OnowTd/AcfyFdXMOgEpep3wmz6F
 1ky6psk7yuA0H4jgzaKi/y+ADBQYd9XRoUZJ4U6bdkQEpIC7dCJMAe6eiWf+v3IaDt7P
 Rc78P5KquhUwVcf1Qri4RpJDLwF3/VqAVrkhczBRy+0ppS6H6Wsv29KAI7VD2XeRwtyz
 /PWQ==
X-Gm-Message-State: APjAAAUVYhYxbw28HUawMb66ViWHGgMTB3LUyAnJ89xLM08v2POXvlJE
 JP36FozbUJ6UI3Hj+0KRMHLqxL5103oUO1gcHvMMZQ==
X-Google-Smtp-Source: APXvYqzFY+F/4hqWEB9M07y7aQBPhigA//AA//nGff+xApx6N9Bq2ruXlO9jZQ9atGCl5BCfg96zA3lhvmZQ4rBHzII=
X-Received: by 2002:aca:bd85:: with SMTP id n127mr5519664oif.136.1575619429442; 
 Fri, 06 Dec 2019 00:03:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 6 Dec 2019 00:03:48 -0800 (PST)
In-Reply-To: <1574687098-26689-4-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-4-git-send-email-Filip.Bozuta@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 6 Dec 2019 09:03:48 +0100
Message-ID: <CAL1e-=hm-0L0YBSuu0uzwUn+A+MnYB5x-cUUuJWN6NkjqiMqNw@mail.gmail.com>
Subject: Re: [PATCH 3/5] mips: mipssim: Renovate coding style
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: multipart/alternative; boundary="00000000000064adb60599047c65"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000064adb60599047c65
Content-Type: text/plain; charset="UTF-8"

On Monday, November 25, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote:

> The script checkpatch.pl located in scripts folder was
> used to detect all errors and warrnings in files:
>     hw/mips/mips_mipssim.c
>     hw/net/mipsnet.c
>
> All these mips mipssim machine files were edited and
> all the errors and warrings generated by the checkpatch.pl
> script were corrected and then the script was
> ran again to make sure there are no more errors and warnings.
>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  hw/net/mipsnet.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
> index f7ae1ce..cb3331f 100644
> --- a/hw/net/mipsnet.c
> +++ b/hw/net/mipsnet.c
> @@ -9,19 +9,19 @@
>
>  /* MIPSnet register offsets */
>
> -#define MIPSNET_DEV_ID         0x00
> -#define MIPSNET_BUSY           0x08
> -#define MIPSNET_RX_DATA_COUNT  0x0c
> -#define MIPSNET_TX_DATA_COUNT  0x10
> -#define MIPSNET_INT_CTL                0x14
> -# define MIPSNET_INTCTL_TXDONE         0x00000001
> -# define MIPSNET_INTCTL_RXDONE         0x00000002
> -# define MIPSNET_INTCTL_TESTBIT                0x80000000
> -#define MIPSNET_INTERRUPT_INFO 0x18
> -#define MIPSNET_RX_DATA_BUFFER 0x1c
> -#define MIPSNET_TX_DATA_BUFFER 0x20
> -
> -#define MAX_ETH_FRAME_SIZE     1514
> +#define MIPSNET_DEV_ID          0x00
> +#define MIPSNET_BUSY            0x08
> +#define MIPSNET_RX_DATA_COUNT   0x0c
> +#define MIPSNET_TX_DATA_COUNT   0x10
> +#define MIPSNET_INT_CTL         0x14
> +# define MIPSNET_INTCTL_TXDONE          0x00000001
> +# define MIPSNET_INTCTL_RXDONE          0x00000002
> +# define MIPSNET_INTCTL_TESTBIT         0x80000000
> +#define MIPSNET_INTERRUPT_INFO  0x18
> +#define MIPSNET_RX_DATA_BUFFER  0x1c
> +#define MIPSNET_TX_DATA_BUFFER  0x20
> +
> +#define MAX_ETH_FRAME_SIZE      1514
>
>  #define TYPE_MIPS_NET "mipsnet"
>  #define MIPS_NET(obj) OBJECT_CHECK(MIPSnetState, (obj), TYPE_MIPS_NET)
> @@ -64,8 +64,9 @@ static void mipsnet_update_irq(MIPSnetState *s)
>
>  static int mipsnet_buffer_full(MIPSnetState *s)
>  {
> -    if (s->rx_count >= MAX_ETH_FRAME_SIZE)
> +    if (s->rx_count >= MAX_ETH_FRAME_SIZE) {
>          return 1;
> +    }
>      return 0;
>  }
>
> @@ -73,18 +74,21 @@ static int mipsnet_can_receive(NetClientState *nc)
>  {
>      MIPSnetState *s = qemu_get_nic_opaque(nc);
>
> -    if (s->busy)
> +    if (s->busy) {
>          return 0;
> +    }
>      return !mipsnet_buffer_full(s);
>  }
>
> -static ssize_t mipsnet_receive(NetClientState *nc, const uint8_t *buf,
> size_t size)
> +static ssize_t mipsnet_receive(NetClientState *nc,
> +                               const uint8_t *buf, size_t size)
>  {
>      MIPSnetState *s = qemu_get_nic_opaque(nc);
>
> -    trace_mipsnet_receive(size);
> -    if (!mipsnet_can_receive(nc))
> +    race_mipsnet_receive(size);
> +    if (!mipsnet_can_receive(nc)) {
>          return 0;
> +    }
>
>      if (size >= sizeof(s->rx_buffer)) {
>          return 0;
> @@ -115,10 +119,10 @@ static uint64_t mipsnet_ioport_read(void *opaque,
> hwaddr addr,
>      addr &= 0x3f;
>      switch (addr) {
>      case MIPSNET_DEV_ID:
> -        ret = be32_to_cpu(0x4d495053);         /* MIPS */
> +        ret = be32_to_cpu(0x4d495053);          /* MIPS */
>          break;
>      case MIPSNET_DEV_ID + 4:
> -        ret = be32_to_cpu(0x4e455430);         /* NET0 */
> +        ret = be32_to_cpu(0x4e455430);          /* NET0 */
>          break;
>      case MIPSNET_BUSY:
>          ret = s->busy;
> --
> 2.7.4
>
>
>

--00000000000064adb60599047c65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 25, 2019, Filip Bozuta &lt;<a href=3D"mailto:Fi=
lip.Bozuta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">The script <a href=3D"http://checkpatch.pl" target=3D"_b=
lank">checkpatch.pl</a> located in scripts folder was<br>
used to detect all errors and warrnings in files:<br>
=C2=A0 =C2=A0 hw/mips/mips_mipssim.c<br>
=C2=A0 =C2=A0 hw/net/mipsnet.c<br>
<br>
All these mips mipssim machine files were edited and<br>
all the errors and warrings generated by the <a href=3D"http://checkpatch.p=
l" target=3D"_blank">checkpatch.pl</a><br>
script were corrected and then the script was<br>
ran again to make sure there are no more errors and warnings.<br>
<br>
Signed-off-by: Filip Bozuta &lt;<a href=3D"mailto:Filip.Bozuta@rt-rk.com">F=
ilip.Bozuta@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0hw/net/mipsnet.c | 44 ++++++++++++++++++++++++------<wbr>------------=
--<br>
=C2=A01 file changed, 24 insertions(+), 20 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c<br>
index f7ae1ce..cb3331f 100644<br>
--- a/hw/net/mipsnet.c<br>
+++ b/hw/net/mipsnet.c<br>
@@ -9,19 +9,19 @@<br>
<br>
=C2=A0/* MIPSnet register offsets */<br>
<br>
-#define MIPSNET_DEV_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00<br>
-#define MIPSNET_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>
-#define MIPSNET_RX_DATA_COUNT=C2=A0 0x0c<br>
-#define MIPSNET_TX_DATA_COUNT=C2=A0 0x10<br>
-#define MIPSNET_INT_CTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x14<br>
-# define MIPSNET_INTCTL_TXDONE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000001=
<br>
-# define MIPSNET_INTCTL_RXDONE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000002=
<br>
-# define MIPSNET_INTCTL_TESTBIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x80000000<br>
-#define MIPSNET_INTERRUPT_INFO 0x18<br>
-#define MIPSNET_RX_DATA_BUFFER 0x1c<br>
-#define MIPSNET_TX_DATA_BUFFER 0x20<br>
-<br>
-#define MAX_ETH_FRAME_SIZE=C2=A0 =C2=A0 =C2=A01514<br>
+#define MIPSNET_DEV_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<br>
+#define MIPSNET_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08<br>
+#define MIPSNET_RX_DATA_COUNT=C2=A0 =C2=A00x0c<br>
+#define MIPSNET_TX_DATA_COUNT=C2=A0 =C2=A00x10<br>
+#define MIPSNET_INT_CTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x14<br>
+# define MIPSNET_INTCTL_TXDONE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0000000=
1<br>
+# define MIPSNET_INTCTL_RXDONE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0000000=
2<br>
+# define MIPSNET_INTCTL_TESTBIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x8000000=
0<br>
+#define MIPSNET_INTERRUPT_INFO=C2=A0 0x18<br>
+#define MIPSNET_RX_DATA_BUFFER=C2=A0 0x1c<br>
+#define MIPSNET_TX_DATA_BUFFER=C2=A0 0x20<br>
+<br>
+#define MAX_ETH_FRAME_SIZE=C2=A0 =C2=A0 =C2=A0 1514<br>
<br>
=C2=A0#define TYPE_MIPS_NET &quot;mipsnet&quot;<br>
=C2=A0#define MIPS_NET(obj) OBJECT_CHECK(MIPSnetState, (obj), TYPE_MIPS_NET=
)<br>
@@ -64,8 +64,9 @@ static void mipsnet_update_irq(<wbr>MIPSnetState *s)<br>
<br>
=C2=A0static int mipsnet_buffer_full(<wbr>MIPSnetState *s)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (s-&gt;rx_count &gt;=3D MAX_ETH_FRAME_SIZE)<br>
+=C2=A0 =C2=A0 if (s-&gt;rx_count &gt;=3D MAX_ETH_FRAME_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
@@ -73,18 +74,21 @@ static int mipsnet_can_receive(<wbr>NetClientState *nc)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MIPSnetState *s =3D qemu_get_nic_opaque(nc);<br>
<br>
-=C2=A0 =C2=A0 if (s-&gt;busy)<br>
+=C2=A0 =C2=A0 if (s-&gt;busy) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return !mipsnet_buffer_full(s);<br>
=C2=A0}<br>
<br>
-static ssize_t mipsnet_receive(NetClientState *nc, const uint8_t *buf, siz=
e_t size)<br>
+static ssize_t mipsnet_receive(NetClientState *nc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint8_t *buf, size_t size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MIPSnetState *s =3D qemu_get_nic_opaque(nc);<br>
<br>
-=C2=A0 =C2=A0 trace_mipsnet_receive(size);<br>
-=C2=A0 =C2=A0 if (!mipsnet_can_receive(nc))<br>
+=C2=A0 =C2=A0 race_mipsnet_receive(size);<br>
+=C2=A0 =C2=A0 if (!mipsnet_can_receive(nc)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (size &gt;=3D sizeof(s-&gt;rx_buffer)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
@@ -115,10 +119,10 @@ static uint64_t mipsnet_ioport_read(void *opaque, hwa=
ddr addr,<br>
=C2=A0 =C2=A0 =C2=A0addr &amp;=3D 0x3f;<br>
=C2=A0 =C2=A0 =C2=A0switch (addr) {<br>
=C2=A0 =C2=A0 =C2=A0case MIPSNET_DEV_ID:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D be32_to_cpu(0x4d495053);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* MIPS */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D be32_to_cpu(0x4d495053);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* MIPS */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MIPSNET_DEV_ID + 4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D be32_to_cpu(0x4e455430);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* NET0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D be32_to_cpu(0x4e455430);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* NET0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MIPSNET_BUSY:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D s-&gt;busy;<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--00000000000064adb60599047c65--

