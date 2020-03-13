Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D1DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C1C206E9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAQ4I5Fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C1C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqVe-0000HE-M3
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 16:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCqUR-0007Y9-Aj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCqUP-0004bv-Pv
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:01:02 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:34407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCqUP-0004aA-Jl; Fri, 13 Mar 2020 16:01:01 -0400
Received: by mail-vs1-xe43.google.com with SMTP id t10so7014369vsp.1;
 Fri, 13 Mar 2020 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0J1L82u1M3QcL0wp0qTvpCsTuxMeMK5Ujyi9B1ea2dA=;
 b=dAQ4I5FndNOJPMKFRvdFBEP3iQG3a0g3MSyFyHZ4pw0aWnjSnOPBU17Nw/iE1Jj3z1
 KXrRetx97j86NiV9WHLSn5kpBJkEF67ihU9vgegfZchAlXj2NslsLYHdbMeZwtmj7CAr
 8XwNAZfLGmevPDE2EogQyYT9ihXEG/1Ig7GCYTyi3SWw6CB+Urt8QkvBR83c6+0J2qjG
 uXoNrsiu3RwT9AZwvTTvg5QQT6mazVGe+Ol+FAMJWJCDFVJ8dyF4EMEln8hslodsk1x1
 xi1chIiOiWlshyGDKvdjTlco6xodLt28hAvmdWT3RXdKL5O6I+i716WIelS955Oyjkyh
 ZjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0J1L82u1M3QcL0wp0qTvpCsTuxMeMK5Ujyi9B1ea2dA=;
 b=JENsSz/DrnmvWb7w6fSL3t3rtY3qT+D+IrniiSoBl7uGRwkbOGB96WYtFzcD13kcm+
 NQ1ZG2gKwgUoRSeuxm1OSoNcdjbhmwKaIsooFpTPoiKYiWC7QS6xoBecZDLnSOMLhK0Y
 cSqjy2QLejctHvWG+QwUYkZVRkRZ/P2v7A7MJRrAqHdPX8V2ZtNqF2Pc+1zKWNECQrrI
 Y/2BGV3aQch2rPYHt9W61CwfLoBkFqNxucxjwAeibwVIpfPuQw29Llv4ER1biMs2OkLS
 Rk9PeeutOpkXCFzZBMehbhALfFh8R9YrP74SZLaSyJM+MvGe2o4+QoSRNFxM4V44n6xR
 cNaA==
X-Gm-Message-State: ANhLgQ3fHRH0EjChchkxleywOwBMIW0zlKwgXiRKaihTWrU/b5uK3oQI
 oMPOi1hr66CdIdGsJT2MTRRcliIwPwUqZv7soFY=
X-Google-Smtp-Source: ADFU+vuzrz2QPphdzxVvokrYH4Ymuld6mMemhNETte1jxXUy/0j4P6gcl81NV1PVzu2A1C9Q8YhL7DIJ5LkAtU7Kul0=
X-Received: by 2002:a67:902:: with SMTP id 2mr10806073vsj.133.1584129660688;
 Fri, 13 Mar 2020 13:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200313193429.8035-1-coreyw7@fb.com>
 <20200313193429.8035-3-coreyw7@fb.com>
In-Reply-To: <20200313193429.8035-3-coreyw7@fb.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2020 13:00:34 -0700
Message-ID: <CAKmqyKPdujwuRveOCc2no50r2fYzmVNE2WNqcyYfe6mgvRs2+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Add a sifive-e34 cpu type
To: Corey Wharton <coreyw7@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 12:37 PM Corey Wharton <coreyw7@fb.com> wrote:
>
> The sifive-e34 cpu type is the same as the sifive-e31 with the
> single precision floating-point extension enabled.
>
> Signed-off-by: Corey Wharton <coreyw7@fb.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2: Added missing RVU flag
>
>  target/riscv/cpu.c | 10 ++++++++++
>  target/riscv/cpu.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c0b7023100..1ae9d085b8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -164,6 +164,15 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>      set_feature(env, RISCV_FEATURE_PMP);
>  }
>
> +static void rv32imafcu_nommu_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
> +    set_priv_version(env, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_PMP);
> +}
> +
>  #elif defined(TARGET_RISCV64)
>
>  static void riscv_base64_cpu_init(Object *obj)
> @@ -609,6 +618,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  #if defined(TARGET_RISCV32)
>      DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
>      /* Depreacted */
>      DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3dcdf92227..ae5a1d9dce 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -36,6 +36,7 @@
>  #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>  #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
> +#define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
>  #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
>  #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
>  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
> --
> 2.21.1
>
>

