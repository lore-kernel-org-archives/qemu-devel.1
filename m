Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47035C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C77206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFZd2DoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C77206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYN6-00076p-8q
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33818 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQYMH-0006hd-IB
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:29:17 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQYMG-0003yC-UG
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:29:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36548)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQYMG-0003wP-9e
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:29:16 -0400
Received: by mail-wm1-x341.google.com with SMTP id u127so10816793wmg.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Y4sw1kY0mzyRRilMuKHu/yGTXrOxc5izPlrmTaRFZJU=;
 b=pFZd2DoIlJ4mfDL7MuTZEn+JiEsz7QnRHciqEm5x2t6HEPrzWwk1tDS+Bbacwyf9Ia
 Crzk9UQH38V+SU/iUuy4cVKFHy9Gs3Ks0RTRwTiy8pepBOcVZLSsyNbG7tQ1jLg/hhOP
 fS4qZfz2G0QieJzkmrBsda1K0tYlqnxIK/cwCqlYtt2s/nH+xxiEHzS59lR0B+8kCUKN
 ZM8qLChRzGCcDum9Czpbeg+8EmkotSygv5Zn1+QWEt8PR6lsrXT4tJPfy/bZ/J9Y9TrR
 tK5GVXEn1nkhi8SR8s63qXxFNEiyV0BfkGGV7rZ7tFavYrzE4jFBq8DMWXiUMprYW/RZ
 MHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Y4sw1kY0mzyRRilMuKHu/yGTXrOxc5izPlrmTaRFZJU=;
 b=q2O+ql1StHRsdZb7NyLqPJ6zZ242ipUY3JohvrkrxB81FNp5lrW+mjl8HUR2301Y4u
 QeMkhjjCX8LFzFQfLMCO8nw2J5wDR4JvxtQri3/XktaeZG90aNyI1H4pLHOKnXGn315W
 IfIR1iXFGXz4CGYbye03+5hkKVX+cMVA0TXi10NZc5cY72H0xSYqwwKjg9Qa5p6vGElO
 p4uKFezLvZeZmh8QU0YXLRP1dL+44KZcBiqNQpgj/u8+aNDHd+68x8gh///j60fzodSj
 5pp1/v8yjKClMPLMrDYQLOIaI+Mj+Gj0euFwMpSVb+Fcujt+iWiitu92mEVHRSecwAYH
 7MJA==
X-Gm-Message-State: AGi0PubqyPgIKgjbqoJwRoUoqtycuuxbs3f5KgHUOpYQ34ulf2p8Kjq/
 75LJOotusBIj+vv+EysCg35Dsg==
X-Google-Smtp-Source: APiQypL+aUVY6rU9SXji9w52XxD2tPmlFjwrZOFiZs7DFo4k/cDUAaJJIHIzu+z0Cvz0OkduFCQ7Tw==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr16665189wme.38.1587396554255; 
 Mon, 20 Apr 2020 08:29:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z76sm2037017wmc.9.2020.04.20.08.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 08:29:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8DF5F1FF7E;
 Mon, 20 Apr 2020 16:29:12 +0100 (BST)
References: <20200418155651.3901-1-richard.henderson@linaro.org>
 <20200418155651.3901-3-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/3] target/arm: Use tcg_gen_gvec_mov for clear_vec_high
In-reply-to: <20200418155651.3901-3-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 16:29:12 +0100
Message-ID: <87ftcydvlj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The 8-byte store for the end a !is_q operation can be
> merged with the other stores.  Use a no-op vector move
> to trigger the expand_clr portion of tcg_gen_gvec_mov.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 095638e09a..d57aa54d6a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -513,14 +513,8 @@ static void clear_vec_high(DisasContext *s, bool is_=
q, int rd)
>      unsigned ofs =3D fp_reg_offset(s, rd, MO_64);
>      unsigned vsz =3D vec_full_reg_size(s);
>=20=20
> -    if (!is_q) {
> -        TCGv_i64 tcg_zero =3D tcg_const_i64(0);
> -        tcg_gen_st_i64(tcg_zero, cpu_env, ofs + 8);
> -        tcg_temp_free_i64(tcg_zero);
> -    }
> -    if (vsz > 16) {
> -        tcg_gen_gvec_dup_imm(MO_64, ofs + 16, vsz - 16, vsz - 16, 0);
> -    }
> +    /* Nop move, with side effect of clearing the tail. */
> +    tcg_gen_gvec_mov(MO_64, ofs, ofs, is_q ? 16 : 8, vsz);
>  }
>=20=20
>  void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)


--=20
Alex Benn=C3=A9e

