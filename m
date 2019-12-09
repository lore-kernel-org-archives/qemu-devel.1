Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E25FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166A92068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kai/XKi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166A92068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIyX-0001TT-7J
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieIq9-0002k2-OO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieIq7-0000dD-J5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:12:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24242
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieIq7-0000d3-Eh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575897159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQUZ5vCt0vHhC/vLRo1BaBM+ejyy1fbgPpqyUuuKQ24=;
 b=Kai/XKi2rS+yocQCSQLdwyj71ZiLvEePVo8aWMNKnAowihijTjVqAAL3mRljOfZJbQar9n
 2LMup428ucvxvU2TKflV79LF2p1tXyA/nbLNSHqeVhQQ53MjqOi6tPjnDK1W/KqdodKUyt
 QS+csTM7gpnantcygfDm6nmKN0Up9T8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-jhRPyGicOIKju721cdcRCA-1; Mon, 09 Dec 2019 08:12:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so7430556wrt.21
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 05:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TQUZ5vCt0vHhC/vLRo1BaBM+ejyy1fbgPpqyUuuKQ24=;
 b=N15ES8KhCRxT7ELi2gr+9CQkp8OGUCZAAkP99bq+GOJoQhusCFHg2ThPFRg2b8AepP
 rGGKoj8nzHIyu0yWCUOrshLn+ujv40W7qXWapJ9IPGuYaKSBiV1/K7/m3Dqv0SL3VDu+
 N3vocpuScpU0BzuVv1HEvn9MpXlL5CgS8vnLXid55ewoLuvr+eAjZKk/mFLxQjcvZZY0
 K/OI2ONwT87sFaiITDEw1X5RhmKydcgzww691bdDkIgmXHexGIREu0HXY1qsk6aYiwo7
 iZayxFMhkFmp+yMpNh9i43q7kyi8cuDzLSN89UGIuEZ4eIrl2REoln3GrkJPk6MxUMAb
 /ZGQ==
X-Gm-Message-State: APjAAAX+NbdT9v8cljGXQ/KGyvPq3OJgQ22vzBGBGIC7Am/ce/a8Vz0x
 2STkAJeDKrGsg94whphsPHpAkwrA/OIyZIay4xbbl+EPnJdw3etpedk+mcbSLVQmmo1XAL4mWOX
 r31eKLa0dPNwuB1U=
X-Received: by 2002:a1c:b7c4:: with SMTP id
 h187mr24834349wmf.105.1575897156896; 
 Mon, 09 Dec 2019 05:12:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTCtT1fzParRMDy6Knni/tKA4WbQSuUCMTPS6W0Ji5Lc/lJcq2tu7e7ca6pDOyx6huAzd1IA==
X-Received: by 2002:a1c:b7c4:: with SMTP id
 h187mr24834334wmf.105.1575897156704; 
 Mon, 09 Dec 2019 05:12:36 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id 2sm28407645wrq.31.2019.12.09.05.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 05:12:36 -0800 (PST)
Subject: Re: [PATCH v2 4/4] hw/display: Remove "rombar" hack from vga-pci and
 vmware_vga
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20191209125248.5849-1-thuth@redhat.com>
 <20191209125248.5849-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ab730ea-658f-ff98-035d-f94ed7775f00@redhat.com>
Date: Mon, 9 Dec 2019 14:12:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209125248.5849-5-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: jhRPyGicOIKju721cdcRCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 1:52 PM, Thomas Huth wrote:
> Now that the old pc-0.x machine types have been removed, we do not need
> the old "rombar" hacks anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/display/vga-pci.c    | 5 -----
>   hw/display/vga.c        | 4 +---
>   hw/display/vmware_vga.c | 5 -----
>   3 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index a27b88122d..cfe095713e 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -264,11 +264,6 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
>   
>           pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
>       }
> -
> -    if (!dev->rom_bar) {
> -        /* compatibility with pc-0.13 and older */
> -        vga_init_vbe(s, OBJECT(dev), pci_address_space(dev));
> -    }
>   }
>   
>   static void pci_std_vga_init(Object *obj)
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 82ebe53610..636586a476 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2304,9 +2304,7 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
>   
>   void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRegion *system_memory)
>   {
> -    /* With pc-0.12 and below we map both the PCI BAR and the fixed VBE region,
> -     * so use an alias to avoid double-mapping the same region.
> -     */
> +    /* Use an alias to avoid double-mapping the same region */

If I understand the comment correctly, we can now revert commit 
8294a64d7f9 and and remove the alias, isn't it?

>       memory_region_init_alias(&s->vram_vbe, obj, "vram.vbe",
>                                &s->vram, 0, memory_region_size(&s->vram));
>       /* XXX: use optimized standard vga accesses */
> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> index 23dc8910cc..ead754eccf 100644
> --- a/hw/display/vmware_vga.c
> +++ b/hw/display/vmware_vga.c
> @@ -1312,11 +1312,6 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
>                        &s->chip.vga.vram);
>       pci_register_bar(dev, 2, PCI_BASE_ADDRESS_MEM_PREFETCH,
>                        &s->chip.fifo_ram);
> -
> -    if (!dev->rom_bar) {
> -        /* compatibility with pc-0.13 and older */
> -        vga_init_vbe(&s->chip.vga, OBJECT(dev), pci_address_space(dev));
> -    }
>   }
>   
>   static Property vga_vmware_properties[] = {
> 


