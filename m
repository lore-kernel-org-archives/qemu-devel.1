Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB94C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B33C20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="QxK2x+Hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B33C20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioRbs-0004Bg-NV
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ioRaa-00031s-TB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ioRaW-0006EO-7X
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:34:32 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ioRaV-0006Dw-MM
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:34:28 -0500
Received: by mail-pg1-x544.google.com with SMTP id z124so26820345pgb.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 04:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=al+5V9P8/pB/2kSy0tiwIjM/z9mRAW7f7ES9KH9BrVI=;
 b=QxK2x+Hiab7pQOeq7+GwT/yAa23pLulOtMhAhwIHyydZViUYpMk5iRTvONjuVbgkvv
 WciQQ2PjkLnVIVYxgSuS2q9zpkiQ0pH/H3nSjDOM3YiA6v3mq3HWkj2e8pod67rWE5YE
 CiQ84B5cJGA6QlpYDTlTVb/6yIxP5BcGylN/EU1iS7b2j2G2CcrvGyGT7Nw4bT/lCSWB
 RKNJIKAiSHM3jru1QtvRPZdK08aY2QbCvB7XWQhBTjBFvj9YdTHdu0eACuJ1oEC6lWwY
 ha1onk0sziz1D743deEY756T7vFWNfGnDcNLIq3eXFpZsVUimX1Fb5cDVc5Q5SRCg9QR
 0fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=al+5V9P8/pB/2kSy0tiwIjM/z9mRAW7f7ES9KH9BrVI=;
 b=Saq0ay6XrZv80RvZ7TrAlMScUXaLdn5V74B4kjO+xasekPhx7D13iGXmpjc7UzvFyi
 YUj6RMjgeIgJamDtXGmSN1iReEYVRGFCzjmTSsrDguLBgOHMv9jc1Bhq08Pc4K7fFoMO
 9FGzQrPNSm5o+i9/2IF22Bx4hw4+xtlBQumuYFXlzDTjsvcraXM7+TcHiwHKX47zn+tO
 8XZxnbL5HWhfmJxp0s72xmJL7cB9uW+IwyZ3+HJsr2NKJTPeNZPnO9POuDPKHykWtiTw
 xv5AaTykjsowBZSb1gjbs7L682fbDmtkpp3Xw+DJDMPaC4pxEnscm584lwNn5EHS8TW+
 SSNg==
X-Gm-Message-State: APjAAAVxgDa21Mb4Ia+KyOOoZWDfVzRkjbDm3m5gKNR3v13V6NCoKoi6
 ApLShgOqBgCXoLPo8XLp8sBmqTDsTYA=
X-Google-Smtp-Source: APXvYqzpXuNbFW7EIsF6rApVhANuJjqVujypyx16ii09kjxDXoMVaDV6V/sAvnhus7cg9Zah8Ub9bQ==
X-Received: by 2002:a62:1889:: with SMTP id
 131mr108905833pfy.250.1578314065850; 
 Mon, 06 Jan 2020 04:34:25 -0800 (PST)
Received: from [192.168.10.152] (124-171-196-88.dyn.iinet.net.au.
 [124.171.196.88])
 by smtp.gmail.com with ESMTPSA id o10sm72378047pgq.68.2020.01.06.04.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 04:34:25 -0800 (PST)
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
 <20200106085042.GW2098@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
Date: Mon, 6 Jan 2020 23:34:13 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200106085042.GW2098@umbus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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



On 06/01/2020 19:50, David Gibson wrote:
> On Mon, Jan 06, 2020 at 05:28:55PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 06/01/2020 15:19, David Gibson wrote:
>>> On Mon, Jan 06, 2020 at 10:42:42AM +1100, Alexey Kardashevskiy wrote:
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
>>>>
>>>> The client interface is implemented exactly as RTAS - a 20 bytes blob,
>>>> right next after the RTAS blob. The entry point is passed to the kernel
>>>> via GPR5.
>>>>
>>>> This implements a handful of client interface methods just to get going.
>>>> In particular, this implements the device tree fetching,
>>>> ibm,client-architecture-support and instantiate-rtas.
>>>>
>>>> This implements changing FDT properties only for "linux,rtas-base" and
>>>> "linux,rtas-entry", just to get early boot going.
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
>>>> This does not implement instances properly but in order to boot a VM,
>>>> we only really need a stdout instance and the "/" instance for
>>>> "call-method", we fake these.
>>>
>>> As we've discussed, I really like the idea of this.  It think the
>>> basic approach looks good too.
>>>
>>> As you probably realize, there are quite a lot of things to be
>>> polished though.  Comments below.
>>>
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
>>>> -kernel vmldbg \
>>>> -machine pseries,bios=off \
>>>> -m 4G \
>>>> -enable-kvm \
>>>> -initrd pb/rootfs.cpio.xz \
>>>> img/u1804-64le.qcow2 \
>>>> -snapshot \
>>>> -smp 8,threads=8 \
>>>> -L /home/aik/t/qemu-ppc64-bios/ \
>>>> -trace events=qemu_trace_events \
>>>> -d guest_errors \
>>>> -chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.ssh37874 \
>>>> -mon chardev=SOCKET0,mode=control
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v2:
>>>> * fixed claim()
>>>> * added "setprop"
>>>> * cleaner client interface and RTAS blobs management
>>>> * boots to petitboot and further to the target system
>>>> * more trace points
>>>> ---
>>>>   hw/ppc/Makefile.objs   |   1 +
>>>>   include/hw/loader.h    |   1 +
>>>>   include/hw/ppc/spapr.h |  25 ++-
>>>>   hw/ppc/spapr.c         | 231 ++++++++++++++++++--
>>>>   hw/ppc/spapr_client.c  | 464 +++++++++++++++++++++++++++++++++++++++++
>>>>   hw/ppc/spapr_hcall.c   |  49 +++--
>>>>   hw/ppc/trace-events    |   9 +
>>>>   7 files changed, 743 insertions(+), 37 deletions(-)
>>>>   create mode 100644 hw/ppc/spapr_client.c
>>>>
>>>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>>>> index 101e9fc59185..ce31c0acd2fb 100644
>>>> --- a/hw/ppc/Makefile.objs
>>>> +++ b/hw/ppc/Makefile.objs
>>>> @@ -6,6 +6,7 @@ obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
>>>>   obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
>>>>   obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>>>>   obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
>>>> +obj-$(CONFIG_PSERIES) += spapr_client.o
>>>
>>> This applies in a bunch of places here.  Just calling things "client"
>>> is clear enough if you're already thinking about Open Firmware.  But
>>> this appears in a bunch of places where you might come across it
>>> without that context, in which case it could be kind of confusing.  So
>>> I'd suggest using "of_client" or "of_client_interface" in most places
>>> you're using "client".
>>>
>>>>   obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
>>>>   # IBM PowerNV
>>>>   obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
>>>> diff --git a/include/hw/loader.h b/include/hw/loader.h
>>>> index 48a96cd55904..a2f58077a47e 100644
>>>> --- a/include/hw/loader.h
>>>> +++ b/include/hw/loader.h
>>>> @@ -262,6 +262,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>>>>   int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void *data,
>>>>                           size_t datasize, size_t romsize, hwaddr addr,
>>>>                           AddressSpace *as);
>>>> +bool rom_intersect(uint64_t start, uint64_t size);
>>>
>>> I don't see this called, so I'm guessing it's a stray chunk leftover.
>>>
>>>>   int rom_check_and_register_reset(void);
>>>>   void rom_set_fw(FWCfgState *f);
>>>>   void rom_set_order_override(int order);
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index 61f005c6f686..876879d12029 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -105,6 +105,11 @@ struct SpaprCapabilities {
>>>>       uint8_t caps[SPAPR_CAP_NUM];
>>>>   };
>>>>   
>>>> +typedef struct {
>>>> +    uint64_t start;
>>>> +    uint64_t size;
>>>> +} spapr_of_claimed;
>>>
>>> Please use the qemu convention of StudlyCaps for types.
>>>
>>>>   /**
>>>>    * SpaprMachineClass:
>>>>    */
>>>> @@ -158,8 +163,13 @@ struct SpaprMachineState {
>>>>       uint32_t fdt_size;
>>>>       uint32_t fdt_initial_size;
>>>>       void *fdt_blob;
>>>> +    uint32_t rtas_base;
>>>>       long kernel_size;
>>>>       bool kernel_le;
>>>> +    uint64_t kernel_addr;
>>>
>>> This would intersect with your other patch to allow changing the
>>> kernel load address, yes?
>>
>>
>> This includes kernel_addr, it is a single patch now. More about this below.
> 
> Hm, ok.
> 
>>>> +    bool bios_enabled;
>>>> +    GArray *claimed; /* array of spapr_of_claimed */
>>>> +    uint64_t claimed_base;
>>>
>>> I'd suggest moving all the client interface related fields to a
>>> visually separated chunk in the structure definition.
>>>
>>>>       uint32_t initrd_base;
>>>>       long initrd_size;
>>>>       uint64_t rtc_offset; /* Now used only during incoming migration */
>>>> @@ -510,7 +520,8 @@ struct SpaprMachineState {
>>>>   /* Client Architecture support */
>>>>   #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>>>>   #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
>>>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
>>>> +#define KVMPPC_H_CLIENT         (KVMPPC_HCALL_BASE + 0x5)
>>>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_CLIENT
>>>>   
>>>>   /*
>>>>    * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
>>>> @@ -538,6 +549,12 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
>>>>   target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>>>                                target_ulong *args);
>>>>   
>>>> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
>>>> +                                            SpaprMachineState *spapr,
>>>> +                                            target_ulong addr,
>>>> +                                            target_ulong fdt_buf,
>>>> +                                            target_ulong fdt_bufsize);
>>>> +
>>>>   /* Virtual Processor Area structure constants */
>>>>   #define VPA_MIN_SIZE           640
>>>>   #define VPA_SIZE_OFFSET        0x4
>>>> @@ -769,6 +786,9 @@ struct SpaprEventLogEntry {
>>>>   void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space);
>>>>   void spapr_events_init(SpaprMachineState *sm);
>>>>   void spapr_dt_events(SpaprMachineState *sm, void *fdt);
>>>> +uint64_t spapr_do_client_claim(SpaprMachineState *sm, uint64_t virt,
>>>> +                               uint64_t size, uint64_t align);
>>>> +int spapr_h_client(SpaprMachineState *sm, target_ulong client_args);
>>>>   void close_htab_fd(SpaprMachineState *spapr);
>>>>   void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
>>>>   void spapr_free_hpt(SpaprMachineState *spapr);
>>>> @@ -891,4 +911,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>>>   #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
>>>>   
>>>>   void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>>>> +
>>>> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base);
>>>> +
>>>>   #endif /* HW_SPAPR_H */
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index e62c89b3dd40..1c97534a0aea 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -896,6 +896,51 @@ out:
>>>>       return ret;
>>>>   }
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
>>> I'd really prefer to read this in from a file (or files) which we
>>> assemble (as with the existing spapr-rtas.img), rather than having a
>>> magic array in qemu.
>>
>> Two considerations here:
>> 1. This blob is not going to change (at least often)
> 
> True, but I'd still prefer to build it from a .S rather than have the
> binary written out.  We already had this until recently (when we moved
> the RTAS image into SLOF), and it's really not too hard to manage.


But what is exactly the benefit? It is not going to change. I can look into making it a .S, compile it to a binary an 
include this binary into qemu-system-ppc64 as a byte array, just need to refresh my gcc/ldd memories but a separate file 
is too much for this imho.


>> 2. A new file which needs to be packaged/signed/copied.
> 
> Eh, again, we had this for RTAS until very recently and it really
> wasn't that much hassle.


I keep secure VMs in mind. And SLOF is a separate package, why was not RTAS?


>>>> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base)
>>>> +{
>>>> +    spapr->rtas_base = base;
>>>> +    cpu_physical_memory_write(base, rtas_client_blob.rtas,
>>>> +                              sizeof(rtas_client_blob.rtas));
>>>> +}
>>>> +
>>>>   static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>>>   {
>>>>       MachineState *ms = MACHINE(spapr);
>>>> @@ -980,6 +1025,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>>>       _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
>>>>                        lrdr_capacity, sizeof(lrdr_capacity)));
>>>>   
>>>> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", spapr->rtas_base));
>>>> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-entry", spapr->rtas_base));
>>>
>>> IIUC, we shouldn't need to add these in bios=off mode, yes?  Instead
>>> the client must instantiate-rtas before attempting to use it.
>>
>>
>> Well. Here is what happens:
>>
>> 1. spapr machine reset creates FDT, lets say without rtas-entry
>> 2. linux calls ibm,client-interface-support
> 
> I assume you mean ibm,client-architecture-support?

Yes.

> 
>> 3. the QEMU handler rebuilds the FDT
> 
> Oh.. not directly relevant here, but that might be an issue.  Do we
> need to ensure that phandles are stable across the CAS call?


We already have predefined values for phandles we care about.


>> 4. linux calls "instantiate-rtas"
>> 5. linux stores "linux,rtas-base" and "linux,rtas-entry" in the FDT
>> using "setprop" client call
>> 6. linux fetches the tree by traversing it and packs it into FDT blob itself
>> 7. linux calls quiesce
>> 8. linux uses "linux,rtas-entry" from FDT to call RTAS.
>>
>> Because in 5) I only allow in-place property update and only for
>> "linux,rtas-base" and "linux,rtas-entry", these do not make to the tree
>> and there is no "linux,rtas-entry" in the FDT.
>>
>> There are choices:
>>
>> 1. I can extend "setprop" (tricky as FDT is flattened by then?)
> 
> I actually don't think this should be too hard - though maybe I've
> missed something, so I'd say this is my frontrunning option.

fdt_splice_() fails because of lack of space in the FDT (you pointed to it below). Not calling fdt_pack() fixed it as it 
just keeps FDT blob rather big. Not sure it is worth further optimizations at this point.


>> 2. simply store rtas base in spapr->rtas_base and do complete FDT rebuild
> 
> I don't think that's viable - phandles definitely shouldn't change
> across an instantiate-rtas call.
> 
>> 3. (currently) I basically have 2 placeholders for these
>> "linux,rtas-base" and "linux,rtas-entry".
> 
> Hm, ok.
> 
>> Or we can avoid flattening FDT at all for bios=off (as nobody wants
>> flattened device tree, my "fetch-fdt" never made it to upstream Linux),
>> then 1) is easy (if it is a problem to begin with).
> 
> Right, but we need a live DT library to make it happen, which means
> someone finding time to write it.


I dropped fdt_pack() and change properties via fdt_setprop() - works just fine.



>>>> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size",
>>>> +                          sizeof(rtas_client_blob.rtas)));
>>>> +    _FDT(fdt_add_mem_rsv(fdt, spapr->rtas_base,
>>>> +                         sizeof(rtas_client_blob.rtas)));
>>>
>>> Nor should we need the mem_rsv with bios=off.
>>
>> True. If not the "setprop" limitation from above, I would only need
>> "rtas-size" here.
>>
>>
>>>
>>>> +
>>>>       spapr_dt_rtas_tokens(fdt, rtas);
>>>>   }
>>>>   
>>>> @@ -1057,7 +1109,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>>>       }
>>>>   
>>>>       if (spapr->kernel_size) {
>>>> -        uint64_t kprop[2] = { cpu_to_be64(KERNEL_LOAD_ADDR),
>>>> +        uint64_t kprop[2] = { cpu_to_be64(spapr->kernel_addr),
>>>>                                 cpu_to_be64(spapr->kernel_size) };
>>>>   
>>>>           _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
>>>> @@ -1104,6 +1156,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>>>           _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
>>>>       }
>>>>   
>>>> +    if (!spapr->bios_enabled) {
>>>> +        _FDT(fdt_setprop_cell(fdt, chosen, "cpu", 0));
>>>
>>> What is this for?
>>
>> Looks like a leftover, I did this for prom_find_boot_cpu() but after
>> double checking and trying it looks like it can proceed without this chunk.
> 
> Ok.
> 
>>>
>>>> +    }
>>>>       spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>>>>   
>>>>       g_free(stdout_path);
>>>> @@ -1133,6 +1188,28 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
>>>>       }
>>>>   }
>>>>   
>>>> +static void spapr_fdt_add_phandles(void *fdt, int parent, uint32_t *phandle)
>>>> +{
>>>> +    int proplen = 0, node;
>>>> +    const void *prop;
>>>> +    char tmp[256] = "BAAD";
>>>> +
>>>> +    fdt_get_path(fdt, parent, tmp, sizeof(tmp));
>>>
>>> You don't actually appear to use tmp.  Is this a debugging leftover?
>>
>> Yes it is.
>>
>>
>>>
>>>> +    prop = fdt_getprop_namelen(fdt, parent, "phandle", 7, &proplen);
>>>> +    if (!prop) {
>>>> +        _FDT(fdt_setprop_cell(fdt, parent, "phandle", *phandle));
>>>> +        while (1) {
>>>> +            ++*phandle;
>>>> +            if (fdt_node_offset_by_phandle(fdt, *phandle) < 0) {
>>>> +                break;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +    fdt_for_each_subnode(node, fdt, parent) {
>>>> +        spapr_fdt_add_phandles(fdt, node, phandle);
>>>> +    }
>>>
>>> Oof, this is pretty inefficient, since fdt_node_offset_by_phandle()
>>> will have to scan the whole tree, and you do it on every node.
>>
>>
>> Inefficient indeed but for a VM with ~30 devices it is not that bad :)
>>
>>
>>> Obviously, a "live" tree structure rather than fdt would be better
>>> suited for this.  I'd like to move to that at some point, but it will
>>> be a while before we're ready.
>>
>> I could have a cache/hashmap of phandles...
> 
> We could, but I doubt it's worth the trouble.  Keeping the offsets in
> there up to date against setprops or other changes could actually a
> fair bit of hassle, I suspect.
> 
>>> I guess this is fine for a PoC, but I think we can do a bit better
>>> without too much extra complexity:
>>>    * Rather than scanning for an existing node with the handle on each
>>>      iteration, you can use fdt_find_max_phandle() once beforehand,
>>>      and start your counter from there, being assured that it won't hit
>>>      any existing phandles
>>
>> I'd like to avoid that as NPU/GPU phandles are quite huge and we will
>> have huge gaps between phandles numbers which is not so much of a big
>> deal but annoying to debug.
> 
> Hrm.  So huge we'll actually be short of space above them?


No, but "randomness" is annoying.


>>>    * The phandles are arbitrary, so you don't actually care about the
>>>      tree structure here.  So instead of recursively descending the
>>>      tree, you can just alter each node in the order they appear in the
>>>      blob.  fdt_next_node() will let you do that, simply by ignoring
>>>      the 'depth' parameter.  [In fact the structure ensures that will
>>>      be a depth first traversal of the tree, just like you have here,
>>>      not that it matters].
>>
>> ... but this one is better.
>>
>> Unlike many others, fdt_next_node() does not have a comment in
>> dtc/libfdt/libfdt.h so I was not sure about what *depth is for and I
>> basically ignored fdt_next_node().
> 
> Yeah, it's kind of subtle - mostly intended as an internal primitive -
> but it suits your needs here.  It moves to the next node in the
> structure block - regardless of whether it's a sibling, child or
> sibling-of-ancestor.  *depth, if a pointer is supplied, is updated to
> reflect which case it is.
> 
>>>    * You should check for overflows of your phandle counter, though
>>>      it's fine to treat that as a fatal error.
>>
>> Ok.
>>
>>
>>>> +}
>>>> +
>>>>   void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>>>>   {
>>>>       MachineState *machine = MACHINE(spapr);
>>>> @@ -1245,7 +1322,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>>>>       /* Build memory reserve map */
>>>>       if (reset) {
>>>>           if (spapr->kernel_size) {
>>>> -            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
>>>> +            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
>>>> +                                  spapr->kernel_size)));
>>>>           }
>>>>           if (spapr->initrd_size) {
>>>>               _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
>>>> @@ -1268,12 +1346,19 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>>>>           }
>>>>       }
>>>>   
>>>> +    if (!spapr->bios_enabled) {
>>>> +        uint32_t phandle = 1;
>>>> +
>>>> +        spapr_fdt_add_phandles(fdt, fdt_path_offset(fdt, "/"), &phandle);
>>>> +    }
>>>> +
>>>>       return fdt;
>>>>   }
>>>>   
>>>>   static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>>>>   {
>>>> -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>>>> +    SpaprMachineState *spapr = opaque;
>>>> +    return (addr & 0x0fffffff) + spapr->kernel_addr;
>>>>   }
>>>>   
>>>>   static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
>>>> @@ -1660,6 +1745,60 @@ static void spapr_machine_reset(MachineState *machine)
>>>>        */
>>>>       fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
>>>>   
>>>> +    /* Set up the entry state */
>>>> +    if (!spapr->bios_enabled) {
>>>> +        if (spapr->claimed) {
>>>> +            g_array_unref(spapr->claimed);
>>>> +        }
>>>> +        spapr->claimed = g_array_new(false, false, sizeof(spapr_of_claimed));
>>>> +        spapr->claimed_base = 0x10000; /* Avoid using the first system page */
>>>> +
>>>> +        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr, fdt_addr);
>>>> +
>>>> +        if (spapr_do_client_claim(spapr, spapr->kernel_addr,
>>>> +                                  spapr->kernel_size, 0) == -1) {
>>>> +            error_report("Memory for kernel is in use");
>>>> +            exit(1);
>>>> +        }
>>>> +        if (spapr_do_client_claim(spapr, spapr->initrd_base,
>>>> +                                  spapr->initrd_size, 0) == -1) {
>>>> +            error_report("Memory for initramdisk is in use");
>>>> +            exit(1);
>>>> +        }
>>>> +        first_ppc_cpu->env.gpr[1] = spapr_do_client_claim(spapr, 0, 0x40000,
>>>> +                                                          0x10000);
>>>> +        if (first_ppc_cpu->env.gpr[1] == -1) {
>>>> +            error_report("Memory for stack is in use");
>>>> +            exit(1);
>>>> +        }
>>>> +
>>>> +        first_ppc_cpu->env.gpr[5] =
>>>> +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_blob.client),
>>>> +                                  sizeof(rtas_client_blob.client));
>>>> +        if (first_ppc_cpu->env.gpr[5] == -1) {
>>>> +            error_report("Memory for OF client is in use");
>>>> +            exit(1);
>>>> +        }
>>>> +        cpu_physical_memory_write(first_ppc_cpu->env.gpr[5],
>>>> +                                  rtas_client_blob.client,
>>>> +                                  sizeof(rtas_client_blob.client));
>>>> +
>>>> +        /* Allocate space for RTAS here so spapr_build_fdt() below picks it */
>>>> +        spapr->rtas_base =
>>>> +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_blob.rtas),
>>>> +                                  0x100);
>>>> +        if (spapr->rtas_base == -1) {
>>>> +            error_report("Memory for RTAS is in use");
>>>> +            exit(1);
>>>> +        }
>>>> +        cpu_physical_memory_write(spapr->rtas_base,
>>>> +                                  rtas_client_blob.rtas,
>>>> +                                  sizeof(rtas_client_blob.rtas));
>>>
>>> The above is complex enough it might be worth having bios and nobios
>>> variants of spapr_cpu_set_entry_state().
>>
>> Probably yes, when it settles. I'd rather prefer having kernel/initrd
>> claiming code where we load them but these are Roms and when we "load"
>> them, they are not loaded, they are loaded from a machine reset handler but:
>>
>> may be we could add a hook to Roms to be called every time an image is
>> actually written to the guest memory and
>>
>> this is when I would "claim" these chunks and
>>
>> this would make the chunk above shorter and we won't need a separate
>> spapr_cpu_set_entry_state().
> 
> Hm, ok.  Well let's see how it turns out.
> 
> Fwiw, I have considered replacing those load_targphys() things with
> explicit write in at reset time.  load_targphys() is, IIUC, mostly
> used for loading things like ROMs which exist in physical memory but
> don't go into regular RAM.  So if it turns out not to really match our
> needs here, that's ok.


Agree, may be later. I want to keep this a single patch.



>>>> +    } else {
>>>> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>>>> +        first_ppc_cpu->env.gpr[5] = 0; /* 0 = kexec !0 = prom_init */
>>>> +    }
>>>> +
>>>>       fdt = spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
>>>>   
>>>>       rc = fdt_pack(fdt);
>>>> @@ -1675,10 +1814,14 @@ static void spapr_machine_reset(MachineState *machine)
>>>>       spapr->fdt_initial_size = spapr->fdt_size;
>>>>       spapr->fdt_blob = fdt;
>>>>   
>>>> -    /* Set up the entry state */
>>>> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>>>> -    first_ppc_cpu->env.gpr[5] = 0;
>>>> -
>>>> +    if (!spapr->bios_enabled) {
>>>> +        /*
>>>> +         * Claim FDT space so initramdisk/zImage are not unpacked over it.
>>>> +         * In practice Linux claim additional memory for FDT and fetches it
>>>> +         * using client interface's "getprop" call.
>>>> +         */
>>>
>>> IIUC, it shouldn't actually be necessary to put the fdt into guest
>>> memory in nobios mode - it will be retrieved piecemeal via the client
>>> interface instead, won't it?
>>
>> Huh. I was under the impression that we pass the FDT to a VM via GPR3
>> and it is safer to avoid "claim" from claiming this memory (even though
>> Linux is not using it).
> 
> Well, depends what you mean.  I mean that's the "fdt boot" convention,
> which you've used previously for the nobios boot with an aware guest
> image.  We use a similar convention for firing up SLOF itself.  But if
> we're starting with a (simulated) OF entry condition, then as long as
> we have a working client interface, we don't need an fdt blob anywhere
> guest visible.
> 
>> Now I realize that this GPR3 is QEMU<->SLOF convention (or some OFW
>> binding - what is it exactly?) and Linux rather expects initramdisk
>> start/size in GPR3/4 and this did not hit me just because GPR4 is always
>> 0 so Linux falls back to the device tree for initramdisk location.
>>
>>
>>
>>
>>>
>>>> +        spapr_do_client_claim(spapr, fdt_addr, fdt_totalsize(fdt), 0);
>>>> +    }
>>>>       spapr->cas_reboot = false;
>>>>   }
>>>>   
>>>> @@ -2897,12 +3040,12 @@ static void spapr_machine_init(MachineState *machine)
>>>>           uint64_t lowaddr = 0;
>>>>   
>>>>           spapr->kernel_size = load_elf(kernel_filename, NULL,
>>>> -                                      translate_kernel_address, NULL,
>>>> +                                      translate_kernel_address, spapr,
>>>>                                         NULL, &lowaddr, NULL, 1,
>>>>                                         PPC_ELF_MACHINE, 0, 0);
>>>>           if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
>>>>               spapr->kernel_size = load_elf(kernel_filename, NULL,
>>>> -                                          translate_kernel_address, NULL, NULL,
>>>> +                                          translate_kernel_address, spapr, NULL,
>>>>                                             &lowaddr, NULL, 0, PPC_ELF_MACHINE,
>>>>                                             0, 0);
>>>>               spapr->kernel_le = spapr->kernel_size > 0;
>>>> @@ -2918,7 +3061,7 @@ static void spapr_machine_init(MachineState *machine)
>>>>               /* Try to locate the initrd in the gap between the kernel
>>>>                * and the firmware. Add a bit of space just in case
>>>>                */
>>>> -            spapr->initrd_base = (KERNEL_LOAD_ADDR + spapr->kernel_size
>>>> +            spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
>>>>                                     + 0x1ffff) & ~0xffff;
>>>>               spapr->initrd_size = load_image_targphys(initrd_filename,
>>>>                                                        spapr->initrd_base,
>>>> @@ -2932,20 +3075,22 @@ static void spapr_machine_init(MachineState *machine)
>>>>           }
>>>>       }
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
>>>>       }
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
>>>>       /* FIXME: Should register things through the MachineState's qdev
>>>>        * interface, this is a legacy from the sPAPREnvironment structure
>>>> @@ -3162,6 +3307,32 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>>>>       visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>>>   }
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
>>>
>>> Might be clearer to split the adjustable kernel addr stuff out into a
>>> separate patch - in fact, didn't you have such a patch before?
>>
>>
>> I did but it was not useful on its own and the whole "bios=off" feature
>> does not need to be "series" at this stage. Also having it separate
>> (before or after "kill slof") means changing same lines in 2 patches of
>> the same patchset which is never really good.
> 
> Hm, ok.  What's the reason you require the changeable load location
> for nobios?


I do not require it. It is purely for debugging. You can basically set address to 0, run qemu with -s and do step 
debugging with debug symbols from vmlinux (well, keep switching endianness), otherwise you would need to calculate 
offset (0x400000 or whatever it is) for every breakpoint you set. Once I passed the prom_init() debugging stage (which 
did not work because I did not provide stack), I have not used it for last couple of days.

So I could ditch it now but we could use it to reduce (small but still) memory fragmentation by placing vmlinux at 0. Dunno.


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
>>>>   static char *spapr_get_ic_mode(Object *obj, Error **errp)
>>>>   {
>>>>       SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>>>> @@ -3267,6 +3438,20 @@ static void spapr_instance_init(Object *obj)
>>>>       object_property_add_bool(obj, "vfio-no-msix-emulation",
>>>>                                spapr_get_msix_emulation, NULL, NULL);
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
>>>>       /* The machine class defines the default interrupt controller mode */
>>>>       spapr->irq = smc->irq;
>>>>       object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
>>>> diff --git a/hw/ppc/spapr_client.c b/hw/ppc/spapr_client.c
>>>> new file mode 100644
>>>> index 000000000000..a318eaae3c40
>>>> --- /dev/null
>>>> +++ b/hw/ppc/spapr_client.c
>>>> @@ -0,0 +1,464 @@
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu-common.h"
>>>> +#include "qapi/error.h"
>>>> +#include "exec/memory.h"
>>>> +#include "hw/ppc/spapr.h"
>>>> +#include "hw/ppc/spapr_vio.h"
>>>> +#include "trace.h"
>>>> +
>>>> +struct prom_args {
>>>
>>> StudlyCaps and typedef, please..
>>>
>>>> +        __be32 service;
>>>> +        __be32 nargs;
>>>> +        __be32 nret;
>>>> +        __be32 args[10];
>>
>>
>> btw we do not generally have __be32 (and x86 build fails), I am
>> replacing these with uint32_t.
> 
> Ok, good.
> 
>>>> +};
>>>> +
>>>> +#define CLI_PH_MASK     0x0FFFFFFF
>>>> +#define CLI_INST_PREFIX 0x20000000
>>>> +
>>>> +#define readstr(pa, buf) cpu_physical_memory_read((pa), (buf), sizeof(buf))
>>>
>>> I'd prefer "readbuf" or something, since this isn't actually looking
>>> at any string structure.
>>>
>>>> +#define readuint32(pa) ({ \
>>>> +    uint32_t __tmp__; \
>>>> +    cpu_physical_memory_read((pa), &__tmp__, sizeof(__tmp__)); \
>>>> +    be32_to_cpu(__tmp__); })
>>>
>>> You can simplify this with ldl_be_phys().  In fact, then you probably
>>> don't need any wrapper at all.
>>
>> Ah right. There are too many of these, was quicker to type this :)
>>
>>
>>>> +
>>>> +static bool _cmpservice(const char *s, size_t len,
>>>> +                        unsigned nargs, unsigned nret,
>>>> +                        const char *s1, size_t len1,
>>>> +                        unsigned nargscheck, unsigned nretcheck)
>>>> +{
>>>> +    if (strncmp(s, s1, MAX(len, len1))) {
>>>> +        return false;
>>>> +    }
>>>> +    if (nargscheck == 0 && nretcheck == 0) {
>>>> +        return true;
>>>> +    }
>>>> +    if (nargs != nargscheck || nret != nretcheck) {
>>>> +        trace_spapr_client_error_param(s, nargscheck, nretcheck, nargs, nret);
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static uint32_t client_finddevice(const void *fdt, uint32_t nodeaddr)
>>>> +{
>>>> +    char node[256];
>>>> +    int ret;
>>>> +
>>>> +    readstr(nodeaddr, node);
>>>> +    ret = fdt_path_offset(fdt, node);
>>>> +    if (ret >= 0) {
>>>> +        ret = fdt_get_phandle(fdt, ret);
>>>> +    }
>>>> +
>>>> +    return (uint32_t) ret;
>>>> +}
>>>> +
>>>> +static uint32_t client_getprop(const void *fdt, uint32_t nodeph, uint32_t pname,
>>>> +            uint32_t valaddr, uint32_t vallen)
>>>> +{
>>>> +    char propname[64];
>>>> +    uint32_t ret = 0;
>>>> +    int proplen = 0;
>>>> +    const void *prop;
>>>> +
>>>> +    readstr(pname, propname);
>>>> +
>>>> +    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
>>>> +                               propname, strlen(propname), &proplen);
>>>
>>> You can just use fdt_getprop().  By definition it's equivalent to
>>> fdt_getprop_namelen(.., propname, strlen(propname), ...)
>>>
>>>> +    if (prop) {
>>>> +        int cb = MIN(proplen, vallen);
>>>> +
>>>> +        cpu_physical_memory_write(valaddr, prop, cb);
>>>> +        ret = cb;
>>>> +    } else if (strncmp(propname, "stdout", 6) == 0 && vallen == sizeof(ret)) {
>>>> +        ret = cpu_to_be32(1);
>>>> +        cpu_physical_memory_write(valaddr, &ret, MIN(vallen, sizeof(ret)));
>>>
>>> I'm guessing the special casing of stdout is to fake the OF instancing
>>> stuff, which I don't really understand.  Some comments to explain
>>> what's going on here would be good.
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/prom_init.c#n2219
>>
>> This thing wants ihandle which is stored as /chosen/stdout and which we
>> do not have as there are no instances.
>>
>> If this property is not there, prom_panic() happens.
>>
>> I could implement some primitive intances, I'll look into this.
> 
> Ok, that's roughly as I guessed.  This seems like a reasonable way of
> handling this for now without having to implement a notion of
> instances - but it would be good to have some comment saying what's
> going on here.
> 
> We might need to implement at least basic awareness of instances
> if/when we need to be a bit more flexible about what input/output
> devices we use for the console.
> 
>>>> +    } else {
>>>> +        ret = -1;
>>>> +    }
>>>> +    trace_spapr_client_getprop(nodeph, propname, ret);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static uint32_t client_setprop(SpaprMachineState *sm,
>>>> +                               uint32_t nodeph, uint32_t pname,
>>>> +                               uint32_t valaddr, uint32_t vallen)
>>>> +{
>>>> +    char propname[64];
>>>> +    uint32_t ret = -1;
>>>> +    int proplen = 0;
>>>> +    const void *prop;
>>>> +
>>>> +    readstr(pname, propname);
>>>> +    if (vallen == sizeof(uint32_t) &&
>>>> +        ((strncmp(propname, "linux,rtas-base", 15) == 0) ||
>>>> +         (strncmp(propname, "linux,rtas-entry", 16) == 0))) {
>>>> +
>>>> +        sm->rtas_base = readuint32(valaddr);
>>>> +        prop = fdt_getprop_namelen(sm->fdt_blob,
>>>> +                                   fdt_node_offset_by_phandle(sm->fdt_blob,
>>>> +                                                              nodeph),
>>>> +                                   propname, strlen(propname), &proplen);
>>>> +        if (proplen == vallen) {
>>>> +            *(uint32_t *) prop = cpu_to_be32(sm->rtas_base);
>>>> +            ret = proplen;
>>>> +        }
>>>
>>> Is there a particular reason to restrict this to the rtas properties,
>>> rather than just allowing the guest to fdt_setprop() something
>>> arbitrary?
>>
>> The FDT is flatten and I am not quite sure if libfdt can handle updating
>> properties if the length has changed.
> 
> fdt_setprop() will handle updating properties with changed length (in
> fact there's a special fdt_setprop_inplace() optimized for the case
> where you don't need that).  It's not particularly efficient, but it
> should work fine for the cases we have here.  In fact, I think you're
> already relying on this for the code that adds the phandles to
> everything.

Well, I used to add phandles before calling fdt_pack() so it is not exactly the same.


> One complication is that it can return FDT_ERR_NOSPACE if there isn't
> enough buffer for the increased thing.  We could either trap that,
> resize and retry, or we could leave a bunch of extra space.  The
> latter would be basically equivalent to not doing fdt_pack() on the
> blob in the nobios case.


This is what I ended up doing.


>> Also, more importantly, potentially property changes like this may have
>> to be reflected in the QEMU device tree so I allowed only the properties
>> which I know how to deal with.
> 
> That's a reasonable concern, but the nice thing about not having SLOF
> is that there's only one copy of the device tree - the blob in qemu.
> So a setprop() on that is automatically a setprop() everywhere (this
> is another reason not to write the fdt into guest memory in the nobios
> case - it will become stale as soon as the client changes anything).


True to a degree. It is "setprop" to the current fdt blob which we do not analyze after we build the fdt. We either need 
to do parse the tree before we rebuild it as CAS so we do not lose the updates or do selective changes to the QEMUs 
objects from the "setprop" handler (this is what I do now). Thanks,


-- 
Alexey

