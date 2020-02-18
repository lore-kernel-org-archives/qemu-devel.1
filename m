Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24EDC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8AC24649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+8EMoKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8AC24649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46t6-0003ue-R2
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46r3-0000PB-Fl
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46r2-0006xE-71
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:40:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46r2-0006wy-3M
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItQAZI2wUcHaNHOfRm1cmbuwadBgZYCKs/OBkRtMPwA=;
 b=A+8EMoKLVx4d8XpTxf+95BLcXhTilA1ha3sc1zCyFxMsC+cQIUB9DHPzErehAPUiXZq+0f
 Wj+QLXhRxvlsne4JcIOwjpQLw4eSvp0HeRkpJTeEBnQVDn9I0NyVPyCs2SMc9j3/Lho64c
 ZY55i0X4q4zm3Y2R6+2RnJEN/5yXG4M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-oISnwlptN6ijnG5V-MB1vQ-1; Tue, 18 Feb 2020 12:40:11 -0500
Received: by mail-wm1-f71.google.com with SMTP id g26so369659wmk.6
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dXlymn5Pjh3M4BCBOwz90QKUXa6xUli8mzyR7qUwfdY=;
 b=fJt7+liuOBmAg7fnU/5diyAlcG60fTVhcdnxV0yoF5TDsUGdOtMgO+in61RhqrM6rE
 bnl9LX/JqgYvbhqrWKvUbTJCMYWyxj6wcC3J7Qp9JVZmQTk00QSim8Kwe5znDvZYHcYU
 ZEQiKazbTLCMk2vGydgJbJA2ljN30XjAhFJs/KZqLsoowImwEOyT8aYLuMsoDz/6ZKBu
 4U8k/DJXBOYkFi9dioJ02E0DF2dIzsHvr6xUvxrBiehBaGNke9Cn3OmSXo0U8higDZua
 +r/wQ4SfqtXJUntHhxfzjjGCvb6OZatwa0prg8ajaYUWn1bMr+PBo1xyiv3ptpwSspWq
 NnkQ==
X-Gm-Message-State: APjAAAW/Boe5CfuURDGhJKM4ygL5m202qeokGszT8G7YUbkZTasLDA7q
 FWzTlmIVqzhvoESPvGQEAy6GhjnFHtkD4mFfm0JPnrXKSnxeliY4+JQiZ4EfnUCBdOhNryIO0o9
 lOLlw+mnA9meZycU=
X-Received: by 2002:a1c:7317:: with SMTP id d23mr4366377wmb.165.1582047610562; 
 Tue, 18 Feb 2020 09:40:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLswQmAuDV1p9Ax3DupXJnije/Rqr63b+uy+nCnqIP7zIStpOC/f8ox96xS7IUZDa0QB2lTA==
X-Received: by 2002:a1c:7317:: with SMTP id d23mr4366350wmb.165.1582047610331; 
 Tue, 18 Feb 2020 09:40:10 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s65sm4367506wmf.48.2020.02.18.09.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:40:09 -0800 (PST)
Subject: Re: [PATCH v5 72/79] remove no longer used
 memory_region_allocate_system_memory()
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-73-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4eeb0f4a-51b8-7e68-eef5-698a578b5f22@redhat.com>
Date: Tue, 18 Feb 2020 18:40:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-73-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: oISnwlptN6ijnG5V-MB1vQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> all boards were switched to using memdev backend for main RAM,
> so we can drop no longer used memory_region_allocate_system_memory()
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> ---
>   include/hw/boards.h | 32 --------------------------------
>   hw/core/numa.c      | 34 ----------------------------------
>   2 files changed, 66 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ae2b60fb5e..142b86d0ae 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -12,38 +12,6 @@
>   #include "qom/object.h"
>   #include "hw/core/cpu.h"
>  =20
> -/**
> - * memory_region_allocate_system_memory - Allocate a board's main memory
> - * @mr: the #MemoryRegion to be initialized
> - * @owner: the object that tracks the region's reference count
> - * @name: name of the memory region
> - * @ram_size: size of the region in bytes
> - *
> - * This function allocates the main memory for a board model, and
> - * initializes @mr appropriately. It also arranges for the memory
> - * to be migrated (by calling vmstate_register_ram_global()).
> - *
> - * Memory allocated via this function will be backed with the memory
> - * backend the user provided using "-mem-path" or "-numa node,memdev=3D.=
.."
> - * if appropriate; this is typically used to cause host huge pages to be
> - * used. This function should therefore be called by a board exactly onc=
e,
> - * for the primary or largest RAM area it implements.
> - *
> - * For boards where the major RAM is split into two parts in the memory
> - * map, you can deal with this by calling memory_region_allocate_system_=
memory()
> - * once to get a MemoryRegion with enough RAM for both parts, and then
> - * creating alias MemoryRegions via memory_region_init_alias() which
> - * alias into different parts of the RAM MemoryRegion and can be mapped
> - * into the memory map in the appropriate places.
> - *
> - * Smaller pieces of memory (display RAM, static RAMs, etc) don't need
> - * to be backed via the -mem-path memory backend and can simply
> - * be created via memory_region_init_ram().
> - */
> -void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owne=
r,
> -                                          const char *name,
> -                                          uint64_t ram_size);
> -
>   #define TYPE_MACHINE_SUFFIX "-machine"
>  =20
>   /* Machine class name that needs to be used for class-name-based machin=
e
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index e6baf2c33e..316bc50d75 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -806,40 +806,6 @@ void numa_cpu_pre_plug(const CPUArchId *slot, Device=
State *dev, Error **errp)
>       }
>   }
>  =20
> -static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *own=
er,
> -                                           const char *name,
> -                                           uint64_t ram_size)
> -{
> -    if (mem_path) {
> -#ifdef __linux__
> -        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0=
,
> -                                         mem_path, &error_fatal);
> -#else
> -        fprintf(stderr, "-mem-path not supported on this host\n");
> -        exit(1);
> -#endif
> -    } else {
> -        memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &err=
or_fatal);
> -    }
> -    vmstate_register_ram_global(mr);
> -}
> -
> -void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owne=
r,
> -                                          const char *name,
> -                                          uint64_t ram_size)
> -{
> -    MachineState *ms =3D MACHINE(qdev_get_machine());
> -
> -    if (ms->numa_state =3D=3D NULL ||
> -        ms->numa_state->num_nodes =3D=3D 0 || numa_uses_legacy_mem()) {
> -        allocate_system_memory_nonnuma(mr, owner, name, ram_size);
> -        return;
> -    }
> -
> -    memory_region_init(mr, owner, name, ram_size);
> -    numa_init_memdev_container(ms, mr);
> -}
> -
>   static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>   {
>       MemoryDeviceInfoList *info_list =3D qmp_memory_device_list();
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


