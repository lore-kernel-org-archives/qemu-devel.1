Received: from eggs.gnu.org ([209.51.188.92]:58734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gtBoO-0008E8-9y
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gtBo6-0006lf-JV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:39:41 -0500
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:42532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gtBo2-0006hC-2H
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:39:32 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190211124519.GD2627@work-vm>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
	<20190204130958.18904-3-yury-kotov@yandex-team.ru>
	<20190211124519.GD2627@work-vm>
MIME-Version: 1.0
Date: Mon, 11 Feb 2019 16:36:27 +0300
Message-Id: <2095681549892187@sas1-bf4ab558af9f.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] migration: Introduce ignore-shared
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>

11.02.2019, 15:45, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0We want to use local migration to update QEMU for running guests=
.
>> =C2=A0In this case we don't need to migrate shared (file backed) RAM.
>> =C2=A0So, add a capability to ignore such blocks during live migration=
.
>>
>> =C2=A0Also, move qemu_ram_foreach_migratable_block (and rename) to the
>> =C2=A0migration code, because it requires access to the migration capa=
bilities.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>
> You could split this patch into the one that introduces the capability
> and then the one that wires it up. We could also remove the x- at some
> point.

I.e. the patch that just adds the capability to json (and migrate_use_*),=
 but
nothing more, and the second one which actually realize the capability?

Like this:
2a4c42f18c migration: add postcopy blocktime ctx into MigrationIncomingSt=
ate
f22f928ec9 migration: introduce postcopy-blocktime capability
?

>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> =C2=A0---
>> =C2=A0=C2=A0exec.c | 19 -------
>> =C2=A0=C2=A0include/exec/cpu-common.h | 1 -
>> =C2=A0=C2=A0migration/migration.c | 9 ++++
>> =C2=A0=C2=A0migration/migration.h | 5 +-
>> =C2=A0=C2=A0migration/postcopy-ram.c | 12 ++---
>> =C2=A0=C2=A0migration/ram.c | 110 +++++++++++++++++++++++++++++-------=
--
>> =C2=A0=C2=A0migration/rdma.c | 2 +-
>> =C2=A0=C2=A0qapi/migration.json | 5 +-
>> =C2=A0=C2=A0stubs/ram-block.c | 15 ++++++
>> =C2=A0=C2=A09 files changed, 123 insertions(+), 55 deletions(-)
>>
>> =C2=A0diff --git a/exec.c b/exec.c
>> =C2=A0index a61d501568..91bfe5fb62 100644
>> =C2=A0--- a/exec.c
>> =C2=A0+++ b/exec.c
>> =C2=A0@@ -3984,25 +3984,6 @@ int qemu_ram_foreach_block(RAMBlockIterFu=
nc func, void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
>> =C2=A0=C2=A0}
>>
>> =C2=A0-int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, vo=
id *opaque)
>> =C2=A0-{
>> =C2=A0- RAMBlock *block;
>> =C2=A0- int ret =3D 0;
>> =C2=A0-
>> =C2=A0- rcu_read_lock();
>> =C2=A0- RAMBLOCK_FOREACH(block) {
>> =C2=A0- if (!qemu_ram_is_migratable(block)) {
>> =C2=A0- continue;
>> =C2=A0- }
>> =C2=A0- ret =3D func(block, opaque);
>> =C2=A0- if (ret) {
>> =C2=A0- break;
>> =C2=A0- }
>> =C2=A0- }
>> =C2=A0- rcu_read_unlock();
>> =C2=A0- return ret;
>> =C2=A0-}
>> =C2=A0-
>> =C2=A0=C2=A0/*
>> =C2=A0=C2=A0=C2=A0* Unmap pages of memory from start to start+length s=
uch that
>> =C2=A0=C2=A0=C2=A0* they a) read as 0, b) Trigger whatever fault mecha=
nism
>> =C2=A0diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common=
.h
>> =C2=A0index bdae5446d7..403463d7bb 100644
>> =C2=A0--- a/include/exec/cpu-common.h
>> =C2=A0+++ b/include/exec/cpu-common.h
>> =C2=A0@@ -122,7 +122,6 @@ extern struct MemoryRegion io_mem_notdirty;
>> =C2=A0=C2=A0typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque)=
;
>>
>> =C2=A0=C2=A0int qemu_ram_foreach_block(RAMBlockIterFunc func, void *op=
aque);
>> =C2=A0-int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, vo=
id *opaque);
>> =C2=A0=C2=A0int ram_block_discard_range(RAMBlock *rb, uint64_t start, =
size_t length);
>>
>> =C2=A0=C2=A0#endif
>> =C2=A0diff --git a/migration/migration.c b/migration/migration.c
>> =C2=A0index 37e06b76dc..c40776a40c 100644
>> =C2=A0--- a/migration/migration.c
>> =C2=A0+++ b/migration/migration.c
>> =C2=A0@@ -1983,6 +1983,15 @@ bool migrate_dirty_bitmaps(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return s->enabled_capabilities[MIG=
RATION_CAPABILITY_DIRTY_BITMAPS];
>> =C2=A0=C2=A0}
>>
>> =C2=A0+bool migrate_ignore_shared(void)
>> =C2=A0+{
>> =C2=A0+ MigrationState *s;
>> =C2=A0+
>> =C2=A0+ s =3D migrate_get_current();
>> =C2=A0+
>> =C2=A0+ return s->enabled_capabilities[MIGRATION_CAPABILITY_X_IGNORE_S=
HARED];
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0bool migrate_use_events(void)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MigrationState *s;
>> =C2=A0diff --git a/migration/migration.h b/migration/migration.h
>> =C2=A0index dcd05d9f87..2c88f8a555 100644
>> =C2=A0--- a/migration/migration.h
>> =C2=A0+++ b/migration/migration.h
>> =C2=A0@@ -261,6 +261,7 @@ bool migrate_release_ram(void);
>> =C2=A0=C2=A0bool migrate_postcopy_ram(void);
>> =C2=A0=C2=A0bool migrate_zero_blocks(void);
>> =C2=A0=C2=A0bool migrate_dirty_bitmaps(void);
>> =C2=A0+bool migrate_ignore_shared(void);
>>
>> =C2=A0=C2=A0bool migrate_auto_converge(void);
>> =C2=A0=C2=A0bool migrate_use_multifd(void);
>> =C2=A0@@ -301,8 +302,10 @@ void migrate_send_rp_resume_ack(MigrationIn=
comingState *mis, uint32_t value);
>> =C2=A0=C2=A0void dirty_bitmap_mig_before_vm_start(void);
>> =C2=A0=C2=A0void init_dirty_bitmap_incoming_migration(void);
>>
>> =C2=A0+int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaq=
ue);
>> =C2=A0+
>> =C2=A0=C2=A0#define qemu_ram_foreach_block \
>> =C2=A0- #warning "Use qemu_ram_foreach_block_migratable in migration c=
ode"
>> =C2=A0+ #warning "Use foreach_not_ignored_block in migration code"
>>
>> =C2=A0=C2=A0void migration_make_urgent_request(void);
>> =C2=A0=C2=A0void migration_consume_urgent_request(void);
>> =C2=A0diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> =C2=A0index b098816221..e2aa57a701 100644
>> =C2=A0--- a/migration/postcopy-ram.c
>> =C2=A0+++ b/migration/postcopy-ram.c
>> =C2=A0@@ -374,7 +374,7 @@ bool postcopy_ram_supported_by_host(Migratio=
nIncomingState *mis)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* We don't support postcopy with =
shared RAM yet */
>> =C2=A0- if (qemu_ram_foreach_migratable_block(test_ramblock_postcopiab=
le, NULL)) {
>> =C2=A0+ if (foreach_not_ignored_block(test_ramblock_postcopiable, NULL=
)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -508,7 +508,7 @@ static int cleanup_range(RAMBlock *rb, void =
*opaque)
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0int postcopy_ram_incoming_init(MigrationIncomingState *mis=
)
>> =C2=A0=C2=A0{
>> =C2=A0- if (qemu_ram_foreach_migratable_block(init_range, NULL)) {
>> =C2=A0+ if (foreach_not_ignored_block(init_range, NULL)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -550,7 +550,7 @@ int postcopy_ram_incoming_cleanup(MigrationI=
ncomingState *mis)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0- if (qemu_ram_foreach_migratable_block(cleanup_range, mis)) {
>> =C2=A0+ if (foreach_not_ignored_block(cleanup_range, mis)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -617,7 +617,7 @@ static int nhp_range(RAMBlock *rb, void *opa=
que)
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0int postcopy_ram_prepare_discard(MigrationIncomingState *m=
is)
>> =C2=A0=C2=A0{
>> =C2=A0- if (qemu_ram_foreach_migratable_block(nhp_range, mis)) {
>> =C2=A0+ if (foreach_not_ignored_block(nhp_range, mis)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -628,7 +628,7 @@ int postcopy_ram_prepare_discard(MigrationIn=
comingState *mis)
>>
>> =C2=A0=C2=A0/*
>> =C2=A0=C2=A0=C2=A0* Mark the given area of RAM as requiring notificati=
on to unwritten areas
>> =C2=A0- * Used as a callback on qemu_ram_foreach_migratable_block.
>> =C2=A0+ * Used as a callback on foreach_not_ignored_block.
>> =C2=A0=C2=A0=C2=A0* host_addr: Base of area to mark
>> =C2=A0=C2=A0=C2=A0* offset: Offset in the whole ram arena
>> =C2=A0=C2=A0=C2=A0* length: Length of the section
>> =C2=A0@@ -1122,7 +1122,7 @@ int postcopy_ram_enable_notify(MigrationIn=
comingState *mis)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mis->have_fault_thread =3D true;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Mark so that we get notified of=
 accesses to unwritten areas */
>> =C2=A0- if (qemu_ram_foreach_migratable_block(ram_block_enable_notify,=
 mis)) {
>> =C2=A0+ if (foreach_not_ignored_block(ram_block_enable_notify, mis)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_repo=
rt("ram_block_enable_notify failed");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0diff --git a/migration/ram.c b/migration/ram.c
>> =C2=A0index 59191c1ed2..01315edd66 100644
>> =C2=A0--- a/migration/ram.c
>> =C2=A0+++ b/migration/ram.c
>> =C2=A0@@ -159,18 +159,44 @@ out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static bool ramblock_is_ignored(RAMBlock *block)
>> =C2=A0+{
>> =C2=A0+ return !qemu_ram_is_migratable(block) ||
>> =C2=A0+ (migrate_ignore_shared() && qemu_ram_is_shared(block));
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0/* Should be holding either ram_list.mutex, or the RCU loc=
k. */
>> =C2=A0+#define RAMBLOCK_FOREACH_NOT_IGNORED(block) \
>> =C2=A0+ INTERNAL_RAMBLOCK_FOREACH(block) \
>> =C2=A0+ if (ramblock_is_ignored(block)) {} else
>> =C2=A0+
>> =C2=A0=C2=A0#define RAMBLOCK_FOREACH_MIGRATABLE(block) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INTERNAL_RAMBLOCK_FOREACH(block) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!qemu_=
ram_is_migratable(block)) {} else
>>
>> =C2=A0=C2=A0#undef RAMBLOCK_FOREACH
>>
>> =C2=A0+int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaq=
ue)
>> =C2=A0+{
>> =C2=A0+ RAMBlock *block;
>> =C2=A0+ int ret =3D 0;
>> =C2=A0+
>> =C2=A0+ rcu_read_lock();
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0+ ret =3D func(block, opaque);
>> =C2=A0+ if (ret) {
>> =C2=A0+ break;
>> =C2=A0+ }
>> =C2=A0+ }
>> =C2=A0+ rcu_read_unlock();
>> =C2=A0+ return ret;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static void ramblock_recv_map_init(void)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBlock *rb;
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(rb) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assert(!rb=
->receivedmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rb->receiv=
edmap =3D bitmap_new(rb->max_length >> qemu_target_page_bits());
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -1545,7 +1571,7 @@ unsigned long migration_bitmap_find_dirty(=
RAMState *rs, RAMBlock *rb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long *bitmap =3D rb->bmap=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long next;
>>
>> =C2=A0- if (!qemu_ram_is_migratable(rb)) {
>> =C2=A0+ if (ramblock_is_ignored(rb)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return siz=
e;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -1594,7 +1620,7 @@ uint64_t ram_pagesize_summary(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBlock *block;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint64_t summary =3D 0;
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0summary |=3D=
 block->page_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -1664,7 +1690,7 @@ static void migration_bitmap_sync(RAMState=
 *rs)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_lock(&rs->bitmap_mutex)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration_=
bitmap_sync_range(rs, block, 0, block->used_length);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ram_counters.remaining =3D ram_byt=
es_remaining();
>> =C2=A0@@ -2388,7 +2414,7 @@ static int ram_save_host_page(RAMState *rs=
, PageSearchStatus *pss,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t pagesize_bits =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_ram_p=
agesize(pss->block) >> TARGET_PAGE_BITS;
>>
>> =C2=A0- if (!qemu_ram_is_migratable(pss->block)) {
>> =C2=A0+ if (ramblock_is_ignored(pss->block)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_repo=
rt("block %s should not be migrated !", pss->block->idstr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -2486,19 +2512,30 @@ void acct_update_position(QEMUFile *f, s=
ize_t size, bool zero)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0}
>>
>> =C2=A0-uint64_t ram_bytes_total(void)
>> =C2=A0+static uint64_t ram_bytes_total_common(bool count_ignored)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBlock *block;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint64_t total =3D 0;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0- total +=3D block->used_length;
>> =C2=A0+ if (count_ignored) {
>> =C2=A0+ RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ total +=3D block->used_length;
>> =C2=A0+ }
>> =C2=A0+ } else {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0+ total +=3D block->used_length;
>> =C2=A0+ }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return total;
>> =C2=A0=C2=A0}
>>
>> =C2=A0+uint64_t ram_bytes_total(void)
>> =C2=A0+{
>> =C2=A0+ return ram_bytes_total_common(false);
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static void xbzrle_load_setup(void)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0XBZRLE.decoded_buf =3D g_malloc(TA=
RGET_PAGE_SIZE);
>> =C2=A0@@ -2547,7 +2584,7 @@ static void ram_save_cleanup(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory_global_dirty_log_stop();
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(blo=
ck->bmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->bma=
p =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(blo=
ck->unsentmap);
>> =C2=A0@@ -2610,7 +2647,7 @@ void ram_postcopy_migrated_memory_release(=
MigrationState *ms)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct RAMBlock *block;
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned l=
ong *bitmap =3D block->bmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned l=
ong range =3D block->used_length >> TARGET_PAGE_BITS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned l=
ong run_start =3D find_next_zero_bit(bitmap, range, 0);
>> =C2=A0@@ -2688,7 +2725,7 @@ static int postcopy_each_ram_send_discard(=
MigrationState *ms)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct RAMBlock *block;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PostcopyDi=
scardState *pds =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0postcopy_discard_send_init(ms, block->idstr);
>>
>> =C2=A0@@ -2896,7 +2933,7 @@ int ram_postcopy_send_discard_bitmap(Migra=
tionState *ms)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rs->last_sent_block =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rs->last_page =3D 0;
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned l=
ong pages =3D block->used_length >> TARGET_PAGE_BITS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned l=
ong *bitmap =3D block->bmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned l=
ong *unsentmap =3D block->unsentmap;
>> =C2=A0@@ -3062,7 +3099,7 @@ static void ram_list_init_bitmaps(void)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Skip setting bitmap if there is=
 no RAM */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ram_bytes_total()) {
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0pages =3D block->max_length >> TARGET_PAGE_BITS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0block->bmap =3D bitmap_new(pages);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0bitmap_set(block->bmap, 0, pages);
>> =C2=A0@@ -3117,7 +3154,7 @@ static void ram_state_resume_prepare(RAMSt=
ate *rs, QEMUFile *out)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* about dirty page logging a=
s well.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pages +=3D=
 bitmap_count_one(block->bmap,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bloc=
k->used_length >> TARGET_PAGE_BITS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -3176,7 +3213,7 @@ static int ram_save_setup(QEMUFile *f, voi=
d *opaque)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>>
>> =C2=A0- qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
>> =C2=A0+ qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_=
MEM_SIZE);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBLOCK_FOREACH_MIGRATABLE(block)=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_put_b=
yte(f, strlen(block->idstr));
>> =C2=A0@@ -3185,6 +3222,10 @@ static int ram_save_setup(QEMUFile *f, vo=
id *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (migrat=
e_postcopy_ram() && block->page_size !=3D qemu_host_page_size) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0qemu_put_be64(f, block->page_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0+ if (migrate_ignore_shared()) {
>> =C2=A0+ qemu_put_be64(f, block->mr->addr);
>> =C2=A0+ qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
>> =C2=A0+ }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> =C2=A0@@ -3443,7 +3484,7 @@ static inline RAMBlock *ram_block_from_str=
eam(QEMUFile *f, int flags)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NUL=
L;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0- if (!qemu_ram_is_migratable(block)) {
>> =C2=A0+ if (ramblock_is_ignored(block)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_repo=
rt("block %s should not be migrated !", id);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NUL=
L;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -3698,7 +3739,7 @@ int colo_init_ram_cache(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBlock *block;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->col=
o_cache =3D qemu_anon_ram_alloc(block->used_length,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0NULL,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0false);
>> =C2=A0@@ -3719,7 +3760,7 @@ int colo_init_ram_cache(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ram_bytes_total()) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBlock *=
block;
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0unsigned long pages =3D block->max_length >> TARGET_PAGE_BITS=
;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0block->bmap =3D bitmap_new(pages);
>> =C2=A0@@ -3734,7 +3775,7 @@ int colo_init_ram_cache(void)
>>
>> =C2=A0=C2=A0out_locked:
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (block-=
>colo_cache) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0qemu_anon_ram_free(block->colo_cache, block->used_length);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0block->colo_cache =3D NULL;
>> =C2=A0@@ -3751,14 +3792,14 @@ void colo_release_ram_cache(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBlock *block;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory_global_dirty_log_stop();
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(blo=
ck->bmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->bma=
p =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (block-=
>colo_cache) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0qemu_anon_ram_free(block->colo_cache, block->used_length);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0block->colo_cache =3D NULL;
>> =C2=A0@@ -3794,7 +3835,7 @@ static int ram_load_cleanup(void *opaque)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBlock *rb;
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(rb) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ramblo=
ck_is_pmem(rb)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0pmem_persist(rb->host, rb->used_length);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -3803,7 +3844,7 @@ static int ram_load_cleanup(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xbzrle_load_cleanup();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compress_threads_load_cleanup();
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(rb) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(rb-=
>receivedmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rb->receiv=
edmap =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -4003,7 +4044,7 @@ static void colo_flush_ram_cache(void)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory_global_dirty_log_sync();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration_=
bitmap_sync_range(ram_state, block, 0, block->used_length);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> =C2=A0@@ -4146,6 +4187,23 @@ static int ram_load(QEMUFile *f, void *op=
aque, int version_id)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0+ if (migrate_ignore_shared()) {
>> =C2=A0+ hwaddr addr =3D qemu_get_be64(f);
>> =C2=A0+ bool ignored =3D qemu_get_byte(f);
>> =C2=A0+ if (ignored !=3D ramblock_is_ignored(block)) {
>> =C2=A0+ error_report("RAM block %s should %s be migrated",
>> =C2=A0+ id, ignored ? "" : "not");
>> =C2=A0+ ret =3D -EINVAL;
>> =C2=A0+ }
>> =C2=A0+ if (ramblock_is_ignored(block) &&
>> =C2=A0+ block->mr->addr !=3D addr) {
>> =C2=A0+ error_report("Mismatched GPAs for block %s "
>> =C2=A0+ "%" PRId64 "!=3D %" PRId64,
>> =C2=A0+ id, (uint64_t)addr,
>> =C2=A0+ (uint64_t)block->mr->addr);
>> =C2=A0+ ret =3D -EINVAL;
>> =C2=A0+ }
>> =C2=A0+ }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ram_control_l=
oad_hook(f, RAM_CONTROL_BLOCK_REG,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->idstr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> =C2=A0@@ -4216,7 +4274,7 @@ static int ram_load(QEMUFile *f, void *opa=
que, int version_id)
>> =C2=A0=C2=A0static bool ram_has_postcopy(void *opaque)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAMBlock *rb;
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(rb) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ramblo=
ck_is_pmem(rb)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0info_report("Block: %s, host: %p is a nvdimm memory, postcopy=
"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0"is not supported now!", rb->idstr, rb->host);
>> =C2=A0@@ -4236,7 +4294,7 @@ static int ram_dirty_bitmap_sync_all(Migra=
tionState *s, RAMState *rs)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_ram_dirty_bitmap_sync_start(=
);
>>
>> =C2=A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> =C2=A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_savev=
m_send_recv_bitmap(file, block->idstr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_ram_=
dirty_bitmap_request(block->idstr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ramblock_c=
ount++;
>> =C2=A0diff --git a/migration/rdma.c b/migration/rdma.c
>> =C2=A0index 7eb38ee764..3cb579cc99 100644
>> =C2=A0--- a/migration/rdma.c
>> =C2=A0+++ b/migration/rdma.c
>> =C2=A0@@ -644,7 +644,7 @@ static int qemu_rdma_init_ram_blocks(RDMACon=
text *rdma)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assert(rdma->blockmap =3D=3D NULL)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(local, 0, sizeof *local);
>> =C2=A0- qemu_ram_foreach_migratable_block(qemu_rdma_init_one_block, rd=
ma);
>> =C2=A0+ foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_qemu_rdma_init_ram_blocks(lo=
cal->nb_blocks);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rdma->dest_blocks =3D g_new0(RDMAD=
estBlock,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rdma->local_ram_blocks=
.nb_blocks);
>> =C2=A0diff --git a/qapi/migration.json b/qapi/migration.json
>> =C2=A0index 7a795ecc16..7105570cd3 100644
>> =C2=A0--- a/qapi/migration.json
>> =C2=A0+++ b/qapi/migration.json
>> =C2=A0@@ -409,13 +409,16 @@
>> =C2=A0=C2=A0# devices (and thus take locks) immediately at the end of =
migration.
>> =C2=A0=C2=A0# (since 3.0)
>> =C2=A0=C2=A0#
>> =C2=A0+# @x-ignore-shared: If enabled, QEMU will not migrate shared me=
mory (since 4.0)
>> =C2=A0+#
>> =C2=A0=C2=A0# Since: 1.2
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0{ 'enum': 'MigrationCapability',
>> =C2=A0=C2=A0=C2=A0=C2=A0'data': ['xbzrle', 'rdma-pin-all', 'auto-conve=
rge', 'zero-blocks',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0'block', 'return-path', 'pause-before-switchover', 'x-multifd',
>> =C2=A0- 'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate' ]=
 }
>> =C2=A0+ 'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>> =C2=A0+ 'x-ignore-shared' ] }
>>
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0# @MigrationCapabilityStatus:
>> =C2=A0diff --git a/stubs/ram-block.c b/stubs/ram-block.c
>> =C2=A0index cfa5d8678f..73c0a3ee08 100644
>> =C2=A0--- a/stubs/ram-block.c
>> =C2=A0+++ b/stubs/ram-block.c
>> =C2=A0@@ -2,6 +2,21 @@
>> =C2=A0=C2=A0#include "exec/ramlist.h"
>> =C2=A0=C2=A0#include "exec/cpu-common.h"
>>
>> =C2=A0+void *qemu_ram_get_host_addr(RAMBlock *rb)
>> =C2=A0+{
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
>> =C2=A0+{
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
>> =C2=A0+{
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0void ram_block_notifier_add(RAMBlockNotifier *n)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0}
>> =C2=A0--
>> =C2=A02.20.1
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury
