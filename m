Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417ADC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EAD20722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQTzOi8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EAD20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4sGx-0001NC-1H
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 15:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4sGH-0000jo-7h
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4sGE-0000aK-W6
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:17:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52834
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4sGE-0000Zn-6I
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582229845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fgbWdj3hJpCjRbHXDCwU4aTvjY1noGYwBVqLCMTdBo=;
 b=RQTzOi8HDrkJRiEUGobIgqe6Ev3L9h55CYwhGC4twdS0so+EzQ9rlM2v8VKRsat2rj+oEf
 2P5tz8vAQsZ217yA9+1mygW/aD94RSe90vI7H2SIgF5KjhRRrkc8EKbTa8xCBGPkMWTttG
 PUBtHze4Pg1Rxd8CSdHpHXZ7i/X9M0A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-PtvHBM_qMSayy25MKLs1nQ-1; Thu, 20 Feb 2020 15:17:23 -0500
Received: by mail-qv1-f69.google.com with SMTP id s5so3381549qvr.15
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 12:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+n+oMrd4UQsOuUJSzWBp8n5iKZgZYQ+Ikc+jZ5WvoA0=;
 b=ejqZF24ElK16K9RNKQswqMBeQExIjDAPUbuieq2mX5J05+o5Mt0QDIZvTKxDe9Mc3x
 A3RVJtj7NcHesiZHJA0i6ht/qxl3y8+UOIbnqfF7a4rPsdD5jZw2r75H6Ge/ausqOSRE
 VaQQBudjOa4ZK4DKVjzsAWWZ8+o4sM/TCKYz7WRBRwlB5JjrNmafmxOH9XxrFLr1iXCq
 zwUjM//w+Prr4arc9QUvZ2ajhJ1S9VlwSyPiXE29wmZINdBfha3CCYcbSRm9LIfkEFYF
 oejpHl9g3ch/RI5mXnH1cRkaEL9RliIUoHvXIXJ0TSyS/HAstnAvLhDa0mGWtcYgeyP4
 DNig==
X-Gm-Message-State: APjAAAXmJzBBoMdxpP9JcBwUt0SBlN1v+IR0ARGlbYLItjolWHpfLS5Y
 CsmpwLmEiLnNKxdyUo+Oh7cCCOdeIK9zRNzw7xjFNPp4QIQgugTl4MnO45pJp/cZuc0Yi8bD8B9
 B3kbe5recHkJCrjA=
X-Received: by 2002:a37:48c4:: with SMTP id
 v187mr30167052qka.198.1582229842170; 
 Thu, 20 Feb 2020 12:17:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwepdbqcVZlmV1o/y70e5yuNw29ZKWZq3bc/hwxq/L+ee84gFB2gvO89QXA9wNXmYcAiiEDRA==
X-Received: by 2002:a37:48c4:: with SMTP id
 v187mr30167022qka.198.1582229841868; 
 Thu, 20 Feb 2020 12:17:21 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id 3sm346120qte.59.2020.02.20.12.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 12:17:20 -0800 (PST)
Date: Thu, 20 Feb 2020 15:17:19 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 05/13] migrate/ram: Handle RAM block resizes during
 precopy
Message-ID: <20200220201719.GC15253@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-6-david@redhat.com>
 <3c3d4d50-a30d-b4e9-6256-4656f4e78cf6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3c3d4d50-a30d-b4e9-6256-4656f4e78cf6@redhat.com>
X-MC-Unique: PtvHBM_qMSayy25MKLs1nQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 04:16:02PM +0100, David Hildenbrand wrote:
> On 19.02.20 17:17, David Hildenbrand wrote:
> > Resizing while migrating is dangerous and does not work as expected.
> > The whole migration code works on the usable_length of ram blocks and d=
oes
> > not expect this to change at random points in time.
> >=20
> > In the case of precopy, the ram block size must not change on the sourc=
e,
> > after syncing the RAM block list in ram_save_setup(), so as long as the
> > guest is still running on the source.
> >=20
> > Resizing can be trigger *after* (but not during) a reset in
> > ACPI code by the guest
> > - hw/arm/virt-acpi-build.c:acpi_ram_update()
> > - hw/i386/acpi-build.c:acpi_ram_update()
> >=20
> > Use the ram block notifier to get notified about resizes. Let's simply
> > cancel migration and indicate the reason. We'll continue running on the
> > source. No harm done.
> >=20
> > Update the documentation. Postcopy will be handled separately.
> >=20
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Shannon Zhao <shannon.zhao@linaro.org>
> > Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  exec.c                |  5 +++--
> >  include/exec/memory.h | 10 ++++++----
> >  migration/migration.c |  9 +++++++--
> >  migration/migration.h |  1 +
> >  migration/ram.c       | 41 +++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 58 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/exec.c b/exec.c
> > index b75250e773..8b015821d6 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -2120,8 +2120,9 @@ static int memory_try_enable_merging(void *addr, =
size_t len)
> >      return qemu_madvise(addr, len, QEMU_MADV_MERGEABLE);
> >  }
> > =20
> > -/* Only legal before guest might have detected the memory size: e.g. o=
n
> > - * incoming migration, or right after reset.
> > +/*
> > + * Resizing RAM while migrating can result in the migration being canc=
eled.
> > + * Care has to be taken if the guest might have already detected the m=
emory.
> >   *
> >   * As memory core doesn't know how is memory accessed, it is up to
> >   * resize callback to update device state and/or add assertions to det=
ect
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index e85b7de99a..de111347e8 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -113,7 +113,7 @@ typedef struct IOMMUNotifier IOMMUNotifier;
> >  #define RAM_SHARED     (1 << 1)
> > =20
> >  /* Only a portion of RAM (used_length) is actually used, and migrated.
> > - * This used_length size can change across reboots.
> > + * Resizing RAM while migrating can result in the migration being canc=
eled.
> >   */
> >  #define RAM_RESIZEABLE (1 << 2)
> > =20
> > @@ -843,7 +843,9 @@ void memory_region_init_ram_shared_nomigrate(Memory=
Region *mr,
> >   *                                     RAM.  Accesses into the region =
will
> >   *                                     modify memory directly.  Only a=
n initial
> >   *                                     portion of this RAM is actually=
 used.
> > - *                                     The used size can change across=
 reboots.
> > + *                                     Changing the size while migrati=
ng
> > + *                                     can result in the migration bei=
ng
> > + *                                     canceled.
> >   *
> >   * @mr: the #MemoryRegion to be initialized.
> >   * @owner: the object that tracks the region's reference count
> > @@ -1464,8 +1466,8 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr)=
;
> > =20
> >  /* memory_region_ram_resize: Resize a RAM region.
> >   *
> > - * Only legal before guest might have detected the memory size: e.g. o=
n
> > - * incoming migration, or right after reset.
> > + * Resizing RAM while migrating can result in the migration being canc=
eled.
> > + * Care has to be taken if the guest might have already detected the m=
emory.
> >   *
> >   * @mr: a memory region created with @memory_region_init_resizeable_ra=
m.
> >   * @newsize: the new size the region
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 8fb68795dc..ac9751dbe5 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -175,13 +175,18 @@ void migration_object_init(void)
> >      }
> >  }
> > =20
> > +void migration_cancel(void)
> > +{
> > +    migrate_fd_cancel(current_migration);
> > +}
> > +
> >  void migration_shutdown(void)
> >  {
> >      /*
> >       * Cancel the current migration - that will (eventually)
> >       * stop the migration using this structure
> >       */
> > -    migrate_fd_cancel(current_migration);
> > +    migration_cancel();
> >      object_unref(OBJECT(current_migration));
> >  }
> > =20
> > @@ -2019,7 +2024,7 @@ void qmp_migrate(const char *uri, bool has_blk, b=
ool blk,
> > =20
> >  void qmp_migrate_cancel(Error **errp)
> >  {
> > -    migrate_fd_cancel(migrate_get_current());
> > +    migration_cancel();
> >  }
> > =20
> >  void qmp_migrate_continue(MigrationStatus state, Error **errp)
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 8473ddfc88..79fd74afa5 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -343,5 +343,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc func=
, void *opaque);
> >  void migration_make_urgent_request(void);
> >  void migration_consume_urgent_request(void);
> >  bool migration_rate_limit(void);
> > +void migration_cancel(void);
> > =20
> >  #endif
> > diff --git a/migration/ram.c b/migration/ram.c
> > index ed23ed1c7c..57f32011a3 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -52,6 +52,7 @@
> >  #include "migration/colo.h"
> >  #include "block.h"
> >  #include "sysemu/sysemu.h"
> > +#include "sysemu/runstate.h"
> >  #include "savevm.h"
> >  #include "qemu/iov.h"
> >  #include "multifd.h"
> > @@ -3710,8 +3711,48 @@ static SaveVMHandlers savevm_ram_handlers =3D {
> >      .resume_prepare =3D ram_resume_prepare,
> >  };
> > =20
> > +static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
> > +                                      size_t old_size, size_t new_size=
)
> > +{
> > +    ram_addr_t offset;
> > +    Error *err =3D NULL;
> > +    RAMBlock *rb =3D qemu_ram_block_from_host(host, false, &offset);
> > +
> > +    if (ramblock_is_ignored(rb)) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Some resizes are triggered on the migration target by precopy c=
ode,
> > +     * when synchronizing RAM block sizes. In these cases, the VM is n=
ot
> > +     * running and migration is not idle. We have to ignore these resi=
zes,
> > +     * as we only care about resizes during precopy on the migration s=
ource.
> > +     * This handler is always registered, so ignore when migration is =
idle.
> > +     */
> > +    if (migration_is_idle() || !runstate_is_running() ||

So I noticed that I mis-misread the code after chat with Dave...

migration_is_idle() should only return false if on the source and only
if during migration.  Destination should still return true for that
(destination VM reads state from MigrationIncomingState.state
instead).

With that, I think we can drop the confusing !runstate_is_running()
check because migration_is_idle() will cover that (and touch up the
comment too)?

> > +        postcopy_is_running()) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Precopy code cannot deal with the size of ram blocks changing a=
t
> > +     * random points in time. We're still running on the source, abort
> > +     * the migration and continue running here. Make sure to wait unti=
l
> > +     * migration was canceled.
> > +     */
> > +    error_setg(&err, "RAM block '%s' resized during precopy.", rb->ids=
tr);
> > +    migrate_set_error(migrate_get_current(), err);
> > +    error_free(err);
> > +    migration_cancel();
> > +}
> > +
> > +static RAMBlockNotifier ram_mig_ram_notifier =3D {
> > +    .ram_block_resized =3D ram_mig_ram_block_resized,
> > +};
> > +
> >  void ram_mig_init(void)
> >  {
> >      qemu_mutex_init(&XBZRLE.lock);
> >      register_savevm_live("ram", 0, 4, &savevm_ram_handlers, &ram_state=
);
> > +    ram_block_notifier_add(&ram_mig_ram_notifier);
> >  }
> >=20
>=20
> So, this seems to work very reliably when triggering a resize of a RAM
> block during system reset (using my virtio-mem prototype):
>=20
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> decompress-error-check: on
> clear-bitmap-shift: 18
> Migration status: cancelled
> total time: 0 milliseconds
>=20
>=20
> And from QEMU
>=20
> qemu-system-x86_64: RAM block '0000:00:03.0/mem1' resized during precopy.

Good news!

Thanks,

--=20
Peter Xu


