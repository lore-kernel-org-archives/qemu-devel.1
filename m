Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C196C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF7F2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3oIze4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF7F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorTk-0006e8-Po
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iorSR-0005V8-Tx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iorSQ-0003Hj-Si
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:11:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iorSQ-0003HT-OQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578413510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=/bt7EgiIhE7SQxbLhQAIF/iRV3BDhzqrQnjIllGIxF0=;
 b=F3oIze4VRJozN/5hTDoWhCAY2ZqCzA7dKG3HlYQ+fakP/SJakX4bZq8Sqdm2f9uR7Q4004
 EiCHMnd9FSmB5W7uzaVP46Jq0vUVIFwyqbsjyrRQVu2JAxESC5ua+zczp2SGCtrOrm0FSr
 prHnyNOun+GSwbB1aI1Mncby2nyYPLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-QnekNZlpOrumzbRCAwZqRQ-1; Tue, 07 Jan 2020 11:11:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6258DBE5
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 16:11:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 460685D9CA;
 Tue,  7 Jan 2020 16:11:46 +0000 (UTC)
Subject: Re: [PATCH 50/86] m68k:mcf5208: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-51-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <384bbf82-e0ee-60a9-288e-b3b5e20008c8@redhat.com>
Date: Tue, 7 Jan 2020 17:11:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-51-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: QnekNZlpOrumzbRCAwZqRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 31/12/2019 14.03, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/m68k/mcf5208.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 158c5e4..d050cb7 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -234,7 +234,6 @@ static void mcf5208evb_init(MachineState *machine)
>      qemu_irq *pic;
>      MemoryRegion *address_space_mem = get_system_memory();
>      MemoryRegion *rom = g_new(MemoryRegion, 1);
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *sram = g_new(MemoryRegion, 1);
>  
>      cpu = M68K_CPU(cpu_create(machine->cpu_type));
> @@ -249,8 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
>      memory_region_add_subregion(address_space_mem, 0x00000000, rom);
>  
>      /* DRAM at 0x40000000 */
> -    memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ram_size);
> -    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
> +    memory_region_add_subregion(address_space_mem, 0x40000000, machine->ram);
>  
>      /* Internal SRAM.  */
>      memory_region_init_ram(sram, NULL, "mcf5208.sram", 16 * KiB, &error_fatal);
> @@ -354,6 +352,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
>      mc->init = mcf5208evb_init;
>      mc->is_default = 1;
>      mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
> +    mc->default_ram_id = "mcf5208.ram";
>  }
>  
>  DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
> 

Acked-by: Thomas Huth <thuth@redhat.com>


