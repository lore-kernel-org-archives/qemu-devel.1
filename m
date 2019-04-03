Received: from eggs.gnu.org ([209.51.188.92]:42606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBbQG-0001XT-AU
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBbQD-00077U-26
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:39:03 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:56988)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBbQB-00074X-JB
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:39:00 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Wed,  3 Apr 2019 11:38:41 +0300
Message-Id: <20190403083841.830-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: fix migration shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, qemu-devel@nongnu.org

It fixes heap-use-after-free which was found by clang's ASAN.

Control flow of this use-after-free:
main_thread:
    * Got SIGTERM and completes main loop
    * Calls migration_shutdown
      - migrate_fd_cancel (so, migration_thread begins to complete)
      - object_unref(OBJECT(current_migration));

migration_thread:
    * migration_iteration_finish -> schedule cleanup bh
    * object_unref(OBJECT(s)); (Now, current_migration is freed)
    * exits

main_thread:
    * Calls vm_shutdown -> drain bdrvs -> main loop
      -> cleanup_bh -> use after free

If you want to reproduce, these couple of sleeps will help:
vl.c:4613:
     migration_shutdown();
+    sleep(2);
migration.c:3269:
+    sleep(1);
     trace_migration_thread_after_loop();
     migration_iteration_finish(s);

Original output:
qemu-system-x86_64: terminating on signal 15 from pid 31980 (<unknown pro=
cess>)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31958=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x61900001d210
  at pc 0x555558a535ca bp 0x7fffffffb190 sp 0x7fffffffb188
READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
    #0 0x555558a535c9 in migrate_fd_cleanup migration/migration.c:1502:23
    #1 0x5555594fde0a in aio_bh_call util/async.c:90:5
    #2 0x5555594fe522 in aio_bh_poll util/async.c:118:13
    #3 0x555559524783 in aio_poll util/aio-posix.c:725:17
    #4 0x555559504fb3 in aio_wait_bh_oneshot util/aio-wait.c:71:5
    #5 0x5555573bddf6 in virtio_blk_data_plane_stop
      hw/block/dataplane/virtio-blk.c:282:5
    #6 0x5555589d5c09 in virtio_bus_stop_ioeventfd hw/virtio/virtio-bus.c=
:246:9
    #7 0x5555589e9917 in virtio_pci_stop_ioeventfd hw/virtio/virtio-pci.c=
:287:5
    #8 0x5555589e22bf in virtio_pci_vmstate_change hw/virtio/virtio-pci.c=
:1072:9
    #9 0x555557628931 in virtio_vmstate_change hw/virtio/virtio.c:2257:9
    #10 0x555557c36713 in vm_state_notify vl.c:1605:9
    #11 0x55555716ef53 in do_vm_stop cpus.c:1074:9
    #12 0x55555716eeff in vm_shutdown cpus.c:1092:12
    #13 0x555557c4283e in main vl.c:4617:5
    #14 0x7fffdfdb482f in __libc_start_main
      (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
    #15 0x555556ecb118 in _start (x86_64-softmmu/qemu-system-x86_64+0x197=
7118)

0x61900001d210 is located 144 bytes inside of 952-byte region
  [0x61900001d180,0x61900001d538)
freed by thread T6 (live_migration) here:
    #0 0x555556f76782 in __interceptor_free
      /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_malloc_linux=
.cc:124:3
    #1 0x555558d5fa94 in object_finalize qom/object.c:618:9
    #2 0x555558d57651 in object_unref qom/object.c:1068:9
    #3 0x555558a55588 in migration_thread migration/migration.c:3272:5
    #4 0x5555595393f2 in qemu_thread_start util/qemu-thread-posix.c:502:9
    #5 0x7fffe057f6b9 in start_thread (/lib/x86_64-linux-gnu/libpthread.s=
o.0+0x76b9)

previously allocated by thread T0 (qemu-vm-0) here:
    #0 0x555556f76b03 in __interceptor_malloc
      /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_malloc_linux=
.cc:146:3
    #1 0x7ffff6ee37b8 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0=
+0x4f7b8)
    #2 0x555558d58031 in object_new qom/object.c:640:12
    #3 0x555558a31f21 in migration_object_init migration/migration.c:139:=
25
    #4 0x555557c41398 in main vl.c:4320:5
    #5 0x7fffdfdb482f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so=
.6+0x2082f)

Thread T6 (live_migration) created by T0 (qemu-vm-0) here:
    #0 0x555556f5f0dd in pthread_create
      /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors=
.cc:210:3
    #1 0x555559538cf9 in qemu_thread_create util/qemu-thread-posix.c:539:=
11
    #2 0x555558a53304 in migrate_fd_connect migration/migration.c:3332:5
    #3 0x555558a72bd8 in migration_channel_connect migration/channel.c:92=
:5
    #4 0x555558a6ef87 in exec_start_outgoing_migration migration/exec.c:4=
2:5
    #5 0x555558a4f3c2 in qmp_migrate migration/migration.c:1922:9
    #6 0x555558bb4f6a in qmp_marshal_migrate qapi/qapi-commands-migration=
.c:607:5
    #7 0x555559363738 in do_qmp_dispatch qapi/qmp-dispatch.c:131:5
    #8 0x555559362a15 in qmp_dispatch qapi/qmp-dispatch.c:174:11
    #9 0x5555571bac15 in monitor_qmp_dispatch monitor.c:4124:11
    #10 0x55555719a22d in monitor_qmp_bh_dispatcher monitor.c:4207:9
    #11 0x5555594fde0a in aio_bh_call util/async.c:90:5
    #12 0x5555594fe522 in aio_bh_poll util/async.c:118:13
    #13 0x5555595201e0 in aio_dispatch util/aio-posix.c:460:5
    #14 0x555559503553 in aio_ctx_dispatch util/async.c:261:5
    #15 0x7ffff6ede196 in g_main_context_dispatch
      (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4a196)

SUMMARY: AddressSanitizer: heap-use-after-free migration/migration.c:1502=
:23
  in migrate_fd_cleanup
Shadow bytes around the buggy address:
  0x0c327fffb9f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c327fffba00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c327fffba10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c327fffba20: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c327fffba30: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
=3D>0x0c327fffba40: fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba50: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba60: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba70: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba80: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba90: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
=3D=3D31958=3D=3DABORTING

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/migration.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 609e0df5d0..54d82bb88b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -128,6 +128,8 @@ static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
+static void migrate_join_thread(MigrationState *s);
+static void migrate_fd_cleanup(void *opaque);
=20
 void migration_object_init(void)
 {
@@ -176,6 +178,17 @@ void migration_shutdown(void)
      * stop the migration using this structure
      */
     migrate_fd_cancel(current_migration);
+    /*
+     * migration_thread schedules cleanup_bh, but migration_shutdown is =
called
+     * from the end of main, so cleanu_up may not be called because main=
-loop is
+     * complete. So, wait for the complition of migration_thread, cancel=
 bh and
+     * call cleanup ourselves.
+     */
+    migrate_join_thread(current_migration);
+    if (current_migration->cleanup_bh) {
+        qemu_bh_cancel(current_migration->cleanup_bh);
+        migrate_fd_cleanup(current_migration);
+    }
     object_unref(OBJECT(current_migration));
 }
=20
@@ -1495,6 +1508,16 @@ static void block_cleanup_parameters(MigrationStat=
e *s)
     }
 }
=20
+static void migrate_join_thread(MigrationState *s)
+{
+    qemu_mutex_unlock_iothread();
+    if (s->migration_thread_running) {
+        qemu_thread_join(&s->thread);
+        s->migration_thread_running =3D false;
+    }
+    qemu_mutex_lock_iothread();
+}
+
 static void migrate_fd_cleanup(void *opaque)
 {
     MigrationState *s =3D opaque;
@@ -1508,12 +1531,7 @@ static void migrate_fd_cleanup(void *opaque)
         QEMUFile *tmp;
=20
         trace_migrate_fd_cleanup();
-        qemu_mutex_unlock_iothread();
-        if (s->migration_thread_running) {
-            qemu_thread_join(&s->thread);
-            s->migration_thread_running =3D false;
-        }
-        qemu_mutex_lock_iothread();
+        migrate_join_thread(s);
=20
         multifd_save_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
--=20
2.21.0
