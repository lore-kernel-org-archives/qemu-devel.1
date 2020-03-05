Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18EA208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+deQQBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18EA208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mem-0000iN-5Z
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1j9mcP-0006ez-1D
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1j9mcN-0005uV-VN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:36 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1j9mcN-0005ts-PD; Thu, 05 Mar 2020 04:16:35 -0500
Received: by mail-wr1-x442.google.com with SMTP id v2so6014686wrp.12;
 Thu, 05 Mar 2020 01:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Sa5xELSz1LdXwv+NNsxnr763IH/tmmTTgRXtX0dAO3s=;
 b=l+deQQBa35UWr9RbNYbqxl8hApwU96ErvCRqm3ZVDje2MrVTEFMWR+rJ/JGtc/hoSX
 iVjFtY6ZCXY2ZhvaBdnaQjuDUrCgGFcBfAWzS9pXl1bcf1Dq0mqG/aclp+pLL9qqUqob
 iSBoBpmmpdOHqLZTuGr9OMrilE6mnD4CRqrPewSLRRxOa6fz1XrQj4ZKS3uIRQMTgdyB
 2XODplcp0GteqP2HvGS0iVVxxnhoWoHWICrpD2BUWmymdujbI+09wJPOjUtN9ayCmTwA
 JBY755XMG7H3315fO3J8ahjEbEiia++L0KK7QRhoTdw19CJbu+qROCsu7KBhwyMm2JVL
 LcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Sa5xELSz1LdXwv+NNsxnr763IH/tmmTTgRXtX0dAO3s=;
 b=aRom05ty71Ff2qDch7Y7Ifsc52D9EHLxfX0Avt9KlK5jl+JnMEVwcdaBcMwprSnfP/
 yVFnMcTotty4z4Y2AnkrleEQ1VB+h6m95DlcDczmG7Sw4Hak+o9T1mpkqYuWiiLSfdJX
 JiUe+x6AsmKOiGhUVUMuhXrAdIPupa9EUQT15PCIOBRAj2hgUr8i8kzjmRCPJBspZ9ih
 V8FBlnqv6Xa/F8pCKlXLxuLpJ+2IfcCcjCQKU2wWNuMMVhHkuAuUzkv0iyj0Qkt1RRh7
 Q0FQKsaTNq5fQpW8pR1WcbRPThP0p/VdHeqli4E5ZMWyS122PrlTwCabaHUHR0p0+7S/
 9FIg==
X-Gm-Message-State: ANhLgQ27c2FIvRpYfllOslqUUyGPfYGHGyH+gxXnHCPiamm/rwtKm23w
 1BDna8O2iHumW9N4EmFk0XI=
X-Google-Smtp-Source: ADFU+vvxrbddaqdxO3PJX4PU7SrWcKndqj2fXT6O2+krAcrBwjr+rgVposWk0l9KQDVf5tPOYHDxMw==
X-Received: by 2002:adf:a512:: with SMTP id i18mr9155203wrb.61.1583399794739; 
 Thu, 05 Mar 2020 01:16:34 -0800 (PST)
Received: from [10.0.1.16] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id a7sm7897520wmj.12.2020.03.05.01.16.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 01:16:34 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 1/3] hw/net/e1000: Add readops/writeops typedefs
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20200305010446.17029-2-philmd@redhat.com>
Date: Thu, 5 Mar 2020 11:16:33 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <E35EF54E-E5AF-40F5-B91F-941810A5F219@gmail.com>
References: <20200305010446.17029-1-philmd@redhat.com>
 <20200305010446.17029-2-philmd@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
> Express the macreg[] arrays using typedefs.
> No logical changes introduced here.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>


> ---
> hw/net/e1000.c       | 6 ++++--
> hw/net/e1000e_core.c | 6 ++++--
> 2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 0b833d5a15..972d9b5083 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1150,7 +1150,8 @@ set_ims(E1000State *s, int index, uint32_t val)
> }
>=20
> #define getreg(x)    [x] =3D mac_readreg
> -static uint32_t (*macreg_readops[])(E1000State *, int) =3D {
> +typedef uint32_t (*readops)(E1000State *, int);
> +static readops macreg_readops[] =3D {
>     getreg(PBA),      getreg(RCTL),     getreg(TDH),      =
getreg(TXDCTL),
>     getreg(WUFC),     getreg(TDT),      getreg(CTRL),     =
getreg(LEDCTL),
>     getreg(MANC),     getreg(MDIC),     getreg(SWSM),     =
getreg(STATUS),
> @@ -1205,7 +1206,8 @@ static uint32_t (*macreg_readops[])(E1000State =
*, int) =3D {
> enum { NREADOPS =3D ARRAY_SIZE(macreg_readops) };
>=20
> #define putreg(x)    [x] =3D mac_writereg
> -static void (*macreg_writeops[])(E1000State *, int, uint32_t) =3D {
> +typedef void (*writeops)(E1000State *, int, uint32_t);
> +static writeops macreg_writeops[] =3D {
>     putreg(PBA),      putreg(EERD),     putreg(SWSM),     =
putreg(WUFC),
>     putreg(TDBAL),    putreg(TDBAH),    putreg(TXDCTL),   =
putreg(RDBAH),
>     putreg(RDBAL),    putreg(LEDCTL),   putreg(VET),      =
putreg(FCRUC),
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 94ea34dca5..38bdb90114 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2855,7 +2855,8 @@ e1000e_set_gcr(E1000ECore *core, int index, =
uint32_t val)
> }
>=20
> #define e1000e_getreg(x)    [x] =3D e1000e_mac_readreg
> -static uint32_t (*e1000e_macreg_readops[])(E1000ECore *, int) =3D {
> +typedef uint32_t (*readops)(E1000ECore *, int);
> +static readops e1000e_macreg_readops[] =3D {
>     e1000e_getreg(PBA),
>     e1000e_getreg(WUFC),
>     e1000e_getreg(MANC),
> @@ -3061,7 +3062,8 @@ static uint32_t =
(*e1000e_macreg_readops[])(E1000ECore *, int) =3D {
> enum { E1000E_NREADOPS =3D ARRAY_SIZE(e1000e_macreg_readops) };
>=20
> #define e1000e_putreg(x)    [x] =3D e1000e_mac_writereg
> -static void (*e1000e_macreg_writeops[])(E1000ECore *, int, uint32_t) =
=3D {
> +typedef void (*writeops)(E1000ECore *, int, uint32_t);
> +static writeops e1000e_macreg_writeops[] =3D {
>     e1000e_putreg(PBA),
>     e1000e_putreg(SWSM),
>     e1000e_putreg(WUFC),
> --=20
> 2.21.1
>=20


