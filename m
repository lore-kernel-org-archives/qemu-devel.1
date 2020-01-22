Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE3C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF5724125
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="tY1RDxki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF5724125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuAEz-0008SM-MH
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 02:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iuADy-0007pc-P2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iuADs-0002hK-Np
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:14:49 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1iuADs-0002fF-CJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:14:44 -0500
Received: by mail-pl1-x643.google.com with SMTP id c23so2568285plz.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 23:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d17Se2ZgDhJEJYy9MZv2uOsQOrhSHgPN0CE4Wpkje1I=;
 b=tY1RDxkiUKWbWPjIC5RKWt9I8gHt7DriBDn56JwovmQQ3Bo5ZztJvn9M/JyoR2Fi/d
 /7pEEldOoyFqmaDVLJfdI8ArGQt3keEzoNAnhLrg5bmIw5pfhEEiyrYK/fi0v7pm1GjK
 d6rSd4ZYoZPDSgc3oJPQwsDHPHbgJfoBVkQMdF9+lyCdOgxuIqYX8WG/fW4Y7yG2+358
 U7peZGSUdVpDcRSmvYLsagrDK0NEEfmVHm1If3ubLOadreODRO4bJtCTptFBPks3rwV/
 HqCMMXink99FAG2eXbshgF1cKxRqFHcIKOucUsKD4OR05Sqkg0+fGtSOowQLWmtEwpyc
 CdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=d17Se2ZgDhJEJYy9MZv2uOsQOrhSHgPN0CE4Wpkje1I=;
 b=dchc0K6XYy13Qxz4P7bo9ek0Vi5CGl/RZUdvH9C/SQj+4R4MccQExhQG3t5AYznr11
 5CimxUj1xq52eqSoj5mh838r2QtGGu0LLgNNKnb6kAuqt8dGIOMzdTHJr1SIFb9q/Vpe
 RTBWFPB1mwCLKsRWjJggJHiS/usmdr+90xOtnd7qUotiYEWyeumJS0vYLWNjrRE3ac2E
 1xvhlT6LH3jdU0MxzHklZSeXfJfQVN8HMZSl49cahkSFiMLnHLFjAHWn3Jr0YWboIWGs
 wrqCf8fthfu6u6MsozvQmMfb4wCdmTsuKlskObx+qrGwoO6O9P+gqGzFOr9NUU1SbWV5
 Inmg==
X-Gm-Message-State: APjAAAWaSxXPY8QipczAq4RWwdtnYOQFovC8ohWb/d1uI5f22GNRbvPg
 tHYKGWTLMEzjy1nizK9ownFZ6Ri5GuI=
X-Google-Smtp-Source: APXvYqz3zIUhbn2xHiV14mLjuTcn2MkOmPgN2ysU4Gp1ADdBvXCZ4ucZmdZ9rlC4D8R+f5UKdIXF4Q==
X-Received: by 2002:a17:90a:7f01:: with SMTP id
 k1mr1391264pjl.81.1579677281565; 
 Tue, 21 Jan 2020 23:14:41 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id u12sm43887996pfm.165.2020.01.21.23.14.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 23:14:40 -0800 (PST)
Subject: Re: [PATCH qemu v5] spapr: Kill SLOF
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200110020925.98711-1-aik@ozlabs.ru>
 <20200121051100.GG265522@umbus.fritz.box>
 <2aee3928-0acb-65ee-de54-de2e8106a6ba@ozlabs.ru>
 <20200122063222.GJ2347@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <6ccbb008-9300-0e4d-bfc2-873d8562cb68@ozlabs.ru>
Date: Wed, 22 Jan 2020 18:14:37 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200122063222.GJ2347@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 22/01/2020 17:32, David Gibson wrote:
> On Tue, Jan 21, 2020 at 06:25:36PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 21/01/2020 16:11, David Gibson wrote:
>>> On Fri, Jan 10, 2020 at 01:09:25PM +1100, Alexey Kardashevskiy wrote:
>>>> The Petitboot bootloader is way more advanced than SLOF is ever going to
>>>> be as Petitboot comes with the full-featured Linux kernel with all
>>>> the drivers, and initramdisk with quite user friendly interface.
>>>> The problem with ditching SLOF is that an unmodified pseries kernel can
>>>> either start via:
>>>> 1. kexec, this requires presence of RTAS and skips
>>>> ibm,client-architecture-support entirely;
>>>> 2. normal boot, this heavily relies on the OF1275 client interface to
>>>> fetch the device tree and do early setup (claim memory).
>>>>
>>>> This adds a new bios-less mode to the pseries machine: "bios=on|off".
>>>> When enabled, QEMU does not load SLOF and jumps to the kernel from
>>>> "-kernel".
>>>
>>> I don't love the name "bios" for this flag, since BIOS tends to refer
>>> to old-school x86 firmware.  Given the various plans we're considering
>>> the future, I'd suggest "firmware=slof" for the current in-guest SLOF
>>> mode, and say "firmware=vof" (Virtual Open Firmware) for the new
>>> model.  We can consider firmware=petitboot or firmware=none (for
>>> direct kexec-style boot into -kernel) or whatever in the future
>>
>> Ok. We could also enforce default loading addresses for SLOF/kernel/grub
>> and drop "kernel-addr", although it is going to be confusing if it
>> changes in not so obvious way...
> 
> Yes, I think that would be confusing, so I think adding the
> kernel-addr override is a good idea, I'd just like it split out for
> clarity.
> 
>> In fact, I will ideally need 3 flags:
>> -bios: on|off to stop loading SLOF;
>> -kernel-addr: 0x0 for slof/kernel; 0x20000 for grub;
> 
> I'm happy for that one to be separate from the "firmware style"
> option.
> 
>> -kernel-translate-hack: on|off - as grub is linked to run from 0x20000
>> and it only works when placed there, the hack breaks it.
> 
> Hrm.  I don't really understand what this one is about.  That doesn't
> really seem like something the user would ever want to fiddle with
> directly.

This allows loading grub, or actually any elf (not that I have anything
else in mind that just grub but still) which is not capable of
relocating itself.


>> Or we can pass grub via -bios and not via -kernel but strictly speaking
>> there is still a firmware - that new 20 bytes blob so it would not be
>> accurate.
>>
>> We can put this all into a single
>> -firmware slof|vof|grub|linux. Not sure.
> 
> I'm not thinking of "grub" as a separate option - that would be the
> same as "vof".  Using vof + no -kernel we'd need to scan the disks in
> the same way SLOF does, and look for a boot partition, which will
> probably contain a GRUB image. 

I was hoping we can avoid that by allowing
"-kernel grub" and let grub do filesystems and MBR/GPT.

> Then we'd need enough faked OF client
> calls to let GRUB operate.

v6 does very basic block devices. Now I need to learn how to build grub
properly, it is 32bit and it is not straight forward how to build it
100% properly on ppc64 machine, I see occasional issues such as
uint32->uint64 extension with a garbage in the top 32bits, things like
this... But it can definitely read MBR/GPT, parse FS, etc.


> 
>>>> The client interface is implemented exactly as RTAS - a 20 bytes blob,
>>>> right next after the RTAS blob. The entry point is passed to the kernel
>>>> via GPR5.
>>>>
>>>> This implements a handful of client interface methods just to get going.
>>>> In particular, this implements the device tree fetching,
>>>> ibm,client-architecture-support and instantiate-rtas.
>>>>
>>>> This implements changing FDT properties for RTAS (for vmlinux and zImage)
>>>> and initramdisk location (for zImage). To make this work, this skips
>>>> fdt_pack() when bios=off as not packing the blob leaves some room for
>>>> appending.
>>>>
>>>> This assigns "phandles" to device tree nodes as there is no more SLOF
>>>> and OF nodes addresses of which served as phandle values.
>>>> This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
>>>> phandles are regenerated at every FDT rebuild.
>>>>
>>>> When bios=off, this adds "/chosen" every time QEMU builds a tree.
>>>>
>>>> This implements "claim" which the client (Linux) uses for memory
>>>> allocation; this is also  used by QEMU for claiming kernel/initrd images,
>>>> client interface entry point, RTAS and the initial stack.
>>>>
>>>> While at this, add a "kernel-addr" machine parameter to allow moving
>>>> the kernel in memory. This is useful for debugging if the kernel is
>>>> loaded at @0, although not necessary.
>>>>
>>>> This adds basic instances support which are managed by a hashmap
>>>> ihandle->[phandle, DeviceState, Chardev].
>>>>
>>>> Note that a 64bit PCI fix is required for Linux:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df5be5be8735e
>>>>
>>>> The test command line:
>>>>
>>>> qemu-system-ppc64 \
>>>> -nodefaults \
>>>> -chardev stdio,id=STDIO0,signal=off,mux=on \
>>>> -device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
>>>> -mon id=MON0,chardev=STDIO0,mode=readline \
>>>> -nographic \
>>>> -vga none \
>>>> -kernel pbuild/kernel-le-guest/arch/powerpc/boot/zImage.pseries \
>>>> -machine pseries,bios=off,cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken \
>>>> -m 4G \
>>>> -enable-kvm \
>>>> -initrd pb/rootfs.cpio.xz \
>>>> -device nec-usb-xhci,id=nec-usb-xhci0 \
>>>> -netdev tap,id=TAP0,helper=/home/aik/qemu-bridge-helper --br=br0 \
>>>> -device virtio-net-pci,id=vnet0,netdev=TAP0 img/f30le.qcow2 \
>>>> -snapshot \
>>>> -smp 8,threads=8 \
>>>> -trace events=qemu_trace_events \
>>>> -d guest_errors \
>>>> -chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.ssh54088 \
>>>> -mon chardev=SOCKET0,mode=control
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> It'd be nice to split this patch up a bit, though I'll admit it's not
>>> very obvious where to do so.
>>
>>
>> v6 is a patchset.
>>
>>>> ---
>>>> Changes:
>>>> v5:
>>>> * made instances keep device and chardev pointers
>>>> * removed VIO dependencies
>>>> * print error if RTAS memory is not claimed as it should have been
>>>> * pack FDT as "quiesce"
>>>>
>>>> v4:
>>>> * fixed open
>>>> * validate ihandles in "call-method"
>>>>
>>>> v3:
>>>> * fixed phandles allocation
>>>> * s/__be32/uint32_t/ as we do not normally have __be32 type in qemu
>>>> * fixed size of /chosen/stdout
>>>> * bunch of renames
>>>> * do not create rtas properties at all, let the client deal with it;
>>>> instead setprop allows changing these in the FDT
>>>> * no more packing FDT when bios=off - nobody needs it and getprop does not
>>>> work otherwise
>>>> * allow updating initramdisk device tree properties (for zImage)
>>>> * added instances
>>>> * fixed stdout on OF's "write"
>>>> * removed special handling for stdout in OF client, spapr-vty handles it
>>>> instead
>>>>
>>>> v2:
>>>> * fixed claim()
>>>> * added "setprop"
>>>> * cleaner client interface and RTAS blobs management
>>>> * boots to petitboot and further to the target system
>>>> * more trace points
>>>> ---
>>>>  hw/ppc/Makefile.objs     |   1 +
>>>>  include/hw/ppc/spapr.h   |  28 +-
>>>>  hw/ppc/spapr.c           | 266 ++++++++++++++--
>>>>  hw/ppc/spapr_hcall.c     |  74 +++--
>>>>  hw/ppc/spapr_of_client.c | 633 +++++++++++++++++++++++++++++++++++++++
>>>>  hw/ppc/trace-events      |  12 +
>>>>  6 files changed, 959 insertions(+), 55 deletions(-)
>>>>  create mode 100644 hw/ppc/spapr_of_client.c
>>>>
>>>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>>>> index 101e9fc59185..20efc0aa6f9b 100644
>>>> --- a/hw/ppc/Makefile.objs
>>>> +++ b/hw/ppc/Makefile.objs
>>>> @@ -6,6 +6,7 @@ obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
>>>>  obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
>>>>  obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>>>>  obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
>>>> +obj-$(CONFIG_PSERIES) += spapr_of_client.o
>>>>  obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
>>>>  # IBM PowerNV
>>>>  obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index 61f005c6f686..efc2c70abf99 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -105,6 +105,11 @@ struct SpaprCapabilities {
>>>>      uint8_t caps[SPAPR_CAP_NUM];
>>>>  };
>>>>  
>>>> +typedef struct {
>>>> +    uint64_t start;
>>>> +    uint64_t size;
>>>> +} SpaprOfClaimed;
>>>> +
>>>
>>> Can we split more of the fake-OF code into a new file?
>>
>>
>> Done in v6, I quite reworked it, this is why I told you to ping me
>> before you review this one :)
> 
> Oops, I forgot.  Sorry.
> 
>>>>  /**
>>>>   * SpaprMachineClass:
>>>>   */
>>>> @@ -160,6 +165,13 @@ struct SpaprMachineState {
>>>>      void *fdt_blob;
>>>>      long kernel_size;
>>>>      bool kernel_le;
>>>> +    uint64_t kernel_addr;
>>>> +    bool bios_enabled;
>>>> +    uint32_t rtas_base;
>>>> +    GArray *claimed; /* array of SpaprOfClaimed */
>>>> +    uint64_t claimed_base;
>>>> +    GHashTable *of_instances; /* ihandle -> SpaprOfInstance */
>>>> +    uint32_t of_instance_last;
>>>>      uint32_t initrd_base;
>>>>      long initrd_size;
>>>>      uint64_t rtc_offset; /* Now used only during incoming migration */
>>>> @@ -510,7 +522,8 @@ struct SpaprMachineState {
>>>>  /* Client Architecture support */
>>>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>>>>  #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
>>>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
>>>> +#define KVMPPC_H_CLIENT         (KVMPPC_HCALL_BASE + 0x5)
>>>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_CLIENT
>>>>  
>>>>  /*
>>>>   * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
>>>> @@ -538,6 +551,11 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
>>>>  target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>>>                               target_ulong *args);
>>>>  
>>>> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
>>>> +                                            SpaprMachineState *spapr,
>>>> +                                            target_ulong addr,
>>>> +                                            target_ulong fdt_bufsize);
>>>> +
>>>>  /* Virtual Processor Area structure constants */
>>>>  #define VPA_MIN_SIZE           640
>>>>  #define VPA_SIZE_OFFSET        0x4
>>>> @@ -769,6 +787,11 @@ struct SpaprEventLogEntry {
>>>>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space);
>>>>  void spapr_events_init(SpaprMachineState *sm);
>>>>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
>>>> +uint64_t spapr_do_of_client_claim(SpaprMachineState *spapr, uint64_t virt,
>>>> +                                  uint64_t size, uint64_t align);
>>>> +
>>>> +uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path);
>>>> +int spapr_h_client(SpaprMachineState *spapr, target_ulong client_args);
>>>>  void close_htab_fd(SpaprMachineState *spapr);
>>>>  void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
>>>>  void spapr_free_hpt(SpaprMachineState *spapr);
>>>> @@ -891,4 +914,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>>>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
>>>>  
>>>>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>>>> +
>>>> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base);
>>>> +
>>>>  #endif /* HW_SPAPR_H */
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index e62c89b3dd40..76ce8b973082 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -896,6 +896,55 @@ out:
>>>>      return ret;
>>>>  }
>>>>  
>>>> +/*
>>>> + * Below is a compiled version of RTAS blob and OF client interface entry point.
>>>> + *
>>>> + * gcc -nostdlib  -mbig -o spapr-rtas.img spapr-rtas.S
>>>> + * objcopy  -O binary -j .text  spapr-rtas.img spapr-rtas.bin
>>>> + *
>>>> + *   .globl  _start
>>>> + *   _start:
>>>> + *           mr      4,3
>>>> + *           lis     3,KVMPPC_H_RTAS@h
>>>> + *           ori     3,3,KVMPPC_H_RTAS@l
>>>> + *           sc      1
>>>> + *           blr
>>>> + *           mr      4,3
>>>> + *           lis     3,KVMPPC_H_CLIENT@h
>>>> + *           ori     3,3,KVMPPC_H_CLIENT@l
>>>> + *           sc      1
>>>> + *           blr
>>>> + */
>>>> +static struct {
>>>
>>> Should be able to add a 'const' here.
>>>
>>>> +    uint8_t rtas[20], client[20];
>>>> +} QEMU_PACKED rtas_client_blob = {
>>>> +    .rtas = {
>>>> +        0x7c, 0x64, 0x1b, 0x78,
>>>> +        0x3c, 0x60, 0x00, 0x00,
>>>> +        0x60, 0x63, 0xf0, 0x00,
>>>> +        0x44, 0x00, 0x00, 0x22,
>>>> +        0x4e, 0x80, 0x00, 0x20
>>>> +    },
>>>> +    .client = {
>>>> +        0x7c, 0x64, 0x1b, 0x78,
>>>> +        0x3c, 0x60, 0x00, 0x00,
>>>> +        0x60, 0x63, 0xf0, 0x05,
>>>> +        0x44, 0x00, 0x00, 0x22,
>>>> +        0x4e, 0x80, 0x00, 0x20
>>>> +    }
>>>> +};
>>>
>>> I'd split this into two variables - there's not really any connection
>>> between the two, AFAICT.
>>>
>>> Note that I'm getting closer to merging the fwnmi stuff at which point
>>> you'll need to pad the RTAS blob with a bunch of extra space for
>>> taking the fwnmi dumps.
>>>
>>>> +
>>>> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base)
>>>> +{
>>>> +    if (spapr_do_of_client_claim(spapr, base, sizeof(rtas_client_blob.rtas),
>>>> +                                 0) != -1) {
>>>
>>> Wait.. == -1 is the success case?  That's a very surprising interface.
>>
>>
>> This is a sort of an assert. spapr_do_of_client_claim() returns an
>> address and the client is expected to claim the memory which it wants
>> RTAS to be copied to, this makes sure it either happened or we claimed
>> it here.
> 
> Ah!  Ok, I understand.
> 
>>>> +        error_report("The OF client did not claim RTAS memory at 0x%x", base);
>>>
>>> Error message is hard to follow.  Maybe "Could not claim memory
>>> for RTAS"
> 
> Which makes my suggestion here a bad one too.
> 
>>>
>>>> +    }
>>>> +    spapr->rtas_base = base;
>>>> +    cpu_physical_memory_write(base, rtas_client_blob.rtas,
>>>> +                              sizeof(rtas_client_blob.rtas));
>>>> +}
>>>> +
>>>>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>>>  {
>>>>      MachineState *ms = MACHINE(spapr);
>>>> @@ -980,6 +1029,11 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>>>      _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
>>>>                       lrdr_capacity, sizeof(lrdr_capacity)));
>>>>  
>>>> +    if (!spapr->bios_enabled) {
>>>> +        _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size",
>>>> +                              sizeof(rtas_client_blob.rtas)));
>>>> +    }
>>>> +
>>>>      spapr_dt_rtas_tokens(fdt, rtas);
>>>>  }
>>>>  
>>>> @@ -1057,7 +1111,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>>>      }
>>>>  
>>>>      if (spapr->kernel_size) {
>>>> -        uint64_t kprop[2] = { cpu_to_be64(KERNEL_LOAD_ADDR),
>>>> +        uint64_t kprop[2] = { cpu_to_be64(spapr->kernel_addr),
>>>
>>> Hrm, I really think I would like to see the change to adjustable
>>> kernel_addr split out - it puts a bunch of noise into the main kill
>>> slof patch.
>>
>> Sure, I'll do that if we decide to proceed with this.
>>
>>
>>>
>>>>                                cpu_to_be64(spapr->kernel_size) };
>>>>  
>>>>          _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
>>>> @@ -1245,7 +1299,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>>>>      /* Build memory reserve map */
>>>>      if (reset) {
>>>>          if (spapr->kernel_size) {
>>>> -            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
>>>> +            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
>>>> +                                  spapr->kernel_size)));
>>>>          }
>>>>          if (spapr->initrd_size) {
>>>>              _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
>>>> @@ -1268,12 +1323,56 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>>>>          }
>>>>      }
>>>>  
>>>> +    if (!spapr->bios_enabled) {
>>>> +        uint32_t phandle;
>>>> +        int i, offset, proplen = 0;
>>>> +        const void *prop;
>>>> +        bool found = false;
>>>> +        GArray *phandles = g_array_new(false, false, sizeof(uint32_t));
>>>> +
>>>> +        /* Find all predefined phandles */
>>>> +        for (offset = fdt_next_node(fdt, -1, NULL);
>>>> +             offset >= 0;
>>>> +             offset = fdt_next_node(fdt, offset, NULL)) {
>>>> +            prop = fdt_getprop_namelen(fdt, offset, "phandle", 7, &proplen);
>>>
>>> You can just use fdt_getprop() rather than the namelen variant (that's
>>> only really useful when you don't have a \0-terminated string with the
>>> name).
>>
>> Ok, will fix. There are just too many similar functions in libfdt.h and
>> fdt_getprop() could be inlined, probably.
> 
> It won't be inlined, but I think it will be tail-call optimized so it
> might as well be.  That is, I think the .o will look something like:
> 
> fdt_getprop:
> 	jiggle some registers
> 	bl	strlen
> 	jiggle some regs
> fdt_getprop_namelen:
> 	...
> 	blr
> 
>>>> +            if (prop && proplen == sizeof(uint32_t)) {
>>>> +                phandle = fdt32_ld(prop);
>>>> +                g_array_append_val(phandles, phandle);
>>>> +            }
>>>> +        }
>>>> +
>>>> +        /* Assign phandles skipping the predefined ones */
>>>> +        for (offset = fdt_next_node(fdt, -1, NULL), phandle = 1;
>>>> +             offset >= 0;
>>>> +             offset = fdt_next_node(fdt, offset, NULL), ++phandle) {
>>>> +            prop = fdt_getprop_namelen(fdt, offset, "phandle", 7, &proplen);
>>>> +            if (prop) {
>>>> +                continue;
>>>> +            }
>>>> +            /* Check if the current phandle is not allocated already */
>>>> +            for ( ; ; ++phandle) {
>>>> +                for (i = 0, found = false; i < phandles->len; ++i) {
>>>> +                    if (phandle == g_array_index(phandles, uint32_t, i)) {
>>>> +                        found = true;
>>>> +                        break;
>>>> +                    }
>>>> +                }
>>>> +                if (!found) {
>>>> +                    break;
>>>> +                }
>>>> +            }
>>>> +            _FDT(fdt_setprop_cell(fdt, offset, "phandle", phandle));
>>>> +        }
>>>> +        g_array_unref(phandles);
>>>> +    }
>>>> +
>>>>      return fdt;
>>>>  }
>>>>  
>>>>  static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>>>>  {
>>>> -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>>>> +    SpaprMachineState *spapr = opaque;
>>>> +    return (addr & 0x0fffffff) + spapr->kernel_addr;
>>>>  }
>>>>  
>>>>  static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
>>>> @@ -1660,24 +1759,89 @@ static void spapr_machine_reset(MachineState *machine)
>>>>       */
>>>>      fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
>>>>  
>>>> +    /* Set up the entry state */
>>>> +    if (!spapr->bios_enabled) {
>>>> +        if (spapr->claimed) {
>>>> +            g_array_unref(spapr->claimed);
>>>> +        }
>>>> +        if (spapr->of_instances) {
>>>> +            g_hash_table_unref(spapr->of_instances);
>>>> +        }
>>>> +
>>>> +        spapr->claimed = g_array_new(false, false, sizeof(SpaprOfClaimed));
>>>> +        spapr->of_instances = g_hash_table_new(g_direct_hash, g_direct_equal);
>>>> +
>>>> +        spapr->claimed_base = 0x10000; /* Avoid using the first system page */
>>>> +
>>>> +        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr,
>>>> +                                  spapr->initrd_base);
>>>> +        first_ppc_cpu->env.gpr[4] = spapr->initrd_size;
>>>> +
>>>> +        if (spapr_do_of_client_claim(spapr, spapr->kernel_addr,
>>>> +                                  spapr->kernel_size, 0) == -1) {
>>>> +            error_report("Memory for kernel is in use");
>>>> +            exit(1);
>>>> +        }
>>>> +        if (spapr_do_of_client_claim(spapr, spapr->initrd_base,
>>>> +                                  spapr->initrd_size, 0) == -1) {
>>>> +            error_report("Memory for initramdisk is in use");
>>>> +            exit(1);
>>>> +        }
>>>> +        first_ppc_cpu->env.gpr[1] = spapr_do_of_client_claim(spapr, 0, 0x40000,
>>>> +                                                             0x10000);
>>>> +        if (first_ppc_cpu->env.gpr[1] == -1) {
>>>> +            error_report("Memory allocation for stack failed");
>>>> +            exit(1);
>>>> +        }
>>>> +
>>>> +        first_ppc_cpu->env.gpr[5] =
>>>> +            spapr_do_of_client_claim(spapr, 0, sizeof(rtas_client_blob.client),
>>>> +                                     sizeof(rtas_client_blob.client));
>>>> +        if (first_ppc_cpu->env.gpr[5] == -1) {
>>>> +            error_report("Memory allocation for OF client failed");
>>>> +            exit(1);
>>>> +        }
>>>> +        cpu_physical_memory_write(first_ppc_cpu->env.gpr[5],
>>>> +                                  rtas_client_blob.client,
>>>> +                                  sizeof(rtas_client_blob.client));
>>>> +    } else {
>>>> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>>>> +        first_ppc_cpu->env.gpr[5] = 0; /* 0 = kexec !0 = prom_init */
>>>> +    }
>>>> +
>>>>      fdt = spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
>>>>  
>>>> -    rc = fdt_pack(fdt);
>>>> -
>>>> -    /* Should only fail if we've built a corrupted tree */
>>>> -    assert(rc == 0);
>>>> -
>>>> -    /* Load the fdt */
>>>> -    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>>> -    cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
>>>>      g_free(spapr->fdt_blob);
>>>>      spapr->fdt_size = fdt_totalsize(fdt);
>>>>      spapr->fdt_initial_size = spapr->fdt_size;
>>>>      spapr->fdt_blob = fdt;
>>>>  
>>>> -    /* Set up the entry state */
>>>> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>>>> -    first_ppc_cpu->env.gpr[5] = 0;
>>>> +    if (spapr->bios_enabled) {
>>>> +        /* Load the fdt */
>>>> +        rc = fdt_pack(spapr->fdt_blob);
>>>> +        /* Should only fail if we've built a corrupted tree */
>>>> +        assert(rc == 0);
>>>> +
>>>> +        spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
>>>> +        spapr->fdt_initial_size = spapr->fdt_size;
>>>> +        qemu_fdt_dumpdtb(spapr->fdt_blob, spapr->fdt_size);
>>>
>>> I think we should still have a dumpdtb call on the !bios path.
>>>
>>>> +        cpu_physical_memory_write(fdt_addr, spapr->fdt_blob, spapr->fdt_size);
>>>> +    } else {
>>>> +        char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
>>>> +        int offset = fdt_path_offset(fdt, "/chosen");
>>>> +
>>>> +        /*
>>>> +         * SLOF-less setup requires an open instance of stdout for early
>>>> +         * kernel printk. By now all phandles are settled so we can open
>>>> +         * the default serial console.
>>>> +         * We skip writing FDT as nothing expects it; OF client interface is
>>>> +         * going to be used for reading the device tree.
>>>> +         */
>>>> +        if (stdout_path) {
>>>> +            _FDT(fdt_setprop_cell(fdt, offset, "stdout",
>>>> +                                  spapr_of_client_open(spapr, stdout_path)));
>>>> +        }
>>>> +    }
>>>>  
>>>>      spapr->cas_reboot = false;
>>>>  }
>>>> @@ -2897,12 +3061,12 @@ static void spapr_machine_init(MachineState *machine)
>>>>          uint64_t lowaddr = 0;
>>>>  
>>>>          spapr->kernel_size = load_elf(kernel_filename, NULL,
>>>> -                                      translate_kernel_address, NULL,
>>>> +                                      translate_kernel_address, spapr,
>>>>                                        NULL, &lowaddr, NULL, 1,
>>>>                                        PPC_ELF_MACHINE, 0, 0);
>>>>          if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
>>>>              spapr->kernel_size = load_elf(kernel_filename, NULL,
>>>> -                                          translate_kernel_address, NULL, NULL,
>>>> +                                          translate_kernel_address, spapr, NULL,
>>>>                                            &lowaddr, NULL, 0, PPC_ELF_MACHINE,
>>>>                                            0, 0);
>>>>              spapr->kernel_le = spapr->kernel_size > 0;
>>>> @@ -2918,7 +3082,7 @@ static void spapr_machine_init(MachineState *machine)
>>>>              /* Try to locate the initrd in the gap between the kernel
>>>>               * and the firmware. Add a bit of space just in case
>>>>               */
>>>> -            spapr->initrd_base = (KERNEL_LOAD_ADDR + spapr->kernel_size
>>>> +            spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
>>>>                                    + 0x1ffff) & ~0xffff;
>>>>              spapr->initrd_size = load_image_targphys(initrd_filename,
>>>>                                                       spapr->initrd_base,
>>>> @@ -2932,20 +3096,22 @@ static void spapr_machine_init(MachineState *machine)
>>>>          }
>>>>      }
>>>>  
>>>> -    if (bios_name == NULL) {
>>>> -        bios_name = FW_FILE_NAME;
>>>> +    if (spapr->bios_enabled) {
>>>> +        if (bios_name == NULL) {
>>>> +            bios_name = FW_FILE_NAME;
>>>> +        }
>>>> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>>> +        if (!filename) {
>>>> +            error_report("Could not find LPAR firmware '%s'", bios_name);
>>>> +            exit(1);
>>>> +        }
>>>> +        fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
>>>> +        if (fw_size <= 0) {
>>>> +            error_report("Could not load LPAR firmware '%s'", filename);
>>>> +            exit(1);
>>>> +        }
>>>> +        g_free(filename);
>>>>      }
>>>> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>>> -    if (!filename) {
>>>> -        error_report("Could not find LPAR firmware '%s'", bios_name);
>>>> -        exit(1);
>>>> -    }
>>>> -    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
>>>> -    if (fw_size <= 0) {
>>>> -        error_report("Could not load LPAR firmware '%s'", filename);
>>>> -        exit(1);
>>>> -    }
>>>> -    g_free(filename);
>>>>  
>>>>      /* FIXME: Should register things through the MachineState's qdev
>>>>       * interface, this is a legacy from the sPAPREnvironment structure
>>>> @@ -3162,6 +3328,32 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>>>>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>>>  }
>>>>  
>>>> +static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *name,
>>>> +                                  void *opaque, Error **errp)
>>>> +{
>>>> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>>>> +}
>>>> +
>>>> +static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *name,
>>>> +                                  void *opaque, Error **errp)
>>>> +{
>>>> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>>>> +}
>>>> +
>>>> +static bool spapr_get_bios_enabled(Object *obj, Error **errp)
>>>> +{
>>>> +    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>>>> +
>>>> +    return spapr->bios_enabled;
>>>> +}
>>>> +
>>>> +static void spapr_set_bios_enabled(Object *obj, bool value, Error **errp)
>>>> +{
>>>> +    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>>>> +
>>>> +    spapr->bios_enabled = value;
>>>> +}
>>>> +
>>>>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>>>>  {
>>>>      SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>>>> @@ -3267,6 +3459,20 @@ static void spapr_instance_init(Object *obj)
>>>>      object_property_add_bool(obj, "vfio-no-msix-emulation",
>>>>                               spapr_get_msix_emulation, NULL, NULL);
>>>>  
>>>> +    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_addr,
>>>> +                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
>>>> +                        &error_abort);
>>>> +    object_property_set_description(obj, "kernel-addr",
>>>> +                                    stringify(KERNEL_LOAD_ADDR)
>>>> +                                    " for -kernel is the default",
>>>> +                                    NULL);
>>>> +    spapr->kernel_addr = KERNEL_LOAD_ADDR;
>>>> +    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
>>>> +                            spapr_set_bios_enabled, NULL);
>>>> +    object_property_set_description(obj, "bios", "Conrols whether to load bios",
>>>> +                                    NULL);
>>>> +    spapr->bios_enabled = true;
>>>> +
>>>>      /* The machine class defines the default interrupt controller mode */
>>>>      spapr->irq = smc->irq;
>>>>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
>>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>>> index f1799b1b707d..f2d8823d2c3a 100644
>>>> --- a/hw/ppc/spapr_hcall.c
>>>> +++ b/hw/ppc/spapr_hcall.c
>>>> @@ -1660,15 +1660,11 @@ static bool spapr_hotplugged_dev_before_cas(void)
>>>>      return false;
>>>>  }
>>>>  
>>>> -static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>>> -                                                  SpaprMachineState *spapr,
>>>> -                                                  target_ulong opcode,
>>>> -                                                  target_ulong *args)
>>>> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
>>>> +                                            SpaprMachineState *spapr,
>>>> +                                            target_ulong addr,
>>>> +                                            target_ulong fdt_bufsize)
>>>>  {
>>>> -    /* Working address in data buffer */
>>>> -    target_ulong addr = ppc64_phys_to_real(args[0]);
>>>> -    target_ulong fdt_buf = args[1];
>>>> -    target_ulong fdt_bufsize = args[2];
>>>>      target_ulong ov_table;
>>>>      uint32_t cas_pvr;
>>>>      SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
>>>> @@ -1816,7 +1812,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>>>  
>>>>      if (!spapr->cas_reboot) {
>>>>          void *fdt;
>>>> -        SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
>>>>  
>>>>          /* If spapr_machine_reset() did not set up a HPT but one is necessary
>>>>           * (because the guest isn't going to use radix) then set it up here. */
>>>> @@ -1825,21 +1820,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>>>              spapr_setup_hpt_and_vrma(spapr);
>>>>          }
>>>>  
>>>> -        if (fdt_bufsize < sizeof(hdr)) {
>>>> -            error_report("SLOF provided insufficient CAS buffer "
>>>> -                         TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
>>>> -            exit(EXIT_FAILURE);
>>>> -        }
>>>> -
>>>> -        fdt_bufsize -= sizeof(hdr);
>>>> -
>>>> -        fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
>>>> -        _FDT((fdt_pack(fdt)));
>>>> -
>>>> -        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
>>>> -        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
>>>> -                                  fdt_totalsize(fdt));
>>>> -        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
>>>> +        fdt = spapr_build_fdt(spapr, !spapr->bios_enabled, fdt_bufsize);
>>>>  
>>>>          g_free(spapr->fdt_blob);
>>>>          spapr->fdt_size = fdt_totalsize(fdt);
>>>> @@ -1854,6 +1835,41 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>>>      return H_SUCCESS;
>>>>  }
>>>>  
>>>> +static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>>> +                                                  SpaprMachineState *spapr,
>>>> +                                                  target_ulong opcode,
>>>> +                                                  target_ulong *args)
>>>> +{
>>>> +    /* Working address in data buffer */
>>>> +    target_ulong addr = ppc64_phys_to_real(args[0]);
>>>> +    target_ulong fdt_buf = args[1];
>>>> +    target_ulong fdt_bufsize = args[2];
>>>> +    target_ulong ret;
>>>> +    SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
>>>> +
>>>> +    if (fdt_bufsize < sizeof(hdr)) {
>>>> +        error_report("SLOF provided insufficient CAS buffer "
>>>> +                     TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
>>>> +        exit(EXIT_FAILURE);
>>>> +    }
>>>> +
>>>> +    fdt_bufsize -= sizeof(hdr);
>>>> +
>>>> +    ret = do_client_architecture_support(cpu, spapr, addr, fdt_bufsize);
>>>> +    if (ret == H_SUCCESS) {
>>>> +        _FDT((fdt_pack(spapr->fdt_blob)));
>>>> +        spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
>>>> +        spapr->fdt_initial_size = spapr->fdt_size;
>>>> +
>>>> +        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
>>>> +        cpu_physical_memory_write(fdt_buf + sizeof(hdr), spapr->fdt_blob,
>>>> +                                  spapr->fdt_size);
>>>> +        trace_spapr_cas_continue(spapr->fdt_size + sizeof(hdr));
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>  static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>>>>                                                SpaprMachineState *spapr,
>>>>                                                target_ulong opcode,
>>>> @@ -1998,6 +2014,14 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>>      return H_SUCCESS;
>>>>  }
>>>>  
>>>> +static target_ulong h_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>> +                             target_ulong opcode, target_ulong *args)
>>>
>>> As I said in an earlier revision, please explan these names from just
>>> "client", for readability by people who aren't already thinking about
>>> open firmware.
>>
>> Yeah, I missed this one.
>>
>>
>>>
>>>> +{
>>>> +    target_ulong client_args = ppc64_phys_to_real(args[0]);
>>>> +
>>>> +    return spapr_h_client(spapr, client_args);
>>>> +}
>>>> +
>>>>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>>>>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
>>>>  static spapr_hcall_fn svm_hypercall_table[(SVM_HCALL_MAX - SVM_HCALL_BASE) / 4 + 1];
>>>> @@ -2121,6 +2145,8 @@ static void hypercall_register_types(void)
>>>>  
>>>>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>>>>  
>>>> +    spapr_register_hypercall(KVMPPC_H_CLIENT, h_client);
>>>> +
>>>>      /* Virtual Processor Home Node */
>>>>      spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
>>>>                               h_home_node_associativity);
>>>> diff --git a/hw/ppc/spapr_of_client.c b/hw/ppc/spapr_of_client.c
>>>> new file mode 100644
>>>> index 000000000000..24d854b76e51
>>>> --- /dev/null
>>>> +++ b/hw/ppc/spapr_of_client.c
>>>
>>> I'd suggest expanding this file to cover as much as you can of the
>>> virtual OF stuff, not just the client interface.
>>
>> This is done in v6.
>>
>>
>>>
>>>> @@ -0,0 +1,633 @@
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu-common.h"
>>>> +#include "qapi/error.h"
>>>> +#include "exec/memory.h"
>>>> +#include "hw/ppc/spapr.h"
>>>> +#include "hw/ppc/spapr_vio.h"
>>>> +#include "chardev/char.h"
>>>> +#include "qom/qom-qobject.h"
>>>> +#include "trace.h"
>>>> +
>>>> +typedef struct {
>>>> +    DeviceState *dev;
>>>> +    Chardev *cdev;
>>>> +    uint32_t phandle;
>>>> +} SpaprOfInstance;
>>>> +
>>>> +/*
>>>> + * OF 1275 "nextprop" description suggests is it 32 bytes max but
>>>> + * LoPAPR defines "ibm,query-interrupt-source-number" which is 33 chars long.
>>>> + */
>>>> +#define OF_PROPNAME_LEN_MAX 64
>>>> +
>>>> +/* Defined as Big Endian */
>>>> +struct prom_args {
>>>> +    uint32_t service;
>>>> +    uint32_t nargs;
>>>> +    uint32_t nret;
>>>> +    uint32_t args[10];
>>>> +};
>>>> +
>>>> +static void readstr(hwaddr pa, char *buf, int size)
>>>> +{
>>>> +    cpu_physical_memory_read(pa, buf, size - 1);
>>>> +    buf[size - 1] = 0;
>>>> +}
>>>
>>> I'd still like to see this return some kind of error if it had to
>>> truncate what was passed by the client.
>>
>>
>> But truncating will produce error anyway - libfdt won't find stuff,
>> etc.
> 
> Probably, but I think the error will be much more comprehensible if we
> catch it here.

I cannot really print an error as the guest can flood the QEMU's log,
returning an error is done by other means. If I make this one return an
error, then every single caller will have to have error_exit label. How
about this:

static void readstr(hwaddr pa, char *buf, int size)
{
    cpu_physical_memory_read(pa, buf, size);
    if (buf[size - 1] != '\0') {
        buf[size - 1] = '\0';
        trace_spapr_of_client_error_strbuf(buf, size);
    }
}

and a tracepoint:

spapr_of_client_error_strbuf(const char *s, int len) "%s is longed than %d"


and let the callers of this fail?


> 
>>>> +
>>>> +static bool _cmpservice(const char *s, size_t len,
>>>
>>> Don't use leading _ please - in userland those are reserved for the
>>> system libraries.
>>>
>>>> +                        unsigned nargs, unsigned nret,
>>>> +                        const char *s1, size_t len1,
>>>> +                        unsigned nargscheck, unsigned nretcheck)
>>>> +{
>>>> +    if (strcmp(s, s1)) {
>>>> +        return false;
>>>> +    }
>>>> +    if (nargscheck == 0 && nretcheck == 0) {
>>>> +        return true;
>>>> +    }
>>>> +    if (nargs != nargscheck || nret != nretcheck) {
>>>> +        trace_spapr_of_client_error_param(s, nargscheck, nretcheck, nargs,
>>>> +                                          nret);
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_finddevice(const void *fdt, uint32_t nodeaddr)
>>>> +{
>>>> +    char node[256];
>>>
>>> Is 256 enough?  OF paths can get pretty long...
>>
>>
>> Hard to imagine that 255 is not enough though. Long parts of the path
>> would be scsi drive id, PHB but in between we can only have a bunch of
>> PCI bridges and these are not so long.
> 
> Hm, ok.  I had a look on a Boston and the longest path I see there is
> 75 characters, I thought it might be a lot more.


May be with a bunch of scsi/pci buses, or when network is involved, with
all the IP+DNS+imagename - these can be long, probably... Although 256
is still pretty long.


> 
>> What do you think is an appropriate limit?
>>
>>
>>>
>>>> +    int ret;
>>>> +
>>>> +    readstr(nodeaddr, node, sizeof(node));
>>>> +    ret = fdt_path_offset(fdt, node);
>>>> +    if (ret >= 0) {
>>>> +        ret = fdt_get_phandle(fdt, ret);
>>>> +    }
>>>> +
>>>> +    return (uint32_t) ret;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_getprop(const void *fdt, uint32_t nodeph,
>>>> +                                  uint32_t pname, uint32_t valaddr,
>>>> +                                  uint32_t vallen)
>>>> +{
>>>> +    char propname[OF_PROPNAME_LEN_MAX + 1];
>>>> +    uint32_t ret = 0;
>>>> +    int proplen = 0;
>>>> +    const void *prop;
>>>> +
>>>> +    readstr(pname, propname, sizeof(propname));
>>>> +    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
>>>> +                               propname, strlen(propname), &proplen);
>>>
>>> Again, you don't need _namelen.
>>>
>>>> +    if (prop) {
>>>> +        int cb = MIN(proplen, vallen);
>>>> +
>>>> +        cpu_physical_memory_write(valaddr, prop, cb);
>>>> +        ret = cb;
>>>
>>> If I'm reading 1275 correctly, the return value should be the
>>> untruncated length of the property.
>>
>>
>> "Size is either the actual size of the property". I'd think the actual
>> size is what we actually copied to the buffer but @proplen is probably
>> what they meant, I'll change to that and see what breaks.
>>
>>
>>
>>>> +    } else {
>>>> +        ret = -1;
>>>> +    }
>>>> +    trace_spapr_of_client_getprop(nodeph, propname, ret);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_getproplen(const void *fdt, uint32_t nodeph,
>>>> +                                     uint32_t pname)
>>>> +{
>>>> +    char propname[OF_PROPNAME_LEN_MAX + 1];
>>>> +    uint32_t ret = 0;
>>>> +    int proplen = 0;
>>>> +    const void *prop;
>>>> +
>>>> +    readstr(pname, propname, sizeof(propname));
>>>> +
>>>> +    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
>>>> +                               propname, strlen(propname), &proplen);
>>>
>>> No _namelen.
>>>
>>>> +    if (prop) {
>>>> +        ret = proplen;
>>>> +    } else {
>>>> +        ret = -1;
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_setprop(SpaprMachineState *spapr,
>>>> +                                  uint32_t nodeph, uint32_t pname,
>>>> +                                  uint32_t valaddr, uint32_t vallen)
>>>> +{
>>>> +    char propname[OF_PROPNAME_LEN_MAX + 1];
>>>> +    uint32_t ret = -1;
>>>> +    int offset;
>>>
>>> A comment noting that you're only allowing a very restricted set of
>>> setprops would be good.
>>
>>
>> Is not that quite clear from the code itself? Okay...
> 
> Well, kinda.  The rationale for it would be useful here though.

I am adding:

 /*
  * We only allow changing properties which we know how to update on
  * the QEMU side.
  */



> 
>>>> +    readstr(pname, propname, sizeof(propname));
>>>> +    if (vallen == sizeof(uint32_t)) {
>>>> +        uint32_t val32 = ldl_be_phys(first_cpu->as, valaddr);
>>>> +
>>>> +        if ((strcmp(propname, "linux,rtas-base") == 0) ||
>>>> +            (strcmp(propname, "linux,rtas-entry") == 0)) {
>>>> +            spapr->rtas_base = val32;
>>>> +        } else if (strcmp(propname, "linux,initrd-start") == 0) {
>>>> +            spapr->initrd_base = val32;
>>>> +        } else if (strcmp(propname, "linux,initrd-end") == 0) {
>>>> +            spapr->initrd_size = val32 - spapr->initrd_base;
>>>> +        } else {
>>>> +            goto trace_exit;
>>>> +        }
>>>> +    } else if (vallen == sizeof(uint64_t)) {
>>>> +        uint64_t val64 = ldq_be_phys(first_cpu->as, valaddr);
>>>> +
>>>> +        if (strcmp(propname, "linux,initrd-start") == 0) {
>>>> +            spapr->initrd_base = val64;
>>>> +        } else if (strcmp(propname, "linux,initrd-end") == 0) {
>>>> +            spapr->initrd_size = val64 - spapr->initrd_base;
>>>> +        } else {
>>>> +            goto trace_exit;
>>>> +        }
>>>> +    } else {
>>>> +        goto trace_exit;
>>>> +    }
>>>> +
>>>> +    offset = fdt_node_offset_by_phandle(spapr->fdt_blob, nodeph);
>>>> +    if (offset >= 0) {
>>>> +        uint8_t data[vallen];
>>>> +
>>>> +        cpu_physical_memory_read(valaddr, data, vallen);
>>>> +        if (!fdt_setprop(spapr->fdt_blob, offset, propname, data, vallen)) {
>>>> +            ret = vallen;
>>>> +        }
>>>> +    }
>>>> +
>>>> +trace_exit:
>>>> +    trace_spapr_of_client_setprop(nodeph, propname, ret);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_nextprop(const void *fdt, uint32_t phandle,
>>>> +                                   uint32_t prevaddr, uint32_t nameaddr)
>>>> +{
>>>> +    int offset = fdt_node_offset_by_phandle(fdt, phandle);
>>>> +    char prev[OF_PROPNAME_LEN_MAX + 1];
>>>> +    const char *tmp;
>>>> +
>>>> +    readstr(prevaddr, prev, sizeof(prev));
>>>> +    for (offset = fdt_first_property_offset(fdt, offset);
>>>> +         offset >= 0;
>>>> +         offset = fdt_next_property_offset(fdt, offset)) {
>>>> +
>>>> +        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
>>>> +            return 0;
>>>> +        }
>>>> +        if (prev[0] == '\0' || strcmp(prev, tmp) == 0) {
>>>> +            if (prev[0] != '\0') {
>>>> +                offset = fdt_next_property_offset(fdt, offset);
>>>> +                if (offset < 0) {
>>>> +                    return 0;
>>>> +                }
>>>> +            }
>>>> +            if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
>>>> +                return 0;
>>>> +            }
>>>> +            cpu_physical_memory_write(nameaddr, tmp, strlen(tmp) + 1);
>>>> +            return 1;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_peer(const void *fdt, uint32_t phandle)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (phandle == 0) {
>>>> +        ret = fdt_path_offset(fdt, "/");
>>>> +    } else {
>>>> +        ret = fdt_next_subnode(fdt, fdt_node_offset_by_phandle(fdt, phandle));
>>>> +    }
>>>> +
>>>> +    if (ret < 0) {
>>>> +        ret = 0;
>>>> +    } else {
>>>> +        ret = fdt_get_phandle(fdt, ret);
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_child(const void *fdt, uint32_t phandle)
>>>> +{
>>>> +    int ret = fdt_first_subnode(fdt, fdt_node_offset_by_phandle(fdt, phandle));
>>>> +
>>>> +    if (ret < 0) {
>>>> +        ret = 0;
>>>> +    } else {
>>>> +        ret = fdt_get_phandle(fdt, ret);
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_parent(const void *fdt, uint32_t phandle)
>>>> +{
>>>> +    int ret = fdt_parent_offset(fdt, fdt_node_offset_by_phandle(fdt, phandle));
>>>> +
>>>> +    if (ret < 0) {
>>>> +        ret = 0;
>>>> +    } else {
>>>> +        ret = fdt_get_phandle(fdt, ret);
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static DeviceState *of_client_find_qom_dev(BusState *bus, const char *path)
>>>> +{
>>>> +    BusChild *kid;
>>>> +
>>>> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
>>>> +        const char *p = qdev_get_fw_dev_path(kid->child);
>>>> +        BusState *child;
>>>> +
>>>> +        if (p && strcmp(path, p) == 0) {
>>>> +            return kid->child;
>>>> +        }
>>>> +        QLIST_FOREACH(child, &kid->child->child_bus, sibling) {
>>>> +            DeviceState *d = of_client_find_qom_dev(child, path);
>>>> +
>>>> +            if (d) {
>>>> +                return d;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
>>>> +{
>>>> +    int offset;
>>>> +    uint32_t ret = 0;
>>>> +    SpaprOfInstance *inst;
>>>> +
>>>> +    if (spapr->of_instance_last == 0xFFFFFFFF) {
>>>> +        /* We do not recycle ihandles yet */
>>>> +        goto trace_exit;
>>>> +    }
>>>> +    offset = fdt_path_offset(spapr->fdt_blob, path);
>>>> +    if (offset < 0) {
>>>> +        trace_spapr_of_client_error_unknown_path(path);
>>>> +        goto trace_exit;
>>>> +    }
>>>> +
>>>> +    inst = g_new(SpaprOfInstance, 1);
>>>> +    inst->phandle = fdt_get_phandle(spapr->fdt_blob, offset);
>>>> +    g_assert(inst->phandle);
>>>> +    ++spapr->of_instance_last;
>>>> +    inst->dev = of_client_find_qom_dev(sysbus_get_default(), path);
>>>> +    g_hash_table_insert(spapr->of_instances,
>>>> +                        GINT_TO_POINTER(spapr->of_instance_last),
>>>> +                        inst);
>>>> +    ret = spapr->of_instance_last;
>>>> +
>>>> +    if (inst->dev) {
>>>> +        const char *cdevstr = object_property_get_str(OBJECT(inst->dev),
>>>> +                                                      "chardev", NULL);
>>>> +
>>>> +        if (cdevstr) {
>>>> +            inst->cdev = qemu_chr_find(cdevstr);
>>>> +        }
>>>> +    }
>>>> +
>>>> +trace_exit:
>>>> +    trace_spapr_of_client_open(path, inst ? inst->phandle : 0, ret);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_open(SpaprMachineState *spapr, uint32_t pathaddr)
>>>> +{
>>>> +    char path[256];
>>>> +
>>>> +    readstr(pathaddr, path, sizeof(path));
>>>> +
>>>> +    return spapr_of_client_open(spapr, path);
>>>> +}
>>>> +
>>>> +static void of_client_close(SpaprMachineState *spapr, uint32_t ihandle)
>>>> +{
>>>> +    if (!g_hash_table_remove(spapr->of_instances, GINT_TO_POINTER(ihandle))) {
>>>> +        trace_spapr_of_client_error_unknown_ihandle_close(ihandle);
>>>> +    }
>>>> +}
>>>> +
>>>> +static uint32_t of_client_instance_to_package(SpaprMachineState *spapr,
>>>> +                                              uint32_t ihandle)
>>>> +{
>>>> +    gpointer instp = g_hash_table_lookup(spapr->of_instances,
>>>> +                                        GINT_TO_POINTER(ihandle));
>>>> +
>>>> +    if (!instp) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    return ((SpaprOfInstance *)instp)->phandle;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_package_to_path(const void *fdt, uint32_t phandle,
>>>> +                                          uint32_t buf, uint32_t len)
>>>> +{
>>>> +    char tmp[256];
>>>> +
>>>> +    if (0 == fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phandle), tmp,
>>>> +                          sizeof(tmp))) {
>>>> +        tmp[sizeof(tmp) - 1] = 0;
>>>> +        cpu_physical_memory_write(buf, tmp, MIN(len, strlen(tmp)));
>>>> +    }
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_instance_to_path(SpaprMachineState *spapr,
>>>> +                                           uint32_t ihandle, uint32_t buf,
>>>> +                                           uint32_t len)
>>>> +{
>>>> +    uint32_t phandle = of_client_instance_to_package(spapr, ihandle);
>>>> +
>>>> +    if (phandle != -1) {
>>>> +        return of_client_package_to_path(spapr->fdt_blob, phandle, buf, len);
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static uint32_t of_client_write(SpaprMachineState *spapr, uint32_t ihandle,
>>>> +                                uint32_t buf, uint32_t len)
>>>> +{
>>>> +    char tmp[256];
>>>> +    int toread, toprint, cb = MIN(len, 1024);
>>>> +    SpaprOfInstance *inst = (SpaprOfInstance *)
>>>> +        g_hash_table_lookup(spapr->of_instances, GINT_TO_POINTER(ihandle));
>>>> +
>>>> +    while (cb > 0) {
>>>> +        toread = MIN(cb + 1, sizeof(tmp));
>>>> +        readstr(buf, tmp, toread);
>>>> +        toprint = strlen(tmp);
>>>> +        if (inst && inst->cdev) {
>>>> +            toprint = qemu_chr_write(inst->cdev, (uint8_t *) tmp, toprint,
>>>> +                                     true);
>>>> +        } else {
>>>> +            /* We normally open stdout so this is fallback */
>>>> +            printf("DBG[%d]%s", ihandle, tmp);
>>>> +        }
>>>> +        buf += toprint;
>>>> +        cb -= toprint;
>>>> +    }
>>>> +
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static bool of_client_claim_avail(GArray *claimed, uint64_t virt, uint64_t size)
>>>> +{
>>>> +    int i;
>>>> +    SpaprOfClaimed *c;
>>>> +
>>>> +    for (i = 0; i < claimed->len; ++i) {
>>>> +        c = &g_array_index(claimed, SpaprOfClaimed, i);
>>>> +        if ((c->start <= virt && virt < c->start + c->size) ||
>>>> +            (virt <= c->start && c->start < virt + size)) {
>>>> +            return false;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static void of_client_claim_add(GArray *claimed, uint64_t virt, uint64_t size)
>>>> +{
>>>> +    SpaprOfClaimed newclaim;
>>>> +
>>>> +    newclaim.start = virt;
>>>> +    newclaim.size = size;
>>>> +    g_array_append_val(claimed, newclaim);
>>>> +}
>>>> +
>>>> +/*
>>>> + * "claim" claims memory at @virt if @align==0; otherwise it allocates
>>>> + * memory at the requested alignment.
>>>> + */
>>>> +uint64_t spapr_do_of_client_claim(SpaprMachineState *spapr, uint64_t virt,
>>>> +                                  uint64_t size, uint64_t align)
>>>> +{
>>>> +    uint32_t ret;
>>>> +
>>>> +    if (align == 0) {
>>>> +        if (!of_client_claim_avail(spapr->claimed, virt, size)) {
>>>> +            return -1;
>>>> +        }
>>>> +        ret = virt;
>>>> +    } else {
>>>> +        align = pow2ceil(align);
>>>
>>> Should this be a pow2ceil, or should it just return an error if align
>>> is not a power of 2. > Note that aligning something to 4 bytes will
>>> (probably) make it *not* aligned to 3 bytes.
>>
>> I did not see any notes about the specific alignment requirements here,
>> the idea is that clients may just not expect unaligned memory at all; I
>> could probably just drop it and see what happens...
> 
> I don't follow you.  Isn't the align value coming from the client?


This code is used by the client and QEMU. So for QEMU users, I'll have
to align myself everywhere, not a huge deal. And since it is an old
interface which nobody follows 100%, I can imagine clients (grub/yaboot)
asking to claim with alignments other than power of two in expectation
that the firmware will align it, may be.


> 
>>>> +        spapr->claimed_base = (spapr->claimed_base + align - 1) & ~(align - 1);
>>>> +        while (1) {
>>>> +            if (spapr->claimed_base >= spapr->rma_size) {
>>>> +                perror("Out of memory");
>>>
>>> error_report() or qemu_log() or something and a message with some more
>>> specificity, please.
>>
>>
>> What kind of specificity is missing here?
> 
> That it's on the OF claim interface specifically, and how much they
> were trying to claim.

Changing it to

error_report("Out of RMA memory for the OF client")

Thanks for the review! I'll post it when we settle on the new bios/vof
machine parameter.



-- 
Alexey

