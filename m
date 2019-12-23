Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FAEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11DD206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REeQndf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11DD206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJ38-0005Hl-2z
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ijJ2V-0004qX-2w
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ijJ2T-0008TV-Tv
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:26:06 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ijJ2T-0008PE-N1
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:26:05 -0500
Received: by mail-ot1-x344.google.com with SMTP id r27so21139955otc.8
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 00:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=MRmUQvhP1Pnnmc+7KZjjGUkKW3/QynPJbZv0u9XwEZY=;
 b=REeQndf0bWxKk9pTETwwvAV0aNp7lTl4Ly0O+N850bYxGID5ZdI4dMfWWGhyipt0lv
 IOStOVtc1rhhrOxLGpDRHpugDNX5oyCKaID+PXIQ0YdKDMmNKklEkI7bX8sGQ9UcL1+K
 iMCZ3rCk2gjEhtzWMeaAfDZ+54eVjm3G7kNhg5AZ+NYfgbegEcB8CDOqmDGieQaDS0Hp
 DsPbuk/jWrE1CDt6iluyYJNJITcU/l9XOKSFf9FbBOLit9RpLQMtnuWImtcefHKRzqYs
 Ai/SHghDWPyFL8qJ3x8fIK3MydwkXpGl2erhBgnpFYD/K3uKCn2r0IEIQHwyKilMaXWc
 +gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=MRmUQvhP1Pnnmc+7KZjjGUkKW3/QynPJbZv0u9XwEZY=;
 b=fEk38tcGF9gr4QwMdcX966ce6VERa9vMYDoL9TUshnVnHi60gXzN/JmhfUSoY1baW9
 Iu5NwfbK7WjF6fFbYgL+CZNtCrJi/8oqkdeklBLgB+wMAQAVEfMVb7+gDxUPZcV4/fpj
 M90xtZOuurjJ1x+bjbsFeECNmbo9/Mlt7flJs9f4/V4INg8vHUZ/jJ9D2SLpWU2R3Hn/
 pJlW3EjY9b3bhOTw8fulUSrzsBWzn587z0DJEAtOJX0xY62HR6k/cAi+f1ESv1hpBqeV
 rQMBQEMOEj4EuOPXCAYijdt5wdlh7E6y/y9yLvYkf00FCtsTlRqVTLHSr/FBau/Exbpg
 4Y0w==
X-Gm-Message-State: APjAAAVWKID64A1guwC6HHiKmCrMDbZLca7ITpSX9F6JOumwXQ55lkWN
 8Ejp+XQ3Yk5QIcAHygMwvxfuQmfb+8lrNemLN/hz6w==
X-Google-Smtp-Source: APXvYqzNkKBiljuDMwMCwF1iWu1sBDz+qrvzL6ERHLjZuQ6bKCcPn8vUmNwrCrKVadXA2GJQNOY2DB8PedqG1pSk4b0=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr29893256otk.64.1577089564491; 
 Mon, 23 Dec 2019 00:26:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 23 Dec 2019 00:26:03 -0800 (PST)
In-Reply-To: <20191222172913.10419-1-hpoussin@reactos.org>
References: <20191222172913.10419-1-hpoussin@reactos.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 23 Dec 2019 09:26:03 +0100
Message-ID: <CAL1e-=jXsLpvWe8RjEPSj7yWYqWv7mT4Db+hjBqy71=7SLbUcg@mail.gmail.com>
Subject: Re: [PATCH] dma/rc4030: correctly reset DMA translation table at reset
To: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: multipart/alternative; boundary="000000000000454438059a5ac7fd"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000454438059a5ac7fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 22, 2019, Herv=C3=A9 Poussineau <hpoussin@reactos.org> =
wrote:

> This fixes a freeze at reboot, introduced in c627e7526a902dd5bb1907dbbd5c=
f9
> 61679dfa68
>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  hw/dma/rc4030.c | 1 +
>  1 file changed, 1 insertion(+)
>
>
Hi, Herve,

Very good that you found the fix, but I would really appreciate if you
provide the details on repro procedure.

One more thing, does this have anything to do eith the Finn's attempt to
start Jazz machine with:

Quote:

I tried to boot NetBSD/arc but failed. I got a blue screen when I typed
"cd:boot" at the "Run A Program" prompt in the ARC menu.

$ ln -s NTPROM.RAW mipsel_bios.bin
$ mips64el-softmmu/qemu-system-mips64el -M magnum -L .
-drive if=3Dscsi,unit=3D2,media=3Dcdrom,format=3Draw,file=3DNetBSD-8.1-arc.=
iso
-global ds1225y.filename=3Dnvram -global ds1225y.size=3D8200
qemu-system-mips64el: g364: invalid read at [0000000000102000]
$

Best regards,
Alekssndar


diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index c4cf8236f4..76302fe431 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -534,6 +534,7 @@ static void rc4030_reset(DeviceState *dev)
>
>      memset(s->dma_regs, 0, sizeof(s->dma_regs));
>
> +    s->dma_tl_base =3D s->dma_tl_limit =3D 0;
>      s->remote_failed_address =3D s->memory_failed_address =3D 0;
>      s->cache_maint =3D 0;
>      s->cache_ptag =3D s->cache_ltag =3D 0;
> --
> 2.19.2
>
>
>

--000000000000454438059a5ac7fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 22, 2019, Herv=C3=A9 Poussineau &lt;<a href=3D"=
mailto:hpoussin@reactos.org">hpoussin@reactos.org</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">This fixes a freeze at reboot, introduced in c627e7=
526a902dd5bb1907dbbd5cf9<wbr>61679dfa68<br>
<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org">hpoussin@reactos.org</a>&gt;<br>
---<br>
=C2=A0hw/dma/rc4030.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br></blockquote><div><br></div><div>Hi, Herve,</div><div><br></div><div>Ve=
ry good that you found the fix, but I would really appreciate if you provid=
e the details on repro procedure.</div><div><br></div><div>One more thing, =
does this have anything to do eith the Finn&#39;s attempt to start Jazz mac=
hine with:</div><div><br></div><div>Quote:</div><div><br></div><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">I tr=
ied to boot NetBSD/arc but failed. I got a blue screen when I typed=C2=A0</=
span><br style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008=
392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.=
1200008392334px">&quot;cd:boot&quot; at the &quot;Run A Program&quot; promp=
t in the ARC menu.</span><br style=3D"color:rgb(34,34,34);font-size:14px;li=
ne-height:22.1200008392334px"><br style=3D"color:rgb(34,34,34);font-size:14=
px;line-height:22.1200008392334px"><span style=3D"color:rgb(34,34,34);font-=
size:14px;line-height:22.1200008392334px">$ ln -s NTPROM.RAW mipsel_bios.bi=
n</span><br style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200=
008392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:=
22.1200008392334px">$ mips64el-softmmu/qemu-system-</span><wbr style=3D"col=
or:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">mips=
64el -M magnum -L .=C2=A0</span><br style=3D"color:rgb(34,34,34);font-size:=
14px;line-height:22.1200008392334px"><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">-drive if=3Dscsi,unit=3D2,media=
=3Dcdrom,</span><wbr style=3D"color:rgb(34,34,34);font-size:14px;line-heigh=
t:22.1200008392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;lin=
e-height:22.1200008392334px">format=3Draw,file=3DNetBSD-8.1-</span><wbr sty=
le=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"><s=
pan style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.120000839233=
4px">arc.iso=C2=A0</span><br style=3D"color:rgb(34,34,34);font-size:14px;li=
ne-height:22.1200008392334px"><span style=3D"color:rgb(34,34,34);font-size:=
14px;line-height:22.1200008392334px">-global ds1225y.filename=3Dnvram -glob=
al ds1225y.size=3D8200</span><br style=3D"color:rgb(34,34,34);font-size:14p=
x;line-height:22.1200008392334px"><span style=3D"color:rgb(34,34,34);font-s=
ize:14px;line-height:22.1200008392334px">qemu-system-mips64el: g364: invali=
d read at [0000000000102000]</span><br style=3D"color:rgb(34,34,34);font-si=
ze:14px;line-height:22.1200008392334px"><span style=3D"color:rgb(34,34,34);=
font-size:14px;line-height:22.1200008392334px">$=C2=A0</span><br style=3D"c=
olor:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"><div>=C2=
=A0<br></div><div>Best regards,</div><div>Alekssndar</div><div><br></div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c<br>
index c4cf8236f4..76302fe431 100644<br>
--- a/hw/dma/rc4030.c<br>
+++ b/hw/dma/rc4030.c<br>
@@ -534,6 +534,7 @@ static void rc4030_reset(DeviceState *dev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0memset(s-&gt;dma_regs, 0, sizeof(s-&gt;dma_regs));<br>
<br>
+=C2=A0 =C2=A0 s-&gt;dma_tl_base =3D s-&gt;dma_tl_limit =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;remote_failed_address =3D s-&gt;memory_failed_add=
ress =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;cache_maint =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;cache_ptag =3D s-&gt;cache_ltag =3D 0;<br>
-- <br>
2.19.2<br>
<br>
<br>
</blockquote>

--000000000000454438059a5ac7fd--

