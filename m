Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C61C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8C821744
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="6teXEMF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8C821744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQFbq-0002Ly-Rb
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 15:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51012 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFZN-0001Ww-O6
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:25:34 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFZM-0006q6-Ly
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:25:33 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40458)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jQFZL-0006fk-O6
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:25:32 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 8594F96EF2;
 Sun, 19 Apr 2020 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1587324329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcFnei8ljT+Hz5ch3N37u2HujLaaWJ/ysdO/xE8tZmA=;
 b=6teXEMF9Fj4pAKMvaXRmkgcFPYWHUW65ub8yXLcFv2VyrOIuHXnvmyRwpTvcbKx4XetZ9T
 mFMNtIwWUtDclu9BkUJuH6pRaVh3lOg5hFu4Tis8hD39MDGxXn21KZloFUSj8FaoX3YQtj
 1k7vCUBBcH/vJ+jm5pn+EXNYW2ucuHc=
Subject: Re: [PATCH v1 3/6] target/microblaze: Add the div-zero-exception
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-4-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <ec41d1a0-10d1-0c37-9e71-32103f9d6b1e@greensocs.com>
Date: Sun, 19 Apr 2020 21:25:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417191022.5247-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1587324329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcFnei8ljT+Hz5ch3N37u2HujLaaWJ/ysdO/xE8tZmA=;
 b=ylkLX/shTy2A03XvQbLgteNl5BN49GnVOa2IwozV0ZGej1UE/ana2zSK0DjsrgRQH960Uf
 LlvGOLiZPGKaAd4ONmAPgghVfcXaH9JJD38a3PNArvzm3SaKnO+RKWw53TlA/seKzHi9M0
 WI0qm99GMeM/p6ohj00hzAaIbQ4R+yY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1587324329; a=rsa-sha256; cv=none;
 b=CIHzFns+uuqHvzBvaYWgf5UtGzrJgP81Y5rTkiS7Pt+2pvhxapMOCfxNJmbHEnKIQGZIH1
 e3T2BjzkV194z4He042gEV4jaeYisnbs+4wKiCcdpfsGfUWUkLZNP7SOojAf4ucht9tDER
 8anJUFZOvHEn2I3eN//ZoW/lV31o2Ds=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs1p.gnu.org: Linux 3.11 and newer
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

On 4/17/20 9:10 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add the div-zero-exception property to control if the core
> traps divizions by zero.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.c       | 2 ++
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/op_helper.c | 5 +++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 36c20d9724..7a40e2fbad 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -280,6 +280,8 @@ static Property mb_properties[] = {
>                       cfg.iopb_bus_exception, false),
>      DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
>                       cfg.illegal_opcode_exception, false),
> +    DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
> +                     cfg.div_zero_exception, false),
>      DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
>                       cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 71d7317a58..3c07f9b3f7 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -305,6 +305,7 @@ struct MicroBlazeCPU {
>          bool iopb_bus_exception;
>          bool illegal_opcode_exception;
>          bool opcode_0_illegal;
> +        bool div_zero_exception;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 18677ddfca..f3b17a95b3 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -132,11 +132,12 @@ uint32_t helper_carry(uint32_t a, uint32_t b, uint32_t cf)
>  
>  static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
>  {
> +    MicroBlazeCPU *cpu = env_archcpu(env);
> +
>      if (b == 0) {
>          env->sregs[SR_MSR] |= MSR_DZ;
>  
> -        if ((env->sregs[SR_MSR] & MSR_EE)
> -            && !(env->pvr.regs[2] & PVR2_DIV_ZERO_EXC_MASK)) {
> +        if ((env->sregs[SR_MSR] & MSR_EE) && cpu->cfg.div_zero_exception) {
>              env->sregs[SR_ESR] = ESR_EC_DIVZERO;
>              helper_raise_exception(env, EXCP_HW_EXCP);
>          }
> 

I don't know the Microblaze but don't you need to set pvr.regs[2] in
mb_cpu_realizefn as you do in previous patches?

Something like:

env->pvr.regs[2] |=
                    ...
                    (cpu->cfg.div_zero_exception ?
                         PVR2_DIV_ZERO_EXC_MASK : 0) |
                    ...
-- 
Luc

