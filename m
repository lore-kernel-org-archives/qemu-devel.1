Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA42DC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E3C2225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5ljGEin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E3C2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVG3k-0008AX-VT
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVG2T-0007CP-7z
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVG2Q-0003sL-54
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603294109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I85qSFUVIu21U1k2m6UogBg9zQM2Rs/v+b9p9Cv4g84=;
 b=C5ljGEin77XARvQJdIzqZngf41PxkSql6tSQ/PcCGGtBzDfoNhshYncCgLbJtNuB/7rcxY
 PXfltnLktmrlp55txU4XgHVBjWd9dWrYrWB/U2NMmsed2p+mm68wuQPktly4BImf9YQoDy
 xyKrvnjxx1jWwiOMDQdC+E9jiqTcT7g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-YInNoOThNoGZXoNjzD4iMA-1; Wed, 21 Oct 2020 11:28:27 -0400
X-MC-Unique: YInNoOThNoGZXoNjzD4iMA-1
Received: by mail-wm1-f70.google.com with SMTP id z7so1758484wme.8
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 08:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I85qSFUVIu21U1k2m6UogBg9zQM2Rs/v+b9p9Cv4g84=;
 b=ucgjSrz09Q9AriVDTDPJA5j2QieuprufpXFcak214gVSYGpe/gK5XcP3PMKkycOnj2
 a6imiXbl2BSR4+TYXsKSdaPy8FwGjDC4Y4evknpD0Tomf51hZ8ua5ij3UPW/8fjdyMr9
 HM7OgCXROacrN88xJ4PI7c44PF1C4nRowInJ1P0dzbYlSaAqK4fKblj42PhuN/tekqIz
 +f9sfiEWwXIcnPHmGenrtcnHLBm6NFgWNm5omSvCb9W/AC89JIotmfJ88v3wrd8x6VnL
 FzcfF81IUulD7E6doQL1RPnfs7uaFlyuH+0Z39hivaRC/8KFUs666pHOgqOw+X7grulN
 rlGA==
X-Gm-Message-State: AOAM530k7HNYDyEv0XIqyWDCj3EnXiShGs7oTFG5+jQimsdFkpJCKFnq
 6ggNbxoB4iU4+Tro5aSA45D5KsceMfOrqxBW0pVS/f5PH74uDdMvJGbD1zE5pFJ7rfE/Z7Z6/ta
 QWfTMZzPEVrLJ+qo=
X-Received: by 2002:a05:600c:2312:: with SMTP id
 18mr4021356wmo.187.1603294106431; 
 Wed, 21 Oct 2020 08:28:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz43e2/KjEXGOzu3sXoRqHOu+CSJRuMCFMj/7pttffV7M2ohmF4274Zeq/pxKTqnffDl4sz9Q==
X-Received: by 2002:a05:600c:2312:: with SMTP id
 18mr4021334wmo.187.1603294106141; 
 Wed, 21 Oct 2020 08:28:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id v123sm3973870wme.7.2020.10.21.08.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 08:28:25 -0700 (PDT)
Subject: Re: [PATCH v3] pc: Implement -no-hpet as sugar for -machine hpet=on
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201021144716.1536388-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a325b01-542e-a5fa-00d6-2d3e1847bfc8@redhat.com>
Date: Wed, 21 Oct 2020 17:28:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021144716.1536388-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 16:47, Eduardo Habkost wrote:
> Get rid of yet another global variable.
> 
> The default will be hpet=on only if CONFIG_HPET=y.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Revert v2 changes (use "hpet" property), plus:
> * Default to hpet=off if CONFIG_HPET=n
> * Error out if creation of HPET device fails and hpet=on
> 
> Changes v1 -> v2:
> * Rename property to "allow-hpet" to make its semantic clearer,
>   as it won't make sure HPET is created if CONFIG_HPET=n
> * Use qdev_new(TYPE_HPET) at pc_basic_device_init()
> ---
>  include/hw/i386/pc.h  |  1 +
>  include/hw/i386/x86.h |  3 ---
>  hw/i386/pc.c          | 61 +++++++++++++++++++++++++++++--------------
>  hw/i386/pc_piix.c     |  2 +-
>  softmmu/vl.c          |  4 +--
>  5 files changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 84639d0ebc..911e460097 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -43,6 +43,7 @@ typedef struct PCMachineState {
>      bool smbus_enabled;
>      bool sata_enabled;
>      bool pit_enabled;
> +    bool hpet_enabled;
>  
>      /* NUMA information: */
>      uint64_t numa_nodes;
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index d5dcf7a07f..4e66a15ff5 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -124,7 +124,4 @@ qemu_irq x86_allocate_cpu_irq(void);
>  void gsi_handler(void *opaque, int n, int level);
>  void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
>  
> -/* hpet.c */
> -extern int no_hpet;
> -
>  #endif
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4e323755d0..416fb0e0f6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1142,28 +1142,31 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>       * Without KVM_CAP_PIT_STATE2, we cannot switch off the in-kernel PIT
>       * when the HPET wants to take over. Thus we have to disable the latter.
>       */
> -    if (!no_hpet && (!kvm_irqchip_in_kernel() || kvm_has_pit_state2())) {
> +    if (pcms->hpet_enabled && (!kvm_irqchip_in_kernel() ||
> +                               kvm_has_pit_state2())) {
>          hpet = qdev_try_new(TYPE_HPET);
> -        if (hpet) {
> -            /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
> -             * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
> -             * IRQ8 and IRQ2.
> -             */
> -            uint8_t compat = object_property_get_uint(OBJECT(hpet),
> -                    HPET_INTCAP, NULL);
> -            if (!compat) {
> -                qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
> -            }
> -            sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), &error_fatal);
> -            sysbus_mmio_map(SYS_BUS_DEVICE(hpet), 0, HPET_BASE);
> +        if (!hpet) {
> +            error_report("couldn't create HPET device");
> +            exit(1);
> +        }
> +        /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
> +            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
> +            * IRQ8 and IRQ2.
> +            */
> +        uint8_t compat = object_property_get_uint(OBJECT(hpet),
> +                HPET_INTCAP, NULL);
> +        if (!compat) {
> +            qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
> +        }
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), &error_fatal);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(hpet), 0, HPET_BASE);
>  
> -            for (i = 0; i < GSI_NUM_PINS; i++) {
> -                sysbus_connect_irq(SYS_BUS_DEVICE(hpet), i, gsi[i]);
> -            }
> -            pit_isa_irq = -1;
> -            pit_alt_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_PIT_INT);
> -            rtc_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_RTC_INT);
> +        for (i = 0; i < GSI_NUM_PINS; i++) {
> +            sysbus_connect_irq(SYS_BUS_DEVICE(hpet), i, gsi[i]);
>          }
> +        pit_isa_irq = -1;
> +        pit_alt_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_PIT_INT);
> +        rtc_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_RTC_INT);
>      }
>      *rtc_state = mc146818_rtc_init(isa_bus, 2000, rtc_irq);
>  
> @@ -1535,6 +1538,20 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
>      pcms->pit_enabled = value;
>  }
>  
> +static bool pc_machine_get_hpet(Object *obj, Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +
> +    return pcms->hpet_enabled;
> +}
> +
> +static void pc_machine_set_hpet(Object *obj, bool value, Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +
> +    pcms->hpet_enabled = value;
> +}
> +
>  static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
>                                              const char *name, void *opaque,
>                                              Error **errp)
> @@ -1585,6 +1602,9 @@ static void pc_machine_initfn(Object *obj)
>      pcms->smbus_enabled = true;
>      pcms->sata_enabled = true;
>      pcms->pit_enabled = true;
> +#ifdef CONFIG_HPET
> +    pcms->hpet_enabled = true;
> +#endif
>  
>      pc_system_flash_create(pcms);
>      pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
> @@ -1705,6 +1725,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>  
>      object_class_property_add_bool(oc, PC_MACHINE_PIT,
>          pc_machine_get_pit, pc_machine_set_pit);
> +
> +    object_class_property_add_bool(oc, "hpet",
> +        pc_machine_get_hpet, pc_machine_set_hpet);
>  }
>  
>  static const TypeInfo pc_machine_info = {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 0cf22a57ad..13d1628f13 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -216,7 +216,7 @@ static void pc_init1(MachineState *machine,
>          i440fx_state = NULL;
>          isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
>                                &error_abort);
> -        no_hpet = 1;
> +        pcms->hpet_enabled = false;
>      }
>      isa_bus_irqs(isa_bus, x86ms->gsi);
>  
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index cb476aa70b..c2281f45a8 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -146,7 +146,6 @@ static Chardev **serial_hds;
>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>  int win2k_install_hack = 0;
>  int singlestep = 0;
> -int no_hpet = 0;
>  int fd_bootchk = 1;
>  static int no_reboot;
>  int no_shutdown = 0;
> @@ -3562,7 +3561,8 @@ void qemu_init(int argc, char **argv, char **envp)
>                  qemu_opts_parse_noisily(olist, "acpi=off", false);
>                  break;
>              case QEMU_OPTION_no_hpet:
> -                no_hpet = 1;
> +                olist = qemu_find_opts("machine");
> +                qemu_opts_parse_noisily(olist, "hpet=off", false);
>                  break;
>              case QEMU_OPTION_no_reboot:
>                  no_reboot = 1;
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

Paolo


