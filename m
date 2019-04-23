Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E439C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB682148D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB682148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3S5-0000kb-Fq
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:59:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3RI-0000Td-7c
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3RG-0006Gw-Vn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:58:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3RG-0006Ci-OE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:58:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so3172028wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:cc:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FUHB/HHaqfl4NWo9CX0hruIYa5lPpweiN+TmagBJCVw=;
	b=URjHQpeLiocsXoPhxdc+qlHbcFr2QJlDIjLRdfuGfw11eYABANHtR/56AW0b8SI8Pm
	kCq2rdLLfb02hGNj7fE51vQnF9p6fkVzQJ1h33VtzCd94X+tKLbgMkzhhUU1SE1nrHxc
	7dF04V9SYwHQUulofhjUeEew41XWdAY3qFfR6rQHiOAW2NjsSEVNIyxu60un7FsM1kxv
	L2Kk3/5D5b2q6RW3zRvJYIYk2yCqiCJV5WsNdLdDf6wBqoQwp5oNJLkW9+VxAhwLAh1/
	Lz4ibLsNWe3tvblS6O+u85GWYnK6w7x8gKdTf0JuxZ9BhsqvaaTCyW0eR0TA11Pt0fu7
	Mm7w==
X-Gm-Message-State: APjAAAWY2L+DjHhu3732cEVLACj7SurLCTYXNTtplaXl2POgTTJGFVcy
	EGJ45qaei/NAV+yg1+16IiWVgMXnULY=
X-Google-Smtp-Source: APXvYqyQp2SQgugrEkzOl+MEzIdr6z9fTtf8HmibXrcNFRC1/0Uf6qOTTLZIdnf6fTN6kTkV4ugyvA==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr3918389wmg.14.1556056732669;
	Tue, 23 Apr 2019 14:58:52 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	u6sm31347649wrg.72.2019.04.23.14.58.51
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 14:58:52 -0700 (PDT)
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	"Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20180106153730.30313-1-hpoussin@reactos.org>
	<20180106153730.30313-13-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f6179552-cc21-0935-ddea-7bbdeecddac3@redhat.com>
Date: Tue, 23 Apr 2019 23:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20180106153730.30313-13-hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4 12/16] piix4: add a mc146818rtc
 controller as specified in datasheet
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423215850.vQW8Pa0nJX6K7n9LLwmykebLnpnjCDGTL3-R-MhVNdI@z>

Hi Hervé,

I haven't forgot this series (still 15 months passed...) and it is now
integrated in a bigger one. While retesting the whole previous to post,
I noticed an error...

On 1/6/18 4:37 PM, Hervé Poussineau wrote:
> Remove mc146818rtc instanciated in malta board, to not have it twice.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/isa/piix4.c       | 12 ++++++++++++
>  hw/mips/mips_malta.c |  5 -----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 7a13e83270..0d68fcb193 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -31,6 +31,7 @@
>  #include "hw/char/isa.h"
>  #include "hw/sysbus.h"
>  #include "hw/timer/i8254.h"
> +#include "hw/timer/mc146818rtc.h"
>  #include "qapi/error.h"
>  
>  PCIDevice *piix4_dev;
> @@ -43,6 +44,7 @@ typedef struct PIIX4State {
>      FDCtrlISABus floppy;
>      ISASerialState serial[2];
>      ISAParallelState parallel;
> +    RTCState rtc;
>  
>      /* Reset Control Register */
>      MemoryRegion rcr_mem;
> @@ -217,6 +219,15 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
>          return;
>      }
>  
> +    /* timer */
> +    qdev_set_parent_bus(DEVICE(&s->rtc), BUS(isa_bus));

... here. You don't set the "base_year" property.
If unset, the default of 1980 is used.
However ...

> +    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    isa_init_irq(ISA_DEVICE(&s->rtc), &s->rtc.irq, RTC_ISA_IRQ);
> +
>      piix4_dev = pci_dev;
>      qemu_register_reset(piix4_reset, s);
>  }
> @@ -231,6 +242,7 @@ static void piix4_init(Object *obj)
>          object_initialize(&s->serial[i], sizeof(s->serial[i]), TYPE_ISA_SERIAL);
>      }
>      object_initialize(&s->parallel, sizeof(s->parallel), TYPE_ISA_PARALLEL);
> +    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_MC146818_RTC);
>  
>      object_property_add_alias(obj, "floppy", OBJECT(&s->floppy), "driveA",
>                                &error_abort);
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 30fb30fc0e..3d304a6e0a 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -995,7 +995,6 @@ void mips_malta_init(MachineState *machine)
>      uint8_t *smbus_eeprom_buf = g_malloc0(smbus_eeprom_size);
>      int64_t kernel_entry, bootloader_run_addr;
>      PCIBus *pci_bus;
> -    ISABus *isa_bus;
>      qemu_irq cbus_irq, i8259_irq;
>      PCIDevice *pci;
>      int piix4_devfn;
> @@ -1197,7 +1196,6 @@ void mips_malta_init(MachineState *machine)
>      qdev_prop_set_chr(dev, "parallel", parallel_hds[0]);
>  
>      qdev_init_nofail(dev);
> -    isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>      piix4_devfn = pci->devfn;
>  
>      /* Interrupt controller */
> @@ -1213,9 +1211,6 @@ void mips_malta_init(MachineState *machine)
>      smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
>      g_free(smbus_eeprom_buf);
>  
> -    /* Super I/O */
> -    mc146818_rtc_init(isa_bus, 2000, NULL);

... here it is set to 2000.
The same value is used in the PC machine (which uses the PIIX3).

> -
>      /* Network card */
>      network_init(pci_bus);
>  
> 

I'll amend this snippet to your patch:

-- >8 --
     /* RTC */
     qdev_set_parent_bus(DEVICE(&s->rtc), BUS(isa_bus));
+    qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
     object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
--

Paolo/Michael: I'll keep your Acked-by, I hope you are OK with that.

Regards,

Phil.

