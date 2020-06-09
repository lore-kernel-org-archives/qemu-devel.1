Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0604C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69ED9207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhhGebcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ED9207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZFc-0005E4-NN
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZEp-0004XP-7l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:04:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45792
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZEn-0004J3-MT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591689840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/Ltjr3Dg+MU5+QrXX6r3ikh2RrTXgf5Zv2d9l86nRb0=;
 b=fhhGebcGByiGRs7w+Ih94+ZpsMii1eZlIn0UH2fTieLx/XPpA36JlfgwbXT5bcfeXC7myF
 4HYp9xZODeQomQMFm2lM0LVMZbzhIJyfp9S5S7EYGWQZgSMgwl1mjZintEgBjHT/NUK7qf
 2knzJlRu1PHp+Qc4IgGg9Zr2MvhgV9k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-VD3fwk-VNvmBiJ-s58MBFQ-1; Tue, 09 Jun 2020 04:03:58 -0400
X-MC-Unique: VD3fwk-VNvmBiJ-s58MBFQ-1
Received: by mail-wm1-f72.google.com with SMTP id b65so446181wmb.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Ltjr3Dg+MU5+QrXX6r3ikh2RrTXgf5Zv2d9l86nRb0=;
 b=sn7Awwlo6vvhwvLaM55iJPfArIzjH2mr61SWjtt8D3I30KmPOQi8DPhgR9xX/qHofc
 BVHkFsJQB8SA5Q5XKcpJ/uewARrwldybqyjWDdw5ZV4xsmpa4gJ6LbQ3PjhgQPzlBXxk
 3ciZwGl97AABOfTp2tyVk1MCm45P13aWpEG9WuZbbID8Be5XqTbAhhI1y30yD/Wnfhr5
 pGKPCjHW//Hw8E0tccfFVh4xGHTRR4U4ijGX3AKQ1cyYEiNnacOPZJoBy0a7uBgTo9eZ
 7lawNV/LMmuKXnEITfJdZapA7QvTr5bNU5J3HzM80HHJxVZHS5QVCxEPFjM4N82rUBrj
 IF5w==
X-Gm-Message-State: AOAM532cdzzLm/aL+XgHGDz81L/d8HDTCk9AmifNnTs+uJRotFbBS62u
 wYtEgiTXXvpIz1leMbsDpaMRpltG+7dUsXJEuvvr5QISPBtVJgSJuWCb/cyJUJZX7oWkz29qjKu
 iHnLMtiPVkEQRZOA=
X-Received: by 2002:adf:feca:: with SMTP id q10mr2799691wrs.380.1591689836984; 
 Tue, 09 Jun 2020 01:03:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE4aPOfJigo8O7UMP4DzFUNF226gF40Ip0ZTq3nQCTw8gJbglXm8hnCub671ZPAbqIRXZkgg==
X-Received: by 2002:adf:feca:: with SMTP id q10mr2799656wrs.380.1591689836435; 
 Tue, 09 Jun 2020 01:03:56 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id h15sm2298809wrt.73.2020.06.09.01.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:03:55 -0700 (PDT)
Subject: Re: [PATCH v2 07/58] qdev: Convert to qdev_unrealize() with Coccinelle
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <92648953-adb1-a251-f0dd-84103981d594@redhat.com>
Date: Tue, 9 Jun 2020 10:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-8-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 3:44 PM, Markus Armbruster wrote:
> For readability, and consistency with qbus_realize().
> 
> Coccinelle script:
> 
>     @ depends on !(file in "hw/core/qdev.c")@
>     typedef DeviceState;
>     DeviceState *dev;
>     symbol false, error_abort;
>     @@
>     -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
>     +    qdev_unrealize(dev);
> 
>     @ depends on !(file in "hw/core/qdev.c")@
>     expression dev;
>     symbol false, error_abort;
>     @@
>     -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
>     +    qdev_unrealize(DEVICE(dev));
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/acpi/pcihp.c            | 2 +-
>  hw/char/serial-pci-multi.c | 2 +-
>  hw/char/serial-pci.c       | 2 +-
>  hw/core/bus.c              | 3 +--
>  hw/i386/pc.c               | 4 ++--
>  hw/pci/pcie.c              | 2 +-
>  hw/pci/shpc.c              | 2 +-
>  hw/ppc/spapr.c             | 8 ++++----
>  hw/ppc/spapr_pci.c         | 3 +--
>  hw/s390x/css-bridge.c      | 2 +-
>  hw/s390x/s390-pci-bus.c    | 4 ++--
>  11 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index d42906ea19..33ea2b76ae 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -266,7 +266,7 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
>  {
>      trace_acpi_pci_unplug(PCI_SLOT(PCI_DEVICE(dev)->devfn),
>                            acpi_pcihp_get_bsel(pci_get_bus(PCI_DEVICE(dev))));
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>  }
>  
>  void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 5f9ccfcc93..23d0ebe2cd 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -56,7 +56,7 @@ static void multi_serial_pci_exit(PCIDevice *dev)
>  
>      for (i = 0; i < pci->ports; i++) {
>          s = pci->state + i;
> -        object_property_set_bool(OBJECT(s), false, "realized", &error_abort);
> +        qdev_unrealize(DEVICE(s));
>          memory_region_del_subregion(&pci->iobar, &s->io);
>          g_free(pci->name[i]);
>      }
> diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> index 37818db156..65eacfae0e 100644
> --- a/hw/char/serial-pci.c
> +++ b/hw/char/serial-pci.c
> @@ -68,7 +68,7 @@ static void serial_pci_exit(PCIDevice *dev)
>      PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
>      SerialState *s = &pci->state;
>  
> -    object_property_set_bool(OBJECT(s), false, "realized", &error_abort);
> +    qdev_unrealize(DEVICE(s));
>      qemu_free_irq(s->irq);

Ah, unrealize() isn't finalize(), so 's' is still a valid memory.
(Comment unrelated to your patch, just reviewing non-obvious code).

>  }
>  
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 6f6071f5fa..6cc28b334e 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -200,8 +200,7 @@ static void bus_set_realized(Object *obj, bool value, Error **errp)
>      } else if (!value && bus->realized) {
>          QTAILQ_FOREACH(kid, &bus->children, sibling) {
>              DeviceState *dev = kid->child;
> -            object_property_set_bool(OBJECT(dev), false, "realized",
> -                                     &error_abort);
> +            qdev_unrealize(dev);
>          }
>          if (bc->unrealize) {
>              bc->unrealize(bus);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2128f3d6fe..f9d51479b1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1385,7 +1385,7 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
>      }
>  
>      pc_dimm_unplug(PC_DIMM(dev), MACHINE(pcms));
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>   out:
>      error_propagate(errp, local_err);
>  }
> @@ -1493,7 +1493,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
>  
>      found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
>      found_cpu->cpu = NULL;
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>  
>      /* decrement the number of CPUs */
>      x86ms->boot_cpus--;
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index f50e10b8fb..582f81fdff 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -457,7 +457,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>  void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                               Error **errp)
>  {
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>  }
>  
>  static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index b76d3d2c9a..99d65d5c4c 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -547,7 +547,7 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>  void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                             Error **errp)
>  {
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>  }
>  
>  void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3b1a5ed865..6a315c0dc8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3671,7 +3671,7 @@ static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
>      SpaprDimmState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
>  
>      pc_dimm_unplug(PC_DIMM(dev), MACHINE(hotplug_dev));
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>      spapr_pending_dimm_unplugs_remove(spapr, ds);
>  }
>  
> @@ -3764,7 +3764,7 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
>  
>      assert(core_slot);
>      core_slot->cpu = NULL;
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>  }
>  
>  static
> @@ -4037,7 +4037,7 @@ void spapr_phb_release(DeviceState *dev)
>  
>  static void spapr_phb_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
>  {
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>  }
>  
>  static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
> @@ -4073,7 +4073,7 @@ static void spapr_tpm_proxy_unplug(HotplugHandler *hotplug_dev, DeviceState *dev
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
>  
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>      object_unparent(OBJECT(dev));
>      spapr->tpm_proxy = NULL;

Ditto, OK.

>  }
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 83f1453096..329002ac04 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1587,8 +1587,7 @@ static void spapr_pci_unplug(HotplugHandler *plug_handler,
>          return;
>      }
>  
> -    object_property_set_bool(OBJECT(plugged_dev), false, "realized",
> -                             &error_abort);
> +    qdev_unrealize(plugged_dev);
>  }
>  
>  static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> index 3f6aec6b6a..813bfc768a 100644
> --- a/hw/s390x/css-bridge.c
> +++ b/hw/s390x/css-bridge.c
> @@ -54,7 +54,7 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
>  
>      css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid, 1, 0);
>  
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>  }
>  
>  static void virtual_css_bus_reset(BusState *qbus)
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index c4a4259f0c..7a4bfb7383 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1003,7 +1003,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                       pbdev->fh, pbdev->fid);
>          bus = pci_get_bus(pci_dev);
>          devfn = pci_dev->devfn;
> -        object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +        qdev_unrealize(dev);
>  
>          s390_pci_msix_free(pbdev);
>          s390_pci_iommu_free(s, bus, devfn);
> @@ -1014,7 +1014,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          pbdev->fid = 0;
>          QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>          g_hash_table_remove(s->zpci_table, &pbdev->idx);
> -        object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +        qdev_unrealize(dev);
>      }
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


