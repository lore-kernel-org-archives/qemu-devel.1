Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18439C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3861208CD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhbqcUOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3861208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nax-0003n8-1a
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4nYw-0001Ls-Qz
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4nYv-0004oc-6Q
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:16:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47102
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4nYv-0004nr-1n
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582211784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dl+Ho8g/GlgYeL39YsNriZ4yVw/aSc7mt7rEsPUIkP8=;
 b=KhbqcUOJVvVaFlYgczTG/ZPq9G7PyB/UKrRJcrz2lnUoI9QNSPUbEpEwxNxXlJCvbgsFYr
 fK12IdPP6yJ3BdjFk+AjbIXeDEhVpOi+tcZKlUk3sjEuFNIhlOI///WsE4N+yKWeUqH1AA
 xf8arxp9D1njESQdkehNv1dCYVgHqFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-U1c4k70bPE-KcPvEJa4-EQ-1; Thu, 20 Feb 2020 10:16:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 138AD8010F5;
 Thu, 20 Feb 2020 15:16:17 +0000 (UTC)
Received: from [10.36.118.29] (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E584186E07;
 Thu, 20 Feb 2020 15:16:04 +0000 (UTC)
Subject: Re: [PATCH v1 05/13] migrate/ram: Handle RAM block resizes during
 precopy
To: qemu-devel@nongnu.org
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-6-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <3c3d4d50-a30d-b4e9-6256-4656f4e78cf6@redhat.com>
Date: Thu, 20 Feb 2020 16:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219161725.115218-6-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: U1c4k70bPE-KcPvEJa4-EQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.02.20 17:17, David Hildenbrand wrote:
> Resizing while migrating is dangerous and does not work as expected.
> The whole migration code works on the usable_length of ram blocks and doe=
s
> not expect this to change at random points in time.
>=20
> In the case of precopy, the ram block size must not change on the source,
> after syncing the RAM block list in ram_save_setup(), so as long as the
> guest is still running on the source.
>=20
> Resizing can be trigger *after* (but not during) a reset in
> ACPI code by the guest
> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> - hw/i386/acpi-build.c:acpi_ram_update()
>=20
> Use the ram block notifier to get notified about resizes. Let's simply
> cancel migration and indicate the reason. We'll continue running on the
> source. No harm done.
>=20
> Update the documentation. Postcopy will be handled separately.
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
>  exec.c                |  5 +++--
>  include/exec/memory.h | 10 ++++++----
>  migration/migration.c |  9 +++++++--
>  migration/migration.h |  1 +
>  migration/ram.c       | 41 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 58 insertions(+), 8 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index b75250e773..8b015821d6 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2120,8 +2120,9 @@ static int memory_try_enable_merging(void *addr, si=
ze_t len)
>      return qemu_madvise(addr, len, QEMU_MADV_MERGEABLE);
>  }
> =20
> -/* Only legal before guest might have detected the memory size: e.g. on
> - * incoming migration, or right after reset.
> +/*
> + * Resizing RAM while migrating can result in the migration being cancel=
ed.
> + * Care has to be taken if the guest might have already detected the mem=
ory.
>   *
>   * As memory core doesn't know how is memory accessed, it is up to
>   * resize callback to update device state and/or add assertions to detec=
t
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e85b7de99a..de111347e8 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -113,7 +113,7 @@ typedef struct IOMMUNotifier IOMMUNotifier;
>  #define RAM_SHARED     (1 << 1)
> =20
>  /* Only a portion of RAM (used_length) is actually used, and migrated.
> - * This used_length size can change across reboots.
> + * Resizing RAM while migrating can result in the migration being cancel=
ed.
>   */
>  #define RAM_RESIZEABLE (1 << 2)
> =20
> @@ -843,7 +843,9 @@ void memory_region_init_ram_shared_nomigrate(MemoryRe=
gion *mr,
>   *                                     RAM.  Accesses into the region wi=
ll
>   *                                     modify memory directly.  Only an =
initial
>   *                                     portion of this RAM is actually u=
sed.
> - *                                     The used size can change across r=
eboots.
> + *                                     Changing the size while migrating
> + *                                     can result in the migration being
> + *                                     canceled.
>   *
>   * @mr: the #MemoryRegion to be initialized.
>   * @owner: the object that tracks the region's reference count
> @@ -1464,8 +1466,8 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
> =20
>  /* memory_region_ram_resize: Resize a RAM region.
>   *
> - * Only legal before guest might have detected the memory size: e.g. on
> - * incoming migration, or right after reset.
> + * Resizing RAM while migrating can result in the migration being cancel=
ed.
> + * Care has to be taken if the guest might have already detected the mem=
ory.
>   *
>   * @mr: a memory region created with @memory_region_init_resizeable_ram.
>   * @newsize: the new size the region
> diff --git a/migration/migration.c b/migration/migration.c
> index 8fb68795dc..ac9751dbe5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -175,13 +175,18 @@ void migration_object_init(void)
>      }
>  }
> =20
> +void migration_cancel(void)
> +{
> +    migrate_fd_cancel(current_migration);
> +}
> +
>  void migration_shutdown(void)
>  {
>      /*
>       * Cancel the current migration - that will (eventually)
>       * stop the migration using this structure
>       */
> -    migrate_fd_cancel(current_migration);
> +    migration_cancel();
>      object_unref(OBJECT(current_migration));
>  }
> =20
> @@ -2019,7 +2024,7 @@ void qmp_migrate(const char *uri, bool has_blk, boo=
l blk,
> =20
>  void qmp_migrate_cancel(Error **errp)
>  {
> -    migrate_fd_cancel(migrate_get_current());
> +    migration_cancel();
>  }
> =20
>  void qmp_migrate_continue(MigrationStatus state, Error **errp)
> diff --git a/migration/migration.h b/migration/migration.h
> index 8473ddfc88..79fd74afa5 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -343,5 +343,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, =
void *opaque);
>  void migration_make_urgent_request(void);
>  void migration_consume_urgent_request(void);
>  bool migration_rate_limit(void);
> +void migration_cancel(void);
> =20
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index ed23ed1c7c..57f32011a3 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -52,6 +52,7 @@
>  #include "migration/colo.h"
>  #include "block.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/runstate.h"
>  #include "savevm.h"
>  #include "qemu/iov.h"
>  #include "multifd.h"
> @@ -3710,8 +3711,48 @@ static SaveVMHandlers savevm_ram_handlers =3D {
>      .resume_prepare =3D ram_resume_prepare,
>  };
> =20
> +static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
> +                                      size_t old_size, size_t new_size)
> +{
> +    ram_addr_t offset;
> +    Error *err =3D NULL;
> +    RAMBlock *rb =3D qemu_ram_block_from_host(host, false, &offset);
> +
> +    if (ramblock_is_ignored(rb)) {
> +        return;
> +    }
> +
> +    /*
> +     * Some resizes are triggered on the migration target by precopy cod=
e,
> +     * when synchronizing RAM block sizes. In these cases, the VM is not
> +     * running and migration is not idle. We have to ignore these resize=
s,
> +     * as we only care about resizes during precopy on the migration sou=
rce.
> +     * This handler is always registered, so ignore when migration is id=
le.
> +     */
> +    if (migration_is_idle() || !runstate_is_running() ||
> +        postcopy_is_running()) {
> +        return;
> +    }
> +
> +    /*
> +     * Precopy code cannot deal with the size of ram blocks changing at
> +     * random points in time. We're still running on the source, abort
> +     * the migration and continue running here. Make sure to wait until
> +     * migration was canceled.
> +     */
> +    error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr=
);
> +    migrate_set_error(migrate_get_current(), err);
> +    error_free(err);
> +    migration_cancel();
> +}
> +
> +static RAMBlockNotifier ram_mig_ram_notifier =3D {
> +    .ram_block_resized =3D ram_mig_ram_block_resized,
> +};
> +
>  void ram_mig_init(void)
>  {
>      qemu_mutex_init(&XBZRLE.lock);
>      register_savevm_live("ram", 0, 4, &savevm_ram_handlers, &ram_state);
> +    ram_block_notifier_add(&ram_mig_ram_notifier);
>  }
>=20

So, this seems to work very reliably when triggering a resize of a RAM
block during system reset (using my virtio-mem prototype):

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
clear-bitmap-shift: 18
Migration status: cancelled
total time: 0 milliseconds


And from QEMU

qemu-system-x86_64: RAM block '0000:00:03.0/mem1' resized during precopy.

--=20
Thanks,

David / dhildenb


