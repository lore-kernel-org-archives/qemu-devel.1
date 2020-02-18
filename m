Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AB3C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1C820801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYTRIoPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1C820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46ec-0003jQ-L5
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46dv-0002sd-C5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46dt-0005y4-B1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:26:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46dt-0005xv-7A
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSLkLtlq7dX6OHzJJNmUMI7a83Idq5d9pfVp295bX4E=;
 b=BYTRIoPwmrgX4bGL6+P4CZTrS33u/qVbIlxcRDlJgSfRB2iveVbpTMVSD3UgftnyxOvHgx
 CyWsi3rKX4jeTclSeMsea6oi2SdZvly6hFKf5HvDwQZcslDRBPWqfTrP9SCAKKoHXLXgMI
 3XHYA3MB2GnoKvXgjJFGcDkjoSvx/1g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-_SBjjAJ9O8qrAUZVAixPnw-1; Tue, 18 Feb 2020 12:26:36 -0500
Received: by mail-wr1-f71.google.com with SMTP id m15so11086505wrs.22
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NbD9DrhKwmiAX9ov5NCH/ihpvF2ebTJFnFBzhvjRHqQ=;
 b=PlEzdxH7KJ5x9LjVeYLyieo/HP7bhX04DDHpkLahvWWL2x3WtM16REsvEpohhRXIXO
 +4krHBYiG61raAQYQWkSOz6THRac+y+98zgR4pN2bwF2Ou6+kB/axNis9lw+Kdcyadlw
 ccZe/FN04VidDDC4PP9anocVpD8g+qGTcop3+jj0kh+ortdDkzThO7bnKosooZ00aGs/
 p2C7I8LQDbW019a2YGi70PTRfcYxHRj4HIaJ/TT5kp+phJYEx9q57dIrMW3z0adc1Xdm
 yEfsZS3AdRFI0iPEkxNAibuKU4xyBBF0KCA6aQWV94m+kQsE0+dXbv7wG6VxhNWb1YRG
 xxXQ==
X-Gm-Message-State: APjAAAXXM745dFS9WGcAmKyKdJvPPb5t2+S1PQGj5+LGaBcJ60vE5agd
 cnJA5xKA3jM5b3vvXReP/4L9qBx8cvBUN/IAfXua7Bd+mn68iISKDU6zL9vqTOJQ7JYLXAH8XMp
 LKECa82DYtvVHhbY=
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr4466133wmf.56.1582046795650; 
 Tue, 18 Feb 2020 09:26:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1T8Dz5Brd5r1CkwSGeV3FbIPg2lnniSio5arWroPcvva5YklLlKCoTXe948XEPRl7JoUK3Q==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr4466116wmf.56.1582046795422; 
 Tue, 18 Feb 2020 09:26:35 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm6623997wrw.20.2020.02.18.09.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:26:34 -0800 (PST)
Subject: Re: [PATCH v5 44/79] lm32/lm32_boards: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-45-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <30cd5be3-6a52-0145-abb9-8b4373128daf@redhat.com>
Date: Tue, 18 Feb 2020 18:26:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-45-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: _SBjjAJ9O8qrAUZVAixPnw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, michael@walle.cc
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>   while at it add check for user supplied RAM size and error
>   out if it mismatches board expected value.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>    * fix format string causing build failure on 32-bit host
>      (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
>=20
> CC: michael@walle.cc
> CC: philmd@redhat.com
> ---
>   hw/lm32/lm32_boards.c | 39 ++++++++++++++++++++++++++-------------
>   1 file changed, 26 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index d1894adab8..4e0a98c117 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -19,6 +19,7 @@
>  =20
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> +#include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   #include "cpu.h"
>   #include "hw/sysbus.h"
> @@ -75,22 +76,28 @@ static void main_cpu_reset(void *opaque)
>  =20
>   static void lm32_evr_init(MachineState *machine)
>   {
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>       const char *kernel_filename =3D machine->kernel_filename;
>       LM32CPU *cpu;
>       CPULM32State *env;
>       DriveInfo *dinfo;
>       MemoryRegion *address_space_mem =3D  get_system_memory();
> -    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
>       qemu_irq irq[32];
>       ResetInfo *reset_info;
>       int i;
>  =20
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
>       /* memory map */
>       hwaddr flash_base  =3D 0x04000000;
>       size_t flash_sector_size       =3D 256 * KiB;
>       size_t flash_size              =3D 32 * MiB;
>       hwaddr ram_base    =3D 0x08000000;
> -    size_t ram_size                =3D 64 * MiB;
>       hwaddr timer0_base =3D 0x80002000;
>       hwaddr uart0_base  =3D 0x80006000;
>       hwaddr timer1_base =3D 0x8000a000;
> @@ -107,9 +114,7 @@ static void lm32_evr_init(MachineState *machine)
>  =20
>       reset_info->flash_base =3D flash_base;
>  =20
> -    memory_region_allocate_system_memory(phys_ram, NULL, "lm32_evr.sdram=
",
> -                                         ram_size);
> -    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
> +    memory_region_add_subregion(address_space_mem, ram_base, machine->ra=
m);
>  =20
>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
>       /* Spansion S29NS128P */
> @@ -144,7 +149,7 @@ static void lm32_evr_init(MachineState *machine)
>  =20
>           if (kernel_size < 0) {
>               kernel_size =3D load_image_targphys(kernel_filename, ram_ba=
se,
> -                                              ram_size);
> +                                              machine->ram_size);
>               reset_info->bootstrap_pc =3D ram_base;
>           }
>  =20
> @@ -159,6 +164,7 @@ static void lm32_evr_init(MachineState *machine)
>  =20
>   static void lm32_uclinux_init(MachineState *machine)
>   {
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *kernel_cmdline =3D machine->kernel_cmdline;
>       const char *initrd_filename =3D machine->initrd_filename;
> @@ -166,18 +172,23 @@ static void lm32_uclinux_init(MachineState *machine=
)
>       CPULM32State *env;
>       DriveInfo *dinfo;
>       MemoryRegion *address_space_mem =3D  get_system_memory();
> -    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
>       qemu_irq irq[32];
>       HWSetup *hw;
>       ResetInfo *reset_info;
>       int i;
>  =20
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
>       /* memory map */
>       hwaddr flash_base   =3D 0x04000000;
>       size_t flash_sector_size        =3D 256 * KiB;
>       size_t flash_size               =3D 32 * MiB;
>       hwaddr ram_base     =3D 0x08000000;
> -    size_t ram_size                 =3D 64 * MiB;
>       hwaddr uart0_base   =3D 0x80000000;
>       hwaddr timer0_base  =3D 0x80002000;
>       hwaddr timer1_base  =3D 0x80010000;
> @@ -200,9 +211,7 @@ static void lm32_uclinux_init(MachineState *machine)
>  =20
>       reset_info->flash_base =3D flash_base;
>  =20
> -    memory_region_allocate_system_memory(phys_ram, NULL,
> -                                         "lm32_uclinux.sdram", ram_size)=
;
> -    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
> +    memory_region_add_subregion(address_space_mem, ram_base, machine->ra=
m);
>  =20
>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
>       /* Spansion S29NS128P */
> @@ -238,7 +247,7 @@ static void lm32_uclinux_init(MachineState *machine)
>  =20
>           if (kernel_size < 0) {
>               kernel_size =3D load_image_targphys(kernel_filename, ram_ba=
se,
> -                                              ram_size);
> +                                              machine->ram_size);
>               reset_info->bootstrap_pc =3D ram_base;
>           }
>  =20
> @@ -252,7 +261,7 @@ static void lm32_uclinux_init(MachineState *machine)
>       hw =3D hwsetup_init();
>       hwsetup_add_cpu(hw, "LM32", 75000000);
>       hwsetup_add_flash(hw, "flash", flash_base, flash_size);
> -    hwsetup_add_ddr_sdram(hw, "ddr_sdram", ram_base, ram_size);
> +    hwsetup_add_ddr_sdram(hw, "ddr_sdram", ram_base, machine->ram_size);
>       hwsetup_add_timer(hw, "timer0", timer0_base, timer0_irq);
>       hwsetup_add_timer(hw, "timer1_dev_only", timer1_base, timer1_irq);
>       hwsetup_add_timer(hw, "timer2_dev_only", timer2_base, timer2_irq);
> @@ -288,6 +297,8 @@ static void lm32_evr_class_init(ObjectClass *oc, void=
 *data)
>       mc->init =3D lm32_evr_init;
>       mc->is_default =3D 1;
>       mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
> +    mc->default_ram_size =3D 64 * MiB;
> +    mc->default_ram_id =3D "lm32_evr.sdram";
>   }
>  =20
>   static const TypeInfo lm32_evr_type =3D {
> @@ -304,6 +315,8 @@ static void lm32_uclinux_class_init(ObjectClass *oc, =
void *data)
>       mc->init =3D lm32_uclinux_init;
>       mc->is_default =3D 0;
>       mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
> +    mc->default_ram_size =3D 64 * MiB;
> +    mc->default_ram_id =3D "lm32_uclinux.sdram";
>   }
>  =20
>   static const TypeInfo lm32_uclinux_type =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


