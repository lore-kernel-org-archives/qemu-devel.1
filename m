Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB85C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB5621556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOQyY30z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB5621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YFW-0001MW-Ug
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YCs-0007xe-EY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YCo-00074T-MV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:16:54 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6YCo-000721-Gs
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:16:50 -0500
Received: by mail-ot1-x343.google.com with SMTP id r16so11741221otd.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JVBTg1kYJiZtDEsHxQmdYhgc7E08qi8Vmk9K+xag6R0=;
 b=ZOQyY30zFUEgzJVWXYAIMOJgtV4P4QHbzhzE3v+f4YZyuIOnKejUyfo+4tPCCKAvXN
 2SG6C9vNDzveHs/zP6HXYWK5CMyyMasJVYPRzTvvy2FXp6jj2lJAUyHTv6A0nR1Qa3Qw
 vfs/bzlESpCdx26adraVxF9Rnd61Ovh+LeG9PzjdML0gRSwOX3xprpTaqlSK4HmqG6uT
 nNJr/bPegJ4FdYzSXTQUMJ+adcytwA1rZS58J31IaY8w+jrq5xYG6fPdvaHvdii+faSs
 5MwkGkwC1YZXUbkQZhk2Mqj+R3McQ9Fccw6bCjj/86l0wl8RYuijsRkTdUxe/i75BY7k
 8iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JVBTg1kYJiZtDEsHxQmdYhgc7E08qi8Vmk9K+xag6R0=;
 b=J/EcnaVY7TnlhwcU//DeYrgQdFKBkRaRJOB/wFASZcLvCRqOtyLnsj6esIikcfTu83
 jfgagfQXrGcI6o5J2Le9rBg55b05eBnTkdY5aQ1puPj8N8L8JGDI2DDlgSxoooF2KzFg
 OHOxe7/x5iqzJdwWVQysV/MvSQP3odwItUBMzfk31+2UZuuhxmkpZzdKX++VweH3sWcU
 tfhXU5dr23qalQYW3Ugkdp5e9nWuZbYt1bN+K68d18q7hfnCQDvZ8Cxur4A+vU3gabRy
 ZNZCkxf+1f4wgFoV0+f9d9VfDE9oaqMd5MnPvqPHeLYbNyjB2ttrSxl5I/x9JxO7MxFn
 hywQ==
X-Gm-Message-State: APjAAAV+YawQKJueb0GAUNdhNGPMBt+QVdoX2ouSO8XI0Q880roPkX0u
 zEsz0E8ASgWv3gWFfOhYQB0reyu69r3rGKxtj2E/cA==
X-Google-Smtp-Source: APXvYqyeDWb4cppy2QBvUdbChLnb8jgNXeUsTBP3NVlogzjG/9Et0KNRKMsaFacl1JdWBQ64jrazEDItx6Xb0qq2CN4=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr42061915otq.221.1582629409417; 
 Tue, 25 Feb 2020 03:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20200223231044.8003-1-philmd@redhat.com>
 <20200223231044.8003-3-philmd@redhat.com>
In-Reply-To: <20200223231044.8003-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 11:16:38 +0000
Message-ID: <CAFEAcA8MSO4YMEq2FqvpJKUVYE_1CqaB2KLD1YN-YebOhJVgEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/gumstix: Use the IEC binary prefix definitions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 23 Feb 2020 at 23:10, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> IEC binary prefixes ease code review: the unit is explicit.
>
> Add a comment describing the Connex uses a Numonyx RC28F128J3F75
> flash, and the Verdex uses a Micron RC28F256P30TFA.
>
> Correct the Verdex machine description (we model the 'Pro' board).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This patch is doing somewhat more than the commit Subject line
suggests. I don't think it's particularly strongly in need
of splitting into more patches, but could you make the
subject line a bit closer to what the patch is doing?

> ---
>  hw/arm/gumstix.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
> index 94904d717b..ca918fda0c 100644
> --- a/hw/arm/gumstix.c
> +++ b/hw/arm/gumstix.c
> @@ -35,6 +35,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "hw/arm/pxa.h"
>  #include "net/net.h"
> @@ -45,18 +46,14 @@
>  #include "sysemu/qtest.h"
>  #include "cpu.h"
>
> -static const int sector_len =3D 128 * 1024;
> +static const int sector_len =3D 128 * KiB;
>
>  static void connex_init(MachineState *machine)
>  {
>      PXA2xxState *cpu;
>      DriveInfo *dinfo;
> -    MemoryRegion *address_space_mem =3D get_system_memory();
>
> -    uint32_t connex_rom =3D 0x01000000;
> -    uint32_t connex_ram =3D 0x04000000;
> -
> -    cpu =3D pxa255_init(address_space_mem, connex_ram);
> +    cpu =3D pxa255_init(get_system_memory(), 64 * MiB);
>
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      if (!dinfo && !qtest_enabled()) {
> @@ -65,7 +62,8 @@ static void connex_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
> +    /* Numonyx RC28F128J3F75 */
> +    if (!pflash_cfi01_register(0x00000000, "connext.rom", 16 * MiB,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
>                                 sector_len, 2, 0, 0, 0, 0, 0)) {
>          error_report("Error registering flash memory");

Previously the variable names were helpfully acting as a
bit of documentation of what the 64MB and 16MB things were.
Perhaps we could instead have

#define CONNEX_ROM_SIZE (16 * MiB)
#define CONNEX_RAM_SIZE (64 * MiB)

and then use those?

> @@ -81,12 +79,8 @@ static void verdex_init(MachineState *machine)
>  {
>      PXA2xxState *cpu;
>      DriveInfo *dinfo;
> -    MemoryRegion *address_space_mem =3D get_system_memory();
>
> -    uint32_t verdex_rom =3D 0x02000000;
> -    uint32_t verdex_ram =3D 0x10000000;
> -
> -    cpu =3D pxa270_init(address_space_mem, verdex_ram, machine->cpu_type=
);
> +    cpu =3D pxa270_init(get_system_memory(), 256 * MiB, machine->cpu_typ=
e);
>
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      if (!dinfo && !qtest_enabled()) {
> @@ -95,7 +89,8 @@ static void verdex_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
> +    /* Micron RC28F256P30TFA */
> +    if (!pflash_cfi01_register(0x00000000, "verdex.rom", 32 * MiB,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
>                                 sector_len, 2, 0, 0, 0, 0, 0)) {
>          error_report("Error registering flash memory");

Similarly here.

> @@ -126,7 +121,7 @@ static void verdex_class_init(ObjectClass *oc, void *=
data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>
> -    mc->desc =3D "Gumstix Verdex (PXA270)";
> +    mc->desc =3D "Gumstix Verdex Pro XL6P COMs (PXA270)";
>      mc->init =3D verdex_init;
>      mc->ignore_memory_transaction_failures =3D true;
>      mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c0");
> --

thanks
-- PMM

