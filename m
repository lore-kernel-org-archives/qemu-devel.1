Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD99C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EE7222FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EE7222FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIZJ-0001pg-3Z
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60967)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvIYk-0001N3-9K
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvIYj-0003Gn-8r
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:48:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvIYj-0003GD-39
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:48:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so57981363wmj.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N/ngK0fLBWxxNXjw4ll1NU2FT8rLNDlpy/iCMu0xQ2U=;
 b=qwRGjQMO8VEEeuvMxX/DheTMppD+fBMhvOxPcwOcohigdqTsHuBwu/bOh6Tvvoo6Gp
 M8yDu0igWQTAbl2ia4b4b9/O98w1wSNECCXqVkkYKWfbu8nJTKYV7oMVd7hapFuhjr0O
 eAIM8g/hajG1/V2SiGMJql9502o9kXlSizIXGXWK7moOOwyhr/Cnby0/AEQGv74+fCNE
 WthV4//exSjA4BuSNMvFqk/FjZGeOf4b5WqKQ/g8oSQrYkQgulpSgHL9gMp301l4PZf7
 gGpLJCYTopaqkSIQJPY2SEYvvjXXXjGKSoU0M2HshLI7ERONr9UrYIjiy6saewtPLR3r
 bLhA==
X-Gm-Message-State: APjAAAXIrjsF5Gf7GACOgPesujL2FyrRoGFNF3Cpt9dUe6fylujPIaiA
 JSiLKF36w0hYrwI6ealoIXpza/Qen8c=
X-Google-Smtp-Source: APXvYqxLi0rD+jYiSut+62GfpIoUKNa4mjg8TEPcK5DU9SFlAFlDv/1FQDAy8i6gjhsLYQ2EqbtZqA==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr3837358wmd.110.1565171320021; 
 Wed, 07 Aug 2019 02:48:40 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id y18sm87501297wmi.23.2019.08.07.02.48.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 02:48:39 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-28-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <aedef9fc-204d-1e6e-b93d-72a14e8a16f9@redhat.com>
Date: Wed, 7 Aug 2019 11:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565163924-18621-28-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 27/28] riscv: virt: Change create_fdt()
 to return void
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

On 8/7/19 9:45 AM, Bin Meng wrote:
> There is no need to return fdt at the end of create_fdt() because
> it's already saved in s->fdt. Other machines (sifive_u, spike)
> don't do it neither.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Changes in v2: None
> 
>  hw/riscv/virt.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2f75195..6bfa721 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -112,7 +112,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename,
>                             0x1800, 0, 0, 0x7);
>  }
>  
> -static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
> +static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> @@ -316,8 +316,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
>      g_free(nodename);
> -
> -    return fdt;
>  }
>  
>  
> @@ -373,7 +371,6 @@ static void riscv_virt_board_init(MachineState *machine)
>      size_t plic_hart_config_len;
>      int i;
>      unsigned int smp_cpus = machine->smp.cpus;
> -    void *fdt;
>  
>      /* Initialize SOC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> @@ -392,7 +389,7 @@ static void riscv_virt_board_init(MachineState *machine)
>          main_mem);
>  
>      /* create device tree */
> -    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
> +    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>  
>      /* boot rom */
>      memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
> @@ -411,9 +408,9 @@ static void riscv_virt_board_init(MachineState *machine)
>              hwaddr end = riscv_load_initrd(machine->initrd_filename,
>                                             machine->ram_size, kernel_entry,
>                                             &start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen",
> +            qemu_fdt_setprop_cell(s->fdt, "/chosen",
>                                    "linux,initrd-start", start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
> +            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
>                                    end);
>          }
>      }
> 

