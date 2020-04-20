Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E0BC54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59B3208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUx7ncRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59B3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSzB-0001d3-4s
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46690 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQSy3-0000jh-3n
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:43:55 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQSy2-0005Gs-D7
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:43:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40044)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQSy1-0005DD-PP
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:43:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id k13so10065579wrw.7
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9+dsfilT1MiwAKTltkD8m3FfB47hjRict92LqWOvi1k=;
 b=OUx7ncRsDf5Xoq+LPQx5RkZlcz9Sk8m3uM8gfYzrZMbwSBPPDV4W9M4JZYQiim6D/w
 ljA4/VPQMvBNasavQHh5eGfmsk8c9+o9buSnZa1sV8S9YC2OO1PY5WFemUOnBCEAx+x3
 CNwn9MAReZQgK7Q4EJJIFid+GwmHQbwrz7x7lYy6CEhw1cmI2RvKkoT9+K81lInnHFCm
 jrii4ry6slLgK/iDMlWslCTMhOhPgrzzM4AgKNY52a1pZyRSS55DthIhUoWF+DWKovc+
 Za9Y6fZe7wyFc7X/WCBVh24jBBOzKY0mjiE318bWHXBcmtfzYfQkpSTtak1m78ImDefj
 76uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9+dsfilT1MiwAKTltkD8m3FfB47hjRict92LqWOvi1k=;
 b=krO03mqR0iJwS8AAiIUt/v2xN8SQPsKl+4/WfjwxtDwoDpl1i6KWtfC72pvngvweSV
 bCClvPeY0T11Y9MPooUmKlvlZTE5RlBOGvaLWukMmP7/9PYkfeKq0GFC2zNr6xOU3gZn
 HRx0SdB6xX+SZtO3CTlylRYTG8iSevfHqHzkBjZOZT2WfaG6khiU/hhx9E8BnDhjxc5f
 PjaH22BhuTt0SrKIfebqWC4dNYe0LnJemNG1g/2fhJAiS8q+Iv7PCSedVTxbPmiYSZIa
 fHYA5tkbfWG5A74SU1KSsqnfJ2/mcP1BemtLRUzpEu9Yfj+RWAtXRkYUSlUpX+uGfAZ/
 DeGQ==
X-Gm-Message-State: AGi0PuZSSESnA10OWDNM84ZLt1HEbeUJAfrtfiHNvgc0/Hlqr10JVOxA
 Uz42jZ0YoUySEfySfI343wucWg==
X-Google-Smtp-Source: APiQypI7rE9PwkETQyrDbjUmr1LDqgZ4wSb1RK4P5mTNjwwKshDlrkqTauBHu6hNHe72ccz4z+bI4g==
X-Received: by 2002:a5d:4e02:: with SMTP id p2mr17772371wrt.302.1587375831476; 
 Mon, 20 Apr 2020 02:43:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b22sm4752099wmj.1.2020.04.20.02.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 02:43:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E64C1FF7E;
 Mon, 20 Apr 2020 10:43:49 +0100 (BST)
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-2-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/7] tcg: Add tcg_gen_gvec_dup_imm
In-reply-to: <20200418150411.1831-2-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 10:43:49 +0100
Message-ID: <87blnmfq5m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 david@gibson.dropbear.id.au, zhiwei_liu@c-sky.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Add a version of tcg_gen_dup_* that takes both immediate and
> a vector element size operand.  This will replace the set of
> tcg_gen_gvec_dup{8,16,32,64}i functions that encode the element
> size within the function name.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-op-gvec.h | 2 ++
>  tcg/tcg-op-gvec.c         | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index 74534e2480..eb0d47a42b 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -313,6 +313,8 @@ void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, u=
int32_t aofs,
>=20=20
>  void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
>                            uint32_t s, uint32_t m);
> +void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t s,
> +                          uint32_t m, uint64_t imm);
>  void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
>                            uint32_t m, TCGv_i32);
>  void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 327d9588e0..593bb4542e 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1569,6 +1569,13 @@ void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t op=
rsz,
>      do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
>  }
>=20=20
> +void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                          uint32_t maxsz, uint64_t x)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
> +}
> +
>  void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t oprsz, uint32_t maxsz)
>  {


--=20
Alex Benn=C3=A9e

