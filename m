Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C91C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9448D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrbHHSXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9448D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46yb-0001cG-Pe
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46x4-0000ZP-2f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46x3-0003R4-3X
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:46:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46x2-0003Qu-VH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ym+UhosjyT0n4ICqQhEehXMC39T91GRtDeR0EdZ/X2I=;
 b=RrbHHSXuOWzlQjfcV/WucjnW+SMhyc6BlqRVqsD11oaER1BC8xwWJRYk6Rqt87DwVzIqP3
 Z8CnlywbV3PfNY33A7jj/l874L9jQMOUKz4viBrAKgIdEpZM90IoCWrr1AULCLrPIuZls7
 E4JTJsqUGXBaAJBmuTBDdSPImz9hgvo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-2xH7WFDzOVWTbioPE58r6Q-1; Tue, 18 Feb 2020 12:46:25 -0500
Received: by mail-wm1-f69.google.com with SMTP id g24so360703wmh.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kWdVmQ23rS/jGxVKj/MNmpCHYBhXMwR5ZJk4HsIgkjY=;
 b=l7X5zJZu6pNVxe+BHOXcZpa3y+V1zWGaDutglaDv7dztiuJ2Iof2QS8S7i7jO//lHE
 N6tFT57u4MeTVEFQ97Cg5OeSH+fxMNAwz1bEmxeg054c0s16emZvKKub6AZq3JmLRDJL
 r+m4qh86f+4VMuUvnqpZ+DBxD8SzN5AGiF6gvGg3PujkfWy9+u4okgQaKNfiWReXRlJz
 ssnI7Xvo1/OXqYJowlDbJnIYsQcZL/x5LF4Gpzugfko0ir+G8XgfC0o4kU3ghGFB3dIH
 gz1dRWTPlzhzWtKTWyrfjtIumEzXxZCqp3JmaiYJuXMdxvfEsmgKNeQyCrWqLZbpClvH
 S0TA==
X-Gm-Message-State: APjAAAWkNwo2z+kAGbijKA6uaAGCZmjffjYI36wx8+ihapb5nolMLrRB
 WpAWnwMXF/OAXRmwgZGzFHxcv36UxX1bVCn7r28K1UtVorckfVVj9aeTym76vSvi0CZno8Th3+c
 V3EJQIwhz/a3MV8Y=
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr4178693wme.153.1582047984110; 
 Tue, 18 Feb 2020 09:46:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxT9RfUddWDj0iNejYKq+1ZY5v6N0YD+xW7FcKeELyemC9qPdzsz+donlM70MJesNJCPS/vMQ==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr4178677wme.153.1582047983907; 
 Tue, 18 Feb 2020 09:46:23 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id j14sm6976497wrn.32.2020.02.18.09.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:46:23 -0800 (PST)
Subject: Re: [PATCH v5 61/79] ppc/mac_oldworld: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-62-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <46a5cb04-c6b1-6458-a967-f9ee907653a6@redhat.com>
Date: Tue, 18 Feb 2020 18:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-62-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 2xH7WFDzOVWTbioPE58r6Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ppc/mac_oldworld.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 7318d7e9b4..66e434bba3 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -91,7 +91,6 @@ static void ppc_heathrow_init(MachineState *machine)
>       CPUPPCState *env =3D NULL;
>       char *filename;
>       int linux_boot, i;
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>       uint32_t kernel_base, initrd_base, cmdline_base =3D 0;
>       int32_t kernel_size, initrd_size;
> @@ -127,9 +126,7 @@ static void ppc_heathrow_init(MachineState *machine)
>           exit(1);
>       }
>  =20
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_heathrow.ram",
> -                                         ram_size);
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    memory_region_add_subregion(sysmem, 0, machine->ram);
>  =20
>       /* allocate and load BIOS */
>       memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
> @@ -446,6 +443,7 @@ static void heathrow_class_init(ObjectClass *oc, void=
 *data)
>       mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("750_v3.1");
>       mc->default_display =3D "std";
>       mc->ignore_boot_device_suffixes =3D true;
> +    mc->default_ram_id =3D "ppc_heathrow.ram";
>       fwc->get_dev_path =3D heathrow_fw_dev_path;
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


