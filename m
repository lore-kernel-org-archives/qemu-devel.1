Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3FDECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BED2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EJonZtdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BED2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFN0T-0001XG-H5
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iFMyJ-0008Jr-Dd
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iFMyI-0002ha-3c
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iFMyH-0002h8-Uc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:02 -0400
Received: by mail-pg1-x542.google.com with SMTP id v27so10245613pgk.10
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=S6a5oA3Zj6JrzqQjT6/wQI3o70xoT4MbmOz5qrTzy84=;
 b=EJonZtdKHP3xCRc9u71MMH/41QaBX1QO0p6JxCyjkcGgYS9Lc97bcQIkYfeipkSPe1
 e2UEiOU7xgsGGX+jqK4vwn4Gc2V66JOcK3kKl+SgipTHr7dnpjh2+nwoVF12MKb8YF5M
 z6kEC6bBx+YUfMiSkqmPc1yN50BaIqcISUIgMLgjKei+75JoIhd2CD69YIEFwNYM0CRs
 BIVPzkUQTVdMBtwfL5qdshkzLTLCF9gRfSN2cF1xuMEMfQgoB6NuHy4a8MJhxz8Q6l/6
 v8FMrlbcXcj7VCD6FY2pMQv5gpoyw4Sik0lOw7waneiqZHcQHFpiQ//MbqdwkydXoECH
 cjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=S6a5oA3Zj6JrzqQjT6/wQI3o70xoT4MbmOz5qrTzy84=;
 b=r9x8WXGVH7cetlztPCCjGxp+7EKkT68ImhThFfPbs0dvsmlLBjUYYSAahig0IBX0FD
 Us5HJhEF/BvZoJOSSaOxoJzsF7NuW6u0GsqUIF7mjyheurMCcGooUY4BEVK2TkUePzs9
 gXLCOwYT26yVqQuLmwh+z8ZnIiC50NcoBEglwJbLaycm7FK9dJHMLhPMHBDQVP2M5Axm
 j/jqQBDavFzNEkTCbKwssXh/lmnHL2g+yDv3oAKPx4jzJuOubYzsyJSVGWz76ibRk2k+
 CA6lzHoWZq2DGOnK//yvsGAFaRPjqmlCEw72XYLpY4dQL2+N1yaDeDg2UKWmQJ5IEj1l
 DBNg==
X-Gm-Message-State: APjAAAVIC6ha1/vSPnIpBLTwSBkXaZSTDBaS5BIajs3kMlCDj0lbyVPU
 H+kUCQwmBAQh+TylVQ0bnhokmsDiVSX0Og==
X-Google-Smtp-Source: APXvYqwCHOF1mdeKfYaRJ25LqX8lifdSE5T1sA9JBgRGxl9uvtzQvLUedip/7XlfwSfVZhcPmJ7eAQ==
X-Received: by 2002:a62:e106:: with SMTP id q6mr28730857pfh.14.1569954840139; 
 Tue, 01 Oct 2019 11:34:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id c3sm3551608pgl.51.2019.10.01.11.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 11:33:59 -0700 (PDT)
Date: Tue, 01 Oct 2019 11:33:59 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:27:13 PDT (-0700)
Subject: Re: [PATCH v1 17/28] target/riscv: Add Hypervisor trap return support
In-Reply-To: <6e2920dbef1ed86b8784827200525c5a112468b2.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-5f63f9ba-daec-4cae-a1f8-23f2a59a244b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:34 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/op_helper.c | 66 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index beb34e705b..5bcf5d2ff7 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -73,6 +73,8 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
>
>  target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>  {
> +    target_ulong prev_priv, prev_virt, mstatus;
> +
>      if (!(env->priv >= PRV_S)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
> @@ -87,16 +89,46 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> -    target_ulong mstatus = *env->mstatus;
> -    target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
> -    mstatus = set_field(mstatus,
> -        env->priv_ver >= PRIV_VERSION_1_10_0 ?
> -        MSTATUS_SIE : MSTATUS_UIE << prev_priv,
> -        get_field(mstatus, MSTATUS_SPIE));
> -    mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
> -    mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
> +    mstatus = *env->mstatus;
> +
> +    if (riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
> +        /* We support Hypervisor extensions and virtulisation is disabled */
> +        target_ulong hstatus = env->hstatus;
> +
> +        prev_priv = get_field(mstatus, MSTATUS_SPP);
> +        prev_virt = get_field(hstatus, HSTATUS_SPV);
> +
> +        hstatus = set_field(hstatus, HSTATUS_SPV,
> +                                 get_field(hstatus, HSTATUS_SP2V));
> +        mstatus = set_field(mstatus, MSTATUS_SPP,
> +                            get_field(hstatus, HSTATUS_SP2P));
> +        hstatus = set_field(hstatus, HSTATUS_SP2V, 0);
> +        hstatus = set_field(hstatus, HSTATUS_SP2P, 0);
> +        mstatus = set_field(mstatus, SSTATUS_SIE,
> +                            get_field(mstatus, SSTATUS_SPIE));
> +        mstatus = set_field(mstatus, SSTATUS_SPIE, 1);
> +
> +        *env->mstatus = mstatus;
> +        env->hstatus = hstatus;
> +
> +        if (prev_virt == VIRT_ON) {
> +            riscv_cpu_swap_hypervisor_regs(env);
> +        }
> +
> +        riscv_cpu_set_virt_enabled(env, prev_virt);
> +    } else {
> +        prev_priv = get_field(mstatus, MSTATUS_SPP);
> +
> +        mstatus = set_field(mstatus,
> +            env->priv_ver >= PRIV_VERSION_1_10_0 ?
> +            MSTATUS_SIE : MSTATUS_UIE << prev_priv,
> +            get_field(mstatus, MSTATUS_SPIE));
> +        mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
> +        mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
> +        *env->mstatus = mstatus;
> +    }
> +
>      riscv_cpu_set_mode(env, prev_priv);
> -    *env->mstatus = mstatus;
>
>      return retpc;
>  }
> @@ -114,14 +146,24 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>
>      target_ulong mstatus = *env->mstatus;
>      target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> +    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
>      mstatus = set_field(mstatus,
>          env->priv_ver >= PRIV_VERSION_1_10_0 ?
>          MSTATUS_MIE : MSTATUS_UIE << prev_priv,
>          get_field(mstatus, MSTATUS_MPIE));
> -    mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
> -    mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
> -    riscv_cpu_set_mode(env, prev_priv);
> +    mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
> +    mstatus = set_field(mstatus, MSTATUS_MPP, 0);
> +    mstatus = set_field(mstatus, MSTATUS_MPV, 0);
>      *env->mstatus = mstatus;
> +    riscv_cpu_set_mode(env, prev_priv);
> +
> +    if (riscv_has_ext(env, RVH)) {
> +        if (prev_virt == VIRT_ON) {
> +            riscv_cpu_swap_hypervisor_regs(env);
> +        }
> +
> +        riscv_cpu_set_virt_enabled(env, prev_virt);
> +    }
>
>      return retpc;
>  }

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

