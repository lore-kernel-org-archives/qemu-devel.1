Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772E0C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BC520B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBSddpmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BC520B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi44F-0008TS-2L
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:42:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45840)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hi3FR-0002Ri-Oz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hi3FN-0002HT-Gr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:49:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hi3FN-0002DG-7y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:49:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so15243926wru.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Ljam71+MU4aYsvkkGkg1ijxKyBjtk8IL0KNeM4xiSo=;
 b=YBSddpmPlrP0YddNkh1rMeIn4HVNZlxBQdpJzo6HpnKZJ6f0i7zJ+v887YwjDfxewo
 dLMzL32bfi5lIuUike5QmmTSIkQVL+a1z3Dm5aRXA71YgyZ8v0UXmmGnXG4QPY8EOHcv
 IINmUuOf/IovWEAHViO0vWKwWtJEWmCn7yZtebc8q+JeJWZ59tS20w0syw2jRRJt5Qef
 UvcrJ9IOhR2ybFPhT9heGwht9RrYEOAQkkBkOeYfTiDu2Z1dmKfj7gZnE6AijAIuzMtX
 l/2VBb1WCIgjCCtLe1p6LZnq+D33jCuORRkzwPNX9ydrrLpCOd/OB/tOF5MBRu2vqT+G
 5CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0Ljam71+MU4aYsvkkGkg1ijxKyBjtk8IL0KNeM4xiSo=;
 b=WidWcxR8vbLP0DbsuMtyQffm+88JYLKvriJO4PffHKqq4NC9skVLjGfFg/bpR9+8p5
 4SMSEJDlBy1TQBZONm0uQjUmqrZUsDuMFRiYLK22cR9C5GOcuqB0joN9HC2WWuMY+Y60
 Fs3CdK8L7/q3uj4lq17gkizjm6PhCRi6XhAFfzscMzccOwtTJv00yXS61823c5uRRfNn
 QJhEALmoLuGHf9Yy50NyBXEpnLR8h9605pimmt+dos5WC7/ksN9CJWETrpmgGe5VOda2
 StUCqRnkbDSrxd/mxGWQ/+bPPW7lvIKj2f3sJpsO/pNEJV5omxnI8qKnYlEWX/YEDw1z
 C4mw==
X-Gm-Message-State: APjAAAUQ/I4dodRxfHbqR/B4YT2wS2Bfu5fMe6SsKeMrQ3qT2mw3gFUN
 I27qFyLYF9Omguh1JZNY8PO8Xz/H
X-Google-Smtp-Source: APXvYqwXZpNv5cpBFcp7W0FHLFGPiUduapXsaiIFEl4XrBoy5hfOE1GJ5rKI1hy0wCG8Y4L2SLxD0w==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr20086302wrp.293.1562004384726; 
 Mon, 01 Jul 2019 11:06:24 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id r2sm413215wme.30.2019.07.01.11.06.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 11:06:23 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-11-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <4fab5459-f1a6-8ac9-2498-bda6a4732a1c@amsat.org>
Date: Mon, 1 Jul 2019 20:06:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624222844.26584-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [RFC PATCH 10/10] hw/pci-host/gt64120: Clean the
 decoded address space
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>,
 linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the kernel folks.

On 6/25/19 12:28 AM, Philippe Mathieu-Daudé wrote:
> The SysAd bus is split in various address spaces.
> Declare the different regions separately, this helps a lot
> while tracing different access while debugging.
> 
> We also add the PCI1 ranges.
> 
> See 'GT-64120A System Controller' datasheet Rev, 1.1,
> "Table 15: CPU and Device Decoder Default Address Mapping"
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> While this device is modelled toward the Malta board, it is generic.
> ---
>  hw/mips/mips_malta.c  |  6 ------
>  hw/pci-host/gt64120.c | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 97f8ffbf1b..d6e4a0dad9 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -53,7 +53,6 @@
>  #include "sysemu/qtest.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> -#include "hw/misc/empty_slot.h"
>  #include "sysemu/kvm.h"
>  #include "hw/semihosting/semihost.h"
>  #include "hw/mips/cps.h"
> @@ -1209,11 +1208,6 @@ void mips_malta_init(MachineState *machine)
>      DeviceState *dev = qdev_create(NULL, TYPE_MIPS_MALTA);
>      MaltaState *s = MIPS_MALTA(dev);
>  
> -    /* The whole address space decoded by the GT-64120A doesn't generate
> -       exception when accessing invalid memory. Create an empty slot to
> -       emulate this feature. */
> -    empty_slot_init("gt64120-ad", 0x00000000, 0x20000000);
> -
>      qdev_init_nofail(dev);
>  
>      /* create CPU */
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index 5209038ee5..6eaa571994 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -31,6 +31,8 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/i386/pc.h"
>  #include "exec/address-spaces.h"
> +#include "hw/misc/empty_slot.h"
> +#include "hw/misc/unimp.h"
>  #include "trace.h"
>  
>  #define GT_REGS                 (0x1000 >> 2)
> @@ -1206,6 +1208,23 @@ PCIBus *gt64120_create(qemu_irq *pic, bool target_is_bigendian)
>                            "isd-mem", 0x1000);
>  
>      pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "gt64120_pci");
> +
> +    create_unimplemented_device("gt64120_i2o", 0x14000000, 256);
> +
> +    empty_slot_init("SCS0",     0x00000000, 8 * MiB);
> +    empty_slot_init("SCS1",     0x00800000, 8 * MiB);
> +    empty_slot_init("SCS2",     0x01000000, 8 * MiB);
> +    empty_slot_init("SCS3",     0x01800000, 8 * MiB);

Since it is a bit pointless to alloc 4 regions, I could
simplify those 4 as:

       empty_slot_init("SCS[4]",   0x00000000, 4 * 8 * MiB);

The difference with the previous content is now we have
two new holes:

- 0x02000000-0x10000000
- 0x14001000-0x1c000000

Ralf/Paul/James, what should happen when a guest access these
holes (hardware PoV, no QEMU)?

The address space with this patch is:

(qemu) info mtree
address-space: memory
0000000000000000-0000000007ffffff (prio 0, i/o): alias low_ram
@mips_malta.ram 0000000000000000-0000000007ffffff
0000000000000000-00000000007fffff (prio -10000, i/o): SCS0
0000000000800000-0000000000ffffff (prio -10000, i/o): SCS1
0000000001000000-00000000017fffff (prio -10000, i/o): SCS2
0000000001800000-0000000001ffffff (prio -10000, i/o): SCS3
0000000002000000-000000000fffffff [hole]
0000000010000000-0000000011ffffff (prio 0, i/o): alias pci0-io @io
0000000000000000-0000000001ffffff
0000000012000000-0000000013ffffff (prio 0, i/o): alias pci0-mem0
@pci0-mem 0000000012000000-0000000013ffffff
0000000014000000-0000000014000fff (prio 0, i/o): isd-mem
0000000014000000-00000000140000ff (prio -1000, i/o): gt64120_i2o
0000000014001000-000000001bffffff [hole]
000000001c000000-000000001c7fffff (prio -10000, i/o): CS0
000000001c800000-000000001cffffff (prio -10000, i/o): CS1
000000001d000000-000000001effffff (prio -10000, i/o): CS2
000000001e000000-000000001e3fffff (prio 0, romd): mips_malta.bios
000000001f000000-000000001f0008ff (prio 0, i/o): alias malta-fpga
@malta-fpga 0000000000000000-00000000000008ff
000000001f000000-000000001fbfffff (prio -10000, i/o): CS3
000000001f000900-000000001f00093f (prio 0, i/o): serial
000000001f000a00-000000001f00ffff (prio 0, i/o): alias malta-fpga
@malta-fpga 0000000000000a00-000000000000ffff
000000001fc00000-000000001fffffff (prio 0, rom): bios.1fc
000000001fc00000-000000001fffffff (prio -10000, i/o): BootCS
0000000020000000-0000000021ffffff (prio -1000, i/o): pci1-io
0000000022000000-0000000023ffffff (prio -10000, i/o): pci1-mem0
0000000024000000-0000000025ffffff (prio -10000, i/o): pci1-mem1
0000000080000000-0000000087ffffff (prio 0, ram): mips_malta.ram
00000000f2000000-00000000f3ffffff (prio 0, i/o): alias pci0-mem1
@pci0-mem 00000000f2000000-00000000f3ffffff

> +    empty_slot_init("CS0",      0x1c000000, 8 * MiB);
> +    empty_slot_init("CS1",      0x1c800000, 8 * MiB);
> +    empty_slot_init("CS2",      0x1d000000, 32 * MiB);
> +    empty_slot_init("CS3",      0x1f000000, 12 * MiB);

I'm not very happy to add a non-pow2 range, but this is how
it appears on the datasheet. I suppose the correct range is
16MB with lower priority than the BootCS.

> +    empty_slot_init("BootCS",   0x1fc00000, 4 * MiB);

> +    create_unimplemented_device("pci1-io", 0x20000000, 32 * MiB);
> +    empty_slot_init("pci1-mem0", 0x22000000, 32 * MiB);
> +    empty_slot_init("pci1-mem1", 0x24000000, 32 * MiB);

This part is new, and could go in a separate patch:
Currently, no guest ever accessed this space.

Regards,

Phil.

> +
>      return phb->bus;
>  }
>  

