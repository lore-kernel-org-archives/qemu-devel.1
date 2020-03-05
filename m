Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC4FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9921208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnHE/Kdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9921208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mdc-0007bm-0Z
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1j9mbx-00065C-VW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1j9mbs-0005fU-UT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:09 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1j9mbs-0005ez-Nh; Thu, 05 Mar 2020 04:16:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id g134so5318364wme.3;
 Thu, 05 Mar 2020 01:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=G8ihgHY7meQ+jB4ChwIjZG2w2SpTxTt2WeZKb7R7xqw=;
 b=QnHE/Kdx+75v7cwZA0Ik+GxKmolbkt3/WgGoZH801G+g6JANKF1GEXtwzr3rZ2NhXH
 APticA0LOYUUvGaW2T6Gw8ytHjLDT+0ZZUPGtvP6HiQ9Dxo9kp88Lt83dt/n6HebPi6a
 yHyD58BfIU6bfMpDPKxDn9zfJ8OFKLkWX0F3Ovzhpno+XmV59m1y6MBPgppmHzERFvGu
 Ikmucuuzm5iDa/ckPkwRhe8wjkto/Lm7yvWsjhnClfxF8Ny/WCn0zYDxZEmFuRG3UdOt
 dgVd1IlVBtThxhZ8qxJFTkqqCzeErX3q8ROBBKh5flMWa2ADtsmRxxDNq8Jd2f9FbjA0
 Bzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=G8ihgHY7meQ+jB4ChwIjZG2w2SpTxTt2WeZKb7R7xqw=;
 b=K4HQVMsYAwQbOcMHnWe6jokL73IBwGPtcPJ8jNnGjm9T4k9EACRmIbyjz9y4J8D4+T
 tSViHyR28fcmrcbBG4d+Kr+ucVsftbZBOLTUO8Ld54BC2gFEGBIOZ71SOZysaDupXsry
 LkhNDv8hsArGjG91fknn+wdCbgrEClUffsdZhBUEkHqra4sKqtPgoocNx5UtB7LP2Fty
 IyGuWWWgpezkQsGsIVGXgFjwLsE7A8MTUWKNSBLor/cAqYXkLlOrUG7DFi8rRaBGC3Pv
 kjCVxbvKHNfqLeGOv5rlBa7ZEZu07EbsbFNk7CFBg2xTvos+iVqMDMgDexBwufqnJ8oZ
 duHg==
X-Gm-Message-State: ANhLgQ3XdMhY4IVI+uC/5hdA1L2VYpS1NRWXq3GCY+Vsc2YZpvNPXluE
 tRyZKRFkvH6PTbmcauFfREzSHXUZF0vb+g==
X-Google-Smtp-Source: ADFU+vt1iSFu6mpvS70MW5nep2wb9HEBpUoeSKdQ2CPuoVAIw4435ZrVTt9dRYMs1Ex5R+Qf8z6Olg==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr8139755wmg.169.1583399762832; 
 Thu, 05 Mar 2020 01:16:02 -0800 (PST)
Received: from [10.0.1.16] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id a7sm7897520wmj.12.2020.03.05.01.16.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 01:16:02 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 2/3] hw/net/e1000: Move macreg[] arrays to .rodata to save
 1MiB of .data
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20200305010446.17029-3-philmd@redhat.com>
Date: Thu, 5 Mar 2020 11:16:00 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <7957C7FB-0972-4FFD-8803-28F47EDEA07E@gmail.com>
References: <20200305010446.17029-1-philmd@redhat.com>
 <20200305010446.17029-3-philmd@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On 5 Mar 2020, at 3:04, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Each array consumes 256KiB of .data. As we do not reassign entries,
> we can move it to the .rodata section, and save a total of 1MiB of
> .data (size reported on x86_64 host).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>


> ---
> hw/net/e1000.c       | 4 ++--
> hw/net/e1000e_core.c | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 972d9b5083..9233248c9a 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1151,7 +1151,7 @@ set_ims(E1000State *s, int index, uint32_t val)
>=20
> #define getreg(x)    [x] =3D mac_readreg
> typedef uint32_t (*readops)(E1000State *, int);
> -static readops macreg_readops[] =3D {
> +static const readops macreg_readops[] =3D {
>     getreg(PBA),      getreg(RCTL),     getreg(TDH),      =
getreg(TXDCTL),
>     getreg(WUFC),     getreg(TDT),      getreg(CTRL),     =
getreg(LEDCTL),
>     getreg(MANC),     getreg(MDIC),     getreg(SWSM),     =
getreg(STATUS),
> @@ -1207,7 +1207,7 @@ enum { NREADOPS =3D ARRAY_SIZE(macreg_readops) =
};
>=20
> #define putreg(x)    [x] =3D mac_writereg
> typedef void (*writeops)(E1000State *, int, uint32_t);
> -static writeops macreg_writeops[] =3D {
> +static const writeops macreg_writeops[] =3D {
>     putreg(PBA),      putreg(EERD),     putreg(SWSM),     =
putreg(WUFC),
>     putreg(TDBAL),    putreg(TDBAH),    putreg(TXDCTL),   =
putreg(RDBAH),
>     putreg(RDBAL),    putreg(LEDCTL),   putreg(VET),      =
putreg(FCRUC),
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 38bdb90114..df957e0c1a 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2856,7 +2856,7 @@ e1000e_set_gcr(E1000ECore *core, int index, =
uint32_t val)
>=20
> #define e1000e_getreg(x)    [x] =3D e1000e_mac_readreg
> typedef uint32_t (*readops)(E1000ECore *, int);
> -static readops e1000e_macreg_readops[] =3D {
> +static const readops e1000e_macreg_readops[] =3D {
>     e1000e_getreg(PBA),
>     e1000e_getreg(WUFC),
>     e1000e_getreg(MANC),
> @@ -3063,7 +3063,7 @@ enum { E1000E_NREADOPS =3D =
ARRAY_SIZE(e1000e_macreg_readops) };
>=20
> #define e1000e_putreg(x)    [x] =3D e1000e_mac_writereg
> typedef void (*writeops)(E1000ECore *, int, uint32_t);
> -static writeops e1000e_macreg_writeops[] =3D {
> +static const writeops e1000e_macreg_writeops[] =3D {
>     e1000e_putreg(PBA),
>     e1000e_putreg(SWSM),
>     e1000e_putreg(WUFC),
> --=20
> 2.21.1
>=20


