Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F734C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2492073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajHHVQE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2492073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorU8-0007KL-IV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iorSp-0005ry-OM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iorSo-0003Rc-K6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:12:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iorSo-0003RK-Fo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578413534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=j3U0+GlDFQXBu3uq7STQ+9EqvUlInv1Wuno9yW9EGyg=;
 b=ajHHVQE822COXI+BaKyhOph+O42ksVh5DAZv6nabYmnbQrrBwXinDLlSQMdRO4U8IHuRr9
 p0zgZ1RB6Vl8Yj1l4YrpVDPUk2VoZevqE5xXfnKms2/EdTbiIHLhVbXBd7IREPG2P7PfRk
 GlpmE6Ej/ZjX5S4gvR0qVqL5ezE7akI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-GWFEa4rDNXuSYCe4yb0IRw-1; Tue, 07 Jan 2020 11:12:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76FA3801E7B
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 16:12:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2CD89CA3;
 Tue,  7 Jan 2020 16:12:09 +0000 (UTC)
Subject: Re: [PATCH 51/86] m68k:next-cube: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-52-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2a2088ef-fba5-5ad1-8dfc-cee241e0ef5a@redhat.com>
Date: Tue, 7 Jan 2020 17:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-52-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GWFEa4rDNXuSYCe4yb0IRw-1
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
>  hw/m68k/next-cube.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index e534334..cd93d9e 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -860,7 +860,6 @@ static void next_cube_init(MachineState *machine)
>  {
>      M68kCPU *cpu;
>      CPUM68KState *env;
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *rom = g_new(MemoryRegion, 1);
>      MemoryRegion *mmiomem = g_new(MemoryRegion, 1);
>      MemoryRegion *scrmem = g_new(MemoryRegion, 1);
> @@ -893,8 +892,7 @@ static void next_cube_init(MachineState *machine)
>      memcpy(ns->rtc.ram, rtc_ram2, 32);
>  
>      /* 64MB RAM starting at 0x04000000  */
> -    memory_region_allocate_system_memory(ram, NULL, "next.ram", ram_size);
> -    memory_region_add_subregion(sysmem, 0x04000000, ram);
> +    memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
>  
>      /* Framebuffer */
>      dev = qdev_create(NULL, TYPE_NEXTFB);
> @@ -967,6 +965,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
>      mc->desc = "NeXT Cube";
>      mc->init = next_cube_init;
>      mc->default_ram_size = RAM_SIZE;
> +    mc->default_ram_id = "next.ram";
>      mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
>  }
>  
> 

Acked-by: Thomas Huth <thuth@redhat.com>


