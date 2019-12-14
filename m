Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1FCC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBF120866
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdCp3WgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBF120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEqH-0006BA-Rs
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEoe-0004Xx-Gb
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEoc-0007xb-1L
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:19:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEob-0007v2-Hn
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576358344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1WKTAAdK/tLnNkgos6Lk4vIt/+CYxOhkXdm02qtRI4=;
 b=SdCp3WgSZYhtWzJy5xIYLDSGVCHuITzfoCvP3HVlsa6Wi4CY1pI7/dj6ch3pwaaEcTDb+8
 qoFOcbeBG8ZqgFNo0HkWi5fsjxbK13fRUGUAzAKmWGOTgS3E1Lq93L1HuMCWVsi+CROvIJ
 B9iyokMMsjICjY6YuzcJnYXpmtYQ0hs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-IRF1AYsgPJ29uxCrvvfezw-1; Sat, 14 Dec 2019 08:15:39 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so986965wrw.0
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y1WKTAAdK/tLnNkgos6Lk4vIt/+CYxOhkXdm02qtRI4=;
 b=RilfM5GqtPiM8Ubt3EHkQ6uGH6EahAd6XLf63OBQ/nkH4/ZQ3GRJFKOK6SEENWVk/V
 p8NPl2l4uVBtK7vKSQjgN0Ta6Gvw7UDkFujYxgQkLABhdgoMefqALfHo2+W8fv2kmRNO
 yhRTZBMLk6yWS8Xdehc5YnLmswrglMVVkebwhJHwH0Z0VKbC1D2UJjG6JG6kRibJn6VA
 sjrx6b2NK+AlAIS48W7p2GsNcl2Eka2Q3/EtyMxVe7VykIIsy1NNeVA/m+3tWHZTSLCJ
 0lgUXDDzd2ew0/Lpf9oQev6n0+ozBq/02k2JM2NEuUmKIUn+lgBmCym5IUvuXUhR+P+z
 yIjg==
X-Gm-Message-State: APjAAAWJn0C6+FS4yMnARA0Kk3Rhunff5d5xSmCWXB0pQXF7Jx/8kX5b
 iiHMtKrgLaYZlaXbb1b2l8brVR55igT0l8pdZJaaevtdnMsYP6caXkpxzmXPlRzF5GdOuHm5oNj
 X9ZmWbxgTjlSO2OM=
X-Received: by 2002:adf:fd07:: with SMTP id e7mr18437409wrr.21.1576329338165; 
 Sat, 14 Dec 2019 05:15:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzq84gfzBloTd+YaV1BT/Az2HOxGWAqJysHV99UsnXBOidd/s4ulY5JkHbF69zA8OlNFY8LpQ==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr18437335wrr.21.1576329337246; 
 Sat, 14 Dec 2019 05:15:37 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id e8sm13607070wrt.7.2019.12.14.05.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:15:36 -0800 (PST)
Subject: Re: [PATCH 3/3] q800: add machine id register
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191212200142.15688-1-laurent@vivier.eu>
 <20191212200142.15688-4-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <147a4c04-3833-b812-977f-786f36c02bd6@redhat.com>
Date: Sat, 14 Dec 2019 14:15:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212200142.15688-4-laurent@vivier.eu>
Content-Language: en-US
X-MC-Unique: IRF1AYsgPJ29uxCrvvfezw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 12/12/19 9:01 PM, Laurent Vivier wrote:
> MacOS reads this address to identify the hardware.
> 
> This is a basic implementation returning the ID of Quadra 800.
> 
> Details:
> 
>    http://mess.redump.net/mess/driver_info/mac_technical_notes
> 
> "There are 3 ID schemes [...]
>   The third and most scalable is a machine ID register at 0x5ffffffc.
>   The top word must be 0xa55a to be valid. Then bits 15-11 are 0 for
>   consumer Macs, 1 for portables, 2 for high-end 68k, and 3 for high-end
>   PowerPC. Bit 10 is 1 if additional ID bits appear elsewhere (e.g. in VIA1).
>   The rest of the bits are a per-model identifier.
> 
>   Model                          Lower 16 bits of ID
> ...
>   Quadra/Centris 610/650/800     0x2BAD"
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/q800.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 9ee0cb1141..c2b2aa779f 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -97,6 +97,23 @@ static void main_cpu_reset(void *opaque)
>       cpu->env.pc = ldl_phys(cs->as, 4);
>   }
>   
> +static uint64_t machine_id_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0xa55a2bad; /* Quadra 800 ID */
> +}
> +
> +static void machine_id_write(void *opaque, hwaddr addr, uint64_t val,
> +                             unsigned size)
> +{

Maybe worth adding:

        qemu_log_mask(LOG_GUEST_ERROR, ...);

> +}
> +
> +static const MemoryRegionOps machine_id_ops = {
> +    .read = machine_id_read,
> +    .write = machine_id_write,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,

I think you want s/valid/impl/, because i.e. the guest could use 16-bit 
access right?

> +};
> +
>   static void q800_init(MachineState *machine)
>   {
>       M68kCPU *cpu = NULL;
> @@ -110,6 +127,7 @@ static void q800_init(MachineState *machine)
>       MemoryRegion *rom;
>       MemoryRegion *ram;
>       MemoryRegion *io;
> +    MemoryRegion *machine_id;
>       const int io_slice_nb = (IO_SIZE / IO_SLICE) - 1;
>       int i;
>       ram_addr_t ram_size = machine->ram_size;
> @@ -159,6 +177,10 @@ static void q800_init(MachineState *machine)
>           g_free(name);
>       }
>   
> +    machine_id = g_malloc(sizeof(*machine_id));

We now prefer g_new(MemoryRegion, 1).

> +    memory_region_init_io(machine_id, NULL, &machine_id_ops, NULL, "Machine ID", 4);
> +    memory_region_add_subregion(get_system_memory(), 0x5ffffffc, machine_id);

To keep the style consistent, can you use a MACHINEID_BASE definition 
instead?

> +
>       /* djMEMC memory and interrupt controller */
>   
>       djmemc_dev = qdev_create(NULL, TYPE_DJMEMC);
> 


