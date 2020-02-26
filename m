Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E40C4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4532224650
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3+rYhsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4532224650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71C1-0004d1-GM
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j71B1-0003He-OC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j71B0-0000ja-GD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:12:55 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j71B0-0000iT-8v; Wed, 26 Feb 2020 13:12:54 -0500
Received: by mail-lj1-x243.google.com with SMTP id q8so145119ljb.2;
 Wed, 26 Feb 2020 10:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sut3B69Gr8gmy8T2vubZY/jzcqTF52GVYnmkZIvPhvo=;
 b=K3+rYhsq5kCjqfvlm49btupgwUGZidu+XG6J510LsikQFNAnMEGJPdierLAIoYuP2O
 SrmXgumoZPqLEWiOfp07lV96JMxDlFMaq5IWrL9cXwbKsGzr/5uYhlxo/FkNL+/qBPP1
 MwsM4mcHJkyO/FePz1jggC+YeZvgqZ4ufpyDLQXOa5Rcbfvy1g6zKQ+Ukx0z1i8KdWP5
 xr7pFvguroQm2FCdcTP5h6cB5ovevO+BWceeDOKJ+dvcmXb+BBXD8dQE6GrQI0riF0+Q
 rHjI0oZq8SfaWYzJfdA+XCkxyf3+7usxsmwkkMo3oJ/Yd2yJ5kIa1BtQpqb092iHNtLu
 l1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sut3B69Gr8gmy8T2vubZY/jzcqTF52GVYnmkZIvPhvo=;
 b=iZL5tLZLSdUcbO+xE6dB5Uha7dLl+Fk7S7X3NNJTEePXhaLw0LPnpAwr4tXhmHHgD2
 nBHDWNcSDn1PiJ3Q6ix2gH4uloMRc6JH54Dw4sKVnBKcYVcA1qxnV9R5NA2coW9xupBz
 rBPkd9ABkctc0ih8Xj7gqFe44odZ6P8aMCj9DHYbSuII6ErZEoHh7mituKkX7SB2QeZO
 1DDnjxCnGGpequclhZTFsSfhU35heP0NmBx32EW+VQhBpnYbMLhWz7CAp5o5B+jTRM1H
 Gqq1P7ycrrRo8r+4ydeHGN6+r75l9r2lYJNGcNAUtwixxdcU2Cp3IFhMFxTK73jlrNdL
 Sm+g==
X-Gm-Message-State: ANhLgQ1r2ziBC4IobM5wPu9ENSb05w8vT2o/EjLqV0SsOvMchSaJO4Zh
 5aKPat5MopOgJeCW38vjgdF0b7LjcaL2QLeq9IQ=
X-Google-Smtp-Source: ADFU+vu4UyGUYzr1XUwVqZXVtjTjxmypgQXaF2eAAAVTWxLH1GhYtIbZsziqkpcZvLdfmV1Wm57cIGklr1ZdeyH0Zeg=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr117252ljn.107.1582740772829; 
 Wed, 26 Feb 2020 10:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <20200221094531.61894-3-zhiwei_liu@c-sky.com>
In-Reply-To: <20200221094531.61894-3-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 10:05:15 -0800
Message-ID: <CAKmqyKM10H9yjQmzWhDHo2sLxKo6bq2QxV0pdpgUq5nD+qqanQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] target/riscv: implementation-defined constant
 parameters
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 1:45 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> vlen is the vector register length in bits.
> elen is the max element size in bits.
> vext_spec is the vector specification version, default value is v0.7.1.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 7 +++++++
>  target/riscv/cpu.h | 5 +++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8c86ebc109..6900714432 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -98,6 +98,11 @@ static void set_priv_version(CPURISCVState *env, int priv_ver)
>      env->priv_ver = priv_ver;
>  }
>
> +static void set_vext_version(CPURISCVState *env, int vext_ver)
> +{
> +    env->vext_ver = vext_ver;
> +}
> +
>  static void set_feature(CPURISCVState *env, int feature)
>  {
>      env->features |= (1ULL << feature);
> @@ -320,6 +325,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      CPURISCVState *env = &cpu->env;
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>      int priv_version = PRIV_VERSION_1_11_0;
> +    int vext_version = VEXT_VERSION_0_07_1;
>      target_ulong target_misa = 0;
>      Error *local_err = NULL;
>
> @@ -345,6 +351,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      }
>
>      set_priv_version(env, priv_version);
> +    set_vext_version(env, vext_version);
>      set_resetvec(env, DEFAULT_RSTVEC);
>
>      if (cpu->cfg.mmu) {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2e8d01c155..748bd557f9 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -83,6 +83,8 @@ enum {
>  #define PRIV_VERSION_1_10_0 0x00011000
>  #define PRIV_VERSION_1_11_0 0x00011100
>
> +#define VEXT_VERSION_0_07_1 0x00000701
> +
>  #define TRANSLATE_PMP_FAIL 2
>  #define TRANSLATE_FAIL 1
>  #define TRANSLATE_SUCCESS 0
> @@ -117,6 +119,7 @@ struct CPURISCVState {
>      target_ulong badaddr;
>
>      target_ulong priv_ver;
> +    target_ulong vext_ver;
>      target_ulong misa;
>      target_ulong misa_mask;
>
> @@ -231,6 +234,8 @@ typedef struct RISCVCPU {
>
>          char *priv_spec;
>          char *user_spec;
> +        uint16_t vlen;
> +        uint16_t elen;
>          bool mmu;
>          bool pmp;
>      } cfg;
> --
> 2.23.0
>

