Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1919C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC0A2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj+sz8qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC0A2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpuC-0004Pa-Sv
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1iwptb-0003t0-77
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1iwpta-0004Du-3B
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:08:51 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1iwptZ-0004DV-TP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:08:50 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so378170wma.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=YaMZPWyvYYYyVLkWKGgdL3DN4EC0x930bl0+wSKDxNE=;
 b=Gj+sz8qdRg9+m4SxWIb75Y1+mugF/xENl+1ZqwJmaYF1jjrTBUZObu3WQ1Tr6kr0eE
 /2A6b3dfeAja5+VxSxlX1csL8tFXmCKFKAQuZ/bKdL1p/j4x+6OhdoFNjoEDgSl81PIm
 s+xX0lnMRbX07+qN0bognN8dylJyVfHZO9gNvMlDRX1zx6zu/yhq5W6VjHdCvmYrjDJ8
 SQhLNEJtNRjqaWIPp+Lt1C0BE88SGA5l/FPBNfHPmQHhAHME9wuafsYfLQ8rZNR9denY
 KldruNm3sy/WBSJnhA/Oa/p5B6l8tdKVWNilb5OWgH9JaITZ34zn1g8QnZZslhNFjssE
 W+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=YaMZPWyvYYYyVLkWKGgdL3DN4EC0x930bl0+wSKDxNE=;
 b=VKOaf7FMD2PU3I03BwagTvHEhRPrzyPx5n5pTkNNxhbrf/iTSUsw58NKBHAl888tbW
 78tRaRzZQVbz48u1Kabz3n5IfIMoWlSg699JftNO86cyKdkBGJ/3RtRNFE4PtG1ExsAO
 hisn99ORsQxQi1ZWHqTFwTujUtzs/4fxEq2TL9t/10ElP5w2XgehDwLTj29QEetEWsnp
 EedB2W9eQLAlRc3KOVOIfC/njTM3pM6frEfV2OD6spHJhAMcsgjMMcbJ10bVMhbZQfHe
 eH5n1l9f7YaTCfhEJ187uq+AfF3nkTmKaiKEKXiApO96NpUVKmx2dQmXd0RkFTpBu6An
 RRXQ==
X-Gm-Message-State: APjAAAWIU7GsCcVNdQaj0kqLCal6pjy37KQ29Fvb2arUgTTnEVHiLOc1
 s5j0ygNki6s2a65ZM8ZoJ4U=
X-Google-Smtp-Source: APXvYqx5UyQGEefvidIy5YhsTI+V2gvcSuqDmWYjvGzLd+5ohhLmPrHdoE3+tPwGsiH6QSGNefm3Tw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr12306380wmj.170.1580314128537; 
 Wed, 29 Jan 2020 08:08:48 -0800 (PST)
Received: from [10.0.1.16] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id o4sm3416167wrx.25.2020.01.29.08.08.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Jan 2020 08:08:47 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] e1000e: Avoid hw_error if legacy mode used
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20200127160312.31367-1-yuri.benditovich@daynix.com>
Date: Wed, 29 Jan 2020 18:08:46 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA18299E-DAAB-4CAB-B702-FAF238DEF9CB@gmail.com>
References: <20200127160312.31367-1-yuri.benditovich@daynix.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On 27 Jan 2020, at 18:03, Yuri Benditovich =
<yuri.benditovich@daynix.com> wrote:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1787142
> The emulation issues hw_error if PSRCTL register
> is written, for example, with zero value.
> Such configuration does not present any problem when
> DTYP bits of RCTL register define legacy format of
> transfer descriptors. Current commit discards check
> for BSIZE0 and BSIZE1 when legacy mode used.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

Acked-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>

> ---
> hw/net/e1000e_core.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 5b05c8ea8a..94ea34dca5 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2813,12 +2813,15 @@ e1000e_set_eitr(E1000ECore *core, int index, =
uint32_t val)
> static void
> e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
> {
> -    if ((val & E1000_PSRCTL_BSIZE0_MASK) =3D=3D 0) {
> -        hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
> -    }
> +    if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
> +
> +        if ((val & E1000_PSRCTL_BSIZE0_MASK) =3D=3D 0) {
> +            hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
> +        }
>=20
> -    if ((val & E1000_PSRCTL_BSIZE1_MASK) =3D=3D 0) {
> -        hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
> +        if ((val & E1000_PSRCTL_BSIZE1_MASK) =3D=3D 0) {
> +            hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
> +        }
>     }
>=20
>     core->mac[PSRCTL] =3D val;
> --=20
> 2.17.1
>=20


