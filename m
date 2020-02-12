Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B2BC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F622082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5fJnv4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F622082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1pYb-0000Gx-Qg
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 05:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j1pXv-00084Q-BC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j1pXu-0004qz-6v
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:47:07 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j1pXt-0004ok-VW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:47:06 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so1616305wrw.8
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 02:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FlVkBcyAUdBxF3UEtCbydT6aZE1E6dBsVvszd5bWrY8=;
 b=E5fJnv4Luv8VV2mtju19DubDVeISmnCSDZJ4Ex7j5w7mNCMnIfLk2lmaN6/dwyqViE
 uKi/GOFJFCyAa48uD1HKrD0gz+tCLoGQj+rIVfUATTk0WScCwtsCTy6PDkaK2JwiIFPW
 jQZhR0wHz2qoadQvw1kiENYyWimnWDwOcsY2K7fzVBo145U6BsgKADyKfey++b8Xyd5Y
 TCSdXnYFBeFagk5BCRfNN86SEdDJ93AfrZcWP/vhA/se6NY5miVPcNg8QuR2aV2eGmw7
 fk+TlIoHYydvTLSpQ6EL4NJrAwVggi1P2tG8cuSBVAN1oy3xqtj4toM48rw+ug3vhD6Z
 TW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FlVkBcyAUdBxF3UEtCbydT6aZE1E6dBsVvszd5bWrY8=;
 b=rRcYqneu1JuUohCTp5Jgd9rUc1GkV/adTMDCqbcxZppDt1KrRVqtrAtUSNvF3YAejr
 nwV/KcwMjLBM+5Xrauq2A4HeqtEm79PUCyG6M3T2uWSDNoPkV4QZNJ7s6ubvLff83AZn
 2ge2H5B/VacIeOsBbyPuXCLm22tS+pIl4bxz3VPwQDNcd2FxEJtXi/jHvUHOb0f3uBUC
 5o6YJdgbZPxJlz9C/9AWwKsHNm0UW1dY8AIVKGt+Su+G6IfNrQiiHzBS1HXZzX55o6TJ
 wSlLEzZAF1uUz9BT4JeH5g8Sr1BODsevVf1nSPUbTG0jLVNXnZ79iriCpifVlaHF2JP/
 soHQ==
X-Gm-Message-State: APjAAAXTi/NISehMdmB+gJHJo3+rIRzbPdcEOpPhnWql3Nv99ij5gaAP
 J2AhV1pjTNJVMQnVKj2qTIU8mlikHBU=
X-Google-Smtp-Source: APXvYqxzLJyUU6nLZj0+3yairoIexCXIur8n/TngwYeenGE6jdX0MfpABjEyZpc2FyKemLW8RipxVA==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr15392848wru.55.1581504424447; 
 Wed, 12 Feb 2020 02:47:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m68sm194281wme.48.2020.02.12.02.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 02:47:03 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1C461FF87;
 Wed, 12 Feb 2020 10:47:02 +0000 (GMT)
References: <20200212025145.24300-1-richard.henderson@linaro.org>
 <20200212025145.24300-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.8; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] tcg: Add tcg_gen_gvec_5_ptr
In-reply-to: <20200212025145.24300-2-richard.henderson@linaro.org>
Date: Wed, 12 Feb 2020 10:47:02 +0000
Message-ID: <87k14sxeu1.fsf@zen.linaroharston>
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
Cc: peter.maydell@linaro.org, tsimpson@quicinc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Extend the vector generator infrastructure to handle
> 5 vector arguments.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-op-gvec.h |  7 +++++++
>  tcg/tcg-op-gvec.c         | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index 830d68f697..74534e2480 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -83,6 +83,13 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, =
uint32_t bofs,
>                          uint32_t maxsz, int32_t data,
>                          gen_helper_gvec_4_ptr *fn);
>=20=20
> +typedef void gen_helper_gvec_5_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_pt=
r,
> +                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_5_ptr *fn);
> +
>  /* Expand a gvec operation.  Either inline or out-of-line depending on
>     the actual vector size and the operations supported by the host.  */
>  typedef struct {
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 41b4a3c661..327d9588e0 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -290,6 +290,38 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs=
, uint32_t bofs,
>      tcg_temp_free_i32(desc);
>  }
>=20=20
> +/* Generate a call to a gvec-style helper with five vector operands
> +   and an extra pointer operand.  */
> +void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_5_ptr *fn)
> +{
> +    TCGv_ptr a0, a1, a2, a3, a4;
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +    a2 =3D tcg_temp_new_ptr();
> +    a3 =3D tcg_temp_new_ptr();
> +    a4 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +    tcg_gen_addi_ptr(a2, cpu_env, bofs);
> +    tcg_gen_addi_ptr(a3, cpu_env, cofs);
> +    tcg_gen_addi_ptr(a4, cpu_env, eofs);
> +
> +    fn(a0, a1, a2, a3, a4, ptr, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_ptr(a3);
> +    tcg_temp_free_ptr(a4);
> +    tcg_temp_free_i32(desc);
> +}
> +
>  /* Return true if we want to implement something of OPRSZ bytes
>     in units of LNSZ.  This limits the expansion of inline code.  */
>  static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)


--=20
Alex Benn=C3=A9e

