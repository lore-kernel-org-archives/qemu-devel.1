Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49038C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285072077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285072077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugym-0000D0-Oe
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iufGN-0007Nm-T5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iufGM-0006Lj-0s
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:23:23 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:48596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1iufGL-0006Kj-MG; Thu, 23 Jan 2020 11:23:21 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id ED4F8748DCE;
 Thu, 23 Jan 2020 17:23:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B63A5748DCC; Thu, 23 Jan 2020 17:23:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B4F49748DCD;
 Thu, 23 Jan 2020 17:23:19 +0100 (CET)
Date: Thu, 23 Jan 2020 17:23:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 65/80] ppc/{ppc440_bamboo, sam460ex}: use memdev
 for RAM
In-Reply-To: <1579779525-20065-66-git-send-email-imammedo@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001231723100.72857@zero.eik.bme.hu>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-66-git-send-email-imammedo@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>  MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> v3:
>  * drop ram_size from comment above ppc4xx_sdram_banks
>     (BALATON Zoltan <balaton@eik.bme.hu>)
>  * move memory alias initialization into the same loop
>    where RAM is split on banks.
>     (BALATON Zoltan <balaton@eik.bme.hu>)
> v3.1
>  * rebase on top of previous patch due to changed context
>
> CC: balaton@eik.bme.hu
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
> include/hw/ppc/ppc4xx.h |  2 +-
> hw/ppc/ppc440_bamboo.c  |  3 ++-
> hw/ppc/ppc4xx_devs.c    | 25 +++++++++----------------
> hw/ppc/sam460ex.c       |  3 ++-
> 4 files changed, 14 insertions(+), 19 deletions(-)
>
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index b8c8f32..cc19c8d 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -42,7 +42,7 @@ enum {
> qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
>                        uint32_t dcr_base, int has_ssr, int has_vr);
>
> -void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
> +void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
>                         MemoryRegion ram_memories[],
>                         hwaddr ram_bases[], hwaddr ram_sizes[],
>                         const ram_addr_t sdram_bank_sizes[]);
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 29a9642..1d4a11d 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -202,7 +202,7 @@ static void bamboo_init(MachineState *machine)
>     /* SDRAM controller */
>     memset(ram_bases, 0, sizeof(ram_bases));
>     memset(ram_sizes, 0, sizeof(ram_sizes));
> -    ppc4xx_sdram_banks(machine->ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
> +    ppc4xx_sdram_banks(machine->ram, PPC440EP_SDRAM_NR_BANKS, ram_memories,
>                        ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
>     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0. */
>     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
> @@ -289,6 +289,7 @@ static void bamboo_machine_init(MachineClass *mc)
>     mc->desc = "bamboo";
>     mc->init = bamboo_init;
>     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
> +    mc->default_ram_id = "ppc4xx.sdram";
> }
>
> DEFINE_MACHINE("bamboo", bamboo_machine_init)
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index d89008a..0e2f81c 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -666,7 +666,7 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>         sdram_map_bcr(sdram);
> }
>
> -/* Fill in consecutive SDRAM banks with 'ram_size' bytes of memory.
> +/* Split RAM between SDRAM banks.
>  *
>  * sdram_bank_sizes[] must be in descending order, that is sizes[i] > sizes[i+1]
>  * and must be 0-terminated.
> @@ -674,16 +674,14 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>  * The 4xx SDRAM controller supports a small number of banks, and each bank
>  * must be one of a small set of sizes. The number of banks and the supported
>  * sizes varies by SoC. */
> -void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
> +void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
>                         MemoryRegion ram_memories[],
>                         hwaddr ram_bases[], hwaddr ram_sizes[],
>                         const ram_addr_t sdram_bank_sizes[])
> {
> -    MemoryRegion *ram = g_malloc0(sizeof(*ram));
> -    ram_addr_t size_left = ram_size;
> +    ram_addr_t size_left = memory_region_size(ram);
>     ram_addr_t base = 0;
>     ram_addr_t bank_size;
> -    int last_bank = 0;
>     int i;
>     int j;
>
> @@ -691,11 +689,15 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
>         for (j = 0; sdram_bank_sizes[j] != 0; j++) {
>             bank_size = sdram_bank_sizes[j];
>             if (bank_size <= size_left) {
> +                char name[32];
> +
>                 ram_bases[i] = base;
>                 ram_sizes[i] = bank_size;
>                 base += bank_size;
>                 size_left -= bank_size;
> -                last_bank = i;
> +                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> +                memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> +                                         ram_bases[i], ram_sizes[i]);
>                 break;
>             }
>         }
> @@ -706,7 +708,7 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
>     }
>
>     if (size_left) {
> -        ram_addr_t used_size = ram_size - size_left;
> +        ram_addr_t used_size = memory_region_size(ram) - size_left;
>         GString *s = g_string_new(NULL);
>
>         for (i = 0; sdram_bank_sizes[i]; i++) {
> @@ -722,15 +724,6 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
>         g_string_free(s, true);
>         exit(EXIT_FAILURE);
>     }
> -
> -    memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
> -
> -    for (i = 0; i <= last_bank; i++) {
> -        char name[32];
> -        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> -        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> -                                 ram_bases[i], ram_sizes[i]);
> -    }
> }
>
> /*****************************************************************************/
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 949acba..b48aea5 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -324,7 +324,7 @@ static void sam460ex_init(MachineState *machine)
>     /* SDRAM controller */
>     /* put all RAM on first bank because board has one slot
>      * and firmware only checks that */
> -    ppc4xx_sdram_banks(machine->ram_size, 1, ram_memories, ram_bases, ram_sizes,
> +    ppc4xx_sdram_banks(machine->ram, 1, ram_memories, ram_bases, ram_sizes,
>                        ppc460ex_sdram_bank_sizes);
>
>     /* FIXME: does 460EX have ECC interrupts? */
> @@ -483,6 +483,7 @@ static void sam460ex_machine_init(MachineClass *mc)
>     mc->init = sam460ex_init;
>     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
>     mc->default_ram_size = 512 * MiB;
> +    mc->default_ram_id = "ppc4xx.sdram";
> }
>
> DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
>

