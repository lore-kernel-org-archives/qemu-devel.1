Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502F8C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F46206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt/P5Ove"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F46206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSpe-00068M-U9
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jTSjs-0000Av-9o
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jTSgM-0001w7-Dk
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:05:39 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:37717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jTSgL-0001qy-SV; Tue, 28 Apr 2020 12:02:01 -0400
Received: by mail-io1-xd44.google.com with SMTP id u11so23551836iow.4;
 Tue, 28 Apr 2020 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o7CLS2y7/WQHEF/89+BpyFTtr4utuBXWVE2QAB0qk4A=;
 b=Kt/P5Ovem2Wk69TEcISMIDQl6aNnYFeKfiARdndnDAjhWefI4Z2hkV4Oev89Sm8JN1
 modHQXTfyI8F349GfFYlNtAC9dZ+WbqnyLljHUTJMt+qrteD4bn22//JgUNWYiwa6gTv
 z+wCiFeI3BV/GUbUzgReguNFBWwNmqWILy99SiYY2BilgY0SclTNWrjTNkJ3CT/oHBe+
 VQBYLfCw3FwOnKcF+rI10jI2f/aBg6Zb2B16kRVjFz+ac12rAMbkdvMPO/B99pmJz5RC
 G6BKslfCS39Jcuu9Xq5Af7lwNAjyNHy2vqfZmsAm7PVYgpepdabArCA0hoCGyQF/QnHJ
 mA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o7CLS2y7/WQHEF/89+BpyFTtr4utuBXWVE2QAB0qk4A=;
 b=eRVKTZCvL0WbtIqG9y2NrylYIehiCrgtrDAYF5grDeW0+kgRhkcyT4raBF9lYCJN0v
 xbwFra733XvwHz3uhfoJ84rLG7SyiUG+3RJd8JwevAwr2k764nE5VgbkZUD0vxF5taln
 h9EmUjB3ITUqljkrl+bbWSDImpgQypMkbO/0S8o3Ba61t34xQX2ARs8y+J5yRYSdeI2y
 PaFD8JUUu+II5M+urQCF9WHEvpZALArU5szNuitVky8rFYwvIDmvrNf1GKWUdhxuWDFF
 amo0KJBuFlgkrblSFvp/17EeZoE4Qis+6RhxV/qulJegbewZVRkrYN35bxoIb0P7Hp3b
 OJLQ==
X-Gm-Message-State: AGi0PuY7DT0QeQepBIA06U/tzVxRq5iIkScHN8tlvJ5EEPgnJMSkgB5J
 kusJ91HDWqPAY4moPgovdS3Dyn1xv1doLdebeVg=
X-Google-Smtp-Source: APiQypJ16mwEAASRoKGF7u6+lDV9nkzWh637T/+EiKkDxFYdlY5SiqCbLpeBKUEjruellKCy46x56S8nudFUFJubo0M=
X-Received: by 2002:a5d:950d:: with SMTP id d13mr26148288iom.136.1588089719960; 
 Tue, 28 Apr 2020 09:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200428155005.25537-1-f4bug@amsat.org>
In-Reply-To: <20200428155005.25537-1-f4bug@amsat.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 28 Apr 2020 18:01:48 +0200
Message-ID: <CABoDooMPjE7si-RR8wqOZ_EDkb_Sid-PjXP2wEP716di1tcezg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Use correct variable for setting 'max'
 cpu's MIDR_EL1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 5:50 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> MIDR_EL1 a 64-bit system register with the top 32-bit being RES0.
>
> This fixes when compiling with -Werror=3Dconversion:
>
>   target/arm/cpu64.c: In function =E2=80=98aarch64_max_initfn=E2=80=99:
>   target/arm/cpu64.c:628:21: error: conversion from =E2=80=98uint64_t=E2=
=80=99 {aka =E2=80=98long unsigned int=E2=80=99} to =E2=80=98uint32_t=E2=80=
=99 {aka =E2=80=98unsigned int=E2=80=99} may change value [-Werror=3Dconver=
sion]
>     628 |         cpu->midr =3D t;
>         |                     ^
>
> Suggested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I suppose cp15.c0_cpuid register in target/arm/cpu.h as uint32_t is OK.
>
> Since v1: Follow Laurent and Peter suggestion.
> ---
>  target/arm/cpu.h | 3 ++-
>  target/arm/cpu.c | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8b9f2961ba..4d1be56df9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -894,7 +894,7 @@ struct ARMCPU {
>          uint64_t id_aa64dfr0;
>          uint64_t id_aa64dfr1;
>      } isar;
> -    uint32_t midr;
> +    uint64_t midr;
>      uint32_t revidr;
>      uint32_t reset_fpsid;
>      uint32_t ctr;
> @@ -1685,6 +1685,7 @@ FIELD(MIDR_EL1, PARTNUM, 4, 12)
>  FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
>  FIELD(MIDR_EL1, VARIANT, 20, 4)
>  FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
> +FIELD(MIDR_EL1, RESERVED, 32, 32)

If you follow Peter advice to not check these 32-bits, you could
remove that field definition and if you keep it please rename it RES0
:-).

Thanks,

Laurent

>
>  FIELD(ID_ISAR0, SWAP, 0, 4)
>  FIELD(ID_ISAR0, BITCOUNT, 4, 4)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a79f233b17..aaa48e06ac 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1182,6 +1182,8 @@ void arm_cpu_post_init(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
>
> +    assert(FIELD_EX64(cpu->midr, MIDR_EL1, RESERVED) =3D=3D 0);
> +
>      /* M profile implies PMSA. We have to do this here rather than
>       * in realize with the other feature-implication checks because
>       * we look at the PMSA bit to see if we should add some properties.
> @@ -2757,7 +2759,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>  static Property arm_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, fal=
se),
>      DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
> -    DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
> +    DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
>      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                          mp_affinity, ARM64_AFFINITY_INVALID),
>      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID=
),
> --
> 2.21.1
>

