Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0DEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5BF21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYv1yKbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5BF21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifToO-00079f-An
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 14:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifTkt-0003vc-Px
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifTkq-0005zG-4H
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:04:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifTkp-0005wp-U7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576177442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vLKKHq/qKBJ0wZeBWToTolzYpv3CKezYhvaUKNuvlY=;
 b=aYv1yKbrg7gVFHe2LQPEvD6tCQCW2ecwxPtZ8h4dPr6KX9J3bpROHeGeLxTzWXEg51BW0J
 qafL5yQlPOYnIzMWrCLYGvD7cMWFcRIwZjC5yJC+yBUi3OwyWxPyBLSCNv30IMAoRUDdIg
 c4cAa/6C88Umy7RiVJ1rv5QTLDyoCQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-JO2vcfMcNH2quELSh69wpQ-1; Thu, 12 Dec 2019 14:04:01 -0500
Received: by mail-wr1-f71.google.com with SMTP id i9so1393389wru.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 11:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1vLKKHq/qKBJ0wZeBWToTolzYpv3CKezYhvaUKNuvlY=;
 b=jAG9EwF98Em5YoqxeisZFJDlVHf5xTKOT2AajR29jRClFLPfnJ4MOLhbLcmajO0Xm/
 M8s67nod4MX52wbuXFWDH06OnlwfcecsKUs8pX+cnhaVHi12x/O8W+NmuYFYysM3jttL
 /NVnrz1l1x5QNqlmrGHcf+NE7+ND4nMB6mk7gg6R7ofMWjgbMfcAJGqN04jTL2z2JE90
 hwvUgDOtoR69s+RUiSyXSZQNXU5YEBTb8mHSEGRuJ4+Cw43NlJeBndxpoCusBbSc2JrD
 CQNF1z1Z7QNjDvxSq3aICuCD1NyzwMINyX0QonA932Q9QfTfqiVgD70IBwUFTZGl6grw
 1v4w==
X-Gm-Message-State: APjAAAWBAK+KzHdhQIVYQrHO+Vw9bfPY0VrIQAeQ7AFSbXPTHNtAT8Ur
 vnZ1Rw7/gV2qeWR6LLVuMehHZiOoZo6JPYAnzO33yG+hiP59idybVI3qKnvjjYNP3xdGTxotlIY
 lspwBHeC+67z97KQ=
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr8375468wrs.287.1576177440253; 
 Thu, 12 Dec 2019 11:04:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2cX5uEYtAgSeYJBT+as8eaebaJIb744R1uRe0KZdz1GyNozvgx166++EkrKi7Jbk3G3pXzw==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr8375441wrs.287.1576177439907; 
 Thu, 12 Dec 2019 11:03:59 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id w8sm7463665wmm.0.2019.12.12.11.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 11:03:59 -0800 (PST)
Subject: Re: [PATCH v2 3/8] hw: replace hw/i386/pc.h with a header just for
 the i8259
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-4-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d58b507e-9d68-d112-0f6c-6f9dfb153a93@redhat.com>
Date: Thu, 12 Dec 2019 20:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576171754-45138-4-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: JO2vcfMcNH2quELSh69wpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 6:29 PM, Paolo Bonzini wrote:
> Remove the need to include i386/pc.h to get to the i8259 functions.
> This is enough to remove the inclusion of hw/i386/pc.h from all non-x86
> files.

Eh this is very similar to the patch I'v staged for 5.0, now than the 
Malta/PC split got merged.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/alpha/alpha_sys.h            |  3 ++-
>   hw/alpha/dp264.c                |  1 +
>   hw/hppa/hppa_sys.h              |  3 ++-
>   hw/hppa/machine.c               |  1 +
>   hw/i386/kvm/i8259.c             |  1 +
>   hw/i386/microvm.c               |  1 +
>   hw/i386/pc.c                    |  1 +
>   hw/i386/x86.c                   |  1 +
>   hw/input/pckbd.c                |  1 -
>   hw/intc/Kconfig                 |  2 ++
>   hw/intc/apic.c                  |  2 +-
>   hw/intc/i8259.c                 |  2 +-
>   hw/intc/i8259_common.c          |  2 +-
>   hw/intc/ioapic.c                |  3 ++-
>   hw/isa/i82378.c                 |  2 +-
>   hw/isa/lpc_ich9.c               |  1 -
>   hw/isa/piix4.c                  |  2 +-
>   hw/mips/gt64xxx_pci.c           |  2 +-
>   hw/mips/mips_fulong2e.c         |  2 +-
>   hw/mips/mips_jazz.c             |  2 +-
>   hw/mips/mips_r4k.c              |  2 +-
>   hw/pci-host/bonito.c            |  1 -
>   hw/pci-host/prep.c              |  2 +-
>   include/hw/i386/pc.h            |  8 --------
>   include/hw/intc/i8259.h         | 12 ++++++++++++
>   include/hw/isa/i8259_internal.h |  2 +-
>   target/i386/monitor.c           |  1 -
>   27 files changed, 37 insertions(+), 26 deletions(-)
>   create mode 100644 include/hw/intc/i8259.h

Can you setup QEMU scripts/git.orderfile?

> 
> diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
> index 4e127a6..95033d7 100644
> --- a/hw/alpha/alpha_sys.h
> +++ b/hw/alpha/alpha_sys.h
> @@ -7,7 +7,8 @@
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_host.h"
>   #include "hw/ide.h"
> -#include "hw/i386/pc.h"
> +#include "hw/boards.h"
> +#include "hw/intc/i8259.h"
>   
>   
>   PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 4320497..5ed9a5a 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -20,6 +20,7 @@
>   #include "hw/timer/i8254.h"
>   #include "hw/isa/superio.h"
>   #include "hw/dma/i8257.h"
> +#include "net/net.h"
>   #include "qemu/cutils.h"
>   
>   #define MAX_IDE_BUS 2
> diff --git a/hw/hppa/hppa_sys.h b/hw/hppa/hppa_sys.h
> index 43d25d2..4e50196 100644
> --- a/hw/hppa/hppa_sys.h
> +++ b/hw/hppa/hppa_sys.h
> @@ -6,7 +6,8 @@
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_host.h"
>   #include "hw/ide.h"
> -#include "hw/i386/pc.h"
> +#include "hw/boards.h"
> +#include "hw/intc/i8259.h"
>   
>   #include "hppa_hardware.h"
>   
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index b30aba6..5d0de26 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -19,6 +19,7 @@
>   #include "hppa_sys.h"
>   #include "qemu/units.h"
>   #include "qapi/error.h"
> +#include "net/net.h"
>   #include "qemu/log.h"
>   
>   #define MAX_IDE_BUS 2
> diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
> index d0c1b1d..e404fdc 100644
> --- a/hw/i386/kvm/i8259.c
> +++ b/hw/i386/kvm/i8259.c
> @@ -12,6 +12,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/isa/i8259_internal.h"
> +#include "hw/intc/i8259.h"
>   #include "qemu/module.h"
>   #include "hw/i386/apic_internal.h"
>   #include "hw/irq.h"
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index def37e6..2068319 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -34,6 +34,7 @@
>   #include "hw/i386/x86.h"
>   #include "hw/i386/pc.h"
>   #include "target/i386/cpu.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/timer/i8254.h"
>   #include "hw/rtc/mc146818rtc.h"
>   #include "hw/char/serial.h"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3d2c5d8..fdbd2bf 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -44,6 +44,7 @@
>   #include "migration/vmstate.h"
>   #include "multiboot.h"
>   #include "hw/rtc/mc146818rtc.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/dma/i8257.h"
>   #include "hw/timer/i8254.h"
>   #include "hw/input/i8042.h"
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 394edc2..3e4aee5 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -39,6 +39,7 @@
>   #include "target/i386/cpu.h"
>   #include "hw/i386/topology.h"
>   #include "hw/i386/fw_cfg.h"
> +#include "hw/intc/i8259.h"
>   
>   #include "hw/acpi/cpu_hotplug.h"
>   #include "hw/nmi.h"
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index f0acfd8..2f09f78 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -26,7 +26,6 @@
>   #include "qemu/log.h"
>   #include "hw/isa/isa.h"
>   #include "migration/vmstate.h"
> -#include "hw/i386/pc.h"
>   #include "hw/input/ps2.h"
>   #include "hw/irq.h"
>   #include "hw/input/i8042.h"
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index 5347f84..10a680b 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -9,6 +9,7 @@ config PL190
>   
>   config IOAPIC
>       bool
> +    select I8259
>   
>   config ARM_GIC
>       bool
> @@ -21,6 +22,7 @@ config OPENPIC
>   config APIC
>       bool
>       select MSI_NONBROKEN
> +    select I8259
>   
>   config ARM_GIC_KVM
>       bool
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index 2a74f7b..bd40467 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -22,10 +22,10 @@
>   #include "hw/i386/apic_internal.h"
>   #include "hw/i386/apic.h"
>   #include "hw/i386/ioapic.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/pci/msi.h"
>   #include "qemu/host-utils.h"
>   #include "trace.h"
> -#include "hw/i386/pc.h"
>   #include "hw/i386/apic-msidef.h"
>   #include "qapi/error.h"
>   
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index 211a989..51b27f6 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -23,7 +23,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "hw/i386/pc.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/irq.h"
>   #include "hw/isa/isa.h"
>   #include "qemu/timer.h"
> diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
> index bd37bb5..e7b1a10 100644
> --- a/hw/intc/i8259_common.c
> +++ b/hw/intc/i8259_common.c
> @@ -24,7 +24,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "hw/i386/pc.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/isa/i8259_internal.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index ead14e1..4f55776 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -23,10 +23,11 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "monitor/monitor.h"
> -#include "hw/i386/pc.h"
>   #include "hw/i386/apic.h"
>   #include "hw/i386/ioapic.h"
>   #include "hw/i386/ioapic_internal.h"
> +#include "hw/i386/x86.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/pci/msi.h"
>   #include "hw/qdev-properties.h"
>   #include "sysemu/kvm.h"
> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> index de276cd..dcb6b47 100644
> --- a/hw/isa/i82378.c
> +++ b/hw/isa/i82378.c
> @@ -19,8 +19,8 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/pci/pci.h"
> -#include "hw/i386/pc.h"
>   #include "hw/irq.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/timer/i8254.h"
>   #include "migration/vmstate.h"
>   #include "hw/audio/pcspk.h"
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 17c292e..170792a 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -35,7 +35,6 @@
>   #include "hw/isa/isa.h"
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
> -#include "hw/i386/pc.h"
>   #include "hw/irq.h"
>   #include "hw/isa/apm.h"
>   #include "hw/i386/ioapic.h"
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 86678e6..7edec5e 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -26,11 +26,11 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "hw/irq.h"
> -#include "hw/i386/pc.h"
>   #include "hw/southbridge/piix.h"
>   #include "hw/pci/pci.h"
>   #include "hw/isa/isa.h"
>   #include "hw/sysbus.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/dma/i8257.h"
>   #include "hw/timer/i8254.h"
>   #include "hw/rtc/mc146818rtc.h"
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index f1af840..b2ea13f 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -30,7 +30,7 @@
>   #include "hw/pci/pci_host.h"
>   #include "hw/southbridge/piix.h"
>   #include "migration/vmstate.h"
> -#include "hw/i386/pc.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/irq.h"
>   #include "exec/address-spaces.h"
>   #include "trace.h"
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 55c143e..6199c54 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -23,7 +23,7 @@
>   #include "qemu/units.h"
>   #include "qapi/error.h"
>   #include "cpu.h"
> -#include "hw/i386/pc.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/dma/i8257.h"
>   #include "hw/isa/superio.h"
>   #include "net/net.h"
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index d978bb6..c40b23f 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -26,7 +26,7 @@
>   #include "qemu-common.h"
>   #include "hw/mips/mips.h"
>   #include "hw/mips/cpudevs.h"
> -#include "hw/i386/pc.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/dma/i8257.h"
>   #include "hw/char/serial.h"
>   #include "hw/char/parallel.h"
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 7002423..fbbd59e 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -15,7 +15,7 @@
>   #include "cpu.h"
>   #include "hw/mips/mips.h"
>   #include "hw/mips/cpudevs.h"
> -#include "hw/i386/pc.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/char/serial.h"
>   #include "hw/isa/isa.h"
>   #include "net/net.h"
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index ceee463..c924007 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -40,7 +40,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
>   #include "hw/pci/pci.h"
> -#include "hw/i386/pc.h"
>   #include "hw/irq.h"
>   #include "hw/mips/mips.h"
>   #include "hw/pci/pci_host.h"
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 85d7ba9..afa136d 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -32,7 +32,7 @@
>   #include "hw/pci/pci_host.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
> -#include "hw/i386/pc.h"
> +#include "hw/intc/i8259.h"
>   #include "hw/irq.h"
>   #include "hw/loader.h"
>   #include "hw/or-irq.h"
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 1f86eba..82447f8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -134,14 +134,6 @@ typedef struct PCMachineClass {
>   #define PC_MACHINE_CLASS(klass) \
>       OBJECT_CLASS_CHECK(PCMachineClass, (klass), TYPE_PC_MACHINE)
>   
> -/* i8259.c */
> -
> -extern DeviceState *isa_pic;
> -qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq);
> -qemu_irq *kvm_i8259_init(ISABus *bus);
> -int pic_read_irq(DeviceState *d);
> -int pic_get_output(DeviceState *d);
> -
>   /* ioapic.c */
>   
>   /* Global System Interrupts */
> diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
> new file mode 100644
> index 0000000..e2b1e8c
> --- /dev/null
> +++ b/include/hw/intc/i8259.h
> @@ -0,0 +1,12 @@
> +#ifndef HW_I8259_H
> +#define HW_I8259_H
> +
> +/* i8259.c */

Instead:

/*
  * QEMU 8259 interrupt controller emulation
  *
  * Copyright (c) 2003-2004 Fabrice Bellard
  *
  * Permission is hereby granted, free of charge, to any person 
obtaining a copy
  * of this software and associated documentation files (the 
"Software"), to deal
  * in the Software without restriction, including without limitation 
the rights
  * to use, copy, modify, merge, publish, distribute, sublicense, and/or 
sell
  * copies of the Software, and to permit persons to whom the Software is
  * furnished to do so, subject to the following conditions:
  *
  * The above copyright notice and this permission notice shall be 
included in
  * all copies or substantial portions of the Software.
  *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR
  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
OTHER
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
ARISING FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN
  * THE SOFTWARE.
  */

> +
> +extern DeviceState *isa_pic;
> +qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq);
> +qemu_irq *kvm_i8259_init(ISABus *bus);

I moved this particular one to hw/i386/kvm/.

> +int pic_get_output(DeviceState *d);
> +int pic_read_irq(DeviceState *d);
> +
> +#endif
> diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
> index ee189e4..861d70d 100644
> --- a/include/hw/isa/i8259_internal.h
> +++ b/include/hw/isa/i8259_internal.h
> @@ -25,9 +25,9 @@
>   #ifndef QEMU_I8259_INTERNAL_H
>   #define QEMU_I8259_INTERNAL_H
>   
> -#include "hw/i386/pc.h"
>   #include "hw/isa/isa.h"
>   #include "hw/intc/intc.h"
> +#include "hw/intc/i8259.h"
>   
>   typedef struct PICCommonState PICCommonState;
>   
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 9fb4d64..27ebfa3 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -28,7 +28,6 @@
>   #include "monitor/hmp-target.h"
>   #include "monitor/hmp.h"
>   #include "qapi/qmp/qdict.h"
> -#include "hw/i386/pc.h"
>   #include "sysemu/kvm.h"
>   #include "sysemu/sev.h"
>   #include "qapi/error.h"
> 


