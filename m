Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A67C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40139222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWmD7wRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40139222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2YAr-0007h7-Em
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 05:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2YA4-0006nf-Sz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2YA3-0004Fx-BT
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:25:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2YA3-0004AP-61
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581675926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFbvotEUuatAu79yPcIjM6CPBwgK9WzDxJU+qsYHYtc=;
 b=iWmD7wRejAo0Wd0NI3XP3LnTHar8QqwnT2bp1nzgdVOrRIZe/6nj1RlEAAlXbxmCXjZRSg
 jGd1Z8zv8+q7vaqO4o7eg+YYFBGDXstjoSBUGmyXgJasAkE/QelCDvvT5teACvpV2pJnNv
 oWXTFUjGDxJZYxR3kTKRKkWRvz+9wQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-puLT-yMHPA2J80_ohABdHQ-1; Fri, 14 Feb 2020 05:25:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63EA107ACCD;
 Fri, 14 Feb 2020 10:25:23 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F138926E7D;
 Fri, 14 Feb 2020 10:25:16 +0000 (UTC)
Date: Fri, 14 Feb 2020 10:25:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214102514.GB3283@work-vm>
References: <20200213172016.196609-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200213172016.196609-1-david@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: puLT-yMHPA2J80_ohABdHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> Resizing while migrating is dangerous and does not work as expected.
> The whole migration code works on the usable_length of ram blocks and doe=
s
> not expect this to change at random points in time.
>=20
> Precopy: The ram block size must not change on the source, after
> ram_save_setup(), so as long as the guest is still running on the source.
>=20
> Postcopy: The ram block size must not change on the target, after
> synchronizing the RAM block list (ram_load_precopy()).
>=20
> AFAIKS, resizing can be trigger *after* (but not during) a reset in
> ACPI code by the guest
> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> - hw/i386/acpi-build.c:acpi_ram_update()
>=20
> I see no easy way to work around this. Fail hard instead of failing
> somewhere in migration code due to strange other reasons. AFAIKs, the
> rebuilts will be triggered during reboot, so this should not affect
> running guests, but only guests that reboot at a very bad time and
> actually require size changes.
>=20
> Let's further limit the impact by checking if an actual resize of the
> RAM (in number of pages) is required.
>=20
> Don't perform the checks in qemu_ram_resize(), as that's called during
> migration when syncing the used_length. Update documentation.

Interesting; we need to do something about this - but banning resets
during migration is a bit harsh; and aborting the source VM is really
nasty - for a precopy especially we shouldn't kill the source VM,
we should just abort the migration.

The other thing that worries me is that acpi_build_update calls
   acpi_ram_update->memory_region_ram_resize
multiple times.
So, it might be that the size you end up with at the end of
acpi_build_update is actually the same size as the original - so
the net effect is the RAMBlock didn't really get resized.

Dave


> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Shannon Zhao <shannon.zhao@linaro.org>
> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> Any idea how to avoid killing the guest? Anything obvious I am missing?
>=20
> ---
>  exec.c                |  6 ++++--
>  include/exec/memory.h | 11 +++++++----
>  memory.c              | 12 ++++++++++++
>  3 files changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index 67e520d18e..faa6708414 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2116,8 +2116,10 @@ static int memory_try_enable_merging(void *addr, s=
ize_t len)
>      return qemu_madvise(addr, len, QEMU_MADV_MERGEABLE);
>  }
> =20
> -/* Only legal before guest might have detected the memory size: e.g. on
> - * incoming migration, or right after reset.
> +/*
> + * RAM must not be resized while migration is active (except from migrat=
ion
> + * code). Care has to be taken if the guest might have already detected
> + * the memory.
>   *
>   * As memory core doesn't know how is memory accessed, it is up to
>   * resize callback to update device state and/or add assertions to detec=
t
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e85b7de99a..1e5bfbe805 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -113,7 +113,8 @@ typedef struct IOMMUNotifier IOMMUNotifier;
>  #define RAM_SHARED     (1 << 1)
> =20
>  /* Only a portion of RAM (used_length) is actually used, and migrated.
> - * This used_length size can change across reboots.
> + * RAM must not be resized while migration is active (except from migrat=
ion
> + * code).
>   */
>  #define RAM_RESIZEABLE (1 << 2)
> =20
> @@ -843,7 +844,8 @@ void memory_region_init_ram_shared_nomigrate(MemoryRe=
gion *mr,
>   *                                     RAM.  Accesses into the region wi=
ll
>   *                                     modify memory directly.  Only an =
initial
>   *                                     portion of this RAM is actually u=
sed.
> - *                                     The used size can change across r=
eboots.
> + *                                     The size must not change while mi=
gration
> + *                                     is active.
>   *
>   * @mr: the #MemoryRegion to be initialized.
>   * @owner: the object that tracks the region's reference count
> @@ -1464,8 +1466,9 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
> =20
>  /* memory_region_ram_resize: Resize a RAM region.
>   *
> - * Only legal before guest might have detected the memory size: e.g. on
> - * incoming migration, or right after reset.
> + * RAM must not be resized while migration is active (except from migrat=
ion
> + * code). Care has to be taken if the guest might have already detected
> + * the memory.
>   *
>   * @mr: a memory region created with @memory_region_init_resizeable_ram.
>   * @newsize: the new size the region
> diff --git a/memory.c b/memory.c
> index aeaa8dcc9e..7fa048aa3a 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -34,6 +34,7 @@
>  #include "sysemu/accel.h"
>  #include "hw/boards.h"
>  #include "migration/vmstate.h"
> +#include "migration/misc.h"
> =20
>  //#define DEBUG_UNASSIGNED
> =20
> @@ -2204,6 +2205,17 @@ void memory_region_ram_resize(MemoryRegion *mr, ra=
m_addr_t newsize, Error **errp
>  {
>      assert(mr->ram_block);
> =20
> +    /*
> +     * Resizing RAM while migrating is not possible, as the used_length =
of
> +     * RAM blocks must neither change on the source (precopy), nor on th=
e
> +     * target (postcopy) as long as migration code is active.
> +     */
> +    if (HOST_PAGE_ALIGN(newsize) !=3D mr->ram_block->used_length &&
> +        !migration_is_idle()) {
> +        error_setg(errp, "Cannot resize RAM while migrating.");
> +        return;
> +    }
> +
>      qemu_ram_resize(mr->ram_block, newsize, errp);
>  }
> =20
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


