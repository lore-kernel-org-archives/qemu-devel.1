Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF6C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57E720767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSP7kavp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57E720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRLFf-0001Nc-0I
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRLF2-0000sW-3l
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRLF1-00089t-DZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:41:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRLF0-000864-SN
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:41:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id t14so3939124wrw.12
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5yzR0d/XcE/IlonCZd7Wm3SojkywcWQXoF/pQzoX3z0=;
 b=vSP7kavpn/2JYQG7fNn30kNdHXgOqHP98+oQEfUdzuYcf9RWfwMby9my4XfTvwz7qa
 OqZ9pqSqePwBu2/2xsTsQhswajdHAEzgNiUPGvCKYjGVc0gCxHtTJuSKOneI7lZzQ+J1
 PLjnpBaptiEit45ZvbqC58xB7Y1jxj+jbehIxB8FW501depYNm4+Tc6hz4bLKZ+xqG7v
 /wreoLaPBDJTezP5ocfzC+7rYX2U/0YwBFhodETwiAh1IwAfIsw1ZrS4Yi0iO7ROY+LW
 3ku9xJvv6m3Cng3cn/kfjex4Vd/wJA7dvaWQevRi+0Cn74+y8jsVvo65+2rPFrFtihhz
 Ktrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5yzR0d/XcE/IlonCZd7Wm3SojkywcWQXoF/pQzoX3z0=;
 b=BKn/m7Rl6rHRtPzaR+C8CuT1VeUU1p3u1+xp+Y75rAekLQcPoUZi96G1XiwAdnoq1k
 BSFCBa65culG3fPB2hvJj/lT0EPqPd50MfEJ6w76Gg4oDd9fDEIZAZWg1sHAC+Gis9IR
 muMlkmDNB2jqGkKH67Tpw73Cb4TMPbMeAAeMNS73PvUZD0u/GWDyRFWugxp9HLH7wrqa
 FhmcDtJyh2wqY8e/imsPs5FF3tMsAUg1SEgm3k7SZlzUOVrZboMNR+ztd85Iy3i5elCM
 R3X4VzHeuD26FbcEh/MsFg3ucYB3ZuxHLrqdRpS8E/nkN6xUBhCYvG6ChqDlXnDrH99m
 JYgQ==
X-Gm-Message-State: AGi0PuZM8t5R5dnt4Fvc21J95mlI+bSKEPtLXEOceXGPmrxcBqUhDT4X
 19FzO9dOPPDzFe2klxVVWnpC+g==
X-Google-Smtp-Source: APiQypLW9bKgEOVZISv/co1USgNp75DFj+X0wEqyeuhHIME0rTw61DXy5rqMgyRLDHi+2qmOxEEBLA==
X-Received: by 2002:adf:df8c:: with SMTP id z12mr782595wrl.116.1587584460785; 
 Wed, 22 Apr 2020 12:41:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w11sm361816wmi.32.2020.04.22.12.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 12:40:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28C7A1FF7E;
 Wed, 22 Apr 2020 20:40:59 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-24-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 23/36] tcg: Add tcg_reg_alloc_dup2
In-reply-to: <20200422011722.13287-24-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 20:40:59 +0100
Message-ID: <87lfmnb96c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There are several ways we can expand a vector dup of a 64-bit
> element on a 32-bit host.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index fc1c97d586..d712d19842 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3870,6 +3870,91 @@ static void tcg_reg_alloc_op(TCGContext *s, const =
TCGOp *op)
>      }
>  }
>=20=20
> +static void tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
> +{
> +    const TCGLifeData arg_life =3D op->life;
> +    TCGTemp *ots, *itsl, *itsh;
> +    TCGType vtype =3D TCGOP_VECL(op) + TCG_TYPE_V64;
> +
> +    /* This opcode is only valid for 32-bit hosts, for 64-bit elements. =
*/
> +    tcg_debug_assert(TCG_TARGET_REG_BITS =3D=3D 32);

Given this maybe the whole function should be in a #if
TCG_TARGET_REG_BITS =3D=3D 32 protection. Most of the other parts of the
code that refer to this have something similar.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

