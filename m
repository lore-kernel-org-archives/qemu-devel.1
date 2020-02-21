Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14DAC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A72F206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQCf/W56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A72F206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AQa-0002Ud-LK
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j5APq-0001zW-R1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j5APp-0007iy-2y
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:40:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j5APo-0007iB-TI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582299632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6sr7yRZF7qq5UE75Jg+44q1+YXuHEB0zJNbkxL3gTM=;
 b=RQCf/W56GPIKFj7PTlewHzDknqCn3sjzet3ebAdUer0zIscV/QqofxTPXy7WblXrUbBSAr
 YdF3Ziz94AWQXwwjQNXN4+hDp5z766z3vB6BfUcz/kbn9ijl78hrLcQNMxpdoBVJU8zgVL
 SdHnC/cNI5kon0o/Ts9cfM3AJpjFe6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-kfGQlPNOObWslniWl93S4Q-1; Fri, 21 Feb 2020 10:40:30 -0500
X-MC-Unique: kfGQlPNOObWslniWl93S4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7BF4800D53;
 Fri, 21 Feb 2020 15:40:29 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 040F31001B07;
 Fri, 21 Feb 2020 15:40:19 +0000 (UTC)
Date: Fri, 21 Feb 2020 15:40:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 05/13] migrate/ram: Handle RAM block resizes during
 precopy
Message-ID: <20200221154017.GG2931@work-vm>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-6-david@redhat.com>
 <20200221151447.GF2931@work-vm>
 <d6552c8b-fc3e-18be-216c-2c66591faa0a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d6552c8b-fc3e-18be-216c-2c66591faa0a@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
> On 21.02.20 16:14, Dr. David Alan Gilbert wrote:
> > * David Hildenbrand (david@redhat.com) wrote:
> >> Resizing while migrating is dangerous and does not work as expected.
> >> The whole migration code works on the usable_length of ram blocks and =
does
> >> not expect this to change at random points in time.
> >>
> >> In the case of precopy, the ram block size must not change on the sour=
ce,
> >> after syncing the RAM block list in ram_save_setup(), so as long as th=
e
> >> guest is still running on the source.
> >>
> >> Resizing can be trigger *after* (but not during) a reset in
> >> ACPI code by the guest
> >> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> >> - hw/i386/acpi-build.c:acpi_ram_update()
> >>
> >> Use the ram block notifier to get notified about resizes. Let's simply
> >> cancel migration and indicate the reason. We'll continue running on th=
e
> >> source. No harm done.
> >>
> >> Update the documentation. Postcopy will be handled separately.
> >>
> >> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> Cc: Juan Quintela <quintela@redhat.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Richard Henderson <richard.henderson@linaro.org>
> >> Cc: Shannon Zhao <shannon.zhao@linaro.org>
> >> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  exec.c                |  5 +++--
> >>  include/exec/memory.h | 10 ++++++----
> >>  migration/migration.c |  9 +++++++--
> >>  migration/migration.h |  1 +
> >>  migration/ram.c       | 41 +++++++++++++++++++++++++++++++++++++++++
> >>  5 files changed, 58 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/exec.c b/exec.c
> >> index b75250e773..8b015821d6 100644
> >> --- a/exec.c
> >> +++ b/exec.c
> >> @@ -2120,8 +2120,9 @@ static int memory_try_enable_merging(void *addr,=
 size_t len)
> >>      return qemu_madvise(addr, len, QEMU_MADV_MERGEABLE);
> >>  }
> >> =20
> >> -/* Only legal before guest might have detected the memory size: e.g. =
on
> >> - * incoming migration, or right after reset.
> >> +/*
> >> + * Resizing RAM while migrating can result in the migration being can=
celed.
> >> + * Care has to be taken if the guest might have already detected the =
memory.
> >>   *
> >>   * As memory core doesn't know how is memory accessed, it is up to
> >>   * resize callback to update device state and/or add assertions to de=
tect
> >> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >> index e85b7de99a..de111347e8 100644
> >> --- a/include/exec/memory.h
> >> +++ b/include/exec/memory.h
> >> @@ -113,7 +113,7 @@ typedef struct IOMMUNotifier IOMMUNotifier;
> >>  #define RAM_SHARED     (1 << 1)
> >> =20
> >>  /* Only a portion of RAM (used_length) is actually used, and migrated=
.
> >> - * This used_length size can change across reboots.
> >> + * Resizing RAM while migrating can result in the migration being can=
celed.
> >>   */
> >>  #define RAM_RESIZEABLE (1 << 2)
> >> =20
> >> @@ -843,7 +843,9 @@ void memory_region_init_ram_shared_nomigrate(Memor=
yRegion *mr,
> >>   *                                     RAM.  Accesses into the region=
 will
> >>   *                                     modify memory directly.  Only =
an initial
> >>   *                                     portion of this RAM is actuall=
y used.
> >> - *                                     The used size can change acros=
s reboots.
> >> + *                                     Changing the size while migrat=
ing
> >> + *                                     can result in the migration be=
ing
> >> + *                                     canceled.
> >>   *
> >>   * @mr: the #MemoryRegion to be initialized.
> >>   * @owner: the object that tracks the region's reference count
> >> @@ -1464,8 +1466,8 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr=
);
> >> =20
> >>  /* memory_region_ram_resize: Resize a RAM region.
> >>   *
> >> - * Only legal before guest might have detected the memory size: e.g. =
on
> >> - * incoming migration, or right after reset.
> >> + * Resizing RAM while migrating can result in the migration being can=
celed.
> >> + * Care has to be taken if the guest might have already detected the =
memory.
> >>   *
> >>   * @mr: a memory region created with @memory_region_init_resizeable_r=
am.
> >>   * @newsize: the new size the region
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 8fb68795dc..ac9751dbe5 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -175,13 +175,18 @@ void migration_object_init(void)
> >>      }
> >>  }
> >> =20
> >> +void migration_cancel(void)
> >> +{
> >> +    migrate_fd_cancel(current_migration);
> >> +}
> >> +
> >>  void migration_shutdown(void)
> >>  {
> >>      /*
> >>       * Cancel the current migration - that will (eventually)
> >>       * stop the migration using this structure
> >>       */
> >> -    migrate_fd_cancel(current_migration);
> >> +    migration_cancel();
> >>      object_unref(OBJECT(current_migration));
> >>  }
> >> =20
> >> @@ -2019,7 +2024,7 @@ void qmp_migrate(const char *uri, bool has_blk, =
bool blk,
> >> =20
> >>  void qmp_migrate_cancel(Error **errp)
> >>  {
> >> -    migrate_fd_cancel(migrate_get_current());
> >> +    migration_cancel();
> >>  }
> >> =20
> >>  void qmp_migrate_continue(MigrationStatus state, Error **errp)
> >> diff --git a/migration/migration.h b/migration/migration.h
> >> index 8473ddfc88..79fd74afa5 100644
> >> --- a/migration/migration.h
> >> +++ b/migration/migration.h
> >> @@ -343,5 +343,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc fun=
c, void *opaque);
> >>  void migration_make_urgent_request(void);
> >>  void migration_consume_urgent_request(void);
> >>  bool migration_rate_limit(void);
> >> +void migration_cancel(void);
> >> =20
> >>  #endif
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index ed23ed1c7c..57f32011a3 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -52,6 +52,7 @@
> >>  #include "migration/colo.h"
> >>  #include "block.h"
> >>  #include "sysemu/sysemu.h"
> >> +#include "sysemu/runstate.h"
> >>  #include "savevm.h"
> >>  #include "qemu/iov.h"
> >>  #include "multifd.h"
> >> @@ -3710,8 +3711,48 @@ static SaveVMHandlers savevm_ram_handlers =3D {
> >>      .resume_prepare =3D ram_resume_prepare,
> >>  };
> >> =20
> >> +static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host=
,
> >> +                                      size_t old_size, size_t new_siz=
e)
> >> +{
> >> +    ram_addr_t offset;
> >> +    Error *err =3D NULL;
> >> +    RAMBlock *rb =3D qemu_ram_block_from_host(host, false, &offset);
> >> +
> >> +    if (ramblock_is_ignored(rb)) {
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Some resizes are triggered on the migration target by precopy =
code,
> >> +     * when synchronizing RAM block sizes. In these cases, the VM is =
not
> >> +     * running and migration is not idle. We have to ignore these res=
izes,
> >> +     * as we only care about resizes during precopy on the migration =
source.
> >> +     * This handler is always registered, so ignore when migration is=
 idle.
> >> +     */
> >> +    if (migration_is_idle() || !runstate_is_running() ||
> >> +        postcopy_is_running()) {
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Precopy code cannot deal with the size of ram blocks changing =
at
> >> +     * random points in time. We're still running on the source, abor=
t
> >> +     * the migration and continue running here. Make sure to wait unt=
il
> >> +     * migration was canceled.
> >> +     */
> >> +    error_setg(&err, "RAM block '%s' resized during precopy.", rb->id=
str);
> >> +    migrate_set_error(migrate_get_current(), err);
> >> +    error_free(err);
> >> +    migration_cancel();
> >> +}
> >> +
> >> +static RAMBlockNotifier ram_mig_ram_notifier =3D {
> >> +    .ram_block_resized =3D ram_mig_ram_block_resized,
> >> +};
> >> +
> >>  void ram_mig_init(void)
> >>  {
> >>      qemu_mutex_init(&XBZRLE.lock);
> >>      register_savevm_live("ram", 0, 4, &savevm_ram_handlers, &ram_stat=
e);
> >> +    ram_block_notifier_add(&ram_mig_ram_notifier);
> >=20
> > Can we avoid the question of the 'is_idle' checks by doing this
> > registration in save_setup/load_setup and unregistering in
> > save_cleanup/load_cleanup?
>=20
> Well, I figured it out now :)
>=20
> migration_is_idle() is enough to handle it in this patch.
>=20
> >=20
> > That means if we land in the handler we know we're in either an incomin=
g
> > or outgoing migration and then you just have to check which?
>=20
> Can save/load race with other QEMU code that might register/unregister
> notifiers? I want to avoid having to introduce locking just for that.

<looks at code> It looks like it can; qemu_savevm_state_setup
is called from near the top of migration_thread, so I don't
think it's holding locks at that point; and all the existing notifier
changes on this notifier seem to be done from either init or vfio_open
which I guess is under the big lock (?)

Dave


> --=20
> Thanks,
>=20
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


