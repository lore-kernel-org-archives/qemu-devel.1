Received: from eggs.gnu.org ([2001:4830:134:3::10]:43808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFUoj-0004eZ-Fb
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 19:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFUoe-0006Hc-NT
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 19:47:37 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-11-vsementsov@virtuozzo.com>
	<97084802-ba48-4bc0-f106-dbeb906fd6e4@redhat.com>
	<8d68daea-955b-21e6-3f14-1daef683651d@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <96ce8283-0184-9fbe-fc43-5df17c67ed2e@redhat.com>
Date: Thu, 16 Nov 2017 19:47:12 -0500
MIME-Version: 1.0
In-Reply-To: <8d68daea-955b-21e6-3f14-1daef683651d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 10/14] migration: add postcopy migration
 of dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 11/16/2017 05:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.11.2017 04:58, John Snow wrote:
>>
>> On 10/30/2017 12:33 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
>>> associated with root nodes and non-root named nodes are migrated.
>>>
>>> If destination qemu is already containing a dirty bitmap with the
>>> same name
>>> as a migrated bitmap (for the same node), then, if their
>>> granularities are
>>> the same the migration will be done, otherwise the error will be
>>> generated.
>>>
>>> If destination qemu doesn't contain such bitmap it will be created.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 include/migration/misc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +
>>> =C2=A0 migration/migration.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>>> =C2=A0 migration/block-dirty-bitmap.c | 734
>>> +++++++++++++++++++++++++++++++++++++++++
>> Ouch :\
>>
>>> =C2=A0 migration/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>>> =C2=A0 migration/savevm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>>> =C2=A0 vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 migration/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 migration/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 14 +
>>> =C2=A0 8 files changed, 761 insertions(+)
>>> =C2=A0 create mode 100644 migration/block-dirty-bitmap.c
>>>
>> Organizationally, you introduce three new 'public' prototypes:
>>
>> dirty_bitmap_mig_init
>> dirty_bitmap_mig_before_vm_start
>> init_dirty_bitmap_incoming_migration
>>
>> mig_init is advertised in migration/misc.h, the other two are in
>> migration/migration.h.
>> The definitions for all three are in migration/block-dirty-bitmap.c
>>
>> In pure naivety, I find it weird to have something that you use in
>> migration.c and advertised in migration.h actually exist separately in
>> block-dirty-bitmap.c; but maybe this is the sanest thing to do.
>>
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index c079b7771b..9cc539e232 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -55,4 +55,7 @@ bool migration_has_failed(MigrationState *);
>>> =C2=A0 bool migration_in_postcopy_after_devices(MigrationState *);
>>> =C2=A0 void migration_global_dump(Monitor *mon);
>>> =C2=A0 +/* migration/block-dirty-bitmap.c */
>>> +void dirty_bitmap_mig_init(void);
>>> +
>>> =C2=A0 #endif
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index 50d1f01346..4e3ad04664 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -211,4 +211,7 @@ void migrate_send_rp_pong(MigrationIncomingState
>>> *mis,
>>> =C2=A0 void migrate_send_rp_req_pages(MigrationIncomingState *mis, co=
nst
>>> char* rbname,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ram_addr_t start, size_t len);
>>> =C2=A0 +void dirty_bitmap_mig_before_vm_start(void);
>>> +void init_dirty_bitmap_incoming_migration(void);
>>> +
>>> =C2=A0 #endif
>>> diff --git a/migration/block-dirty-bitmap.c
>>> b/migration/block-dirty-bitmap.c
>>> new file mode 100644
>>> index 0000000000..53cb20045d
>>> --- /dev/null
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -0,0 +1,734 @@
>>> +/*
>>> + * Block dirty bitmap postcopy migration
>>> + *
>>> + * Copyright IBM, Corp. 2009
>>> + * Copyright (c) 2016-2017 Parallels International GmbH
>>> + *
>>> + * Authors:
>>> + *=C2=A0 Liran Schour=C2=A0=C2=A0 <lirans@il.ibm.com>
>>> + *=C2=A0 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2.=C2=
=A0
>>> See
>>> + * the COPYING file in the top-level directory.
>>> + * This file is derived from migration/block.c, so it's author and
>>> IBM copyright
>>> + * are here, although content is quite different.
>>> + *
>>> + * Contributions after 2012-01-13 are licensed under the terms of th=
e
>>> + * GNU GPL, version 2 or (at your option) any later version.
>>> + *
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ***
>>> + *
>>> + * Here postcopy migration of dirty bitmaps is realized. Only named
>>> dirty
>>> + * bitmaps, associated with root nodes and non-root named nodes are
>>> migrated.
>> Put another way, only QMP-addressable bitmaps. Nodes without a name th=
at
>> are not the root have no way to be addressed.
>>
>>> + *
>>> + * If destination qemu is already containing a dirty bitmap with the
>>> same name
>> "If the destination QEMU already contains a dirty bitmap with the same
>> name"
>>
>>> + * as a migrated bitmap (for the same node), then, if their
>>> granularities are
>>> + * the same the migration will be done, otherwise the error will be
>>> generated.
>> "an error"
>>
>>> + *
>>> + * If destination qemu doesn't contain such bitmap it will be create=
d.
>> "If the destination QEMU doesn't contain such a bitmap, it will be
>> created."
>>
>>> + *
>>> + * format of migration:
>>> + *
>>> + * # Header (shared for different chunk types)
>>> + * 1, 2 or 4 bytes: flags (see qemu_{put,put}_flags)
>>> + * [ 1 byte: node name size ] \=C2=A0 flags & DEVICE_NAME
>>> + * [ n bytes: node name=C2=A0=C2=A0=C2=A0=C2=A0 ] /
>>> + * [ 1 byte: bitmap name size ] \=C2=A0 flags & BITMAP_NAME
>>> + * [ n bytes: bitmap name=C2=A0=C2=A0=C2=A0=C2=A0 ] /
>>> + *
>>> + * # Start of bitmap migration (flags & START)
>>> + * header
>>> + * be64: granularity
>>> + * 1 byte: bitmap flags (corresponds to BdrvDirtyBitmap)
>>> + *=C2=A0=C2=A0 bit 0=C2=A0=C2=A0=C2=A0 -=C2=A0 bitmap is enabled
>>> + *=C2=A0=C2=A0 bit 1=C2=A0=C2=A0=C2=A0 -=C2=A0 bitmap is persistent
>>> + *=C2=A0=C2=A0 bit 2=C2=A0=C2=A0=C2=A0 -=C2=A0 bitmap is autoloading
>>> + *=C2=A0=C2=A0 bits 3-7 - reserved, must be zero
>>> + *
>>> + * # Complete of bitmap migration (flags & COMPLETE)
>>> + * header
>>> + *
>>> + * # Data chunk of bitmap migration
>>> + * header
>>> + * be64: start sector
>>> + * be32: number of sectors
>>> + * [ be64: buffer size=C2=A0 ] \ ! (flags & ZEROES)
>>> + * [ n bytes: buffer=C2=A0=C2=A0=C2=A0 ] /
>>> + *
>>> + * The last chunk in stream should contain flags & EOS. The chunk
>>> may skip
>>> + * device and/or bitmap names, assuming them to be the same with the
>>> previous
>>> + * chunk.
>>> + */
>>> +
>> Been a while since I reviewed the format, but it seems sane.
>>
>>> +#include "qemu/osdep.h"
>>> +#include "block/block.h"
>>> +#include "block/block_int.h"
>>> +#include "sysemu/block-backend.h"
>>> +#include "qemu/main-loop.h"
>>> +#include "qemu/error-report.h"
>>> +#include "migration/misc.h"
>>> +#include "migration/migration.h"
>>> +#include "migration/qemu-file.h"
>>> +#include "migration/vmstate.h"
>>> +#include "migration/register.h"
>>> +#include "qemu/hbitmap.h"
>>> +#include "sysemu/sysemu.h"
>>> +#include "qemu/cutils.h"
>>> +#include "qapi/error.h"
>>> +#include "trace.h"
>>> +
>>> +#define CHUNK_SIZE=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 10)
>>> +
>>> +/* Flags occupy one, two or four bytes (Big Endian). The size is
>>> determined as
>>> + * follows:
>>> + * in first (most significant) byte bit 8 is clear=C2=A0 -->=C2=A0 o=
ne byte
>>> + * in first byte bit 8 is set=C2=A0=C2=A0=C2=A0 -->=C2=A0 two or fou=
r bytes, depending
>>> on second
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 byt=
e:
>>> + *=C2=A0=C2=A0=C2=A0 | in second byte bit 8 is clear=C2=A0 -->=C2=A0=
 two bytes
>>> + *=C2=A0=C2=A0=C2=A0 | in second byte bit 8 is set=C2=A0=C2=A0=C2=A0=
 -->=C2=A0 four bytes
>>> + */
>>> +#define DIRTY_BITMAP_MIG_FLAG_EOS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x01
>>> +#define DIRTY_BITMAP_MIG_FLAG_ZEROES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x02
>>> +#define DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME=C2=A0=C2=A0 0x04
>>> +#define DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME=C2=A0=C2=A0 0x08
>>> +#define DIRTY_BITMAP_MIG_FLAG_START=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x10
>>> +#define DIRTY_BITMAP_MIG_FLAG_COMPLETE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x20
>>> +#define DIRTY_BITMAP_MIG_FLAG_BITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x40
>>> +
>>> +#define DIRTY_BITMAP_MIG_EXTRA_FLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x80
>>> +
>>> +#define DIRTY_BITMAP_MIG_START_FLAG_ENABLED=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01
>>> +#define DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x02
>>> +#define DIRTY_BITMAP_MIG_START_FLAG_AUTOLOAD=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x04
>>> +#define DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK=C2=A0=C2=A0=C2=A0 =
0xf8
>>> +
>>> +typedef struct DirtyBitmapMigBitmapState {
>>> +=C2=A0=C2=A0=C2=A0 /* Written during setup phase. */
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 const char *node_name;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t total_sectors;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t sectors_per_chunk;
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_ENTRY(DirtyBitmapMigBitmapState) entry;
>>> +=C2=A0=C2=A0=C2=A0 uint8_t flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* For bulk phase. */
>>> +=C2=A0=C2=A0=C2=A0 bool bulk_completed;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t cur_sector;
>>> +} DirtyBitmapMigBitmapState;
>>> +
>>> +typedef struct DirtyBitmapMigState {
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_HEAD(dbms_list, DirtyBitmapMigBitmapStat=
e) dbms_list;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bool bulk_completed;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* for send_bitmap_bits() */
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *prev_bs;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *prev_bitmap;
>>> +} DirtyBitmapMigState;
>>> +
>>> +typedef struct DirtyBitmapLoadState {
>>> +=C2=A0=C2=A0=C2=A0 uint32_t flags;
>>> +=C2=A0=C2=A0=C2=A0 char node_name[256];
>>> +=C2=A0=C2=A0=C2=A0 char bitmap_name[256];
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>>> +} DirtyBitmapLoadState;
>>> +
>>> +static DirtyBitmapMigState dirty_bitmap_mig_state;
>>> +
>>> +typedef struct DirtyBitmapLoadBitmapState {
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>>> +=C2=A0=C2=A0=C2=A0 bool migrated;
>>> +} DirtyBitmapLoadBitmapState;
>>> +static GSList *enabled_bitmaps;
>>> +QemuMutex finish_lock;
>>> +
>>> +void init_dirty_bitmap_incoming_migration(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_init(&finish_lock);
>>> +}
>>> +
>> This is a little odd as public interface. David, is there a nicer way =
to
>> integrate in-migrate hooks? I guess it hasn't come up yet. Anyway, it
>> might be nice to leave a comment here for now that says that the only
>> caller is migration.c, and it will only ever call it once.
>>
>>> +static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint8_t flags =3D qemu_get_byte(f);
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_EXTRA_FLAGS) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D flags << 8 | qe=
mu_get_byte(f);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_=
MIG_EXTRA_FLAGS) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
lags =3D flags << 16 | qemu_get_be16(f);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return flags;
>>> +}
>>> +
>> ok
>>
>> (Sorry for the per-function ACKs, it's just helpful for me to know whi=
ch
>> functions I followed execution of on paper to make sure I got everythi=
ng
>> in this big patch.)
>>
>>> +static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 /* The code currently do not send flags more than=
 one byte */
>>> +=C2=A0=C2=A0=C2=A0 assert(!(flags & (0xffffff00 | DIRTY_BITMAP_MIG_E=
XTRA_FLAGS)));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_byte(f, flags);
>>> +}
>>> +
>> ok
>>
>>> +static void send_bitmap_header(QEMUFile *f,
>>> DirtyBitmapMigBitmapState *dbms,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t additional_flags)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D dbms->bs;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap =3D dbms->bitmap;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t flags =3D additional_flags;
>>> +=C2=A0=C2=A0=C2=A0 trace_send_bitmap_header_enter();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (bs !=3D dirty_bitmap_mig_state.prev_bs) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.pr=
ev_bs =3D bs;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D DIRTY_BITMAP_M=
IG_FLAG_DEVICE_NAME;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (bitmap !=3D dirty_bitmap_mig_state.prev_bitma=
p) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.pr=
ev_bitmap =3D bitmap;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D DIRTY_BITMAP_M=
IG_FLAG_BITMAP_NAME;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>> I guess the idea here is that we might be able to skip the node name
>> broadcast, leaving the possibilities as:
>>
>> - new node and bitmap: send both
>> - new bitmap, but not node: send bitmap name only
>> - same for both: send neither
>=20
> yes
>=20
>>
>> and that otherwise it's not possible to have a new node but "same
>> bitmap" by nature of how the structures are organized.
>=20
> I hope we don't have bitmaps, shared between nodes)
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, flags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f=
, dbms->node_name);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f=
, bdrv_dirty_bitmap_name(bitmap));
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>> ok
>>
>>> +static void send_bitmap_start(QEMUFile *f, DirtyBitmapMigBitmapState
>>> *dbms)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG=
_START);
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_be32(f, bdrv_dirty_bitmap_granularity(db=
ms->bitmap));
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_byte(f, dbms->flags);
>>> +}
>>> +
>> ok
>>
>>> +static void send_bitmap_complete(QEMUFile *f,
>>> DirtyBitmapMigBitmapState *dbms)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG=
_COMPLETE);
>>> +}
>>> +
>> ok
>>
>>> +static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState
>>> *dbms,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t start_sector, uint32_t
>>> nr_sectors)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 /* align for buffer_is_zero() */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t align =3D 4 * sizeof(long);
>>> +=C2=A0=C2=A0=C2=A0 uint64_t unaligned_size =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_seriali=
zation_size(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
bms->bitmap, start_sector << BDRV_SECTOR_BITS,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
uint64_t)nr_sectors << BDRV_SECTOR_BITS);
>>> +=C2=A0=C2=A0=C2=A0 uint64_t buf_size =3D (unaligned_size + align - 1=
) & ~(align - 1);
>>> +=C2=A0=C2=A0=C2=A0 uint8_t *buf =3D g_malloc0(buf_size);
>>> +=C2=A0=C2=A0=C2=A0 uint32_t flags =3D DIRTY_BITMAP_MIG_FLAG_BITS;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_serialize_part(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbms->bitmap, buf, start_=
sector << BDRV_SECTOR_BITS,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (uint64_t)nr_sectors << B=
DRV_SECTOR_BITS);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (buffer_is_zero(buf, buf_size)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(buf);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D DIRTY_BITMAP_M=
IG_FLAG_ZEROES;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 trace_send_bitmap_bits(flags, start_sector, nr_se=
ctors, buf_size);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 send_bitmap_header(f, dbms, flags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_be64(f, start_sector);
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_be32(f, nr_sectors);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* if a block is zero we need to flush here since=
 the network
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bandwidth is now a lot higher than the st=
orage device bandwidth.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * thus if we queue zero blocks we slow down=
 the migration. */
>> Can you elaborate on this for me?
>=20
> it comes from migration/block.c, as it was a prototype for dirty bitmap=
s
> migration.
> May be the original thought was to give destination storage more time t=
o
> handle
> write-zeros? It may make sense if it can't do it fast but really writes
> zeros.
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fflush(f);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_be64(f, buf_size=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_buffer(f, buf, b=
uf_size);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 g_free(buf);
>>> +}
>>> +
>>> +
>>> +/* Called with iothread lock taken.=C2=A0 */
>>> +
>>> +static int init_dirty_bitmap_migration(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>>> +=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms;
>>> +=C2=A0=C2=A0=C2=A0 BdrvNextIterator it;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.bulk_completed =3D false;
>>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.prev_bs =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.prev_bitmap =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next=
(&it)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bdrv_get_device_or_n=
ode_name(bs)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* not named non-root node */
>> I can't imagine the situation it would arise in, but is it possible to
>> have a named bitmap attached to a now-anonymous node?
>>
>> Let's say we attach a bitmap to a root node, but then later we insert =
a
>> filter or something above it and it's no longer at the root.
>>
>> We should probably prohibit such things, or at the very least toss out
>> an error here instead of silently continuing.
>>
>> I think the only things valid to just *skip* are nameless bitmaps.
>> Anything named we really ought to either migrate or error out over, I
>> think, even if the circumstances leading to such a configuration are
>> very unlikely.
>=20
> agree, will fix.
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (bitmap =3D bdrv_dirt=
y_bitmap_next(bs, NULL); bitmap;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!bdrv_dirty_bitmap_name(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (bdrv_dirty_bitmap_frozen(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("Can't migrate frozen dirty bitmap: '%=
s",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_name(bitmap));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next=
(&it)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bdrv_get_device_or_n=
ode_name(bs)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* not named non-root node */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> Why two-pass? I guess because we don't have to tear anything down if w=
e
>> check for errors in advance?
>>
>> I worry that if we need to amend the logic here that it's error-prone =
to
>> update it in two places, so maybe we ought to just have one loop.
>=20
> why? just check all errors in first loop and then do all preparations i=
n
> the second..
>=20

Sure, keep it this way for now. It just struck me as odd, but you're the
one writing it and it's not wrong; I just wondered if there was a way to
not have to select the bitmaps to work on separately, twice.

If it doesn't strike you as particularly worth changing, then I wouldn't
worry about it.

>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (bitmap =3D bdrv_dirt=
y_bitmap_next(bs, NULL); bitmap;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!bdrv_dirty_bitmap_name(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_ref(bs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_dirty_bitmap_set_frozen(bitmap, true);
>>> +
>> We could say that for any bitmap in the list of pending bitmaps to
>> migrate, we know that we have to un-freeze it, since we never add any
>> bitmaps that are frozen to our list.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
bms =3D g_new0(DirtyBitmapMigBitmapState, 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
bms->bs =3D bs;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
bms->node_name =3D bdrv_get_node_name(bs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!dbms->node_name || dbms->node_name[0] =3D=3D '\0') {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dbms->node_name =3D bdrv_get_device_name(bs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
bms->bitmap =3D bitmap;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
bms->total_sectors =3D bdrv_nb_sectors(bs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
bms->sectors_per_chunk =3D CHUNK_SIZE * 8 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_granularity(bitmap) >>
>>> BDRV_SECTOR_BITS;
>> Eric may want to avoid checking in new code that thinks in sectors, bu=
t
>> for the sake of review I don't mind right now.
>>
>> (Sorry, Eric!)
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (bdrv_dirty_bitmap_enabled(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dbms->flags |=3D DIRTY_BITMAP_MIG_START_FLAG_ENABLE=
D;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (bdrv_dirty_bitmap_get_persistance(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dbms->flags |=3D DIRTY_BITMAP_MIG_START_FLAG_PERSIS=
TENT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (bdrv_dirty_bitmap_get_autoload(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dbms->flags |=3D DIRTY_BITMAP_MIG_START_FLAG_AUTOLO=
AD;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_dirty_bitmap_set_persistance(bitmap, false);
>> Oh, this might be stranger to undo. Perhaps what we CAN do is limit th=
e
>> second pass to just this action and allow ourselves to unroll everythi=
ng
>> else.
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Q=
SIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbms, entry);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>=20
> hmm, I need to think about correct bitmap locking in the code
> (BdrvDirtyBitmap.lock)
>=20

Only if you felt like combining the two loops.

>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +/* Called with no lock taken.=C2=A0 */
>>> +static void bulk_phase_send_chunk(QEMUFile *f,
>>> DirtyBitmapMigBitmapState *dbms)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint32_t nr_sectors =3D MIN(dbms->total_sectors -=
 dbms->cur_sector,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dbms->sectors_per_chunk);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 send_bitmap_bits(f, dbms, dbms->cur_sector, nr_se=
ctors);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dbms->cur_sector +=3D nr_sectors;
>>> +=C2=A0=C2=A0=C2=A0 if (dbms->cur_sector >=3D dbms->total_sectors) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbms->bulk_completed =3D =
true;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +/* Called with no lock taken.=C2=A0 */
>>> +static void bulk_phase(QEMUFile *f, bool limit)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.db=
ms_list, entry) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!dbms->bulk_comple=
ted) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
ulk_phase_send_chunk(f, dbms);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (limit && qemu_file_rate_limit(f)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.bulk_completed =3D true;
>>> +}
>>> +
>>> +/* Called with iothread lock taken.=C2=A0 */
>>> +static void dirty_bitmap_mig_cleanup(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 while ((dbms =3D
>>> QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) !=3D NULL) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE_HEAD(&dir=
ty_bitmap_mig_state.dbms_list, entry);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_fro=
zen(dbms->bitmap, false);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unref(dbms->bs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dbms);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>> ok
>>
>>> +/* for SaveVMHandlers */
>>> +static void dirty_bitmap_save_cleanup(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_cleanup();
>>> +}
>>> +
>> ok
>>
>>> +static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_save_iterate(migration_in_post=
copy());
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (migration_in_postcopy() &&
>>> !dirty_bitmap_mig_state.bulk_completed) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_phase(f, true);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EO=
S);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return dirty_bitmap_mig_state.bulk_completed;
>>> +}
>>> +
>> What's the purpose behind doing bulk save both here and in
>> dirty_bitmap_save_complete? Is there a path that isn't guaranteed to
>> call one of the completion functions?
>>
>> (The way it's coded seems like it'll work fine, but I'm curious about
>> what looks like a redundancy at a glance.)
>=20
> bulk_phase(f, true) is not guaranteed to do all the work. so in complet=
e()
> we call it with false, to complete.
>=20
> hmm, it is saved from precopy migration approach. And looks like really=
,
> in case of postcopy
> we need only blulk_phase(f, false) in _complete and nothing else. I'll
> check.
>=20

OK, so more of a holdover that covers all the bases than something that
arose out of necessity. That makes sense to me.

>>
>>> +/* Called with iothread lock taken.=C2=A0 */
>>> +
>>> +static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms;
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_save_complete_enter();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!dirty_bitmap_mig_state.bulk_completed) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_phase(f, false);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>> funny now that we don't actually really iterate over the data, and the
>> bulk phase is now really the _only_ phase :)
>>
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.db=
ms_list, entry) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_bitmap_complete(f, d=
bms);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EO=
S);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_save_complete_finish();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_cleanup();
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>> ok
>>
>>> +static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t max_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t *res_precopy_only,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t *res_compatible,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t *res_postcopy_only)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t pending =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock_iothread();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.db=
ms_list, entry) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t gran =3D bdrv_di=
rty_bitmap_granularity(dbms->bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t sectors =3D dbms=
->bulk_completed ? 0 :
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dbms->total_sectors - dbms->cur_sector;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pending +=3D (sectors * B=
DRV_SECTOR_SIZE + gran - 1) / gran;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock_iothread();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_save_pending(pending, max_size=
);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 *res_postcopy_only +=3D pending;
>>> +}
>>> +
>> ok
>>
>>> +/* First occurrence of this bitmap. It should be created if doesn't
>>> exist */
>>> +static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState
>>> *s)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t granularity =3D qemu_get_be32(f);
>>> +=C2=A0=C2=A0=C2=A0 uint8_t flags =3D qemu_get_byte(f);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!s->bitmap) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bitmap =3D bdrv_create=
_dirty_bitmap(s->bs, granularity,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bitmap_name,
>>> &local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bitmap) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report_err(local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t dest_granularity=
 =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_dirty_bitmap_granularity(s->bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dest_granularity !=3D=
 granularity) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("Error: "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "Migrated bitmap granularity (%" PRIu32 ") "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "doesn't match the destination bitmap '%s' "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "granularity (%" PRIu32 ")",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 granularity,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bdrv_dirty_bitmap_name(s->bitmap),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dest_granularity);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>> I'm a fan of auto-creating the bitmaps. Do you have a use-case for why
>> creating them ahead of time is better, or are you just attempting to b=
e
>> flexible?
>=20
> the second. I just was my first approach about two years ago and it was=
 not
> discussed until now). In our scenarios we use auto-creating way. So, it=
 may
> be better to just fail if corresponding bitmap exists on destination
> without
> any granularity checks.
>=20
I don't think you need to change anything yet, I was just curious as to
what inspired the flexibility here.

>>
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_START_FLAG_RESERVED_=
MASK) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Unknown fla=
gs in migrated dirty bitmap header:
>>> %x",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_START_FLAG_PERSISTEN=
T) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_per=
sistance(s->bitmap, true);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_START_FLAG_AUTOLOAD)=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_aut=
oload(s->bitmap, true);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bdrv_disable_dirty_bitmap(s->bitmap);
>> OK, so we start them off as disabled, and
>>
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DirtyBitmapLoadBitmapStat=
e *b;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_create_=
successor(s->bs, s->bitmap,
>>> &local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report_err(local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>> If they weren't disabled on the host, we create a successor to record
>> writes while we wait for the rest of the data to arrive.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b =3D g_new(DirtyBitmapLo=
adBitmapState, 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b->bs =3D s->bs;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b->bitmap =3D s->bitmap;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b->migrated =3D false;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled_bitmaps =3D g_sli=
st_prepend(enabled_bitmaps, b);
>> And we make a note of which ones we were supposed to re-enable.
>>
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>> OK
>>
>>> +
>>> +void dirty_bitmap_mig_before_vm_start(void)
>> Similarly, I guess I find it weird that this is a callable interface.
>>
>> David, no nice hook for just-prior-to-vm-start calls? a
>> .postcopy_pivot() hook or something might be nice..
>>
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 GSList *item;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&finish_lock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (item =3D enabled_bitmaps; item; item =3D g_s=
list_next(item)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DirtyBitmapLoadBitmapStat=
e *b =3D item->data;
>>> +
>> Anyway, if I am reading this right; we call this in the postcopy phase
>> prior to receiving the entirety of the bitmaps (so before receiving
>> COMPLETE) ... right?
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (b->migrated) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_enable_dirty_bitmap(b->bitmap);
>=20
> This is the most difficult thing here. Race is possible between postcop=
y
> complete
> and vm start. So, here is a finish_lock. And bitmap may be already
> migrated or not.
>=20

That makes sense. Figured it could be something of the kind, but wanted
to make sure I was reading it right.

>> ...or, am I confused, and we might receive a COMPLETE event prior to t=
he
>> postcopy pivot?
>>
>> Anyway, I suppose this code says "If we received the entire bitmap, go
>> ahead and enable it."
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_dirty_bitmap_enable_successor(b->bitmap);
>> And this says "If we haven't received it yet, enable the successor to
>> record writes until we get the rest of the data."
>=20
> yes
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(b);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 g_slist_free(enabled_bitmaps);
>>> +=C2=A0=C2=A0=C2=A0 enabled_bitmaps =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&finish_lock);
>>> +}
>>> +
>>> +static void dirty_bitmap_load_complete(QEMUFile *f,
>>> DirtyBitmapLoadState *s)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 GSList *item;
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_complete();
>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&finish_lock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (item =3D enabled_bitmaps; item; item =3D g_s=
list_next(item)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DirtyBitmapLoadBitmapStat=
e *b =3D item->data;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (b->bitmap =3D=3D s->b=
itmap) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
->migrated =3D true;
>> we can probably break; here now, right?
>=20
> agree.
>=20
>>
>> (This whole stanza is a little strange, can't we cache the active
>> DirtyBitmapLoadBitmapState in DirtyBitmapLoadState? I guess not, becau=
se
>> we're looking up the BdrvDirtyBitmap itself and caching that instead, =
so
>> either way we have some kind of lookup on every context switch.)
>=20
> this search is needed only once, so caching will not help.
>=20

Yep, gotcha.

>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_frozen(s->bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (enabled_bitmaps =3D=3D=
 NULL) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* in postcopy */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A=
ioContext *aio_context =3D bdrv_get_aio_context(s->bs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
io_context_acquire(aio_context);
>=20
> looks like it should be moved to use new BdrvDirtyBitmap locks.
>=20

Good catch!

>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_reclaim_dirty_bitmap(s->bs, s->bitmap, &error_abort);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_enable_dirty_bitmap(s->bitmap);
>>> +
>> OK, so if enabled_bitmaps is gone, that means we already pivoted and
>> we're live on the receiving end here. We merge the successor into the
>> fully deserialized bitmap and enable it.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
io_context_release(aio_context);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* target not started, successor is empty */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_dirty_bitmap_release_successor(s->bs, s->bitmap);
>> Otherwise we just trash the successor. Did we really need a new call f=
or
>> this? I suppose it's faster than merging a 0-bit bitmap, but the
>> additional API complexity for the speed win here seems like premature
>> optimization.
>>
>> ...well, you already wrote it, so I won't argue.
>=20
> right idea. However in this case (and even with my approach) it is good
> to assert here
> that successor is empty. and additional api is needed for it.
>=20

Sure, it's less flexible and that will help us spot errors in our
thinking. Can't argue with that.

>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(&finish_lock);
>>> +}
>>> +
>>> +static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState =
*s)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint64_t first_byte =3D qemu_get_be64(f) << BDRV_=
SECTOR_BITS;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t nr_bytes =3D (uint64_t)qemu_get_be32(f) =
<< BDRV_SECTOR_BITS;
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_bits_enter(first_byte >> =
BDRV_SECTOR_BITS,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 nr_bytes >> BDRV_SECTOR_BITS);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_b=
its_zeroes();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_deseria=
lize_zeroes(s->bitmap, first_byte,
>>> nr_bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *buf;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t buf_size =3D qem=
u_get_be64(f);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t needed_size =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_dirty_bitmap_serialization_size(s->bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fir=
st_byte, nr_bytes);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (needed_size > buf_siz=
e) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("Error: Migrated bitmap granularity doesn't "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "match the destination bitmap '%s'
>>> granularity",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bdrv_dirty_bitmap_name(s->bitmap));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D g_malloc(buf_size=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_get_buffer(f, buf, b=
uf_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_deseria=
lize_part(s->bitmap, buf,
>>> first_byte, nr_bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(buf);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>> ok
>>
>>> +static int dirty_bitmap_load_header(QEMUFile *f,
>>> DirtyBitmapLoadState *s)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 s->flags =3D qemu_get_bitmap_flags(f);
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_header(s->flags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME)=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_get_counted_str=
ing(f, s->node_name)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("Unable to read node name string");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bs =3D bdrv_lookup_bs(=
s->node_name, s->node_name, &local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bs) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report_err(local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } else if (!s->bs) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Error: bloc=
k device name is not set");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME)=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_get_counted_str=
ing(f, s->bitmap_name)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("Unable to read node name string");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bitmap =3D bdrv_find_d=
irty_bitmap(s->bs, s->bitmap_name);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* bitmap may be NULL her=
e, it wouldn't be an error if it is
>>> the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * first occurrence =
of the bitmap */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bitmap && !(s->fl=
ags & DIRTY_BITMAP_MIG_FLAG_START)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("Error: unknown dirty bitmap "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "'%s' for block device '%s'",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 s->bitmap_name, s->node_name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } else if (!s->bitmap) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Error: bloc=
k device name is not set");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>> ok
>>
>>> +static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_=
id)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 static DirtyBitmapLoadState s;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_enter();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (version_id !=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 do {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_load_header(=
f, &s);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s.flags & DIRTY_BITMA=
P_MIG_FLAG_START) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D dirty_bitmap_load_start(f, &s);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (s.flags & DIRT=
Y_BITMAP_MIG_FLAG_COMPLETE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
irty_bitmap_load_complete(f, &s);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (s.flags & DIRT=
Y_BITMAP_MIG_FLAG_BITS) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D dirty_bitmap_load_bits(f, &s);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D qemu_file_get_error(f);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_success();
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>> OK
>>
>>> +
>>> +static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 if (init_dirty_bitmap_migration() < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.db=
ms_list, entry) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_bitmap_start(f, dbms=
);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EO=
S);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>> ok
>>
>>> +static bool dirty_bitmap_is_active(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return migrate_dirty_bitmaps();
>>> +}
>>> +
>> ok
>>
>>> +static bool dirty_bitmap_is_active_iterate(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return dirty_bitmap_is_active(opaque) && !runstat=
e_is_running();
>>> +}
>>> +
>> On second thought, in patch 9, can you add a little tiny bit of
>> documentation text explaining the exact nature of this callback?
>>
>> Is the second portion of the conditional here so that once we reach th=
e
>> postcopy state that .is_active_iterate starts returning true?
>>
>> "ok" if I'm reading this right, but it might be helped along by a litt=
le
>> comment.
>=20
> yes. ok, I'll add a comment.
>=20
>>
>>> +static bool dirty_bitmap_has_postcopy(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return true;
>>> +}
>>> +
>> ok! :)
>>
>>> +static SaveVMHandlers savevm_dirty_bitmap_handlers =3D {
>>> +=C2=A0=C2=A0=C2=A0 .save_setup =3D dirty_bitmap_save_setup,
>>> +=C2=A0=C2=A0=C2=A0 .save_live_complete_postcopy =3D dirty_bitmap_sav=
e_complete,
>>> +=C2=A0=C2=A0=C2=A0 .save_live_complete_precopy =3D dirty_bitmap_save=
_complete,
>>> +=C2=A0=C2=A0=C2=A0 .has_postcopy =3D dirty_bitmap_has_postcopy,
>>> +=C2=A0=C2=A0=C2=A0 .save_live_pending =3D dirty_bitmap_save_pending,
>>> +=C2=A0=C2=A0=C2=A0 .save_live_iterate =3D dirty_bitmap_save_iterate,
>>> +=C2=A0=C2=A0=C2=A0 .is_active_iterate =3D dirty_bitmap_is_active_ite=
rate,
>>> +=C2=A0=C2=A0=C2=A0 .load_state =3D dirty_bitmap_load,
>>> +=C2=A0=C2=A0=C2=A0 .save_cleanup =3D dirty_bitmap_save_cleanup,
>>> +=C2=A0=C2=A0=C2=A0 .is_active =3D dirty_bitmap_is_active,
>>> +};
>>> +
>>> +void dirty_bitmap_mig_init(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 register_savevm_live(NULL, "dirty-bitmap", 0, 1,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &savevm_dirty_bitmap_handlers,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &dirty_bitmap_mig_state);
>>> +}
>> ok
>>
>> dgilbert, would it be worth registering a block-driver-like registrati=
on
>> trick that automatically invokes these functions instead of having to
>> hook them up in vl.c? the more we add, the more hacky it looks to not
>> have some subsystem-wide registration hook.
>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index e973837bfd..66e9cf03cd 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -150,6 +150,9 @@ MigrationIncomingState
>>> *migration_incoming_get_current(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&mis_cu=
rrent, 0, sizeof(MigrationIncomingState));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_ini=
t(&mis_current.rp_mutex);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_event_ini=
t(&mis_current.main_thread_load_event, false);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_dirty_bitmap_incomin=
g_migration();
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 once =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return &mis_current;
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 9bbfb3fa1b..b0c37ef9f1 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1673,6 +1673,8 @@ static void loadvm_postcopy_handle_run_bh(void
>>> *opaque)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_loadvm_postcopy_handle_ru=
n_vmstart();
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_before_vm_start();
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (autostart) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Hold onto y=
our hats, starting the CPU */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_start();
>>> diff --git a/vl.c b/vl.c
>>> index ec299099ff..3d393aaf2c 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -4642,6 +4642,7 @@ int main(int argc, char **argv, char **envp)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mig_init();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ram_mig_init();
>>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_init();
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If the currently selected ma=
chine wishes to override the
>>> units-per-bus
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * property of its default HBA in=
terface type, do so now. */
>>> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
>>> index 99e038024d..c83ec47ba8 100644
>>> --- a/migration/Makefile.objs
>>> +++ b/migration/Makefile.objs
>>> @@ -6,6 +6,7 @@ common-obj-y +=3D qemu-file.o global_state.o
>>> =C2=A0 common-obj-y +=3D qemu-file-channel.o
>>> =C2=A0 common-obj-y +=3D xbzrle.o postcopy-ram.o
>>> =C2=A0 common-obj-y +=3D qjson.o
>>> +common-obj-y +=3D block-dirty-bitmap.o
>>> =C2=A0 =C2=A0 common-obj-$(CONFIG_RDMA) +=3D rdma.o
>>> =C2=A0 diff --git a/migration/trace-events b/migration/trace-events
>>> index a04fffb877..e9eb8078d4 100644
>>> --- a/migration/trace-events
>>> +++ b/migration/trace-events
>>> @@ -227,3 +227,17 @@ colo_vm_state_change(const char *old, const char
>>> *new) "Change '%s' =3D> '%s'"
>>> =C2=A0 colo_send_message(const char *msg) "Send '%s' message"
>>> =C2=A0 colo_receive_message(const char *msg) "Receive '%s' message"
>>> =C2=A0 colo_failover_set_state(const char *new_state) "new state %s"
>>> +
>>> +# migration/block-dirty-bitmap.c
>>> +send_bitmap_header_enter(void) ""
>>> +send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t
>>> nr_sectors, uint64_t data_size) "\n=C2=A0=C2=A0 flags:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x%x\n=C2=A0=C2=A0
>>> start_sector: %" PRIu64 "\n=C2=A0=C2=A0 nr_sectors:=C2=A0=C2=A0 %" PR=
Iu32 "\n=C2=A0=C2=A0
>>> data_size:=C2=A0=C2=A0=C2=A0 %" PRIu64 "\n"
>>> +dirty_bitmap_save_iterate(int in_postcopy) "in postcopy: %d"
>>> +dirty_bitmap_save_complete_enter(void) ""
>>> +dirty_bitmap_save_complete_finish(void) ""
>>> +dirty_bitmap_save_pending(uint64_t pending, uint64_t max_size)
>>> "pending %" PRIu64 " max: %" PRIu64
>>> +dirty_bitmap_load_complete(void) ""
>>> +dirty_bitmap_load_bits_enter(uint64_t first_sector, uint32_t
>>> nr_sectors) "chunk: %" PRIu64 " %" PRIu32
>>> +dirty_bitmap_load_bits_zeroes(void) ""
>>> +dirty_bitmap_load_header(uint32_t flags) "flags 0x%x"
>>> +dirty_bitmap_load_enter(void) ""
>>> +dirty_bitmap_load_success(void) ""
>>>
>> OK, I think everything here is probably in order, and it's only my
>> understanding that is a barrier at this point. Help me understand the
>> rest of this patch and I'll re-pester migration to get this staged for
>> qemu-next.
>>
>> --js
>=20
> Thank you for reviewing! I hope, I'll post new version next week.
>=20

It looks pretty much all set from my end apart from just minor little
things. Max reviewed most of the tests and Juan reviewed most of the
migration system bits, so I'm hopeful that this will be done soon.

Thanks!
