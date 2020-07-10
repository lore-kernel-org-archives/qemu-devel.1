Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF3EC433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5482B20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HznVMdx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5482B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtxcu-0003xN-LS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtxcL-0003Vv-Ah
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:19:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtxcJ-0004ny-4r
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:19:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id o8so7064518wmh.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2bFGq3P5fqfdRRFNnry7GjHopk/3w08fUzKnu6E0MCg=;
 b=HznVMdx4+XkVg4D18SKyTo5RgsYSfKAZFNQtHUZRNnwJF5efztgMPlgpAAaKYf3U2D
 gOf6xcLYJl7Qo+X8DFMkgakFcll3r3I6QCwGrr+drcwUs7IHvvqr3zQV27vBTmWy/FIZ
 hXIsiIW0FUSxNzdvIDvuR5ice7a0Kg7Rc8skLnvC7MutW99ISzB4FM8w7oxlGNYAkOC2
 CEZGqLfwh+Z6Wd/XunDmme4hFJ1iNj/NpL97QypNJwMVAYEvtRGSnpOFy4k3qYQxlpah
 l2qfqyTNj9SH2HdggkZrhlb3eJKUL0gsGGCWB1oPU+zppWXCbu6oaiMpnI41Ilg7PEDu
 I4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2bFGq3P5fqfdRRFNnry7GjHopk/3w08fUzKnu6E0MCg=;
 b=ofO68aJIcNjmPsF3A8NO1P/mO6AtWIYxdYBhvrguZxkFdPmaRm9HKH/MqUkd2+iHrd
 CLGpazNqo7sX2MpSroHuhAulQGp1yOMoIIq/G4FF5N98EAWXaY7PBWMON5WZ/uLJ4AdF
 Kb0QS5ziH2D3rXv50erLGEuJJMcJpFeL94LRsKnOSCFII++OCztLwwGMF5YWSXGTTPJg
 R5RtvXOTjzU80fQUwVX5YJyiuopv/Yl3LYXTPjQHkUy54eBc9jX8zb7N1ueLC5JeDl3e
 jTX+n95DONjyNnV4Pg0yCsZqxwuCZ5P2rGRKvfTtKvOi3mQvCk6wXSDeFWFg1T/jJIkm
 Uq9g==
X-Gm-Message-State: AOAM533uRM0oT/H87If5M5Qa5O/6gXmYpCi40ZTt/V43snHY/ByX/R9O
 8V9SwPvVPvYrAhY3HIKgYsL0Kg==
X-Google-Smtp-Source: ABdhPJwSSY8BGKVEYP/Cj5W3nwKWMss0McdmcY1vGbsf2jPB5Yp9KWv9JsNZSBe0lSQRxzOizU+Tew==
X-Received: by 2002:a05:600c:281:: with SMTP id
 1mr6439788wmk.143.1594405161513; 
 Fri, 10 Jul 2020 11:19:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y16sm11548421wro.71.2020.07.10.11.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 11:19:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B12721FF7E;
 Fri, 10 Jul 2020 19:19:19 +0100 (BST)
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-58-frank.chang@sifive.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: frank.chang@sifive.com
Subject: Re: [RFC 57/65] target/riscv: rvv-0.9: floating-point min/max
 instructions
In-reply-to: <20200710104920.13550-58-frank.chang@sifive.com>
Date: Fri, 10 Jul 2020 19:19:19 +0100
Message-ID: <87o8onjkrc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


frank.chang@sifive.com writes:

> From: Frank Chang <frank.chang@sifive.com>
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/vector_helper.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 42a48be5fd..d617d0dfbd 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3831,28 +3831,28 @@ GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
>  GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
>=20=20
>  /* Vector Floating-Point MIN/MAX Instructions */
> -RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum)
> -RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum)
> -RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minnum)
> +RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum_noprop)
> +RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum_noprop)
> +RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8,
>  float64_minnum_noprop)

This patch breaks bisection because you don't introduce this into
softfloat until later. You should always ensure each step can build and
run - practically this means the softfloat changes should be at the
beginning of the series.

>  GEN_VEXT_VV_ENV(vfmin_vv_h, 2, 2, clearh)
>  GEN_VEXT_VV_ENV(vfmin_vv_w, 4, 4, clearl)
>  GEN_VEXT_VV_ENV(vfmin_vv_d, 8, 8, clearq)
> -RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum)
> -RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum)
> -RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum)
> +RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum_noprop)
> +RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum_noprop)
> +RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum_noprop)
>  GEN_VEXT_VF(vfmin_vf_h, 2, 2, clearh)
>  GEN_VEXT_VF(vfmin_vf_w, 4, 4, clearl)
>  GEN_VEXT_VF(vfmin_vf_d, 8, 8, clearq)
>=20=20
> -RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum)
> -RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum)
> -RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum)
> +RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum_noprop)
> +RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum_noprop)
> +RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum_noprop)
>  GEN_VEXT_VV_ENV(vfmax_vv_h, 2, 2, clearh)
>  GEN_VEXT_VV_ENV(vfmax_vv_w, 4, 4, clearl)
>  GEN_VEXT_VV_ENV(vfmax_vv_d, 8, 8, clearq)
> -RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum)
> -RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum)
> -RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
> +RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum_noprop)
> +RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum_noprop)
> +RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum_noprop)
>  GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
>  GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
>  GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)


--=20
Alex Benn=C3=A9e

