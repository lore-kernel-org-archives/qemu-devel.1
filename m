Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BECBC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 05:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B9E208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 05:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnBg/zKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B9E208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWvfa-0003Yh-GE
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 01:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWvez-00039I-Ln
 for qemu-devel@nongnu.org; Fri, 08 May 2020 01:34:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWvey-0004eQ-0k
 for qemu-devel@nongnu.org; Fri, 08 May 2020 01:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588916094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9cIxYZ4M6GBlMag/rjs0c76h4zJpAwA0JgCL0kqyZo=;
 b=DnBg/zKtiJLM8rB2xAKVzSKB1Z8eFZ/EXEV836lEpDf3FaZP5WTQimxmS4KgG9f79dENrf
 LKgj/Ks00BFZxH3c8gbGXevG+KX++Q4k3DbfRTaCaExdLoU0wnJcjGzCz6rcYLkUeXBFiL
 0q7HhgQ/xyoqsk9HoBWYf9f9f2K3vtc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-reh7XOhdPFqOl6u11CNL3Q-1; Fri, 08 May 2020 01:34:52 -0400
X-MC-Unique: reh7XOhdPFqOl6u11CNL3Q-1
Received: by mail-wr1-f71.google.com with SMTP id z8so348758wrp.7
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 22:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gUS4ClGn6G8XqFXHNiGlmCwk06xms6ktvah597TE/uY=;
 b=iYdhuWlnX8ZNGoV6ZXwrrVQa90DFGrCf+G4OzoeErlKoACeo4ZRDkSsOkI4iksjM5M
 0+eyJKpsH1EObPB71Mt+I3N0rcBwRxB8qE1Nd7Mj5E8iFK3nxowKQaRhzwTG7Yz6ToHs
 ngwixGoxXYiH+9Hr0aZSZtsPYWTE7oAIIxsHZ2SIK+/MYc5xoJsrdTfXY++8+cOCkT0T
 AWQ2duOSrIYHQUWUHd7XOqfRpvsPWTfCN9tCtObKge0FWGewL4XExr+wyD/BkWB4vE3W
 6E2PlqjJX0Ss9zZ5J4luPgECWooA6iGtSfIKuL3O/pRuevunBchmKW2dJ5AKgP1Nu7vI
 jIxg==
X-Gm-Message-State: AGi0PuZzR5s6l7DnRM+aDZPgLuRtGkE5RBIDghERJBfIHnwtQFQE5JYG
 hs2WFdRjglu5BD0SquRq7ThiTPdZcJITG0i3glvqnLPseVaRgyZLOcgsepY1aJDVO1+PisjfUeg
 ISAWEAVJhycRQDLo=
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr13547738wmh.29.1588916091364; 
 Thu, 07 May 2020 22:34:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypI61Fm7WBN/SXhfhIYSOo0bFejh0pT6oDtMsWaGpFR+cCbdXjuMM/JbC85hgfYNOcJ8QGT+TQ==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr13547723wmh.29.1588916091120; 
 Thu, 07 May 2020 22:34:51 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm12158464wmc.30.2020.05.07.22.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 22:34:50 -0700 (PDT)
Subject: Re: [PATCH] accel: Move Xen accelerator code under accel/xen/
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200507155813.16169-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d84e5541-da7a-4ead-6277-3b144744f58b@redhat.com>
Date: Fri, 8 May 2020 07:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507155813.16169-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paul Durrant <paul@xen.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 5:58 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This code is not related to hardware emulation.
> Move it under accel/ with the other hypervisors.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> We could also move the memory management functions from
> hw/i386/xen/xen-hvm.c but it is not trivial.
>=20
> Necessary step to remove "exec/ram_addr.h" in the next series.
> ---
>   include/exec/ram_addr.h                    |  2 +-
>   include/hw/xen/xen.h                       | 11 ------
>   include/sysemu/xen.h                       | 40 ++++++++++++++++++++++
>   hw/xen/xen-common.c =3D> accel/xen/xen-all.c |  3 ++
>   hw/acpi/piix4.c                            |  2 +-
>   hw/i386/pc.c                               |  1 +
>   hw/i386/pc_piix.c                          |  1 +
>   hw/i386/pc_q35.c                           |  1 +
>   hw/i386/xen/xen-hvm.c                      |  1 +
>   hw/i386/xen/xen_platform.c                 |  1 +
>   hw/isa/piix3.c                             |  1 +
>   hw/pci/msix.c                              |  1 +
>   migration/savevm.c                         |  2 +-
>   softmmu/vl.c                               |  2 +-
>   stubs/xen-hvm.c                            |  9 -----
>   target/i386/cpu.c                          |  2 +-
>   MAINTAINERS                                |  2 ++
>   accel/Makefile.objs                        |  1 +
>   accel/xen/Makefile.objs                    |  1 +
>   hw/xen/Makefile.objs                       |  2 +-
>   20 files changed, 60 insertions(+), 26 deletions(-)
>   create mode 100644 include/sysemu/xen.h
>   rename hw/xen/xen-common.c =3D> accel/xen/xen-all.c (99%)
>   create mode 100644 accel/xen/Makefile.objs
>=20
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 5e59a3d8d7..4e05292f91 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -21,7 +21,7 @@
>  =20
>   #ifndef CONFIG_USER_ONLY
>   #include "cpu.h"
> -#include "hw/xen/xen.h"
> +#include "sysemu/xen.h"
>   #include "sysemu/tcg.h"
>   #include "exec/ramlist.h"
>   #include "exec/ramblock.h"
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index 5ac1c6dc55..771dd447f2 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -20,13 +20,6 @@ extern uint32_t xen_domid;
>   extern enum xen_mode xen_mode;
>   extern bool xen_domid_restrict;
>  =20
> -extern bool xen_allowed;
> -
> -static inline bool xen_enabled(void)
> -{
> -    return xen_allowed;
> -}
> -
>   int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
>   void xen_piix3_set_irq(void *opaque, int irq_num, int level);
>   void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, i=
nt len);
> @@ -39,10 +32,6 @@ void xenstore_store_pv_console_info(int i, struct Char=
dev *chr);
>  =20
>   void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory);
>  =20
> -void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> -                   struct MemoryRegion *mr, Error **errp);
> -void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
> -
>   void xen_register_framebuffer(struct MemoryRegion *mr);
>  =20
>   #endif /* QEMU_HW_XEN_H */
> diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
> new file mode 100644
> index 0000000000..609d2d4184
> --- /dev/null
> +++ b/include/sysemu/xen.h
> @@ -0,0 +1,40 @@
> +/*
> + * QEMU Xen support
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef SYSEMU_XEN_H
> +#define SYSEMU_XEN_H
> +
> +#ifdef CONFIG_XEN
> +
> +extern bool xen_allowed;
> +
> +#define xen_enabled() (xen_allowed)
> +
> +#ifndef CONFIG_USER_ONLY
> +void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
> +void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> +                   struct MemoryRegion *mr, Error **errp);
> +#endif
> +
> +#else /* !CONFIG_XEN */
> +
> +#define xen_enabled() 0
> +#ifndef CONFIG_USER_ONLY
> +static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t =
length)
> +{
> +    abort();
> +}
> +static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> +                                 MemoryRegion *mr, Error **errp)
> +{
> +    abort();
> +}
> +#endif

Unfortunately this triggers:

#1  0x00007fca778a5895 abort (libc.so.6)
#2  0x000055f51ebd3e12 xen_hvm_modified_memory (qemu-system-aarch64)
#3  0x000055f51ebd44c9 cpu_physical_memory_set_dirty_range=20
(qemu-system-aarch64)
#4  0x000055f51ebd9de4 ram_block_add (qemu-system-aarch64)
#5  0x000055f51ebda2e3 qemu_ram_alloc_internal (qemu-system-aarch64)
#6  0x000055f51ebda3be qemu_ram_alloc (qemu-system-aarch64)
#7  0x000055f51ec3db9b memory_region_init_ram_shared_nomigrate=20
(qemu-system-aarch64)
#8  0x000055f51ef089e6 ram_backend_memory_alloc (qemu-system-aarch64)
#9  0x000055f51ef081ae host_memory_backend_memory_complete=20
(qemu-system-aarch64)
#10 0x000055f51f2b624b user_creatable_complete (qemu-system-aarch64)
#11 0x000055f51ed93382 create_default_memdev (qemu-system-aarch64)
#12 0x000055f51ed96d1a qemu_init (qemu-system-aarch64)
#13 0x000055f51f3b14bb main (qemu-system-aarch64)
#14 0x00007fca778a6f43 __libc_start_main (libc.so.6)
#15 0x000055f51ebd27de _start (qemu-system-aarch64)

I'll resend adding the following patch checking for xen_enabled() before=20
calling, as we do with other accelerators:

-- >8 --
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
@@ -330,7 +330,9 @@ static inline void=20
cpu_physical_memory_set_dirty_range(ram_addr_t start,
          }
      }

-    xen_hvm_modified_memory(start, length);
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
  }

  #if !defined(_WIN32)
@@ -388,7 +390,9 @@ static inline void=20
cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
              }
          }

-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
      } else {
          uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL :=20
DIRTY_CLIENTS_NOCODE;
---


