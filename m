Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686D5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3152820684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUuJmF6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3152820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqbr-0002U7-Ao
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iMqb1-0001wh-L7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iMqb0-0007yh-6z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:36:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iMqaz-0007yC-T8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:36:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id z9so17205943wrl.11
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=GrCBnZOHUvRRpHLwj3Uwsc68sejzQVaZtg23m4/K6j8=;
 b=WUuJmF6m2EemZlSV0VSdUd6zUyK3hE0vp07VDo63LwtyKtieaWF1ieOxtezRuiODAn
 yIXV3/iO/YHRd0fgqWNibnC6rTwAeh5HCEAV9+zXG6okCgj7ytJdciRMkZUt+ThkiBoA
 AOprxGtMRoNIJPEPyrjIYMBbbx+6o1jXrVh8re1+WWbFSG3aw+VKcaji4fSmpkT/bj+O
 nnnEekoL5BIa8GSQ5TaU4JtZUxVMbGjMNCGSfvfxVg89K7lS9Hx2I8w3pyr8VWe5MrEL
 9Mo0+WL1QPGOun65Oyck4T/ZHkjA5UVscu7/CqOySAnWfHYiXL2tm+uaCAP/au94rIg+
 CqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=GrCBnZOHUvRRpHLwj3Uwsc68sejzQVaZtg23m4/K6j8=;
 b=Zj16SrXIUJ+eD0PSnLMy5Q/VMBwLFqPvfpfSKugrLMPvVhXoiEGBsoXYeg+efBvtYO
 s2TZaWU78fxJiUJmrXw4nra/DW4cWyzsqCvqUX70acQV4GEA0J/UopIKHj85AG5k9WcX
 tKFeD9KDqI2d9h5IuZFjWMZTnB+X7L02e7d4lF5nuO6aW66K1db70kwb2O/M+RSxaC0F
 USqvMY54Hymglcypr21qDUMBvt6syF8ADLpV64aHk9AnEZ/4RucvNDMCEfLWSACDeIrS
 fbZfE1d/XlN1jvCXgazDy6qfisHh0gveIaa0o3pleeywfmUx4SJ7oe/qr5KM6zc8OmuF
 IbBg==
X-Gm-Message-State: APjAAAViMBk6n/LMxBno+m0QhN/aZBrdagWlGP7PKbBHrQri0h4vjEF+
 U4e7DztBpHaOoDP8dxzd0Gc=
X-Google-Smtp-Source: APXvYqyPts4CApDpEPLLuEZPPFc0cV9UiFde2SXy+eKy8wFu6ds6+3XR6Ejip2yCblHyQTEJDh0d8A==
X-Received: by 2002:adf:9e90:: with SMTP id a16mr1630547wrf.89.1571737012380; 
 Tue, 22 Oct 2019 02:36:52 -0700 (PDT)
Received: from ?IPv6:2a01:c23:604c:2a00:af2b:2e92:39f9:c05b?
 ([2a01:c23:604c:2a00:af2b:2e92:39f9:c05b])
 by smtp.gmail.com with ESMTPSA id w15sm9134360wro.65.2019.10.22.02.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 02:36:51 -0700 (PDT)
Message-ID: <1cbd3bf3c5dd48e06fae1c7c5acd541d1bd1ada3.camel@gmail.com>
Subject: Re: [PATCH v2 13/20] hw/pci-host/piix: Extract piix3_create()
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org
Date: Tue, 22 Oct 2019 11:33:20 +0200
In-Reply-To: <20191018134754.16362-14-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-14-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daudé escribió:
> Extract the PIIX3 creation code from the i440fx_init() function.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/pci-host/piix.c | 51 ++++++++++++++++++++++++++++--------------
> ----
>  1 file changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 2f4cbcbfe9..3292703de7 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -331,6 +331,36 @@ static void i440fx_realize(PCIDevice *dev, Error
> **errp)
>      }
>  }
>  
> +static PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus)
> +{
> +    PIIX3State *piix3;
> +    PCIDevice *pci_dev;
> +
> +    /*
> +     * Xen supports additional interrupt routes from the PCI devices
> to
> +     * the IOAPIC: the four pins of each PCI device on the bus are
> also
> +     * connected to the IOAPIC directly.
> +     * These additional routes can be discovered through ACPI.
> +     */
> +    if (xen_enabled()) {
> +        pci_dev = pci_create_simple_multifunction(pci_bus, -1, true,
> +                                                  TYPE_PIIX3_XEN_DEV
> ICE);
> +        piix3 = PIIX3_PCI_DEVICE(pci_dev);
> +        pci_bus_irqs(pci_bus, xen_piix3_set_irq,
> xen_pci_slot_get_pirq,
> +                     piix3, XEN_PIIX_NUM_PIRQS);
> +    } else {
> +        pci_dev = pci_create_simple_multifunction(pci_bus, -1, true,
> +                                                  TYPE_PIIX3_DEVICE)
> ;
> +        piix3 = PIIX3_PCI_DEVICE(pci_dev);
> +        pci_bus_irqs(pci_bus, piix3_set_irq, pci_slot_get_pirq,
> +                     piix3, PIIX_NUM_PIRQS);
> +        pci_bus_set_route_irq_fn(pci_bus,
> piix3_route_intx_pin_to_irq);
> +    }
> +    *isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
> +
> +    return piix3;
> +}
> +
>  PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>                      PCII440FXState **pi440fx_state,
>                      int *piix3_devfn,
> @@ -400,27 +430,8 @@ PCIBus *i440fx_init(const char *host_type, const
> char *pci_type,
>                   PAM_EXPAN_SIZE);
>      }
>  
> -    /* Xen supports additional interrupt routes from the PCI devices
> to
> -     * the IOAPIC: the four pins of each PCI device on the bus are
> also
> -     * connected to the IOAPIC directly.
> -     * These additional routes can be discovered through ACPI. */
> -    if (xen_enabled()) {
> -        PCIDevice *pci_dev = pci_create_simple_multifunction(b,
> -                             -1, true, TYPE_PIIX3_XEN_DEVICE);
> -        piix3 = PIIX3_PCI_DEVICE(pci_dev);
> -        pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slot_get_pirq,
> -                piix3, XEN_PIIX_NUM_PIRQS);
> -    } else {
> -        PCIDevice *pci_dev = pci_create_simple_multifunction(b,
> -                             -1, true, TYPE_PIIX3_DEVICE);
> -        piix3 = PIIX3_PCI_DEVICE(pci_dev);
> -        pci_bus_irqs(b, piix3_set_irq, pci_slot_get_pirq, piix3,
> -                PIIX_NUM_PIRQS);
> -        pci_bus_set_route_irq_fn(b, piix3_route_intx_pin_to_irq);
> -    }
> +    piix3 = piix3_create(b, isa_bus);
>      piix3->pic = pic;
> -    *isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
> -
>      *piix3_devfn = piix3->dev.devfn;
>  
>      ram_size = ram_size / 8 / 1024 / 1024;
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


