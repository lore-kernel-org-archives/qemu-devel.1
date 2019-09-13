Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5790BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1860A20692
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="eKRg432d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1860A20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8roX-0002Ai-7f
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 16:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1i8rjn-0007eH-Fv
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1i8rjb-0007k3-3J
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:00:05 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1i8rja-0007jd-Mz
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 15:59:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id 41so26755648oti.12
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=laQc1mgER2G0R7nWWvmAyA91YEL9Vihl+mBNXn3OPRs=;
 b=eKRg432dH2fuWPXxFP7fe7hlysRdj920g/PwhgKCmPWVUElvMtSA2HKGqO6xqhRdSf
 O5bFU9dOhuwlvC0ndDxR17sbyUc3kUKXj8/4gXcBgmAQba9UJMHAug5BZibevGSpKC6C
 F7weMp5mzY9APSdlRAbXtcIYVy+w+Dvxp1wvXRW0Zx7uLM9JkdbJEsyR5dvSrOeVgPDL
 PJ8gSdX8tbGL1cxHQmGQgx7M9PNM2I39z19aOmanTcOVmGW+stDUdzsV1kXElDPxq9Zs
 utJOlhpDpZ5a+iJc6Xy8tOLvyqr6yIgh1ofnUXC6evsfkKI+7xpVt5cr9ka/3NxLO7/8
 /gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=laQc1mgER2G0R7nWWvmAyA91YEL9Vihl+mBNXn3OPRs=;
 b=MyO3A9BG1U4dMoNhsjV5K8ShXowk5/sBM81uNILQs+Gi3UhAHP8UKDkgE3RuKGanl4
 2+MOVSWshvgyuXaeUe/7vrRoyQyoebHh54UdDK1TTTRLA/V2OMKbdagi+hTp67hAdlFW
 Dkb3imVBeWhqugxeVR3l7GpFt4aeTPOzXbEfypbmsGhbI8cdcvD0hFV30zYybT7cjrOn
 jia88NKrjCvae8GvA107Pjt+lZ0af2hzXbljgPk8zNFDeKzpNkJVGNUywcyT7rb0HoR+
 wCa0FqXUOTMfYY+30HJWaYKAL/gPvsIFmz47dxJo5271gkCmgs2ThG/llXfd3eNgAwCy
 1jSQ==
X-Gm-Message-State: APjAAAUUy5qIdk9QvpCKAX5HmiNF6TDhGylNrGbC81Ynz4dDcls8YZlK
 qXrOrxaYG69eXrd49mWFuBwgbg==
X-Google-Smtp-Source: APXvYqzqbPkBykhcNzBHwrOExdv7tjeslJBP9d8rC0tDHnu5Sjb49zahimYUfnRWA5fbpsi2CsRkxg==
X-Received: by 2002:a9d:2043:: with SMTP id n61mr44468849ota.17.1568404797251; 
 Fri, 13 Sep 2019 12:59:57 -0700 (PDT)
Received: from t560 ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id a10sm6200321oto.17.2019.09.13.12.59.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Sep 2019 12:59:56 -0700 (PDT)
Date: Fri, 13 Sep 2019 14:59:55 -0500
From: Corey Minyard <cminyard@mvista.com>
To: minyard@acm.org
Message-ID: <20190913195955.GE13434@t560>
References: <20190819201705.31633-1-minyard@acm.org>
 <20190819201705.31633-16-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819201705.31633-16-minyard@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 15/15] pc: Add an SMB0 ACPI device to q35
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
Reply-To: cminyard@mvista.com
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 03:17:05PM -0500, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> This is so I2C devices can be found in the ACPI namespace.  Currently
> that's only IPMI, but devices can be easily added now.
> 
> Adding the devices required some PCI information, and the bus itself
> to be added to the PCMachineState structure.
> 
> Note that this only works on Q35, the ACPI for PIIX4 is not capable
> of handling an SMBus device.

I haven't recevied any comments on this, and it seems like something
some people should review.  Is this ok?

Thanks

-corey

> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/i386/acpi-build.c             |  15 +++++++++++++++
>  hw/i386/pc_piix.c                |  12 ++++++------
>  hw/i386/pc_q35.c                 |   9 +++++----
>  include/hw/i386/pc.h             |   2 ++
>  tests/data/acpi/q35/DSDT         | Bin 7841 -> 7879 bytes
>  tests/data/acpi/q35/DSDT.bridge  | Bin 7858 -> 7896 bytes
>  tests/data/acpi/q35/DSDT.cphp    | Bin 8304 -> 8342 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm | Bin 9494 -> 9532 bytes
>  tests/data/acpi/q35/DSDT.ipmibt  | Bin 7916 -> 7954 bytes
>  tests/data/acpi/q35/DSDT.memhp   | Bin 9200 -> 9238 bytes
>  tests/data/acpi/q35/DSDT.mmio64  | Bin 8971 -> 9009 bytes
>  tests/data/acpi/q35/DSDT.numamem | Bin 7847 -> 7885 bytes
>  12 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0c94e21a1a..e5fb3d6ef0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1809,6 +1809,18 @@ static Aml *build_q35_osc_method(void)
>      return method;
>  }
>  
> +static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
> +{
> +    Aml *scope = aml_scope("_SB.PCI0");
> +    Aml *dev = aml_device("SMB0");
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
> +    aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
> +    build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
> +    aml_append(scope, dev);
> +    aml_append(table, scope);
> +}
> +
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker,
>             AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -1862,6 +1874,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_q35_isa_bridge(dsdt);
>          build_isa_devices_aml(dsdt);
>          build_q35_pci0_int(dsdt);
> +        if (pcms->smbus && !pcmc->do_not_add_smb_acpi) {
> +            build_smb0(dsdt, pcms->smbus, ICH9_SMB_DEV, ICH9_SMB_FUNC);
> +        }
>      }
>  
>      if (pcmc->legacy_cpu_hotplug) {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 9e187f856a..96311b0a91 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -283,15 +283,14 @@ else {
>  
>      if (pcmc->pci_enabled && acpi_enabled) {
>          DeviceState *piix4_pm;
> -        I2CBus *smbus;
>  
>          smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
>          /* TODO: Populate SPD eeprom data.  */
> -        smbus = piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
> -                              pcms->gsi[9], smi_irq,
> -                              pc_machine_is_smm_enabled(pcms),
> -                              &piix4_pm);
> -        smbus_eeprom_init(smbus, 8, NULL, 0);
> +        pcms->smbus = piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
> +                                    pcms->gsi[9], smi_irq,
> +                                    pc_machine_is_smm_enabled(pcms),
> +                                    &piix4_pm);
> +        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
>  
>          object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
>                                   TYPE_HOTPLUG_HANDLER,
> @@ -464,6 +463,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
>  
>      pc_i440fx_4_0_machine_options(m);
>      m->is_default = 0;
> +    pcmc->do_not_add_smb_acpi = true;
>      m->smbus_no_migration_support = true;
>      m->alias = NULL;
>      pcmc->pvh_enabled = false;
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index be3464f485..7ce4fb6fdb 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -316,10 +316,10 @@ static void pc_q35_init(MachineState *machine)
>  
>      if (pcms->smbus_enabled) {
>          /* TODO: Populate SPD eeprom data.  */
> -        smbus_eeprom_init(ich9_smb_init(host_bus,
> -                                        PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
> -                                        0xb100),
> -                          8, NULL, 0);
> +        pcms->smbus = ich9_smb_init(host_bus,
> +                                    PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
> +                                    0xb100);
> +        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
>      }
>  
>      pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
> @@ -410,6 +410,7 @@ static void pc_q35_3_1_machine_options(MachineClass *m)
>  
>      pc_q35_4_0_machine_options(m);
>      m->default_kernel_irqchip_split = false;
> +    pcmc->do_not_add_smb_acpi = true;
>      m->smbus_no_migration_support = true;
>      m->alias = NULL;
>      pcmc->pvh_enabled = false;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 4bb9e29114..4013ac721c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -38,6 +38,7 @@ struct PCMachineState {
>      HotplugHandler *acpi_dev;
>      ISADevice *rtc;
>      PCIBus *bus;
> +    I2CBus *smbus;
>      FWCfgState *fw_cfg;
>      qemu_irq *gsi;
>      PFlashCFI01 *flash[2];
> @@ -116,6 +117,7 @@ typedef struct PCMachineClass {
>      bool rsdp_in_ram;
>      int legacy_acpi_table_size;
>      unsigned acpi_data_size;
> +    bool do_not_add_smb_acpi;
>  
>      /* SMBIOS compat: */
>      bool smbios_defaults;
> diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
> index f9f36d1645c9b57aea38350d67dfaa143845697d..77ea60ffed421c566138fe6341421f579129a582 100644
> GIT binary patch
> delta 62
> zcmZ2zd)$`GCD<k8xEuomWBo=hV@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
> RN0%TTW(IkN%{G#$tN;mh4yXVC
> 
> delta 24
> fcmX?ZyU>=)CD<iop&SDPquoX>W690Qk}0eJT(JhZ
> 
> diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
> index 29176832ca9842c6654273ae1246321aa38b2821..fbc2d40000428b402586ea9302b5ccf36ef8de1e 100644
> GIT binary patch
> delta 62
> zcmdmFd&8E?CD<k8h8zO}qx?oLV@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
> RN0%TTW(IkN%{G!{tN;Tx4vYW*
> 
> delta 24
> fcmca%yUCWzCD<iolN<vB<Gqbs#*&+pB}-WWXCMci
> 
> diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
> index 19bdb5d21050f24aaacbafb1f84d6e1d541876c6..6a896cb2142feadbcabc6276b59c138a7e93f540 100644
> GIT binary patch
> delta 62
> zcmez1FwK$6CD<iongRm@<ByG8#*(V4dhx+d@d3`B2GLED!M;ug9Pu8WE<9`k46GdS
> RjxIqw%nb4jn{6ab*a06=4(I>?
> 
> delta 24
> fcmbQ{_`!k8CD<jTK!JgQar;ItW690QlE&-+VHF1X
> 
> diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
> index 727fe489b4c8cdd39476ff61e7d7664c816f5291..23fdf5e60a5069f60d6c680ac9c68c4a8a81318e 100644
> GIT binary patch
> delta 62
> zcmbQ{wa1IgCD<jzMwNkq@!&=-V@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
> RN0%TTW(IkN%{G#^xB>h%4&?v<
> 
> delta 24
> fcmdnvHO-65CD<iIOqGFwv0)>ZvE=4t$(!5&ShNQA
> 
> diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
> index 9634930e6125de4375d87a56a353f636985599d4..c3fca0a71efa7b55c958a49f305389426fbe7922 100644
> GIT binary patch
> delta 62
> zcmaE3JIRjACD<iINS=X#aq&j3I!RSkz4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
> RN0%TTW(IkN&Fzw@tN{Nt4#fZf
> 
> delta 24
> fcmbPa_r{jXCD<k8jT{35WAa9>I?2uJBvV)cXHo~&
> 
> diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
> index dad5dc8db2f13bdb0de001da42c13b18286c3061..2abd0e36cd1344cbca3fa4ab59c5db2ea326d125 100644
> GIT binary patch
> delta 62
> zcmez1KFx#6CD<iIOof4gv0x*Yv81Z1UVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB11m?o
> Rqe~DEGlM+CW*f;ZTmbN04s`$k
> 
> delta 24
> fcmbQ{@xh(TCD<k8gE9jHqrpZlW690QlAE~zWv~Z^
> 
> diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
> index 20f627ed08a0cae4e144f3e4dd7dd5f1d8d0318c..b32034a11c1f8a0a156df3765df44b14a88dbb4d 100644
> GIT binary patch
> delta 62
> zcmeBn+vvvS66_LUsLa5?sI!sFSW;D0FFx2QKET=2Ai7C1*w@K`Bi_T)g@;Xmft4fP
> R(Itq7nL(amvyJ3=P5{<m4j2Fc
> 
> delta 24
> fcmdn!*6qgS66_Mft<1o{_<AFkvE=4t$#a|lSziY!
> 
> diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
> index 7b96a972804e95e191d9d3bf9a965e90f6f7e555..d8b2b47f8b47067d375021a30086ca97d8aca43f 100644
> GIT binary patch
> delta 62
> zcmZ2(d)AiACD<k8tQ-Raqvl2~V@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
> RN0%TTW(IkN%{G$RtN{IN4r%}Z
> 
> delta 24
> fcmX?WyWEz`CD<ioxf}xn<BN@4#*&+pC9_xoWX}hC
> 
> -- 
> 2.17.1
> 

