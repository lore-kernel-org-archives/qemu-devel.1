Received: from eggs.gnu.org ([209.51.188.92]:54914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBxiv-0001xe-US
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBxU6-0003SJ-AK
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:12:32 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:49136)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBxU2-0003Fo-HL
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:12:30 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190403190503.GI2790@work-vm>
References: <20190403083841.830-1-yury-kotov@yandex-team.ru>
	<20190403190503.GI2790@work-vm>
MIME-Version: 1.0
Date: Thu, 04 Apr 2019 11:12:20 +0300
Message-Id: <48831554365540@vla1-9d3c37294942.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix migration shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, Juan Quintela <quintela@redhat.com>

03.04.2019, 22:06, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0It fixes heap-use-after-free which was found by clang's ASAN.
>>
>> =C2=A0Control flow of this use-after-free:
>> =C2=A0main_thread:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Got SIGTERM and completes main loop
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Calls migration_shutdown
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- migrate_fd_cancel (so, mig=
ration_thread begins to complete)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- object_unref(OBJECT(curren=
t_migration));
>>
>> =C2=A0migration_thread:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* migration_iteration_finish -> schedule=
 cleanup bh
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* object_unref(OBJECT(s)); (Now, current=
_migration is freed)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* exits
>>
>> =C2=A0main_thread:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Calls vm_shutdown -> drain bdrvs -> ma=
in loop
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> cleanup_bh -> use after f=
ree
>>
>> =C2=A0If you want to reproduce, these couple of sleeps will help:
>> =C2=A0vl.c:4613:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration_shutdown();
>> =C2=A0+ sleep(2);
>> =C2=A0migration.c:3269:
>> =C2=A0+ sleep(1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_migration_thread_after_loop(=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration_iteration_finish(s);
>
> Fun; I hadn't realised you could get more main loop after exiting
> the main loop.
>
> Is this fallout from my 892ae715b6b or is this just another case it
> didn't catch?
> I guess it moved the shutdown early, so it probably is fallout, and
> so probably does need to go to 4.0 ?
>
I think this is closer to another case than fallout. Because without
892ae715b6b, reproducing of UAF at exit was much easier.
Another way to fix it - remove unref from migration_shutdown
(but keep migrate_fd_cancel) and restore migration_object_finalize.

>> =C2=A0Original output:
>> =C2=A0qemu-system-x86_64: terminating on signal 15 from pid 31980 (<un=
known process>)
>> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0=3D=3D31958=3D=3DERROR: AddressSanitizer: heap-use-after-free on=
 address 0x61900001d210
>> =C2=A0=C2=A0=C2=A0at pc 0x555558a535ca bp 0x7fffffffb190 sp 0x7fffffff=
b188
>> =C2=A0READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#0 0x555558a535c9 in migrate_fd_cleanup =
migration/migration.c:1502:23
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#1 0x5555594fde0a in aio_bh_call util/as=
ync.c:90:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#2 0x5555594fe522 in aio_bh_poll util/as=
ync.c:118:13
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#3 0x555559524783 in aio_poll util/aio-p=
osix.c:725:17
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#4 0x555559504fb3 in aio_wait_bh_oneshot=
 util/aio-wait.c:71:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#5 0x5555573bddf6 in virtio_blk_data_pla=
ne_stop
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/block/dataplane/virtio-bl=
k.c:282:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#6 0x5555589d5c09 in virtio_bus_stop_ioe=
ventfd hw/virtio/virtio-bus.c:246:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#7 0x5555589e9917 in virtio_pci_stop_ioe=
ventfd hw/virtio/virtio-pci.c:287:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#8 0x5555589e22bf in virtio_pci_vmstate_=
change hw/virtio/virtio-pci.c:1072:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#9 0x555557628931 in virtio_vmstate_chan=
ge hw/virtio/virtio.c:2257:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#10 0x555557c36713 in vm_state_notify vl=
.c:1605:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#11 0x55555716ef53 in do_vm_stop cpus.c:=
1074:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#12 0x55555716eeff in vm_shutdown cpus.c=
:1092:12
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#13 0x555557c4283e in main vl.c:4617:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#14 0x7fffdfdb482f in __libc_start_main
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(/lib/x86_64-linux-gnu/libc.=
so.6+0x2082f)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#15 0x555556ecb118 in _start (x86_64-sof=
tmmu/qemu-system-x86_64+0x1977118)
>>
>> =C2=A00x61900001d210 is located 144 bytes inside of 952-byte region
>> =C2=A0=C2=A0=C2=A0[0x61900001d180,0x61900001d538)
>> =C2=A0freed by thread T6 (live_migration) here:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f76782 in __interceptor_free
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src/projects=
/compiler-rt/lib/asan/asan_malloc_linux.cc:124:3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#1 0x555558d5fa94 in object_finalize qom=
/object.c:618:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558d57651 in object_unref qom/ob=
ject.c:1068:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a55588 in migration_thread mi=
gration/migration.c:3272:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#4 0x5555595393f2 in qemu_thread_start u=
til/qemu-thread-posix.c:502:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#5 0x7fffe057f6b9 in start_thread (/lib/=
x86_64-linux-gnu/libpthread.so.0+0x76b9)
>>
>> =C2=A0previously allocated by thread T0 (qemu-vm-0) here:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f76b03 in __interceptor_mallo=
c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src/projects=
/compiler-rt/lib/asan/asan_malloc_linux.cc:146:3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#1 0x7ffff6ee37b8 in g_malloc (/lib/x86_=
64-linux-gnu/libglib-2.0.so.0+0x4f7b8)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558d58031 in object_new qom/obje=
ct.c:640:12
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a31f21 in migration_object_in=
it migration/migration.c:139:25
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#4 0x555557c41398 in main vl.c:4320:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#5 0x7fffdfdb482f in __libc_start_main (=
/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
>>
>> =C2=A0Thread T6 (live_migration) created by T0 (qemu-vm-0) here:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f5f0dd in pthread_create
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src/projects=
/compiler-rt/lib/asan/asan_interceptors.cc:210:3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#1 0x555559538cf9 in qemu_thread_create =
util/qemu-thread-posix.c:539:11
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558a53304 in migrate_fd_connect =
migration/migration.c:3332:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a72bd8 in migration_channel_c=
onnect migration/channel.c:92:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#4 0x555558a6ef87 in exec_start_outgoing=
_migration migration/exec.c:42:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#5 0x555558a4f3c2 in qmp_migrate migrati=
on/migration.c:1922:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#6 0x555558bb4f6a in qmp_marshal_migrate=
 qapi/qapi-commands-migration.c:607:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#7 0x555559363738 in do_qmp_dispatch qap=
i/qmp-dispatch.c:131:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#8 0x555559362a15 in qmp_dispatch qapi/q=
mp-dispatch.c:174:11
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#9 0x5555571bac15 in monitor_qmp_dispatc=
h monitor.c:4124:11
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#10 0x55555719a22d in monitor_qmp_bh_dis=
patcher monitor.c:4207:9
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#11 0x5555594fde0a in aio_bh_call util/a=
sync.c:90:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#12 0x5555594fe522 in aio_bh_poll util/a=
sync.c:118:13
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#13 0x5555595201e0 in aio_dispatch util/=
aio-posix.c:460:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#14 0x555559503553 in aio_ctx_dispatch u=
til/async.c:261:5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#15 0x7ffff6ede196 in g_main_context_dis=
patch
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(/lib/x86_64-linux-gnu/libgl=
ib-2.0.so.0+0x4a196)
>>
>> =C2=A0SUMMARY: AddressSanitizer: heap-use-after-free migration/migrati=
on.c:1502:23
>> =C2=A0=C2=A0=C2=A0in migrate_fd_cleanup
>> =C2=A0Shadow bytes around the buggy address:
>> =C2=A0=C2=A0=C2=A00x0c327fffb9f0: fa fa fa fa fa fa fa fa fa fa fa fa =
fa fa fa fa
>> =C2=A0=C2=A0=C2=A00x0c327fffba00: fa fa fa fa fa fa fa fa fa fa fa fa =
fa fa fa fa
>> =C2=A0=C2=A0=C2=A00x0c327fffba10: fa fa fa fa fa fa fa fa fa fa fa fa =
fa fa fa fa
>> =C2=A0=C2=A0=C2=A00x0c327fffba20: fa fa fa fa fa fa fa fa fa fa fa fa =
fa fa fa fa
>> =C2=A0=C2=A0=C2=A00x0c327fffba30: fd fd fd fd fd fd fd fd fd fd fd fd =
fd fd fd fd
>> =C2=A0=3D>0x0c327fffba40: fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd=
 fd
>> =C2=A0=C2=A0=C2=A00x0c327fffba50: fd fd fd fd fd fd fd fd fd fd fd fd =
fd fd fd fd
>> =C2=A0=C2=A0=C2=A00x0c327fffba60: fd fd fd fd fd fd fd fd fd fd fd fd =
fd fd fd fd
>> =C2=A0=C2=A0=C2=A00x0c327fffba70: fd fd fd fd fd fd fd fd fd fd fd fd =
fd fd fd fd
>> =C2=A0=C2=A0=C2=A00x0c327fffba80: fd fd fd fd fd fd fd fd fd fd fd fd =
fd fd fd fd
>> =C2=A0=C2=A0=C2=A00x0c327fffba90: fd fd fd fd fd fd fd fd fd fd fd fd =
fd fd fd fd
>> =C2=A0Shadow byte legend (one shadow byte represents 8 application byt=
es):
>> =C2=A0=C2=A0=C2=A0Addressable: 00
>> =C2=A0=C2=A0=C2=A0Partially addressable: 01 02 03 04 05 06 07
>> =C2=A0=C2=A0=C2=A0Heap left redzone: fa
>> =C2=A0=C2=A0=C2=A0Freed heap region: fd
>> =C2=A0=C2=A0=C2=A0Stack left redzone: f1
>> =C2=A0=C2=A0=C2=A0Stack mid redzone: f2
>> =C2=A0=C2=A0=C2=A0Stack right redzone: f3
>> =C2=A0=C2=A0=C2=A0Stack after return: f5
>> =C2=A0=C2=A0=C2=A0Stack use after scope: f8
>> =C2=A0=C2=A0=C2=A0Global redzone: f9
>> =C2=A0=C2=A0=C2=A0Global init order: f6
>> =C2=A0=C2=A0=C2=A0Poisoned by user: f7
>> =C2=A0=C2=A0=C2=A0Container overflow: fc
>> =C2=A0=C2=A0=C2=A0Array cookie: ac
>> =C2=A0=C2=A0=C2=A0Intra object redzone: bb
>> =C2=A0=C2=A0=C2=A0ASan internal: fe
>> =C2=A0=C2=A0=C2=A0Left alloca redzone: ca
>> =C2=A0=C2=A0=C2=A0Right alloca redzone: cb
>> =C2=A0=C2=A0=C2=A0Shadow gap: cc
>> =C2=A0=3D=3D31958=3D=3DABORTING
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0migration/migration.c | 30 ++++++++++++++++++++++++------
>> =C2=A0=C2=A01 file changed, 24 insertions(+), 6 deletions(-)
>>
>> =C2=A0diff --git a/migration/migration.c b/migration/migration.c
>> =C2=A0index 609e0df5d0..54d82bb88b 100644
>> =C2=A0--- a/migration/migration.c
>> =C2=A0+++ b/migration/migration.c
>> =C2=A0@@ -128,6 +128,8 @@ static int migration_maybe_pause(MigrationSt=
ate *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int *curre=
nt_active_state,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int new_st=
ate);
>> =C2=A0=C2=A0static void migrate_fd_cancel(MigrationState *s);
>> =C2=A0+static void migrate_join_thread(MigrationState *s);
>> =C2=A0+static void migrate_fd_cleanup(void *opaque);
>>
>> =C2=A0=C2=A0void migration_object_init(void)
>> =C2=A0=C2=A0{
>> =C2=A0@@ -176,6 +178,17 @@ void migration_shutdown(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* stop the migration using t=
his structure
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migrate_fd_cancel(current_migratio=
n);
>> =C2=A0+ /*
>> =C2=A0+ * migration_thread schedules cleanup_bh, but migration_shutdow=
n is called
>> =C2=A0+ * from the end of main, so cleanu_up may not be called because=
 main-loop is
>> =C2=A0+ * complete. So, wait for the complition of migration_thread, c=
ancel bh and
>> =C2=A0+ * call cleanup ourselves.
>> =C2=A0+ */
>
> (Some typos)
>
Ok :)

>> =C2=A0+ migrate_join_thread(current_migration);
>
> I'll admit to being a bit nervous that something in here could be
> hanging and thus we could hang here rather than die as SIGTERM is
> expecting us to.
>
I think it's only way to be sure we havn't other races with migration_thr=
ead.
And this joining is cheaper than vm_shutdown IMHO.

>> =C2=A0+ if (current_migration->cleanup_bh) {
>> =C2=A0+ qemu_bh_cancel(current_migration->cleanup_bh);
>
> Is that needed? Doesn't migrate_fd_cleanup start with a qemu_bh_delete?
>
Agree, it's odd.

>> =C2=A0+ migrate_fd_cleanup(current_migration);
>> =C2=A0+ }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_unref(OBJECT(current_migrat=
ion));
>> =C2=A0=C2=A0}
>>
>> =C2=A0@@ -1495,6 +1508,16 @@ static void block_cleanup_parameters(Migr=
ationState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static void migrate_join_thread(MigrationState *s)
>> =C2=A0+{
>> =C2=A0+ qemu_mutex_unlock_iothread();
>> =C2=A0+ if (s->migration_thread_running) {
>> =C2=A0+ qemu_thread_join(&s->thread);
>> =C2=A0+ s->migration_thread_running =3D false;
>> =C2=A0+ }
>> =C2=A0+ qemu_mutex_lock_iothread();
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static void migrate_fd_cleanup(void *opaque)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MigrationState *s =3D opaque;
>> =C2=A0@@ -1508,12 +1531,7 @@ static void migrate_fd_cleanup(void *opaq=
ue)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QEMUFile *=
tmp;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_migr=
ate_fd_cleanup();
>> =C2=A0- qemu_mutex_unlock_iothread();
>> =C2=A0- if (s->migration_thread_running) {
>> =C2=A0- qemu_thread_join(&s->thread);
>> =C2=A0- s->migration_thread_running =3D false;
>> =C2=A0- }
>> =C2=A0- qemu_mutex_lock_iothread();
>> =C2=A0+ migrate_join_thread(s);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0multifd_sa=
ve_cleanup();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex=
_lock(&s->qemu_file_lock);
>
> Dave
>
>> =C2=A0--
>> =C2=A02.21.0
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
