Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17732074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="bASRpnst";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="jM9eJxOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17732074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjILc-000162-2U
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jjIKa-0000aF-QZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:13:00 -0400
Received: from relay5.mymailcheap.com ([159.100.241.64]:52766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jjIKX-00053M-RH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:13:00 -0400
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
 by relay5.mymailcheap.com (Postfix) with ESMTPS id 38D4B20149
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 08:12:53 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 84B913F1C5;
 Thu, 11 Jun 2020 04:12:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 617FC2A3AD;
 Thu, 11 Jun 2020 04:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1591863167;
 bh=k/Iam9cwNtzG1ZfiWKbUmT+KNL7+cynX7vwu7+fs69A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bASRpnst6M38gMQ59wCZqYAW0epAI0nGCMu1+gWWhPsp4ExxrMYRmwQ1NnTOe+XBu
 n8Mfx3lHpXRdu3XJIsHx1wfR8+4AOtnia0mkMg/2A/3uUbGvFWeed9lcTI/9JZ6suW
 QnQvEEdzJBtmyvlKaO5XcCR6lrqB2EfD7+BVZdwI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uIiXE7WsAU23; Thu, 11 Jun 2020 04:12:45 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Thu, 11 Jun 2020 04:12:45 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id CC38140EA9;
 Thu, 11 Jun 2020 08:12:43 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="jM9eJxOI"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (n219078103103.netvigator.com [219.78.103.103])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0E2C840EA9;
 Thu, 11 Jun 2020 08:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1591863137;
 bh=k/Iam9cwNtzG1ZfiWKbUmT+KNL7+cynX7vwu7+fs69A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jM9eJxOIERotUZxTNR+6Hh/QjKj9k+XmgVx3RrwR4ZMQxvlG8ICN1rCrVTsCorBb0
 WcSJpAhPVO5qxI6CSlM8JlxQMnQxMgYdK+PayawIPQ3Jq4jM7A2DkHdXXJP/OkCL0e
 UPupOMeLzpX5jYgnpzCAmjHCRIcOLDdUjC3+c0Q0=
Subject: Re: [PATCH for-5.1 V4 3/4] hw/mips: Add Loongson-3 machine support
 (with KVM)
To: Huacai Chen <chenhuacai@gmail.com>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-4-git-send-email-chenhc@lemote.com>
 <59a6cfbb-3b53-1ca0-7871-5956b4188e31@flygoat.com>
 <CAAhV-H66OdX3zNwWj5sRjAWLJWoB5GPLsj1-MnV5G8Dt0i_RmQ@mail.gmail.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <3cfda172-7637-2791-cf65-0ba7a2e4c6bb@flygoat.com>
Date: Thu, 11 Jun 2020 16:12:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H66OdX3zNwWj5sRjAWLJWoB5GPLsj1-MnV5G8Dt0i_RmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC38140EA9
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 ML_SERVERS(-3.10)[148.251.23.173]; TO_DN_ALL(0.00)[];
 DKIM_TRACE(0.00)[flygoat.com:+]; RCPT_COUNT_SEVEN(0.00)[7];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 FREEMAIL_CC(0.00)[gmail.com,amsat.org,rt-rk.com,nongnu.org,aurel32.net];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=159.100.241.64;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay5.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 04:12:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/6/11 15:49, Huacai Chen 写道:
> Hi, Jiaxun,
> 
> On Thu, Jun 11, 2020 at 1:59 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>>
>>
>> 在 2020/6/2 10:39, Huacai Chen 写道:
>>> Add Loongson-3 based machine support, it use i8259 as the interrupt
>>> controler and use GPEX as the pci controller. Currently it can only
>>> work with KVM, but we will add TCG support in future.
>>>
>>> We already have a full functional Linux kernel (based on Linux-5.4.x LTS
>>> but not upstream yet) here:
>>>
>>> https://github.com/chenhuacai/linux
>>>
>>> How to use QEMU/Loongson-3?
>>> 1, Download kernel source from the above URL;
>>> 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
>>> 3, Boot the a Loongson-3A4000 host with this kernel;
>>> 4, Build QEMU-5.0.0 with this patchset;
>>> 5, modprobe kvm;
>>> 6, Use QEMU with TCG (available in future):
>>>          qemu-system-mips64el -M loongson3,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
>>>      Use QEMU with KVM (available at present):
>>>          qemu-system-mips64el -M loongson3,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...
>>>
>>>      The "-cpu" parameter can be omitted here and QEMU will use the correct type for TCG/KVM automatically.
>>>
>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>> ---
>>>    default-configs/mips64el-softmmu.mak |   1 +
>>>    hw/mips/Kconfig                      |  10 +
>>>    hw/mips/Makefile.objs                |   1 +
>>>    hw/mips/loongson3.c                  | 901 +++++++++++++++++++++++++++++++++++
>>>    4 files changed, 913 insertions(+)
>>>    create mode 100644 hw/mips/loongson3.c
>>
>> Hi there,
>>
>> I was working on TCG support based on this machine, and noticed some
>> minor issue here.
>>
>> Huacai, would you mind me to include your machine support in my TCG
>> series? As currently KVM support is blocked kernel.
>>
>>

[...]

>>> +
>>> +static int get_host_cpu_freq(void)
>>> +{
>>
>> "model name" have not been accppted by mainline kernel.
>> Probably asking kernel frequency via a part of QEMU IOCTL is a better
>> option?
> Is there exsiting better method? I will use if possible.

CPUCFG instruction introduced by 3A4000 have CCfreq domain to describe 
the frequency.
Or we can add it to kernel's data structure?

> 
>>
>>> +    int fd = 0, freq = 0;
>>> +    char buf[1024], *buf_p;
>>> +
>>> +    fd = open("/proc/cpuinfo", O_RDONLY);
>>> +    if (fd == -1) {
>>> +        fprintf(stderr, "Failed to open /proc/cpuinfo!\n");
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (read(fd, buf, 1024) < 0) {
>>> +        close(fd);
>>> +        fprintf(stderr, "Failed to read /proc/cpuinfo!\n");
>>> +        return 0;
>>> +    }
>>> +    close(fd);
>>> +
>>> +    buf_p = strstr(buf, "model name");
>>> +    while (*buf_p != '@') {
>>> +        buf_p++;
>>> +    }
>>> +
>>> +    buf_p += 2;
>>> +    memcpy(buf, buf_p, 12);
>>> +    buf_p = buf;
>>> +    while ((*buf_p >= '0') && (*buf_p <= '9')) {
>>> +        buf_p++;
>>> +    }
>>> +    *buf_p = '\0';
>>> +
>>> +    freq = atoi(buf);
>>> +
>>> +    return freq * 1000 * 1000;
>>> +}

[...]

>>> +
>>> +    setenv("memsize", memenv, 1);
>>> +    setenv("highmemsize", highmemenv, 1);
>>
>> These setenv looks pointless.
> memsize and highmemsize is standard MIPS kernel parameters.

By setenv you're not adding it to kernel parameter but adding it to 
*host's* environment variable.

Also memory size have already been passed by loongson's boot_param 
structure so no need to supply it in env again.

> 
>>
>>> +
>>> +    ret = ((ret + 32) & ~31);
>>> +
>>> +    boot_params_buf = (void *)(params_buf + ret);
>>> +    boot_params_p = boot_params_buf + align(sizeof(struct boot_params));
>>> +
>>> +    init_boot_param(boot_params_buf);
>>> +
>>> +    rom_add_blob_fixed("params", params_buf, params_size,
>>> +                       BOOTPARAM_PHYADDR);
>>> +    loaderparams.a0 = 2;
>>> +    loaderparams.a1 = 0xffffffff80000000ULL + BOOTPARAM_PHYADDR;
>>> +    loaderparams.a2 = 0xffffffff80000000ULL + BOOTPARAM_PHYADDR + ret;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int64_t load_kernel(CPUMIPSState *env)
>>> +{
>>> +    long kernel_size;
>>> +    ram_addr_t initrd_offset;
>>> +    int64_t kernel_entry, kernel_low, kernel_high, initrd_size;
>>> +
>>> +    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
>>> +                           cpu_mips_kseg0_to_phys, NULL,
>>> +                           (uint64_t *)&kernel_entry,
>>> +                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_high,
>>> +                           NULL, 0, EM_MIPS, 1, 0);
>>> +    if (kernel_size < 0) {
>>> +        error_report("could not load kernel '%s': %s",
>>> +                     loaderparams.kernel_filename,
>>> +                     load_elf_strerror(kernel_size));
>>> +        exit(1);
>>> +    }
>>> +
>>> +    /* load initrd */
>>> +    initrd_size = 0;
>>> +    initrd_offset = 0;
>>> +    if (loaderparams.initrd_filename) {
>>> +        initrd_size = get_image_size(loaderparams.initrd_filename);
>>> +        if (initrd_size > 0) {
>>> +            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
>>> +                            INITRD_PAGE_MASK;
>>> +            initrd_offset = MAX(initrd_offset, INITRD_OFFSET);
>>> +
>>> +            if (initrd_offset + initrd_size > ram_size) {
>>> +                error_report("memory too small for initial ram disk '%s'",
>>> +                             loaderparams.initrd_filename);
>>> +                exit(1);
>>> +            }
>>> +
>>> +            initrd_size = load_image_targphys(loaderparams.initrd_filename,
>>> +                                              initrd_offset,
>>> +                                              ram_size - initrd_offset);
>>> +        }
>>> +
>>> +        if (initrd_size == (target_ulong) -1) {
>>> +            error_report("could not load initial ram disk '%s'",
>>> +                         loaderparams.initrd_filename);
>>> +            exit(1);
>>> +        }
>>> +    }
>>> +
>>> +    /* Setup prom parameters. */
>>> +    set_prom_bootparam(initrd_offset, initrd_size);
>>> +
>>> +    return kernel_entry;
>>> +}
>>> +
>>> +static void main_cpu_reset(void *opaque)
>>> +{
>>> +    MIPSCPU *cpu = opaque;
>>> +    CPUMIPSState *env = &cpu->env;
>>> +
>>> +    cpu_reset(CPU(cpu));
>>> +
>>> +    /* Loongson-3 reset stuff */
>>> +    if (loaderparams.kernel_filename) {
>>> +        if (cpu == MIPS_CPU(first_cpu)) {
>>> +            env->active_tc.gpr[4] = loaderparams.a0;
>>> +            env->active_tc.gpr[5] = loaderparams.a1;
>>> +            env->active_tc.gpr[6] = loaderparams.a2;
>>> +            env->active_tc.PC = loaderparams.kernel_entry;
>>> +        }
>>> +        env->CP0_Status &= ~((1 << CP0St_BEV) | (1 << CP0St_ERL));
>>> +    }
>>> +}
>>> +
>>> +static void loongson3_isa_init(qemu_irq intc)
>>> +{
>>> +    qemu_irq *i8259;
>>> +    ISABus *isa_bus;
>>> +
>>> +    isa_bus = isa_bus_new(NULL, get_system_memory(), get_system_io(), &error_abort);
>>> +
>>> +    /* Interrupt controller */
>>> +    /* The 8259 -> IP3  */
>>> +    i8259 = i8259_init(isa_bus, intc);
>>> +    isa_bus_irqs(isa_bus, i8259);
>>> +    /* init other devices */
>>> +    isa_create_simple(isa_bus, "i8042");
>>> +    mc146818_rtc_init(isa_bus, 2000, NULL);
>>> +}
>>> +
>>> +static inline void loongson3_pcie_init(MachineState *machine, DeviceState *pic)
>>> +{
>>> +    int i;
>>> +    qemu_irq irq;
>>> +    PCIBus *pci_bus;
>>> +    DeviceState *dev;
>>> +    MemoryRegion *pio_alias;
>>> +    MemoryRegion *mmio_alias, *mmio_reg;
>>> +    MemoryRegion *ecam_alias, *ecam_reg;
>>> +
>>> +    dev = qdev_create(NULL, TYPE_GPEX_HOST);
>>> +
>>> +    qdev_init_nofail(dev);
>>> +    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
>>> +
>>> +    ecam_alias = g_new0(MemoryRegion, 1);
>>> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>>> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
>>> +                             ecam_reg, 0, VIRT_PCI_ECAM_SIZE);
>>> +    memory_region_add_subregion(get_system_memory(), VIRT_PCI_ECAM_BASE, ecam_alias);
>>> +
>>> +    mmio_alias = g_new0(MemoryRegion, 1);
>>> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>>> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
>>> +                             mmio_reg, VIRT_PCI_MEM_BASE, VIRT_PCI_MEM_SIZE);
>>> +    memory_region_add_subregion(get_system_memory(), VIRT_PCI_MEM_BASE, mmio_alias);
>>> +
>>> +    pio_alias = g_new0(MemoryRegion, 1);
>>> +    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
>>> +                             get_system_io(), 0, VIRT_PCI_IO_SIZE);
>>> +    memory_region_add_subregion(get_system_memory(), VIRT_PCI_IO_BASE, pio_alias);
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, VIRT_PCI_IO_BASE);
>>> +
>>> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
>>> +        irq = qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
>>> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
>>> +        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
>>> +    }
>>> +
>>> +    pci_vga_init(pci_bus);
>>> +
>>> +    for (i = 0; i < nb_nics; i++) {
>>> +        NICInfo *nd = &nd_table[i];
>>> +
>>> +        if (!nd->model) {
>>> +            nd->model = g_strdup("virtio");
>>> +        }
>>> +
>>> +        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
>>> +    }
>>> +}
>>> +
>>> +static void mips_loongson3_init(MachineState *machine)
>>> +{
>>> +    int i;
>>> +    long bios_size;
>>> +    MIPSCPU *cpu;
>>> +    CPUMIPSState *env;
>>> +    char *filename;
>>> +    const char *kernel_cmdline = machine->kernel_cmdline;
>>> +    const char *kernel_filename = machine->kernel_filename;
>>> +    const char *initrd_filename = machine->initrd_filename;
>>> +    ram_addr_t ram_size = machine->ram_size;
>>> +    MemoryRegion *address_space_mem = get_system_memory();
>>> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>>> +    MemoryRegion *bios = g_new(MemoryRegion, 1);
>>> +    MemoryRegion *iomem = g_new(MemoryRegion, 1);
>>> +
>>> +    if (!kvm_enabled()) {
>>> +        if (!machine->cpu_type) {
>>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
>>> +        }
>>> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
>>> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1000");
>>> +            exit(1);
>>> +        }
>>> +    } else {
>>> +        if (!machine->cpu_type) {
>>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
>>> +        }
>>> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
>>> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4000");
>>> +            exit(1);
>>> +        }
>>> +    }
>>> +
>>> +    if (ram_size < 256 * 0x100000) {
>>> +        error_report("Loongson-3 need at least 256MB memory");
>>> +        exit(1);
>>> +    }
>>> +
>>> +    for (i = 0; i < machine->smp.cpus; i++) {
>>> +        /* init CPUs */
>>> +        cpu = MIPS_CPU(cpu_create(machine->cpu_type));
>>> +
>>> +        /* Init internal devices */
>>> +        cpu_mips_irq_init_cpu(cpu);
>>> +        cpu_mips_clock_init(cpu);
>>> +        qemu_register_reset(main_cpu_reset, cpu);
>>> +    }
>>> +    env = &MIPS_CPU(first_cpu)->env;
>>> +
>>> +    /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
>>> +    memory_region_init_rom(bios, NULL, "loongson3.bios",
>>> +                           BIOS_SIZE, &error_fatal);
>>> +    memory_region_init_alias(ram, NULL, "loongson3.lowram",
>>> +                           machine->ram, 0, 256 * 0x100000);
>>> +    memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
>>> +                           NULL, "loongson3_pm", PM_MMIO_SIZE);
>>> +
>>> +    memory_region_add_subregion(address_space_mem, 0x00000000LL, ram);
>>> +    memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
>>> +    memory_region_add_subregion(address_space_mem, 0x80000000LL, machine->ram);
>>> +    memory_region_add_subregion(address_space_mem, PM_MMIO_ADDR, iomem);
>>> +
>>> +    /*
>>> +     * We do not support flash operation, just loading pmon.bin as raw BIOS.
>>> +     * Please use -L to set the BIOS path and -bios to set bios name.
>>> +     */
>>> +
>>> +    if (kernel_filename) {
>>> +        loaderparams.ram_size = ram_size;
>>> +        loaderparams.kernel_filename = kernel_filename;
>>> +        loaderparams.kernel_cmdline = kernel_cmdline;
>>> +        loaderparams.initrd_filename = initrd_filename;
>>> +        loaderparams.kernel_entry = load_kernel(env);
>>> +        rom_add_blob_fixed("bios",
>>> +                         bios_boot_code, sizeof(bios_boot_code), 0x1fc00000LL);
>>> +    } else {
>>> +        if (bios_name == NULL) {
>>> +                bios_name = LOONGSON3_BIOSNAME;
>>> +        }
>>> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>> +        if (filename) {
>>> +            bios_size = load_image_targphys(filename, 0x1fc00000LL,
>>> +                                            BIOS_SIZE);
>>> +            g_free(filename);
>>> +        } else {
>>> +            bios_size = -1;
>>> +        }
>>> +
>>> +        if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
>>> +            !kernel_filename && !qtest_enabled()) {
>>> +            error_report("Could not load MIPS bios '%s'", bios_name);
>>> +            exit(1);
>>> +        }
>>> +
>>> +        fw_conf_init(ram_size);
>>> +        rom_add_blob_fixed("fw_conf",
>>> +                         &fw_config, sizeof(fw_config), FW_CONF_ADDR);
>>> +    }
>>> +
>>> +    msi_nonbroken = true;
>>
>> As this machine is not reflecting any actual Loongson-3 system, I would
>> say "loongson3-virt" can be a better name.
> I think "loongson3" can be a generic name, we don't need to show
> "virt" explicitly.
> 
>>
>>> +    loongson3_isa_init(env->irq[3]);
>>> +    loongson3_pcie_init(machine, isa_pic);
>>> +
>>> +    if (serial_hd(0)) {
>>> +        serial_mm_init(address_space_mem, 0x1fe001e0, 0, env->irq[2],
>>> +                           115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
>>> +    }
>>> +}
>>> +
>>> +static void mips_loongson3_machine_init(MachineClass *mc)
>>> +{
>>> +    mc->desc = "Generic Loongson-3 Platform";
>>> +    mc->init = mips_loongson3_init;
>>> +    mc->block_default_type = IF_IDE;
>>> +    mc->max_cpus = LOONGSON_MAX_VCPUS;
>>> +    mc->default_ram_id = "loongson3.highram";
>>> +    mc->default_ram_size = 1200 * MiB;
>>
>> 1200MiB looks wired... Why not 1024?
> Oh, it is just because our Fedora28 needs more than 1024MB to work
> fine, maybe 1280 is better?

Ahh if that's the reason then it looks fine for me.

> 
>>
>>> +    mc->kvm_type = mips_kvm_type;
>>> +    mc->minimum_page_bits = 14;
>>> +}
>>> +
>>> +DEFINE_MACHINE("loongson3", mips_loongson3_machine_init)
>>>
>>
>> As this machine is not reflecting any actual Loongson-3 system, I would
>> say "loongson3-virt" can be a better name
>>
>> Furthermore, the design of machine can be updated over time. So probably
>> we can add a version suffix to it just like what arm-virt did.
>>
>> Thanks!
>>
>> --
>> - Jiaxun
>>

-- 
- Jiaxun

