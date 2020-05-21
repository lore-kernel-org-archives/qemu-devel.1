Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22159C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B913A207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="pI/aJtSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B913A207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbreS-0001Ri-0H
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jbrcC-00051y-GD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:16:28 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jbrcB-0003ft-01
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:16:28 -0400
Received: by mail-pj1-x1044.google.com with SMTP id n15so3784044pjt.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=xOKS8sHG3UnAa1osuCaEzt1VEF7fXgKLY316KPJKFus=;
 b=pI/aJtSVWJvQGy+jwxLmSWL0nLIe2WL0VttijR0Wv7BVtl55CmL1lhOCni/zjv98DR
 cbmqn4d7Eftg/lyM4/DOW4eat/+JZUfJtcoP4UYDz598sW1HvPdlLWPAH0PTf0tWWtpn
 S3dKhmEG/nq4LaFS3zOkaIMAWqjtkoL6ew9gD6nigOV7I0AQghlGqqNxkQXn6iK2TGof
 Q8OdTNOlSkmHZE7QXCScw/293lwBBaVVkSdeNhtPMy+nufriwypKkOr7grzGtI4+kckd
 zZUOXqX0OF/wawAvRFSRtUht2oq6pnvCOL/haBxS1nBQyLkkd1b5r0HTKOZgN9TpvJDV
 2UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=xOKS8sHG3UnAa1osuCaEzt1VEF7fXgKLY316KPJKFus=;
 b=Nkx8uwrGDRB3Rizt8V7vp/aOadNymRQQnxdvIX4fbganIMVQVkcvapetg0fmBK0k0Z
 sTvlE/nmIRKJwCVLYB2A6x3s3XdREcwsCpp81SmP+1ZWHSwWG5a1uN5u64vGDl0nWpPx
 Turwk9hDwVW4fAxMhBNIjeo1mUDdgBCekOv4dPoVaC8d+7nkF9qj3x2Pu5Zusui99oAB
 aXl+H73rzuFsugZjb+yoJJNTEwXcJasTlIfduolxSS14iT4C1yDARdcsGn1khq8oGvMH
 W4yxLLxrkO9UnefR8IYpZ9GFI4CVb8IcDaEQIRQkDUpbCPDdrk8OtXLTb6jbAs2zj4NN
 AAww==
X-Gm-Message-State: AOAM532Pev+8MQYGz1FJlDXu9AYdUeazTaUTcfTb+5n0BjhOxaHGxc56
 4EdmwduAt/P3Oks/etXqhluVEg==
X-Google-Smtp-Source: ABdhPJwNjNYLpyWwviOUn2C6eIF8trUerE9fQmkN/90hBZGvZiWkpd4iZR8xFQ/Ek4+sEA9Sw4tPpg==
X-Received: by 2002:a17:90a:33ad:: with SMTP id
 n42mr275147pjb.168.1590092185326; 
 Thu, 21 May 2020 13:16:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id z29sm5276834pff.120.2020.05.21.13.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:16:24 -0700 (PDT)
Date: Thu, 21 May 2020 13:16:24 -0700 (PDT)
X-Google-Original-Date: Thu, 21 May 2020 13:06:01 PDT (-0700)
Subject: Re: [PATCH 2/4] hw/riscv: spike: Allow creating multiple sockets
In-Reply-To: <20200516063746.18296-3-anup.patel@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-a9ec47e8-e98a-4c33-83db-ed838eb62404@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=palmer@dabbelt.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 23:37:44 PDT (-0700), Anup Patel wrote:
> We extend RISC-V spike machine to allow creating a multi-socket machine.
> Each RISC-V spike machine socket is a set of HARTs and a CLINT instance.
> Other peripherals are shared between all RISC-V spike machine sockets.
> We also update RISC-V spike machine device tree to treat each socket as
> a NUMA node.
>
> The number of sockets in RISC-V spike machine can be specified using
> the "sockets=" sub-option of QEMU "-smp" command-line option. By
> default, only one socket RISC-V spike machine will be created.
>
> Currently, we only allow creating upto maximum 4 sockets with minimum
> 2 HARTs per socket. In future, this limits can be changed.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/riscv/spike.c         | 206 ++++++++++++++++++++++++---------------
>  include/hw/riscv/spike.h |   8 +-
>  2 files changed, 133 insertions(+), 81 deletions(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index d5e0103d89..f63c57a87c 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -64,9 +64,11 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> -    int cpu;
> -    uint32_t *cells;
> -    char *nodename;
> +    int cpu, socket;
> +    uint32_t *clint_cells;
> +    unsigned long clint_addr;
> +    uint32_t cpu_phandle, intc_phandle, phandle = 1;
> +    char *name, *clint_name, *clust_name, *core_name, *cpu_name, *intc_name;
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
>      if (!fdt) {
> @@ -88,68 +90,85 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>
> -    nodename = g_strdup_printf("/memory@%lx",
> -        (long)memmap[SPIKE_DRAM].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +    name = g_strdup_printf("/memory@%lx", (long)memmap[SPIKE_DRAM].base);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_cells(fdt, name, "reg",
>          memmap[SPIKE_DRAM].base >> 32, memmap[SPIKE_DRAM].base,
>          mem_size >> 32, mem_size);
> -    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -    g_free(nodename);
> +    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
> +    g_free(name);
>
>      qemu_fdt_add_subnode(fdt, "/cpus");
>      qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
>          SIFIVE_CLINT_TIMEBASE_FREQ);
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
>
> -    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
> -        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> -        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> -        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
> -        qemu_fdt_add_subnode(fdt, nodename);
> +    for (socket = (s->num_socs - 1); socket >= 0; socket--) {
> +        clust_name = g_strdup_printf("/cpus/cpu-map/cluster0%d", socket);
> +        qemu_fdt_add_subnode(fdt, clust_name);
> +
> +        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
> +
> +        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
> +            cpu_phandle = phandle++;
> +
> +            cpu_name = g_strdup_printf("/cpus/cpu@%d",
> +                s->soc[socket].hartid_base + cpu);
> +            qemu_fdt_add_subnode(fdt, cpu_name);
>  #if defined(TARGET_RISCV32)
> -        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
> +            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
>  #else
> -        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> +            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
>  #endif
> -        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
> -        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
> -        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
> -        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
> -        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
> -        qemu_fdt_add_subnode(fdt, intc);
> -        qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
> -        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
> -        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
> -        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> -        g_free(isa);
> -        g_free(intc);
> -        g_free(nodename);
> -    }
> +            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
> +            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
> +            g_free(name);
> +            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
> +            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> +                s->soc[socket].hartid_base + cpu);
> +            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
> +
> +            intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
> +            qemu_fdt_add_subnode(fdt, intc_name);
> +            intc_phandle = phandle++;
> +            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandle);
> +            qemu_fdt_setprop_string(fdt, intc_name, "compatible",
> +                "riscv,cpu-intc");
> +            qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
> +            qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
> +
> +            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> +            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
> +            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> +            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
> +
> +            core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
> +            qemu_fdt_add_subnode(fdt, core_name);
> +            qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
> +
> +            g_free(core_name);
> +            g_free(intc_name);
> +            g_free(cpu_name);
> +        }
>
> -    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
> -    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
> -        nodename =
> -            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> -        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
> -        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> -        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
> -        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> -        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
> -        g_free(nodename);
> +        clint_addr = memmap[SPIKE_CLINT].base +
> +            (memmap[SPIKE_CLINT].size * socket);
> +        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
> +        qemu_fdt_add_subnode(fdt, clint_name);
> +        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
> +        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
> +            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
> +        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
> +            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
> +
> +        g_free(clint_name);
> +        g_free(clint_cells);
> +        g_free(clust_name);
>      }
> -    nodename = g_strdup_printf("/soc/clint@%lx",
> -        (long)memmap[SPIKE_CLINT].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SPIKE_CLINT].base,
> -        0x0, memmap[SPIKE_CLINT].size);
> -    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> -        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
> -    g_free(cells);
> -    g_free(nodename);
>
>      if (cmdline) {
>          qemu_fdt_add_subnode(fdt, "/chosen");
> @@ -160,23 +179,51 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>  static void spike_board_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = spike_memmap;
> -
>      SpikeState *s = g_new0(SpikeState, 1);
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      int i;
> +    char *soc_name;
>      unsigned int smp_cpus = machine->smp.cpus;
> -
> -    /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> -                            &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> -                            &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> -                            &error_abort);
> +    unsigned int base_hartid, cpus_per_socket;
> +
> +    s->num_socs = machine->smp.sockets;
> +
> +    /* Ensure minumum required CPUs per socket */
> +    if ((smp_cpus / s->num_socs) < SPIKE_CPUS_PER_SOCKET_MIN)
> +        s->num_socs = 1;

Why?  It seems like creating single-hart sockets would be a good test case, and
I'm pretty sure it's a configuration that we had in embedded systems.

> +    /* Limit the number of sockets */
> +    if (SPIKE_SOCKETS_MAX < s->num_socs)
> +        s->num_socs = SPIKE_SOCKETS_MAX;
> +
> +    /* Initialize socket */
> +    for (i = 0; i < s->num_socs; i++) {
> +        base_hartid = i * (smp_cpus / s->num_socs);
> +        if (i == (s->num_socs - 1))
> +            cpus_per_socket = smp_cpus - base_hartid;
> +        else
> +            cpus_per_socket = smp_cpus / s->num_socs;
> +        soc_name = g_strdup_printf("soc%d", i);
> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
> +            sizeof(s->soc[i]), TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> +        g_free(soc_name);
> +        object_property_set_str(OBJECT(&s->soc[i]),
> +            machine->cpu_type, "cpu-type", &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]),
> +            base_hartid, "hartid-base", &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]),
> +            cpus_per_socket, "num-harts", &error_abort);
> +        object_property_set_bool(OBJECT(&s->soc[i]),
> +            true, "realized", &error_abort);
> +
> +        /* Core Local Interruptor (timer and IPI) for each socket */
> +        sifive_clint_create(
> +            memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
> +            memmap[SPIKE_CLINT].size, base_hartid, cpus_per_socket,
> +            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
> +    }
>
>      /* register system main memory (actual RAM) */
>      memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
> @@ -249,12 +296,7 @@ static void spike_board_init(MachineState *machine)
>                            &address_space_memory);
>
>      /* initialize HTIF using symbols found in load_kernel */
> -    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> -
> -    /* Core Local Interruptor (timer and IPI) */
> -    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> -        false);
> +    htif_mm_init(system_memory, mask_rom, &s->soc[0].harts[0].env, serial_hd(0));
>  }
>
>  static void spike_v1_10_0_board_init(MachineState *machine)
> @@ -268,6 +310,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>      int i;
>      unsigned int smp_cpus = machine->smp.cpus;
>
> +    s->num_socs = 1;
> +
>      if (!qtest_enabled()) {
>          info_report("The Spike v1.10.0 machine has been deprecated. "
>                      "Please use the generic spike machine and specify the ISA "
> @@ -275,13 +319,13 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>      }
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc[0], sizeof(s->soc[0]),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
> +    object_property_set_str(OBJECT(&s->soc[0]), SPIKE_V1_10_0_CPU, "cpu-type",
>                              &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> +    object_property_set_int(OBJECT(&s->soc[0]), smp_cpus, "num-harts",
>                              &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> +    object_property_set_bool(OBJECT(&s->soc[0]), true, "realized",
>                              &error_abort);
>
>      /* register system main memory (actual RAM) */
> @@ -339,7 +383,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>                            &address_space_memory);
>
>      /* initialize HTIF using symbols found in load_kernel */
> -    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> +    htif_mm_init(system_memory, mask_rom, &s->soc[0].harts[0].env, serial_hd(0));
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> @@ -358,6 +402,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>      int i;
>      unsigned int smp_cpus = machine->smp.cpus;
>
> +    s->num_socs = 1;
> +
>      if (!qtest_enabled()) {
>          info_report("The Spike v1.09.1 machine has been deprecated. "
>                      "Please use the generic spike machine and specify the ISA "
> @@ -365,13 +411,13 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>      }
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc[0], sizeof(s->soc[0]),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
> +    object_property_set_str(OBJECT(&s->soc[0]), SPIKE_V1_09_1_CPU, "cpu-type",
>                              &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> +    object_property_set_int(OBJECT(&s->soc[0]), smp_cpus, "num-harts",
>                              &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> +    object_property_set_bool(OBJECT(&s->soc[0]), true, "realized",
>                              &error_abort);
>
>      /* register system main memory (actual RAM) */
> @@ -425,7 +471,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>          "};\n";
>
>      /* build config string with supplied memory size */
> -    char *isa = riscv_isa_string(&s->soc.harts[0]);
> +    char *isa = riscv_isa_string(&s->soc[0].harts[0]);
>      char *config_string = g_strdup_printf(config_string_tmpl,
>          (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
>          (uint64_t)memmap[SPIKE_DRAM].base,
> @@ -448,7 +494,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>                            &address_space_memory);
>
>      /* initialize HTIF using symbols found in load_kernel */
> -    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> +    htif_mm_init(system_memory, mask_rom, &s->soc[0].harts[0].env, serial_hd(0));
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> @@ -476,7 +522,7 @@ static void spike_machine_init(MachineClass *mc)
>  {
>      mc->desc = "RISC-V Spike Board";
>      mc->init = spike_board_init;
> -    mc->max_cpus = 8;
> +    mc->max_cpus = SPIKE_CPUS_MAX;
>      mc->is_default = true;
>      mc->default_cpu_type = SPIKE_V1_10_0_CPU;
>  }
> diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
> index dc770421bc..04a9f593b5 100644
> --- a/include/hw/riscv/spike.h
> +++ b/include/hw/riscv/spike.h
> @@ -22,12 +22,18 @@
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/sysbus.h"
>
> +#define SPIKE_SOCKETS_MAX 4
> +#define SPIKE_CPUS_PER_SOCKET_MIN 2
> +#define SPIKE_CPUS_PER_SOCKET_MAX 4
> +#define SPIKE_CPUS_MAX (SPIKE_SOCKETS_MAX * SPIKE_CPUS_PER_SOCKET_MAX)
> +
>  typedef struct {
>      /*< private >*/
>      SysBusDevice parent_obj;
>
>      /*< public >*/
> -    RISCVHartArrayState soc;
> +    unsigned int num_socs;
> +    RISCVHartArrayState soc[SPIKE_SOCKETS_MAX];
>      void *fdt;
>      int fdt_size;
>  } SpikeState;

