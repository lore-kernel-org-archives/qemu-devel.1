Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF2C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6902173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n326L2RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6902173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4BZz-0000dr-OK
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j4BYy-000059-UH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j4BYx-0003nC-AF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:41:56 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j4BYx-0003kO-1P; Tue, 18 Feb 2020 17:41:55 -0500
Received: by mail-lj1-x244.google.com with SMTP id a13so24888982ljm.10;
 Tue, 18 Feb 2020 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QuKvaVnrUysWMIbGL23jrhUN+9Nh6y0irw4MyiCGRM4=;
 b=n326L2RDS8b9xspWS8nfAkJBts2KhF07nHk9/tB/Rs/Z0mPhM1jjwfxMkMidZVefqp
 2koNMdPvsWsIyK5pBccRNlD7GoS0qM3LXB/fEMC/oH+njl1Wa3NcqSYHk2JLnAyDmZ9z
 0RNooZ8Bey1KbXFXPkhD59B5ufCwdPwqJJRH0KySNbTVLqjIIuIgoDplCzVP7248qPcA
 koCx3wRsNAuSowSWAbj10LCVWXZ3PNF6v4u9p3p49pAbaomT/2iCcYfE540zt5BGjWBb
 jikosUjLv0v2+aSky/FC7OB7bdRLOi/1sdtb7hfCy+VxNccZLmj6UfrlxCBSeBga8h2y
 65Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QuKvaVnrUysWMIbGL23jrhUN+9Nh6y0irw4MyiCGRM4=;
 b=Nz/JGMs6flKX6kiNx7FpqAlsUNOjkqgSEx+N9GctJGJlDDMjVnfmsOVJDkD6xuIsCM
 NfmLNj5cNvrGBaxj3YMsZ1MYsfP7o2/dvm6bUxzBzFxg61wXWGr21BhUfiPwcAgo4E08
 HMzNjzW+FXH0RskeWPBQ4HaRun+g+j52zvzBz3PoAdx/jEBOplp4RlvoVBZnjWLGgd9s
 jyyQgwjwAaBSlSl5NwNZ3ywE4TK9WeoZQkdZBiD9DbcaoKAFYOtWPF4yC5Heprv+Iv8a
 5C1BoJ9/9vlG5tPtWE1tiv/DIcaP2NH1Nd9W/lCar/7BDWkaCVqPBhsvC6mpYk5iAvdq
 se+g==
X-Gm-Message-State: APjAAAXhe2KBzDEMjTM+W6KrGp13NE1Mv5djiOTxxmQVy9qMd5GAeyNv
 dykJ2o43UwAUQ9ziHDmJINTbC1Fc25c30kVVWvo=
X-Google-Smtp-Source: APXvYqycpNodkOUgAT4ZJwG6MZqNkl8kOax61OBeNcrvGoCX9eAQwRdA/3ZPEoFcNP+54jEjs1hkXGdtf0onwvF6Tgc=
X-Received: by 2002:a2e:8197:: with SMTP id e23mr13351957ljg.250.1582065713559; 
 Tue, 18 Feb 2020 14:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-3-zhiwei_liu@c-sky.com>
In-Reply-To: <20200210081240.11481-3-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Feb 2020 14:34:27 -0800
Message-ID: <CAKmqyKORm9dfkgSOe0WR1aDBzJyMq9YP9+bBPwkeX2J2jYmLAg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] target/riscv: configure and turn on vector
 extension from command line
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

On Mon, Feb 10, 2020 at 12:12 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Vector extension is default on only for "any" cpu. It can be turned
> on by command line "-cpu rv64,v=true,vlen=128,elen=64,vext_spec=v0.7.1".
>
> vlen is the vector register length, default value is 128 bit.
> elen is the max operator size in bits, default value is 64 bit.
> vext_spec is the vector specification version, default value is v0.7.1.
> Thest properties and cpu can be specified with other values.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

This looks fine to me. Shouldn't this be the last patch though? As in
once the vector extension has been added to QEMU you can turn it on
from the command line. Right now this turns it on but it isn't
implemented.

Alistair

> ---
>  target/riscv/cpu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++--
>  target/riscv/cpu.h |  8 ++++++++
>  2 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8c86ebc109..95fdb6261e 100644
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
> @@ -113,7 +118,7 @@ static void set_resetvec(CPURISCVState *env, int resetvec)
>  static void riscv_any_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
> +    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU | RVV);
>      set_priv_version(env, PRIV_VERSION_1_11_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
>  }
> @@ -320,6 +325,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      CPURISCVState *env = &cpu->env;
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>      int priv_version = PRIV_VERSION_1_11_0;
> +    int vext_version = VEXT_VERSION_0_07_1;
>      target_ulong target_misa = 0;
>      Error *local_err = NULL;
>
> @@ -343,8 +349,18 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>      }
> -
> +    if (cpu->cfg.vext_spec) {
> +        if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
> +            vext_version = VEXT_VERSION_0_07_1;
> +        } else {
> +            error_setg(errp,
> +                       "Unsupported vector spec version '%s'",
> +                       cpu->cfg.vext_spec);
> +            return;
> +        }
> +    }
>      set_priv_version(env, priv_version);
> +    set_vext_version(env, vext_version);
>      set_resetvec(env, DEFAULT_RSTVEC);
>
>      if (cpu->cfg.mmu) {
> @@ -409,6 +425,30 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          if (cpu->cfg.ext_u) {
>              target_misa |= RVU;
>          }
> +        if (cpu->cfg.ext_v) {
> +            target_misa |= RVV;
> +            if (!is_power_of_2(cpu->cfg.vlen)) {
> +                error_setg(errp,
> +                       "Vector extension VLEN must be power of 2");
> +                return;
> +            }
> +            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
> +                error_setg(errp,
> +                       "Vector extension implementation only supports VLEN "
> +                       "in the range [128, %d]", RV_VLEN_MAX);
> +                return;
> +            }
> +            if (!is_power_of_2(cpu->cfg.elen)) {
> +                error_setg(errp,
> +                       "Vector extension ELEN must be power of 2");
> +                return;
> +            }
> +            if (cpu->cfg.elen > 64) {
> +                error_setg(errp,
> +                       "Vector extension ELEN must <= 64");
> +                return;
> +            }
> +        }
>
>          set_misa(env, RVXLEN | target_misa);
>      }
> @@ -444,10 +484,14 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
>      DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
> +    DEFINE_PROP_BOOL("v", RISCVCPU, cfg.ext_v, false),
>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>      DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
>      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
> +    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
> +    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
> +    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
>      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>      DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 07e63016a7..bf2b4b55af 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -64,6 +64,7 @@
>  #define RVA RV('A')
>  #define RVF RV('F')
>  #define RVD RV('D')
> +#define RVV RV('V')
>  #define RVC RV('C')
>  #define RVS RV('S')
>  #define RVU RV('U')
> @@ -82,6 +83,8 @@ enum {
>  #define PRIV_VERSION_1_10_0 0x00011000
>  #define PRIV_VERSION_1_11_0 0x00011100
>
> +#define VEXT_VERSION_0_07_1 0x00000701
> +
>  #define TRANSLATE_PMP_FAIL 2
>  #define TRANSLATE_FAIL 1
>  #define TRANSLATE_SUCCESS 0
> @@ -118,6 +121,7 @@ struct CPURISCVState {
>      target_ulong badaddr;
>
>      target_ulong priv_ver;
> +    target_ulong vext_ver;
>      target_ulong misa;
>      target_ulong misa_mask;
>
> @@ -226,12 +230,16 @@ typedef struct RISCVCPU {
>          bool ext_c;
>          bool ext_s;
>          bool ext_u;
> +        bool ext_v;
>          bool ext_counters;
>          bool ext_ifencei;
>          bool ext_icsr;
>
>          char *priv_spec;
>          char *user_spec;
> +        char *vext_spec;
> +        uint16_t vlen;
> +        uint16_t elen;
>          bool mmu;
>          bool pmp;
>      } cfg;
> --
> 2.23.0
>

