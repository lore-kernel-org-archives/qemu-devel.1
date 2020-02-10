Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779AAC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429FA2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFEC896m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429FA2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1875-0001Y7-Fg
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j186L-00012V-5i
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j186J-0002Vu-V5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:23:44 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j186J-0002VH-NI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:23:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so7448164wrr.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 04:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hxe2VEgQvxw4/2MTCpFTHwTYeglrxxW8o/dFzqMxF94=;
 b=UFEC896meyj8bVVtuLU3Rrmoxzq1V22W9JgwroK3myPRw+j4YkdfEltpuAhzDlUgLw
 XtMgvPL7K80vYkfbZbvVpQ3G8bswW5iwGVl9Nr1kLX8xXt9NlhDOB6YfWVWeG80E+e5Z
 dqGhaPLKQ7qKUJTQpmvaGqGb3ZFI6p++K15S60QrInsuvBO3hG12M/8xq+izl4ysHTHK
 Iadb6tBG9dG2iPVahwP96CiEWymc56sMRz79958AYXlOQeTl3gCJtj10RtZGrwwGcGxp
 GM1IImoUFCX+17MITOhsooZGFshHwfPf0g2rySi2YNY3rqScvCBDlXrhmGk1Xrm/FXiA
 VWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hxe2VEgQvxw4/2MTCpFTHwTYeglrxxW8o/dFzqMxF94=;
 b=ZdJ2mOVJ0/Ph3INx3OJdfQGICIUsNwiIsxhXtAy8la/12RKL65mP6PqCmQ1Bxz9hCG
 WR2VLTdO/JXimU4bZeeKivrpMjmSIc0J/HSylw9s3YiKAhe39UU2aUxMxH3qZ1h2qFoj
 0mS8YU5Ine8wqSkiQFDx/iCE0vYoFiN4NlZrxwoK1K3wLaeVW1YN4VthGMK/Wj99/LkS
 V8tiw7BeksHClF/EciID9+dbmiLAROscYLGT795FONShyHbonZORWjzd6f/CLkrrWS96
 KGz0slPckHruFkc/Zu4IqOQvz3wi/oceOt3/SmMeDwIbVTPXV/p5afziGvXo3WCD0mmz
 wZjw==
X-Gm-Message-State: APjAAAWiTq1d2WBg6rv4IveZk95Mc4KMpSXVPOxRgERu6DdbZHSi+VOG
 wmeldVW//j/wWVWy8pA63emmgg==
X-Google-Smtp-Source: APXvYqxMvohN0rFy2T5AIMvSz6zYf4xSVV5suecehB0ERfjM3bNd8uEjcRMahKjdbrzFx3XDGEnOTg==
X-Received: by 2002:a5d:674d:: with SMTP id l13mr1733547wrw.11.1581337422534; 
 Mon, 10 Feb 2020 04:23:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g128sm342199wme.47.2020.02.10.04.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 04:23:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7CFB51FF87;
 Mon, 10 Feb 2020 12:23:40 +0000 (GMT)
References: <20200210120146.17631-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.8; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm: Implement ARMv8.1-VMID16 extension
In-reply-to: <20200210120146.17631-1-peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 12:23:40 +0000
Message-ID: <875zge3a2b.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The ARMv8.1-VMID16 extension extends the VMID from 8 bits to 16 bits:
>
>  * the ID_AA64MMFR1_EL1.VMIDBits field specifies whether the VMID is
>    8 or 16 bits
>  * the VMID field in VTTBR_EL2 is extended to 16 bits
>  * VTCR_EL2.VS lets the guest specify whether to use the full 16 bits,
>    or use the backwards-compatible 8 bits
>
> For QEMU implementing this is trivial:
>  * we do not track VMIDs in TLB entries, so we never use the VMID
> field

Not currently but does the VMID allow you to have per-guest page table
caching? Last time I chatted to rth about potential performance wins we
discussed how easy it would be to support this in the softmmu now we
have indirect TLB lookups anyway. Given how much time is currently spent
expensively re-populating tables we could keep the last couple of id
tagged tables around for faster switching between sets of tables.

>  * we treat any write to VTTBR_EL2, not just a change to the VMID field
>    bits, as a "possible VMID change" that causes us to throw away TLB
>    entries, so that code doesn't need changing
>  * we allow the guest to read/write the VTCR_EL2.VS bit already
>
> So all that's missing is the ID register part: report that we support
> VMID16 in our 'max' CPU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not something anybody's been asking for, but worthwhile as
> a step towards finishing off support for all the v8.1 extensions.
>
>  target/arm/cpu64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 2d97bf45e1e..bf2cf278c03 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -672,6 +672,7 @@ static void aarch64_max_initfn(Object *obj)
>          t =3D cpu->isar.id_aa64mmfr1;
>          t =3D FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
>          t =3D FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
> +        t =3D FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* VMID16 */
>          cpu->isar.id_aa64mmfr1 =3D t;
>=20=20
>          /* Replicate the same data to the 32-bit id registers.  */

I guess we can easily add the isar_feature_aa64_ functions when we need
them.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

