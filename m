Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284EC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDECD2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKI/UfVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDECD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXu7-0003ag-Sw
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRXtT-0003A5-KJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRXtL-00013G-Cj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:11:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRXtK-0000wj-O0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:11:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id j1so5938327wrt.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fFD5WjWiJMHH+/6s0n3YxKI6uF8dUOs0F0SaSzWvO6A=;
 b=pKI/UfVIPxyqNykjw8GpsShszfwBaoshb7qwItlzC0WJAGXVwn1voQcsC+iUsvLHn3
 Z7fqnwwxTKe+dZV2XlQrflVxdIDmeaSZoXb/ZKash/qgWkubL/EDYGIwe7NOqW3Mj4Xf
 RSrYX20a9BVIGjNe837mgi4tP8JATEtlTiaZ4258TJnGpL9Vlb+DlZst4PdMWnHgX4E+
 lXdPiTw99j3/W0tKXjh+gNSJg6cIpaYA+xTXEj3ppGe0QGX2VwTvXZg1pcYcISjzBh2c
 lFs7293X6P8BJs6OaFOk9H/RD+KNtn5Zw/jNxbK/UylGrhlAtYG3Kkc7d6tTB5t7ksR8
 KEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fFD5WjWiJMHH+/6s0n3YxKI6uF8dUOs0F0SaSzWvO6A=;
 b=dFvL9oXGE1oZTSXQpH85rp5xmifPqmjDMnbS7Rr2FLaIUwCOa/it720slfp/roPxwB
 MaE1Hdk3OiOy/2qV+irDsdu6hK29iyKVsOwMC7oswHeA51tHgCIF2ZLNqON5GF7/pV4K
 fiv35lcMnJmwQ9l2WQlIstBxUjYf2s/2NI0r0O/Wxs+wNWMXE2dZngm+cMI58w2I/nIT
 g2ITdRtfNwB7PHqBaOgKQxRzhfKphKzusmouSj+MiDP2IASyF+NNf/G4UYO1ylI43X3q
 6U1BNGJLjAJ61KKNi8N9kUjcrpsceXjnWmBNHivROso5s2KhOqt7F7mg4sxF0ierNNun
 V/cA==
X-Gm-Message-State: AGi0PuazQplQ3ZdtupBL6XsMl/b+VgbSZ/wKBsIj5TSikw6RplSeXNYW
 QBZtKHXLoMJk/aJW6bCKq5RwOA==
X-Google-Smtp-Source: APiQypJiPJt5KMwi9q8ZfpTX/xJh/k+kbA8g4B21H+VRE4ig6QG6vJ+ucjuBX/n249+n17x4S4DsHg==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr3742441wrn.197.1587633087743; 
 Thu, 23 Apr 2020 02:11:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s12sm2693391wmc.7.2020.04.23.02.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 02:11:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CFD151FF7E;
 Thu, 23 Apr 2020 10:11:25 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-26-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 25/36] tcg: Remove tcg_gen_dup{8,16,32,64}i_vec
In-reply-to: <20200422011722.13287-26-richard.henderson@linaro.org>
Date: Thu, 23 Apr 2020 10:11:25 +0100
Message-ID: <87d07ybm82.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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

> These interfaces have been replaced by tcg_gen_dupi_vec
> and tcg_constant_vec.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-op.h |  4 ----
>  tcg/tcg-op-vec.c     | 20 --------------------
>  2 files changed, 24 deletions(-)
>
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 11ed9192f7..a39eb13ff0 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -959,10 +959,6 @@ void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
>  void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
>  void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
>  void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_l=
ong);
> -void tcg_gen_dup8i_vec(TCGv_vec, uint32_t);
> -void tcg_gen_dup16i_vec(TCGv_vec, uint32_t);
> -void tcg_gen_dup32i_vec(TCGv_vec, uint32_t);
> -void tcg_gen_dup64i_vec(TCGv_vec, uint64_t);
>  void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
>  void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 6343046e18..a9c16d85c5 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -284,26 +284,6 @@ void tcg_gen_dupi_vec(unsigned vece, TCGv_vec dest, =
uint64_t val)
>      tcg_gen_mov_vec(dest, tcg_constant_vec(type, vece, val));
>  }
>=20=20
> -void tcg_gen_dup64i_vec(TCGv_vec dest, uint64_t val)
> -{
> -    tcg_gen_dupi_vec(MO_64, dest, val);
> -}
> -
> -void tcg_gen_dup32i_vec(TCGv_vec dest, uint32_t val)
> -{
> -    tcg_gen_dupi_vec(MO_32, dest, val);
> -}
> -
> -void tcg_gen_dup16i_vec(TCGv_vec dest, uint32_t val)
> -{
> -    tcg_gen_dupi_vec(MO_16, dest, val);
> -}
> -
> -void tcg_gen_dup8i_vec(TCGv_vec dest, uint32_t val)
> -{
> -    tcg_gen_dupi_vec(MO_8, dest, val);
> -}
> -
>  void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
>  {
>      TCGArg ri =3D tcgv_vec_arg(r);


--=20
Alex Benn=C3=A9e

