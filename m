Received: from eggs.gnu.org ([209.51.188.92]:36100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtDvQ-0007Ti-VU
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtDvO-0006U0-KT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:55:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gtDvM-0006S3-UF
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:55:13 -0500
Date: Mon, 11 Feb 2019 15:55:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190211155503.GJ2627@work-vm>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
	<20190204130958.18904-3-yury-kotov@yandex-team.ru>
	<20190211124519.GD2627@work-vm>
	<2095681549892187@sas1-bf4ab558af9f.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2095681549892187@sas1-bf4ab558af9f.qloud-c.yandex.net>
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
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> 11.02.2019, 15:45, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A0We want to use local migration to update QEMU for running guests.
> >> =A0In this case we don't need to migrate shared (file backed) RAM.
> >> =A0So, add a capability to ignore such blocks during live migration.
> >>
> >> =A0Also, move qemu_ram_foreach_migratable_block (and rename) to the
> >> =A0migration code, because it requires access to the migration capab=
ilities.
> >>
> >> =A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> >
> > You could split this patch into the one that introduces the capabilit=
y
> > and then the one that wires it up. We could also remove the x- at som=
e
> > point.
>=20
> I.e. the patch that just adds the capability to json (and migrate_use_*=
), but
> nothing more, and the second one which actually realize the capability?

Right.

Dave

> Like this:
> 2a4c42f18c migration: add postcopy blocktime ctx into MigrationIncoming=
State
> f22f928ec9 migration: introduce postcopy-blocktime capability
> ?
>=20
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> >> =A0---
> >> =A0=A0exec.c | 19 -------
> >> =A0=A0include/exec/cpu-common.h | 1 -
> >> =A0=A0migration/migration.c | 9 ++++
> >> =A0=A0migration/migration.h | 5 +-
> >> =A0=A0migration/postcopy-ram.c | 12 ++---
> >> =A0=A0migration/ram.c | 110 +++++++++++++++++++++++++++++---------
> >> =A0=A0migration/rdma.c | 2 +-
> >> =A0=A0qapi/migration.json | 5 +-
> >> =A0=A0stubs/ram-block.c | 15 ++++++
> >> =A0=A09 files changed, 123 insertions(+), 55 deletions(-)
> >>
> >> =A0diff --git a/exec.c b/exec.c
> >> =A0index a61d501568..91bfe5fb62 100644
> >> =A0--- a/exec.c
> >> =A0+++ b/exec.c
> >> =A0@@ -3984,25 +3984,6 @@ int qemu_ram_foreach_block(RAMBlockIterFun=
c func, void *opaque)
> >> =A0=A0=A0=A0=A0=A0return ret;
> >> =A0=A0}
> >>
> >> =A0-int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, voi=
d *opaque)
> >> =A0-{
> >> =A0- RAMBlock *block;
> >> =A0- int ret =3D 0;
> >> =A0-
> >> =A0- rcu_read_lock();
> >> =A0- RAMBLOCK_FOREACH(block) {
> >> =A0- if (!qemu_ram_is_migratable(block)) {
> >> =A0- continue;
> >> =A0- }
> >> =A0- ret =3D func(block, opaque);
> >> =A0- if (ret) {
> >> =A0- break;
> >> =A0- }
> >> =A0- }
> >> =A0- rcu_read_unlock();
> >> =A0- return ret;
> >> =A0-}
> >> =A0-
> >> =A0=A0/*
> >> =A0=A0=A0* Unmap pages of memory from start to start+length such tha=
t
> >> =A0=A0=A0* they a) read as 0, b) Trigger whatever fault mechanism
> >> =A0diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.=
h
> >> =A0index bdae5446d7..403463d7bb 100644
> >> =A0--- a/include/exec/cpu-common.h
> >> =A0+++ b/include/exec/cpu-common.h
> >> =A0@@ -122,7 +122,6 @@ extern struct MemoryRegion io_mem_notdirty;
> >> =A0=A0typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
> >>
> >> =A0=A0int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque=
);
> >> =A0-int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, voi=
d *opaque);
> >> =A0=A0int ram_block_discard_range(RAMBlock *rb, uint64_t start, size=
_t length);
> >>
> >> =A0=A0#endif
> >> =A0diff --git a/migration/migration.c b/migration/migration.c
> >> =A0index 37e06b76dc..c40776a40c 100644
> >> =A0--- a/migration/migration.c
> >> =A0+++ b/migration/migration.c
> >> =A0@@ -1983,6 +1983,15 @@ bool migrate_dirty_bitmaps(void)
> >> =A0=A0=A0=A0=A0=A0return s->enabled_capabilities[MIGRATION_CAPABILIT=
Y_DIRTY_BITMAPS];
> >> =A0=A0}
> >>
> >> =A0+bool migrate_ignore_shared(void)
> >> =A0+{
> >> =A0+ MigrationState *s;
> >> =A0+
> >> =A0+ s =3D migrate_get_current();
> >> =A0+
> >> =A0+ return s->enabled_capabilities[MIGRATION_CAPABILITY_X_IGNORE_SH=
ARED];
> >> =A0+}
> >> =A0+
> >> =A0=A0bool migrate_use_events(void)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0MigrationState *s;
> >> =A0diff --git a/migration/migration.h b/migration/migration.h
> >> =A0index dcd05d9f87..2c88f8a555 100644
> >> =A0--- a/migration/migration.h
> >> =A0+++ b/migration/migration.h
> >> =A0@@ -261,6 +261,7 @@ bool migrate_release_ram(void);
> >> =A0=A0bool migrate_postcopy_ram(void);
> >> =A0=A0bool migrate_zero_blocks(void);
> >> =A0=A0bool migrate_dirty_bitmaps(void);
> >> =A0+bool migrate_ignore_shared(void);
> >>
> >> =A0=A0bool migrate_auto_converge(void);
> >> =A0=A0bool migrate_use_multifd(void);
> >> =A0@@ -301,8 +302,10 @@ void migrate_send_rp_resume_ack(MigrationInc=
omingState *mis, uint32_t value);
> >> =A0=A0void dirty_bitmap_mig_before_vm_start(void);
> >> =A0=A0void init_dirty_bitmap_incoming_migration(void);
> >>
> >> =A0+int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaqu=
e);
> >> =A0+
> >> =A0=A0#define qemu_ram_foreach_block \
> >> =A0- #warning "Use qemu_ram_foreach_block_migratable in migration co=
de"
> >> =A0+ #warning "Use foreach_not_ignored_block in migration code"
> >>
> >> =A0=A0void migration_make_urgent_request(void);
> >> =A0=A0void migration_consume_urgent_request(void);
> >> =A0diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> >> =A0index b098816221..e2aa57a701 100644
> >> =A0--- a/migration/postcopy-ram.c
> >> =A0+++ b/migration/postcopy-ram.c
> >> =A0@@ -374,7 +374,7 @@ bool postcopy_ram_supported_by_host(Migration=
IncomingState *mis)
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0=A0=A0=A0=A0=A0/* We don't support postcopy with shared RAM yet *=
/
> >> =A0- if (qemu_ram_foreach_migratable_block(test_ramblock_postcopiabl=
e, NULL)) {
> >> =A0+ if (foreach_not_ignored_block(test_ramblock_postcopiable, NULL)=
) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0@@ -508,7 +508,7 @@ static int cleanup_range(RAMBlock *rb, void *=
opaque)
> >> =A0=A0=A0*/
> >> =A0=A0int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> >> =A0=A0{
> >> =A0- if (qemu_ram_foreach_migratable_block(init_range, NULL)) {
> >> =A0+ if (foreach_not_ignored_block(init_range, NULL)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0@@ -550,7 +550,7 @@ int postcopy_ram_incoming_cleanup(MigrationIn=
comingState *mis)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >>
> >> =A0- if (qemu_ram_foreach_migratable_block(cleanup_range, mis)) {
> >> =A0+ if (foreach_not_ignored_block(cleanup_range, mis)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >>
> >> =A0@@ -617,7 +617,7 @@ static int nhp_range(RAMBlock *rb, void *opaq=
ue)
> >> =A0=A0=A0*/
> >> =A0=A0int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
> >> =A0=A0{
> >> =A0- if (qemu_ram_foreach_migratable_block(nhp_range, mis)) {
> >> =A0+ if (foreach_not_ignored_block(nhp_range, mis)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0@@ -628,7 +628,7 @@ int postcopy_ram_prepare_discard(MigrationInc=
omingState *mis)
> >>
> >> =A0=A0/*
> >> =A0=A0=A0* Mark the given area of RAM as requiring notification to u=
nwritten areas
> >> =A0- * Used as a callback on qemu_ram_foreach_migratable_block.
> >> =A0+ * Used as a callback on foreach_not_ignored_block.
> >> =A0=A0=A0* host_addr: Base of area to mark
> >> =A0=A0=A0* offset: Offset in the whole ram arena
> >> =A0=A0=A0* length: Length of the section
> >> =A0@@ -1122,7 +1122,7 @@ int postcopy_ram_enable_notify(MigrationInc=
omingState *mis)
> >> =A0=A0=A0=A0=A0=A0mis->have_fault_thread =3D true;
> >>
> >> =A0=A0=A0=A0=A0=A0/* Mark so that we get notified of accesses to unw=
ritten areas */
> >> =A0- if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, =
mis)) {
> >> =A0+ if (foreach_not_ignored_block(ram_block_enable_notify, mis)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_report("ram_block_enable_notify =
failed");
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0diff --git a/migration/ram.c b/migration/ram.c
> >> =A0index 59191c1ed2..01315edd66 100644
> >> =A0--- a/migration/ram.c
> >> =A0+++ b/migration/ram.c
> >> =A0@@ -159,18 +159,44 @@ out:
> >> =A0=A0=A0=A0=A0=A0return ret;
> >> =A0=A0}
> >>
> >> =A0+static bool ramblock_is_ignored(RAMBlock *block)
> >> =A0+{
> >> =A0+ return !qemu_ram_is_migratable(block) ||
> >> =A0+ (migrate_ignore_shared() && qemu_ram_is_shared(block));
> >> =A0+}
> >> =A0+
> >> =A0=A0/* Should be holding either ram_list.mutex, or the RCU lock. *=
/
> >> =A0+#define RAMBLOCK_FOREACH_NOT_IGNORED(block) \
> >> =A0+ INTERNAL_RAMBLOCK_FOREACH(block) \
> >> =A0+ if (ramblock_is_ignored(block)) {} else
> >> =A0+
> >> =A0=A0#define RAMBLOCK_FOREACH_MIGRATABLE(block) \
> >> =A0=A0=A0=A0=A0=A0INTERNAL_RAMBLOCK_FOREACH(block) \
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!qemu_ram_is_migratable(block)) {}=
 else
> >>
> >> =A0=A0#undef RAMBLOCK_FOREACH
> >>
> >> =A0+int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaqu=
e)
> >> =A0+{
> >> =A0+ RAMBlock *block;
> >> =A0+ int ret =3D 0;
> >> =A0+
> >> =A0+ rcu_read_lock();
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0+ ret =3D func(block, opaque);
> >> =A0+ if (ret) {
> >> =A0+ break;
> >> =A0+ }
> >> =A0+ }
> >> =A0+ rcu_read_unlock();
> >> =A0+ return ret;
> >> =A0+}
> >> =A0+
> >> =A0=A0static void ramblock_recv_map_init(void)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0RAMBlock *rb;
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(rb) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0assert(!rb->receivedmap);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rb->receivedmap =3D bitmap_new(rb->max=
_length >> qemu_target_page_bits());
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0@@ -1545,7 +1571,7 @@ unsigned long migration_bitmap_find_dirty(R=
AMState *rs, RAMBlock *rb,
> >> =A0=A0=A0=A0=A0=A0unsigned long *bitmap =3D rb->bmap;
> >> =A0=A0=A0=A0=A0=A0unsigned long next;
> >>
> >> =A0- if (!qemu_ram_is_migratable(rb)) {
> >> =A0+ if (ramblock_is_ignored(rb)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return size;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0@@ -1594,7 +1620,7 @@ uint64_t ram_pagesize_summary(void)
> >> =A0=A0=A0=A0=A0=A0RAMBlock *block;
> >> =A0=A0=A0=A0=A0=A0uint64_t summary =3D 0;
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0summary |=3D block->page_size;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0@@ -1664,7 +1690,7 @@ static void migration_bitmap_sync(RAMState =
*rs)
> >>
> >> =A0=A0=A0=A0=A0=A0qemu_mutex_lock(&rs->bitmap_mutex);
> >> =A0=A0=A0=A0=A0=A0rcu_read_lock();
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0migration_bitmap_sync_range(rs, block,=
 0, block->used_length);
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0ram_counters.remaining =3D ram_bytes_remaining();
> >> =A0@@ -2388,7 +2414,7 @@ static int ram_save_host_page(RAMState *rs,=
 PageSearchStatus *pss,
> >> =A0=A0=A0=A0=A0=A0size_t pagesize_bits =3D
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_ram_pagesize(pss->block) >> TARGE=
T_PAGE_BITS;
> >>
> >> =A0- if (!qemu_ram_is_migratable(pss->block)) {
> >> =A0+ if (ramblock_is_ignored(pss->block)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_report("block %s should not be m=
igrated !", pss->block->idstr);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0@@ -2486,19 +2512,30 @@ void acct_update_position(QEMUFile *f, si=
ze_t size, bool zero)
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0}
> >>
> >> =A0-uint64_t ram_bytes_total(void)
> >> =A0+static uint64_t ram_bytes_total_common(bool count_ignored)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0RAMBlock *block;
> >> =A0=A0=A0=A0=A0=A0uint64_t total =3D 0;
> >>
> >> =A0=A0=A0=A0=A0=A0rcu_read_lock();
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0- total +=3D block->used_length;
> >> =A0+ if (count_ignored) {
> >> =A0+ RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ total +=3D block->used_length;
> >> =A0+ }
> >> =A0+ } else {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0+ total +=3D block->used_length;
> >> =A0+ }
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0rcu_read_unlock();
> >> =A0=A0=A0=A0=A0=A0return total;
> >> =A0=A0}
> >>
> >> =A0+uint64_t ram_bytes_total(void)
> >> =A0+{
> >> =A0+ return ram_bytes_total_common(false);
> >> =A0+}
> >> =A0+
> >> =A0=A0static void xbzrle_load_setup(void)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0XBZRLE.decoded_buf =3D g_malloc(TARGET_PAGE_SIZE);
> >> =A0@@ -2547,7 +2584,7 @@ static void ram_save_cleanup(void *opaque)
> >> =A0=A0=A0=A0=A0=A0=A0*/
> >> =A0=A0=A0=A0=A0=A0memory_global_dirty_log_stop();
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g_free(block->bmap);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->bmap =3D NULL;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g_free(block->unsentmap);
> >> =A0@@ -2610,7 +2647,7 @@ void ram_postcopy_migrated_memory_release(M=
igrationState *ms)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0struct RAMBlock *block;
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long *bitmap =3D block->bmap;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long range =3D block->used_le=
ngth >> TARGET_PAGE_BITS;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long run_start =3D find_next_=
zero_bit(bitmap, range, 0);
> >> =A0@@ -2688,7 +2725,7 @@ static int postcopy_each_ram_send_discard(M=
igrationState *ms)
> >> =A0=A0=A0=A0=A0=A0struct RAMBlock *block;
> >> =A0=A0=A0=A0=A0=A0int ret;
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0PostcopyDiscardState *pds =3D
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0postcopy_discard_send_init=
(ms, block->idstr);
> >>
> >> =A0@@ -2896,7 +2933,7 @@ int ram_postcopy_send_discard_bitmap(Migrat=
ionState *ms)
> >> =A0=A0=A0=A0=A0=A0rs->last_sent_block =3D NULL;
> >> =A0=A0=A0=A0=A0=A0rs->last_page =3D 0;
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long pages =3D block->used_le=
ngth >> TARGET_PAGE_BITS;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long *bitmap =3D block->bmap;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long *unsentmap =3D block->un=
sentmap;
> >> =A0@@ -3062,7 +3099,7 @@ static void ram_list_init_bitmaps(void)
> >>
> >> =A0=A0=A0=A0=A0=A0/* Skip setting bitmap if there is no RAM */
> >> =A0=A0=A0=A0=A0=A0if (ram_bytes_total()) {
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pages =3D block->max_lengt=
h >> TARGET_PAGE_BITS;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->bmap =3D bitmap_new=
(pages);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bitmap_set(block->bmap, 0,=
 pages);
> >> =A0@@ -3117,7 +3154,7 @@ static void ram_state_resume_prepare(RAMSta=
te *rs, QEMUFile *out)
> >> =A0=A0=A0=A0=A0=A0=A0* about dirty page logging as well.
> >> =A0=A0=A0=A0=A0=A0=A0*/
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pages +=3D bitmap_count_one(block->bma=
p,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->used_length >> TARGET_PAGE_=
BITS);
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0@@ -3176,7 +3213,7 @@ static int ram_save_setup(QEMUFile *f, void=
 *opaque)
> >>
> >> =A0=A0=A0=A0=A0=A0rcu_read_lock();
> >>
> >> =A0- qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
> >> =A0+ qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_M=
EM_SIZE);
> >>
> >> =A0=A0=A0=A0=A0=A0RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_put_byte(f, strlen(block->idstr))=
;
> >> =A0@@ -3185,6 +3222,10 @@ static int ram_save_setup(QEMUFile *f, voi=
d *opaque)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (migrate_postcopy_ram() && block->p=
age_size !=3D qemu_host_page_size) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_put_be64(f, block->pa=
ge_size);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0+ if (migrate_ignore_shared()) {
> >> =A0+ qemu_put_be64(f, block->mr->addr);
> >> =A0+ qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
> >> =A0+ }
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0=A0=A0=A0=A0=A0rcu_read_unlock();
> >> =A0@@ -3443,7 +3484,7 @@ static inline RAMBlock *ram_block_from_stre=
am(QEMUFile *f, int flags)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0- if (!qemu_ram_is_migratable(block)) {
> >> =A0+ if (ramblock_is_ignored(block)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_report("block %s should not be m=
igrated !", id);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0@@ -3698,7 +3739,7 @@ int colo_init_ram_cache(void)
> >> =A0=A0=A0=A0=A0=A0RAMBlock *block;
> >>
> >> =A0=A0=A0=A0=A0=A0rcu_read_lock();
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->colo_cache =3D qemu_anon_ram_al=
loc(block->used_length,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0NULL,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0false);
> >> =A0@@ -3719,7 +3760,7 @@ int colo_init_ram_cache(void)
> >> =A0=A0=A0=A0=A0=A0if (ram_bytes_total()) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0RAMBlock *block;
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long pages =3D bl=
ock->max_length >> TARGET_PAGE_BITS;
> >>
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->bmap =3D bitmap_new=
(pages);
> >> =A0@@ -3734,7 +3775,7 @@ int colo_init_ram_cache(void)
> >>
> >> =A0=A0out_locked:
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (block->colo_cache) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_anon_ram_free(block->=
colo_cache, block->used_length);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->colo_cache =3D NULL=
;
> >> =A0@@ -3751,14 +3792,14 @@ void colo_release_ram_cache(void)
> >> =A0=A0=A0=A0=A0=A0RAMBlock *block;
> >>
> >> =A0=A0=A0=A0=A0=A0memory_global_dirty_log_stop();
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g_free(block->bmap);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->bmap =3D NULL;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0=A0=A0=A0=A0=A0rcu_read_lock();
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (block->colo_cache) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_anon_ram_free(block->=
colo_cache, block->used_length);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->colo_cache =3D NULL=
;
> >> =A0@@ -3794,7 +3835,7 @@ static int ram_load_cleanup(void *opaque)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0RAMBlock *rb;
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(rb) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ramblock_is_pmem(rb)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pmem_persist(rb->host, rb-=
>used_length);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0@@ -3803,7 +3844,7 @@ static int ram_load_cleanup(void *opaque)
> >> =A0=A0=A0=A0=A0=A0xbzrle_load_cleanup();
> >> =A0=A0=A0=A0=A0=A0compress_threads_load_cleanup();
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(rb) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g_free(rb->receivedmap);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rb->receivedmap =3D NULL;
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0@@ -4003,7 +4044,7 @@ static void colo_flush_ram_cache(void)
> >>
> >> =A0=A0=A0=A0=A0=A0memory_global_dirty_log_sync();
> >> =A0=A0=A0=A0=A0=A0rcu_read_lock();
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0migration_bitmap_sync_range(ram_state,=
 block, 0, block->used_length);
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0rcu_read_unlock();
> >> =A0@@ -4146,6 +4187,23 @@ static int ram_load(QEMUFile *f, void *opa=
que, int version_id)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0ret =3D -EINVAL;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0+ if (migrate_ignore_shared()) {
> >> =A0+ hwaddr addr =3D qemu_get_be64(f);
> >> =A0+ bool ignored =3D qemu_get_byte(f);
> >> =A0+ if (ignored !=3D ramblock_is_ignored(block)) {
> >> =A0+ error_report("RAM block %s should %s be migrated",
> >> =A0+ id, ignored ? "" : "not");
> >> =A0+ ret =3D -EINVAL;
> >> =A0+ }
> >> =A0+ if (ramblock_is_ignored(block) &&
> >> =A0+ block->mr->addr !=3D addr) {
> >> =A0+ error_report("Mismatched GPAs for block %s "
> >> =A0+ "%" PRId64 "!=3D %" PRId64,
> >> =A0+ id, (uint64_t)addr,
> >> =A0+ (uint64_t)block->mr->addr);
> >> =A0+ ret =3D -EINVAL;
> >> =A0+ }
> >> =A0+ }
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ra=
m_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->ids=
tr);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> >> =A0@@ -4216,7 +4274,7 @@ static int ram_load(QEMUFile *f, void *opaq=
ue, int version_id)
> >> =A0=A0static bool ram_has_postcopy(void *opaque)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0RAMBlock *rb;
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(rb) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ramblock_is_pmem(rb)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0info_report("Block: %s, ho=
st: %p is a nvdimm memory, postcopy"
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0"is not supported now!", rb->idstr, rb->host);
> >> =A0@@ -4236,7 +4294,7 @@ static int ram_dirty_bitmap_sync_all(Migrat=
ionState *s, RAMState *rs)
> >>
> >> =A0=A0=A0=A0=A0=A0trace_ram_dirty_bitmap_sync_start();
> >>
> >> =A0- RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> =A0+ RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_savevm_send_recv_bitmap(file, blo=
ck->idstr);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0trace_ram_dirty_bitmap_request(block->=
idstr);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ramblock_count++;
> >> =A0diff --git a/migration/rdma.c b/migration/rdma.c
> >> =A0index 7eb38ee764..3cb579cc99 100644
> >> =A0--- a/migration/rdma.c
> >> =A0+++ b/migration/rdma.c
> >> =A0@@ -644,7 +644,7 @@ static int qemu_rdma_init_ram_blocks(RDMACont=
ext *rdma)
> >>
> >> =A0=A0=A0=A0=A0=A0assert(rdma->blockmap =3D=3D NULL);
> >> =A0=A0=A0=A0=A0=A0memset(local, 0, sizeof *local);
> >> =A0- qemu_ram_foreach_migratable_block(qemu_rdma_init_one_block, rdm=
a);
> >> =A0+ foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
> >> =A0=A0=A0=A0=A0=A0trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
> >> =A0=A0=A0=A0=A0=A0rdma->dest_blocks =3D g_new0(RDMADestBlock,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rdma->local_ram_blocks.nb_blocks);
> >> =A0diff --git a/qapi/migration.json b/qapi/migration.json
> >> =A0index 7a795ecc16..7105570cd3 100644
> >> =A0--- a/qapi/migration.json
> >> =A0+++ b/qapi/migration.json
> >> =A0@@ -409,13 +409,16 @@
> >> =A0=A0# devices (and thus take locks) immediately at the end of migr=
ation.
> >> =A0=A0# (since 3.0)
> >> =A0=A0#
> >> =A0+# @x-ignore-shared: If enabled, QEMU will not migrate shared mem=
ory (since 4.0)
> >> =A0+#
> >> =A0=A0# Since: 1.2
> >> =A0=A0##
> >> =A0=A0{ 'enum': 'MigrationCapability',
> >> =A0=A0=A0=A0'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zer=
o-blocks',
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'compress', 'events', 'postco=
py-ram', 'x-colo', 'release-ram',
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'block', 'return-path', 'paus=
e-before-switchover', 'x-multifd',
> >> =A0- 'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate' ] =
}
> >> =A0+ 'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> >> =A0+ 'x-ignore-shared' ] }
> >>
> >> =A0=A0##
> >> =A0=A0# @MigrationCapabilityStatus:
> >> =A0diff --git a/stubs/ram-block.c b/stubs/ram-block.c
> >> =A0index cfa5d8678f..73c0a3ee08 100644
> >> =A0--- a/stubs/ram-block.c
> >> =A0+++ b/stubs/ram-block.c
> >> =A0@@ -2,6 +2,21 @@
> >> =A0=A0#include "exec/ramlist.h"
> >> =A0=A0#include "exec/cpu-common.h"
> >>
> >> =A0+void *qemu_ram_get_host_addr(RAMBlock *rb)
> >> =A0+{
> >> =A0+ return 0;
> >> =A0+}
> >> =A0+
> >> =A0+ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
> >> =A0+{
> >> =A0+ return 0;
> >> =A0+}
> >> =A0+
> >> =A0+ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
> >> =A0+{
> >> =A0+ return 0;
> >> =A0+}
> >> =A0+
> >> =A0=A0void ram_block_notifier_add(RAMBlockNotifier *n)
> >> =A0=A0{
> >> =A0=A0}
> >> =A0--
> >> =A02.20.1
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
> Regards,
> Yury
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
