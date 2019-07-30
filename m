Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F0BC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5932087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="se3lhPTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5932087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsc1s-0006mU-BH
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35103)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hsc1U-0006MK-I9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hsc1T-00019H-BV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:59:16 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hsc1T-00016I-01
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:59:15 -0400
Received: by mail-lf1-x141.google.com with SMTP id z15so41751681lfh.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8ZFMaAAqODuPDpCUuDoy5gYJ4VcvCYwrP1IIPVEHIS0=;
 b=se3lhPTvG3R/EMLwsQ+10hQhyos5oCPj7UzHcAdhAJmOYaV2MRBNKCys+06djOsCUz
 rId5oBKc9F6Fvq03GAoivHVwPaNgbRLSLR02BfT5R6x53aISTFqvgz6Wf5Q+w/0iFNGr
 z61QNN1nZXP4TnfXFtK8tMpHBkrxaTXXrE6Ffzi8l0SkU8adMHi413gTAwQ9Z7hR91Lj
 Z0RnnCj8Mq4j672MSmsrYcfgQIUevPlfKENd0iWql9onV/R3508+DOOOL+rgTlBGZNo6
 sSv+tZZtjurGUz9brwPqglLL9s+1kOZdU3zUY6AZBRCiobWBJEMWzSczx6cvYU+TZLsX
 ErMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8ZFMaAAqODuPDpCUuDoy5gYJ4VcvCYwrP1IIPVEHIS0=;
 b=r8NoetazwN4hUEh7o8bJFzRuPhAFWtmGbl5xGnlU2Q5PMMmff6Q05fpEKggvNaenQw
 +D4yKAZy0qK6pXh5RIOohJHjv6k4uiIqH8zMikmt8l1UYRs8BuddD2U7AwLNiOaTW08l
 X9z6ww4GYP7roFc+iyW9ydzbQPjFSnHVFKupW6FvcSvRy3yDqHaF+11LCC3MRbfVt5+t
 7FC7gHGcW7XQxhfrngHRyjUe1EHDG6j8J9pyz2857g2KijepKWYq2Fu8l4I+x2rjOo9n
 bwzQfDv5zYwGHLeJBEu02+hJ0PxLtXNtb8bPKVsNh6QRvdIEqjD+H/mU3bfqQVCgnQWA
 nFTQ==
X-Gm-Message-State: APjAAAUyKX31/jINHoaqE8/Lppbg+4F3ulANnoSZhyy8ktRToOz+p+Xn
 CxT3gh6IQ86EX6Z8916cmMdGXAFUVlESH1s5R5Q=
X-Google-Smtp-Source: APXvYqxsRejNbONWuibEpW9AXKqQAoIq2frInITRoZ3UGnQOKeH79rGzf5kdrUW7NXTY7wDPtcEzfaeDLt6q2dfjEjs=
X-Received: by 2002:a19:6904:: with SMTP id e4mr37485400lfc.156.1564531153276; 
 Tue, 30 Jul 2019 16:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <F94AE129-7994-48B1-8215-EF429990C512@espressif.com>
In-Reply-To: <F94AE129-7994-48B1-8215-EF429990C512@espressif.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jul 2019 16:55:39 -0700
Message-ID: <CAKmqyKMwm_-HK4=Yq8UiZW-NCE=7V1PL1ZkwCNZawQbc0dLzjw@mail.gmail.com>
To: Ivan Grokhotkov <ivan@espressif.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH] target/riscv: don't overwrite priv_version
 and resetvec when realizing
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 6:22 AM Ivan Grokhotkov <ivan@espressif.com> wrote:
>
> CPU-specific init functions (riscv_*_cpu_init) configure members of
> CPURISCVState, such as priv_version and resetvec. However
> riscv_cpu_realize unconditionally overwrites these members. The
> result is that some CPUs (such as CPU_SIFIVE_U34) are getting created
> with incorrect priv_version.
>
> Only set priv_version in riscv_cpu_realize if priv_spec property was
> set. Don't set resetvec in riscv_cpu_realize, rely on the init
> function to set it. Set default priv_version and resetvec in init
> functions where this was missing.
>
> Signed-off-by: Ivan Grokhotkov <ivan@espressif.com>
> ---
> target/riscv/cpu.c | 12 +++++++-----
> target/riscv/cpu.h |  1 +
> 2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd20a..cded5bac22 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -110,7 +110,7 @@ static void riscv_any_cpu_init(Object *obj)
> {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
> -    set_priv_version(env, PRIV_VERSION_1_11_0);
> +    set_priv_version(env, PRIV_VERSION_DEFAULT);
>      set_resetvec(env, DEFAULT_RSTVEC);
> }
>
> @@ -119,6 +119,8 @@ static void riscv_any_cpu_init(Object *obj)
> static void riscv_base32_cpu_init(Object *obj)
> {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> +    set_priv_version(env, PRIV_VERSION_DEFAULT);
> +       set_resetvec(env, DEFAULT_RSTVEC);

Your indentation seems off (and in some other places as well).

Otherwise this patch looks fine.

Alistair

>      /* We set this in the realise function */
>      set_misa(env, 0);
> }
> @@ -157,6 +159,8 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
> static void riscv_base64_cpu_init(Object *obj)
> {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> +    set_priv_version(env, PRIV_VERSION_DEFAULT);
> +       set_resetvec(env, DEFAULT_RSTVEC);
>      /* We set this in the realise function */
>      set_misa(env, 0);
> }
> @@ -316,7 +320,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error=
 **errp)
>      RISCVCPU *cpu =3D RISCV_CPU(dev);
>      CPURISCVState *env =3D &cpu->env;
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(dev);
> -    int priv_version =3D PRIV_VERSION_1_11_0;
> +    int priv_version =3D PRIV_VERSION_DEFAULT;
>      target_ulong target_misa =3D 0;
>      Error *local_err =3D NULL;
>
> @@ -339,11 +343,9 @@ static void riscv_cpu_realize(DeviceState *dev, Erro=
r **errp)
>                         cpu->cfg.priv_spec);
>              return;
>          }
> +        set_priv_version(env, priv_version);
>      }
>
> -    set_priv_version(env, priv_version);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> -
>      if (cpu->cfg.mmu) {
>          set_feature(env, RISCV_FEATURE_MMU);
>      }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f32..88a52a1c8c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -81,6 +81,7 @@ enum {
> #define PRIV_VERSION_1_09_1 0x00010901
> #define PRIV_VERSION_1_10_0 0x00011000
> #define PRIV_VERSION_1_11_0 0x00011100
> +#define PRIV_VERSION_DEFAULT PRIV_VERSION_1_11_0
>
> #define TRANSLATE_PMP_FAIL 2
> #define TRANSLATE_FAIL 1
> --
> 2.20.1 (Apple Git-117)
>
> I couldn=E2=80=99t find an existing place where a unit test for correct p=
riv_version could be added, but would be happy to do so if poked in the rig=
ht direction. Thanks.
>
> ---
> Best regards,
> Ivan Grokhotkov
>
>
>

