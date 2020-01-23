Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1354C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECA221D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECA221D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhO7-00029Q-Ac
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iufFU-0005oZ-00
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iufFR-0005pP-EM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:22:27 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:48575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1iufFR-0005mk-3U; Thu, 23 Jan 2020 11:22:25 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 94F66748DCC;
 Thu, 23 Jan 2020 17:22:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5FB0F7482D2; Thu, 23 Jan 2020 17:22:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5E8A57482D0;
 Thu, 23 Jan 2020 17:22:21 +0100 (CET)
Date: Thu, 23 Jan 2020 17:22:21 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 64/80] ppc/{ppc440_bamboo, sam460ex}: drop RAM
 size fixup
In-Reply-To: <1579779525-20065-65-git-send-email-imammedo@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001231721190.72857@zero.eik.bme.hu>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-65-git-send-email-imammedo@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported or sometimes
> crash like this:
>  %QEMU -M bamboo -m 1
>    exec.c:1926: find_ram_offset: Assertion `size != 0' failed.
>    Aborted (core dumped)
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
>
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
> That also fixes crash issue, since wrongly calculated size
> isn't used to allocate RAM
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> v2:
>  * s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/
>     (BALATON Zoltan <balaton@eik.bme.hu>)
>  * print possible valid ram size id not all RAM was distributed
>  * initialize ram_bases/ram_bases at the same time we are checking
>    that user supplied RAM would fit available banks and drop nested
>    loop that were duplicating the same calculations.
>  * coincidentally fix crash when -m is less than minimal bank size
> v3:
>  * s/ppc4xx_sdram_prep/ppc4xx_sdram_banks/
>      (BALATON Zoltan <balaton@eik.bme.hu>)
>  * fix subject line in commit message
> v3.1:
>  * add lost 'break' statement in 'j' loop
> v3.2:
>  * replace global ram_size with machine->ram_size in ppc4xx_sdram_banks() call
>  * add a comment about the expected sorting order within sdram_bank_sizes[]
>    (BALATON Zoltan <balaton@eik.bme.hu>)
>
> CC: balaton@eik.bme.hu
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
> include/hw/ppc/ppc4xx.h |  9 ++++----
> hw/ppc/ppc440_bamboo.c  | 11 ++++-----
> hw/ppc/ppc4xx_devs.c    | 60 ++++++++++++++++++++++++++-----------------------
> hw/ppc/sam460ex.c       |  5 ++---
> 4 files changed, 42 insertions(+), 43 deletions(-)
>
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 7d82259..b8c8f32 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -42,11 +42,10 @@ enum {
> qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
>                        uint32_t dcr_base, int has_ssr, int has_vr);
>
> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> -                               MemoryRegion ram_memories[],
> -                               hwaddr ram_bases[],
> -                               hwaddr ram_sizes[],
> -                               const ram_addr_t sdram_bank_sizes[]);
> +void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
> +                        MemoryRegion ram_memories[],
> +                        hwaddr ram_bases[], hwaddr ram_sizes[],
> +                        const ram_addr_t sdram_bank_sizes[]);
>
> void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>                         MemoryRegion ram_memories[],
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index b782641..29a9642 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -158,7 +158,6 @@ static void main_cpu_reset(void *opaque)
>
> static void bamboo_init(MachineState *machine)
> {
> -    ram_addr_t ram_size = machine->ram_size;
>     const char *kernel_filename = machine->kernel_filename;
>     const char *kernel_cmdline = machine->kernel_cmdline;
>     const char *initrd_filename = machine->initrd_filename;
> @@ -203,10 +202,8 @@ static void bamboo_init(MachineState *machine)
>     /* SDRAM controller */
>     memset(ram_bases, 0, sizeof(ram_bases));
>     memset(ram_sizes, 0, sizeof(ram_sizes));
> -    ram_size = ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS,
> -                                   ram_memories,
> -                                   ram_bases, ram_sizes,
> -                                   ppc440ep_sdram_bank_sizes);
> +    ppc4xx_sdram_banks(machine->ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
> +                       ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
>     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0. */
>     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
>                       ram_bases, ram_sizes, 1);
> @@ -268,7 +265,7 @@ static void bamboo_init(MachineState *machine)
>     /* Load initrd. */
>     if (initrd_filename) {
>         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
> -                                          ram_size - RAMDISK_ADDR);
> +                                          machine->ram_size - RAMDISK_ADDR);
>
>         if (initrd_size < 0) {
>             error_report("could not load ram disk '%s' at %x",
> @@ -279,7 +276,7 @@ static void bamboo_init(MachineState *machine)
>
>     /* If we're loading a kernel directly, we must load the device tree too. */
>     if (kernel_filename) {
> -        if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
> +        if (bamboo_load_device_tree(FDT_ADDR, machine->ram_size, RAMDISK_ADDR,
>                                     initrd_size, kernel_cmdline) < 0) {
>             error_report("couldn't load device tree");
>             exit(1);
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index c2e5013..d89008a 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -668,21 +668,22 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>
> /* Fill in consecutive SDRAM banks with 'ram_size' bytes of memory.
>  *
> - * sdram_bank_sizes[] must be 0-terminated.
> + * sdram_bank_sizes[] must be in descending order, that is sizes[i] > sizes[i+1]
> + * and must be 0-terminated.
>  *
>  * The 4xx SDRAM controller supports a small number of banks, and each bank
>  * must be one of a small set of sizes. The number of banks and the supported
>  * sizes varies by SoC. */
> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> -                               MemoryRegion ram_memories[],
> -                               hwaddr ram_bases[],
> -                               hwaddr ram_sizes[],
> -                               const ram_addr_t sdram_bank_sizes[])
> +void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
> +                        MemoryRegion ram_memories[],
> +                        hwaddr ram_bases[], hwaddr ram_sizes[],
> +                        const ram_addr_t sdram_bank_sizes[])
> {
>     MemoryRegion *ram = g_malloc0(sizeof(*ram));
>     ram_addr_t size_left = ram_size;
>     ram_addr_t base = 0;
>     ram_addr_t bank_size;
> +    int last_bank = 0;
>     int i;
>     int j;
>
> @@ -690,7 +691,12 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
>         for (j = 0; sdram_bank_sizes[j] != 0; j++) {
>             bank_size = sdram_bank_sizes[j];
>             if (bank_size <= size_left) {
> +                ram_bases[i] = base;
> +                ram_sizes[i] = bank_size;
> +                base += bank_size;
>                 size_left -= bank_size;
> +                last_bank = i;
> +                break;
>             }
>         }
>         if (!size_left) {
> @@ -699,34 +705,32 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
>         }
>     }
>
> -    ram_size -= size_left;
>     if (size_left) {
> -        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
> -                     " controller limits", ram_size / MiB);
> +        ram_addr_t used_size = ram_size - size_left;
> +        GString *s = g_string_new(NULL);
> +
> +        for (i = 0; sdram_bank_sizes[i]; i++) {
> +            g_string_append_printf(s, "%" PRIi64 "%s",
> +                                   sdram_bank_sizes[i] / MiB,
> +                                   sdram_bank_sizes[i + 1] ? " ," : "");
> +        }
> +        error_report("Max %d banks of %s MB DIMM/bank supported",
> +            nr_banks, s->str);
> +        error_report("Possible valid RAM size: %" PRIi64,
> +            used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
> +
> +        g_string_free(s, true);
> +        exit(EXIT_FAILURE);
>     }
>
>     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
>
> -    size_left = ram_size;
> -    for (i = 0; i < nr_banks && size_left; i++) {
> -        for (j = 0; sdram_bank_sizes[j] != 0; j++) {
> -            bank_size = sdram_bank_sizes[j];
> -
> -            if (bank_size <= size_left) {
> -                char name[32];
> -                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> -                memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> -                                         base, bank_size);
> -                ram_bases[i] = base;
> -                ram_sizes[i] = bank_size;
> -                base += bank_size;
> -                size_left -= bank_size;
> -                break;
> -            }
> -        }
> +    for (i = 0; i <= last_bank; i++) {
> +        char name[32];
> +        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> +        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> +                                 ram_bases[i], ram_sizes[i]);
>     }
> -
> -    return ram_size;
> }
>
> /*****************************************************************************/
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 437e214..949acba 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
>     /* SDRAM controller */
>     /* put all RAM on first bank because board has one slot
>      * and firmware only checks that */
> -    machine->ram_size = ppc4xx_sdram_adjust(machine->ram_size, 1,
> -                                   ram_memories, ram_bases, ram_sizes,
> -                                   ppc460ex_sdram_bank_sizes);
> +    ppc4xx_sdram_banks(machine->ram_size, 1, ram_memories, ram_bases, ram_sizes,
> +                       ppc460ex_sdram_bank_sizes);
>
>     /* FIXME: does 460EX have ECC interrupts? */
>     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
>

