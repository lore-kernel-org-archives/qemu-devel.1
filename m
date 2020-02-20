Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCAEC11D24
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA5020679
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbOxQyot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA5020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4sr7-0005l1-P4
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 15:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4sqT-0005Ej-Ja
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4sqR-0007XY-AD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:54:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4sqR-0007X8-1A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582232090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dsdSVcmmEE14di1ma5hmHp8AFDOrcscadvX7c9zAv0=;
 b=fbOxQyot4ENrZNpRDxzgXxubcmL+awX5dq6vF1zc9GiAIJXO2V7sE5h6QbrBsc2ookRx7w
 ohca+qUka4mXqJMaLuTqGqSo8+FYnaJy2s+1UjMyQ9W7sdPUIeIbLZS1HodItMOvbr/zmJ
 WvbaQTFFEZJZuLmgfvHpIEbEEBnZ7uw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-suWEc39cNgCiedfE5pr-4w-1; Thu, 20 Feb 2020 15:54:46 -0500
Received: by mail-qt1-f200.google.com with SMTP id t9so35310qtn.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 12:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Pe6I8du5fEiCYo/wn8Dm8DH1mnLQmHizG11Ii1GEqsg=;
 b=ogAj3WLS2KRNnqep+gRSVlKBV7CNYVs8sNE1i2buRvg80yv/Q5upoSzOSX9KSZvXws
 WYeMCmU0TrS0iWRVBYytE/eX/+xJUMK0GfwMRch2K61BGibFr1gOVC5irG2XW8Fb4Bko
 ecwc0roOmuV7I6nMfke4EQM5fA7ddGM81MyvUPhOM6x3PnvkaYP3ltRCQjdrdf0WSxN/
 1sMefAqv9YC0mWY5NSccyEVPAoSnP4y4DmKlmBNtvQSNADjFGZ/oaT6cAENruPnIxiO0
 MrTaaKL03MVcPdTHMw9xn9ylNB4BcXam9olCIW+tTTcDYat2qv/ZmI8IpRxMMgBSI9Lr
 6eyg==
X-Gm-Message-State: APjAAAXjAtvAQlPRZR6iLBYBVK6Y8WzYsGwdZbKDLyo40xJC+XuZx5TQ
 VJk/hfNLWYeE0xXEzvRnTmpm54YzefnR4dQqCVxLjWR5AdzXqgkizaW/mrAlRn4qm0IDT+kYoqH
 wr7nM1gPtmMIVkfQ=
X-Received: by 2002:a37:396:: with SMTP id 144mr29672011qkd.260.1582232085746; 
 Thu, 20 Feb 2020 12:54:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwbnX0KeCf6r5y8mxVwddkUh493CAYlV1MD1QAcf8Tp8hKMyHZ4RqEDn0/y35Dl4zsGScj/w==
X-Received: by 2002:a37:396:: with SMTP id 144mr29671987qkd.260.1582232085450; 
 Thu, 20 Feb 2020 12:54:45 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id u12sm399342qtj.84.2020.02.20.12.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 12:54:44 -0800 (PST)
Date: Thu, 20 Feb 2020 15:54:43 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 10/13] migrate/ram: Handle RAM block resizes during
 postcopy
Message-ID: <20200220205443.GD15253@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-11-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200219161725.115218-11-david@redhat.com>
X-MC-Unique: suWEc39cNgCiedfE5pr-4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 05:17:22PM +0100, David Hildenbrand wrote:
> Resizing while migrating is dangerous and does not work as expected.
> The whole migration code works on the usable_length of ram blocks and doe=
s
> not expect this to change at random points in time.
>=20
> In the case of postcopy, relying on used_length is racy as soon as the
> guest is running. Also, when used_length changes we might leave the
> uffd handler registered for some memory regions, reject valid pages
> when migrating and fail when sending the recv bitmap to the source.
>=20
> Resizing can be trigger *after* (but not during) a reset in
> ACPI code by the guest
> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> - hw/i386/acpi-build.c:acpi_ram_update()
>=20
> Let's remember the original used_length in a separate variable and
> use it in relevant postcopy code. Make sure to update it when we resize
> during precopy, when synchronizing the RAM block sizes with the source.
>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Shannon Zhao <shannon.zhao@linaro.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/exec/ramblock.h  |  9 +++++++++
>  migration/postcopy-ram.c | 15 ++++++++++++---
>  migration/ram.c          | 11 +++++++++--
>  3 files changed, 30 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 07d50864d8..0e9e9b346b 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -59,6 +59,15 @@ struct RAMBlock {
>       */
>      unsigned long *clear_bmap;
>      uint8_t clear_bmap_shift;
> +
> +    /*
> +     * RAM block used_length before the guest started running while post=
copy
> +     * was active. Once the guest is running, used_length can change. Us=
ed to
> +     * register/unregister uffd handlers and as the size of the recv bit=
map.
> +     * Receiving any page beyond this length will bail out, as it could =
not have
> +     * been valid on the source.
> +     */
> +    ram_addr_t postcopy_length;
>  };
>  #endif
>  #endif
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index a36402722b..c68caf4e42 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -17,6 +17,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/rcu.h"
>  #include "exec/target_page.h"
>  #include "migration.h"
>  #include "qemu-file.h"
> @@ -31,6 +32,7 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  #include "hw/boards.h"
> +#include "exec/ramblock.h"
> =20
>  /* Arbitrary limit on size of each discard command,
>   * keeps them around ~200 bytes
> @@ -456,6 +458,13 @@ static int init_range(RAMBlock *rb, void *opaque)
>      ram_addr_t length =3D qemu_ram_get_used_length(rb);
>      trace_postcopy_init_range(block_name, host_addr, offset, length);
> =20
> +    /*
> +     * Save the used_length before running the guest. In case we have to
> +     * resize RAM blocks when syncing RAM block sizes from the source du=
ring
> +     * precopy, we'll update it manually via the ram block notifier.
> +     */
> +    rb->postcopy_length =3D length;
> +
>      /*
>       * We need the whole of RAM to be truly empty for postcopy, so thing=
s
>       * like ROMs and any data tables built during init must be zero'd
> @@ -478,7 +487,7 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
>      const char *block_name =3D qemu_ram_get_idstr(rb);
>      void *host_addr =3D qemu_ram_get_host_addr(rb);
>      ram_addr_t offset =3D qemu_ram_get_offset(rb);
> -    ram_addr_t length =3D qemu_ram_get_used_length(rb);
> +    ram_addr_t length =3D rb->postcopy_length;
>      MigrationIncomingState *mis =3D opaque;
>      struct uffdio_range range_struct;
>      trace_postcopy_cleanup_range(block_name, host_addr, offset, length);
> @@ -600,7 +609,7 @@ static int nhp_range(RAMBlock *rb, void *opaque)
>      const char *block_name =3D qemu_ram_get_idstr(rb);
>      void *host_addr =3D qemu_ram_get_host_addr(rb);
>      ram_addr_t offset =3D qemu_ram_get_offset(rb);
> -    ram_addr_t length =3D qemu_ram_get_used_length(rb);
> +    ram_addr_t length =3D rb->postcopy_length;
>      trace_postcopy_nhp_range(block_name, host_addr, offset, length);
> =20
>      /*
> @@ -644,7 +653,7 @@ static int ram_block_enable_notify(RAMBlock *rb, void=
 *opaque)
>      struct uffdio_register reg_struct;
> =20
>      reg_struct.range.start =3D (uintptr_t)qemu_ram_get_host_addr(rb);
> -    reg_struct.range.len =3D qemu_ram_get_used_length(rb);
> +    reg_struct.range.len =3D rb->postcopy_length;
>      reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> =20
>      /* Now tell our userfault_fd that it's responsible for this area */
> diff --git a/migration/ram.c b/migration/ram.c
> index ab1f5534cf..6d1dcb362c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -244,7 +244,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
>          return -1;
>      }
> =20
> -    nbits =3D block->used_length >> TARGET_PAGE_BITS;
> +    nbits =3D block->postcopy_length >> TARGET_PAGE_BITS;
> =20
>      /*
>       * Make sure the tmp bitmap buffer is big enough, e.g., on 32bit
> @@ -3159,7 +3159,13 @@ static int ram_load_postcopy(QEMUFile *f)
>                  break;
>              }
> =20
> -            if (!offset_in_ramblock(block, addr)) {
> +            /*
> +             * Relying on used_length is racy and can result in false po=
sitives.
> +             * We might place pages beyond used_length in case RAM was s=
hrunk
> +             * while in postcopy, which is fine - trying to place via
> +             * UFFDIO_COPY/UFFDIO_ZEROPAGE will never segfault.
> +             */
> +            if (!block->host || addr >=3D block->postcopy_length) {
>                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>                  ret =3D -EINVAL;
>                  break;
> @@ -3744,6 +3750,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotif=
ier *n, void *host,
>                               rb->idstr);
>              }
>          }
> +        rb->postcopy_length =3D new_size;

With this change, postcopy_length will be the same as used_length?

I thought you wanted to cache that value when starting the postcopy
phase so postcopy_length should be constant after set once.  Did I
misunderstood?

Thanks,

>          return;
>      }
> =20
> --=20
> 2.24.1
>=20

--=20
Peter Xu


