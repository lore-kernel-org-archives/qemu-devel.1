Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA47DC2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1191206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZArsN/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1191206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWcW-0005ux-Se
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLWFW-0006ne-OV
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLWFV-0003Qs-Iz
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:13:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLWFV-0003Pv-4j
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:13:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id k1so622266wrm.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gpAygWzDUXiL8EOJoOxXksGFFQ5Ela25FmX2gC3U99o=;
 b=zZArsN/3ctNtfWWOxUnD2du1SpCxlSaAfynWdyLQUy1VoxWNmgL35UAj0cOh12SobT
 tG3tguYlIjdNIz+xyOTRqiMY8btzYPTsaEDOkyFRJoxl3NsHXdxEBOox2A7GkkJGAvVy
 AEzAwQYtFZ4UVNAXEDxfcvHywzGePyFwAa0UtsuSIsGWfWW9hwdi3fNmt3+gXePWXPlW
 Y1BpE+CzGHBjZe3zO2rD6tnm1DYahi8CSKNVQIPPATVNhbbbyFdiKpHWbS7ZOPgZ53yV
 qA1dY4mxScD0f0Md+6YxKqIUYSb1LW4/V5ZyNYbyeNj00NxQ76ZL0+FXnPXqhLW34xeL
 Z92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gpAygWzDUXiL8EOJoOxXksGFFQ5Ela25FmX2gC3U99o=;
 b=BN73xaUwWKf4TeIB/HbUnjszAHK51eh8bESq3NKWEabLT7d/SZCQsoNvGogkz1ebN3
 Gc7qmOHHB86Vol7X94FxzdKUmLv3e5viIqdCO0Xjecy4f2UOWhVlt6Tvx8G2SqgzQEMA
 Z1e8/USDJXLNodp80XY/gXRLVAxVkgkbpdIWL7uvI2PgJVDOOl35SL27qbyrP31SOPkP
 bIlmTnb/7IA2CMZX/GXYLf0j+DsPQYyKFTjDutF4UqtKh3SqJ4vDPeO88x/8iHB8IFpJ
 qaeqmv3b/HTMZl0PYKamMG0b+z1M0kdiMmMCipv2EV0IHAEcEIHvrafPM4QYlJjIKtox
 CvTA==
X-Gm-Message-State: AGi0PuasA2OiEkSLXgtRVbtjnbG87GuK5Gk88Kra6qIF5sIH+hPOlHp8
 t4uamcexYdnIs5fhb4O0TEQIWg==
X-Google-Smtp-Source: APiQypJ2L1a7pje2jJmgC8EavlztQg/iAv9uIq9dNNGgcJmRfChy1zfZufE0BJI3OsVtqzHiTOV6yQ==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr468809wrk.135.1586196807865; 
 Mon, 06 Apr 2020 11:13:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q11sm462231wme.0.2020.04.06.11.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 11:13:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 106651FF7E;
 Mon,  6 Apr 2020 19:13:26 +0100 (BST)
References: <20200406174803.8192-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-5.0] tcg/i386: Fix %r12 guest_base initialization
In-reply-to: <20200406174803.8192-1-richard.henderson@linaro.org>
Date: Mon, 06 Apr 2020 19:13:26 +0100
Message-ID: <87tv1wa3eh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> When %gs cannot be used, we use register offset addressing.
> This path is almost never used, so it was clearly not tested.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/i386/tcg-target.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 7f61eeedd0..ec083bddcf 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -3737,7 +3737,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>          } else {
>              /* Choose R12 because, as a base, it requires a SIB byte. */
>              x86_guest_base_index =3D TCG_REG_R12;
> -            tcg_out_mov(s, TCG_TYPE_PTR, x86_guest_base_index, guest_bas=
e);
> +            tcg_out_movi(s, TCG_TYPE_PTR, x86_guest_base_index, guest_ba=
se);
>              tcg_regset_set_reg(s->reserved_regs, x86_guest_base_index);
>          }
>      }


--=20
Alex Benn=C3=A9e

