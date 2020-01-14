Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C3CC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C90207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTYAh4n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C90207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irA6w-0004OP-0M
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 19:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irA68-0003mu-Ho
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irA65-00059c-Bl
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:30:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irA65-000580-5S
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578961815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7unlg0kc2Y0bptR3qOcJ4HEqkc5Dm+tlK8rE7rbb3I=;
 b=YTYAh4n52zJJE7MVsaH3DdKYN2ogwbcS4klOnejw+wurf6VwDxhmZ58XzGUECu4RHGg7Rb
 L9zuNL2FBv4P9KZ2Fo4DyDRQ1b4mmMbhNTDDPxAw/d71B9YdPBldAPseaZVtOSY1nQehk9
 LOGW7MwEf1oxN0pxFIyqSXrv4IvY6kM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-F4uc5XRHPUqUMsstcrEp5A-1; Mon, 13 Jan 2020 19:30:14 -0500
Received: by mail-wr1-f72.google.com with SMTP id k18so5777850wrw.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 16:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pMzxAAkkMHTLKF+XPxF0gjlIftuAcZQ1XoyhG2QXeP4=;
 b=ij02PbXPaLAjUvPn80iE0VxoV5KzvrO06+BFeEoSR4nQMbrtiFQLM3j2z8uWzn1KC/
 RMfv7blhmV4xx+t3k9wlpQiEu7lilVsjy+j9vJmHP5qPSmvW1GnkXL4L81Be49k9026z
 IWAOBYWffRYlW1qzyXxIXmJtRUOTfm4A2GtPknKwWWKCxQtNC0pzt4+bgdiSZdBW8E55
 TJdNXegCgz1XPynNWqBGiADeRbTPUm1r6ciO/FdDwOuGxUDlF7SHiondAMXcULh8UbSq
 wVso7WaKNPhtj9+y9I0MafSCvbQb772VgBpuhK4Li17/RYxuCgBHNl4mDYh47kDD3AnC
 Bpeg==
X-Gm-Message-State: APjAAAXMAOOo7cndfDyzaF9rP6kS8wrEAlUXKDDfyXAJclMTbYKWeg9P
 3XXpuYr9FnQYDE4hxnr7KNI8qgDZ/u08gmibqwmTVhivpc3TAvCTxpWGmuUMiJ2clzDLbB6n6ke
 Ctc601uAUzvqjr28=
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr22715032wml.18.1578961813225; 
 Mon, 13 Jan 2020 16:30:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTM3PvuL27m0lnED1b3ymFxg4zaiSrkUJCx8otkjib/zqvDb/PuZ31RUsR4dr00hopOSus2g==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr22715012wml.18.1578961812931; 
 Mon, 13 Jan 2020 16:30:12 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id w22sm15684946wmk.34.2020.01.13.16.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 16:30:12 -0800 (PST)
Subject: Re: [PATCH 4/7] target/ppc: Add SPR TBU40
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191128134700.16091-1-clg@kaod.org>
 <20191128134700.16091-5-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4bdcca41-14e7-24c0-8e65-b711c032e0f7@redhat.com>
Date: Tue, 14 Jan 2020 01:30:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128134700.16091-5-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: F4uc5XRHPUqUMsstcrEp5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/19 2:46 PM, C=C3=A9dric Le Goater wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> The spr TBU40 is used to set the upper 40 bits of the timebase
> register, present on POWER5+ and later processors.
>=20
> This register can only be written by the hypervisor, and cannot be read.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   target/ppc/cpu.h                |  1 +
>   target/ppc/helper.h             |  1 +
>   hw/ppc/ppc.c                    | 13 +++++++++++++
>   target/ppc/timebase_helper.c    |  5 +++++
>   target/ppc/translate_init.inc.c | 19 +++++++++++++++++++
>   5 files changed, 39 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 646a94370dba..8ffcfa0ea162 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1312,6 +1312,7 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env);
>   void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value);
>   target_ulong cpu_ppc_load_hdecr(CPUPPCState *env);
>   void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
> +void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
>   uint64_t cpu_ppc_load_purr(CPUPPCState *env);
>   void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
>   uint32_t cpu_ppc601_load_rtcl(CPUPPCState *env);
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 356a14d8a639..cd0dfe383a2a 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -672,6 +672,7 @@ DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void,=
 env, tl)
>   DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
>   DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
>   DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
> +DEF_HELPER_FLAGS_2(store_tbu40, TCG_CALL_NO_RWG, void, env, tl)
>   DEF_HELPER_2(store_hid0_601, void, env, tl)
>   DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
>   DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 353f11b91d40..3666e58865b3 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -710,6 +710,19 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t va=
lue)
>                        &tb_env->vtb_offset, value);
>   }
>  =20
> +void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
> +{
> +    ppc_tb_t *tb_env =3D env->tb_env;
> +    uint64_t tb;
> +
> +    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                        tb_env->tb_offset);
> +    tb &=3D 0xFFFFFFUL;
> +    tb |=3D (value & ~0xFFFFFFUL);

IMHO easier to review as:

        tb =3D deposit64(value, 0, 40, tb);

> +    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                     &tb_env->tb_offset, tb);
> +}
> +
>   static void cpu_ppc_tb_stop (CPUPPCState *env)
>   {
>       ppc_tb_t *tb_env =3D env->tb_env;
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 2395295b778c..703bd9ed18b9 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -128,6 +128,11 @@ void helper_store_vtb(CPUPPCState *env, target_ulong=
 val)
>       cpu_ppc_store_vtb(env, val);
>   }
>  =20
> +void helper_store_tbu40(CPUPPCState *env, target_ulong val)
> +{
> +    cpu_ppc_store_tbu40(env, val);
> +}
> +
>   target_ulong helper_load_40x_pit(CPUPPCState *env)
>   {
>       return load_40x_pit(env);
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index a3cf1d8a450c..9815df6f77c8 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -327,6 +327,11 @@ static void spr_write_vtb(DisasContext *ctx, int spr=
n, int gprn)
>       gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
>   }
>  =20
> +static void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
> +}
> +
>   #endif
>   #endif
>  =20
> @@ -7848,6 +7853,16 @@ static void gen_spr_power5p_ear(CPUPPCState *env)
>                    0x00000000);
>   }
>  =20
> +static void gen_spr_power5p_tb(CPUPPCState *env)
> +{
> +    /* TBU40 (High 40 bits of the Timebase register */
> +    spr_register_hv(env, SPR_TBU40, "TBU40",
> +                    SPR_NOACCESS, SPR_NOACCESS,
> +                    SPR_NOACCESS, SPR_NOACCESS,
> +                    SPR_NOACCESS, &spr_write_tbu40,
> +                    0x00000000);
> +}
> +
>   #if !defined(CONFIG_USER_ONLY)
>   static void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
>   {
> @@ -8399,6 +8414,7 @@ static void init_proc_power5plus(CPUPPCState *env)
>       gen_spr_power5p_common(env);
>       gen_spr_power5p_lpar(env);
>       gen_spr_power5p_ear(env);
> +    gen_spr_power5p_tb(env);
>  =20
>       /* env variables */
>       env->dcache_line_size =3D 128;
> @@ -8511,6 +8527,7 @@ static void init_proc_POWER7(CPUPPCState *env)
>       gen_spr_power5p_common(env);
>       gen_spr_power5p_lpar(env);
>       gen_spr_power5p_ear(env);
> +    gen_spr_power5p_tb(env);
>       gen_spr_power6_common(env);
>       gen_spr_power6_dbg(env);
>       gen_spr_power7_book4(env);
> @@ -8652,6 +8669,7 @@ static void init_proc_POWER8(CPUPPCState *env)
>       gen_spr_power5p_common(env);
>       gen_spr_power5p_lpar(env);
>       gen_spr_power5p_ear(env);
> +    gen_spr_power5p_tb(env);
>       gen_spr_power6_common(env);
>       gen_spr_power6_dbg(env);
>       gen_spr_power8_tce_address_control(env);
> @@ -8842,6 +8860,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>       gen_spr_power5p_common(env);
>       gen_spr_power5p_lpar(env);
>       gen_spr_power5p_ear(env);
> +    gen_spr_power5p_tb(env);
>       gen_spr_power6_common(env);
>       gen_spr_power6_dbg(env);
>       gen_spr_power8_tce_address_control(env);
>=20


