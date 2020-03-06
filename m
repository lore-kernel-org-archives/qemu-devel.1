Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF8C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91802208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0ZGQb6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91802208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGHo-0007rJ-Mw
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 11:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jAGH3-0007Sa-UC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jAGH2-0007Bs-B9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:56:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28176
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jAGH2-00078X-5N
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583513791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5yr1TzEBIlol8WEebzanSBrb5i2ZKuJ8aFfs9+94vU=;
 b=C0ZGQb6syptVoVbRqGuK766RBxfwJ7rqbvsyUetuia5q4wt1z8tkD2O4wOTf4kYd6ZwhyW
 qTJ3wx073gZQOyM4OvOSgrTl4L++H9Nn+0RQV2eZzl8vQ+OoGVWczAG5pjToLoBnkmnn4u
 qJuxmUYZlkZ6cXEdMy1kiEIWtNfxfIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-V8ostj0eP4uLmOPjFf2XYA-1; Fri, 06 Mar 2020 11:56:29 -0500
X-MC-Unique: V8ostj0eP4uLmOPjFf2XYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A9DB184C80C;
 Fri,  6 Mar 2020 16:56:28 +0000 (UTC)
Received: from work-vm (ovpn-116-247.ams2.redhat.com [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 145A45DA2C;
 Fri,  6 Mar 2020 16:56:18 +0000 (UTC)
Date: Fri, 6 Mar 2020 16:56:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 10/13] migration/ram: Handle RAM block resizes during
 postcopy
Message-ID: <20200306165615.GG3033@work-vm>
References: <20200226155304.60219-1-david@redhat.com>
 <20200226155304.60219-11-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226155304.60219-11-david@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
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
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Shannon Zhao <shannon.zhao@linaro.org>
> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/exec/ramblock.h  | 10 ++++++++++
>  migration/postcopy-ram.c | 15 ++++++++++++---
>  migration/ram.c          | 11 +++++++++--
>  3 files changed, 31 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 07d50864d8..664701b759 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -59,6 +59,16 @@ struct RAMBlock {
>       */
>      unsigned long *clear_bmap;
>      uint8_t clear_bmap_shift;
> +
> +    /*
> +     * RAM block length that corresponds to the used_length on the migra=
tion
> +     * source (after RAM block sizes were synchronized). Especially, aft=
er
> +     * starting to run the guest, used_length and postcopy_length can di=
ffer.
> +     * Used to register/unregister uffd handlers and as the size of the =
received
> +     * bitmap. Receiving any page beyond this length will bail out, as i=
t
> +     * could not have been valid on the source.
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
> index 1a5ff07997..ee5c3d5784 100644
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
> @@ -3160,7 +3160,13 @@ static int ram_load_postcopy(QEMUFile *f)
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

Is this actually safe? Imagine that the region had got shrunk, would it
still be mmap'd in there - or could there now be a space where something
else might have landed in?

> +            if (!block->host || addr >=3D block->postcopy_length) {
>                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>                  ret =3D -EINVAL;
>                  break;
> @@ -3757,6 +3763,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotif=
ier *n, void *host,
>                               rb->idstr);
>              }
>          }
> +        rb->postcopy_length =3D new_size;
>          break;
>      case POSTCOPY_INCOMING_NONE:
>      case POSTCOPY_INCOMING_RUNNING:
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


