Received: from eggs.gnu.org ([2001:4830:134:3::10]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cjjXc-0004NH-Mu
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cjjXY-0000jy-Mh
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:30:24 -0500
Received: from [45.249.212.189] (port=2414 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cjjXX-0000hD-Ry
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:30:20 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 3 Mar 2017 09:29:51 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1D01C2@DGGEMA505-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [Bug?] BQL about live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "quintela@redhat.com" <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: yanghongyang <yanghongyang@huawei.com>, Huangzhichao <huangzhichao@huawei.com>

Hello Juan & Dave,

We hit a bug in our test:
Network error occurs when migrating a guest, libvirt then rollback the
migration, causes qemu coredump
qemu log:
2017-03-01T12:54:33.904949+08:00|info|qemu[17672]|[33614]|monitor_qapi_even=
t_emit[479]|: {"timestamp": {"seconds": 1488344073, "microseconds": 904914}=
, "event": "STOP"}
2017-03-01T12:54:37.522500+08:00|info|qemu[17672]|[17672]|handle_qmp_comman=
d[3930]|: qmp_cmd_name: migrate_cancel
2017-03-01T12:54:37.522607+08:00|info|qemu[17672]|[17672]|monitor_qapi_even=
t_emit[479]|: {"timestamp": {"seconds": 1488344077, "microseconds": 522556}=
, "event": "MIGRATION", "data": {"status": "cancelling"}}
2017-03-01T12:54:37.524671+08:00|info|qemu[17672]|[17672]|handle_qmp_comman=
d[3930]|: qmp_cmd_name: cont
2017-03-01T12:54:37.524733+08:00|info|qemu[17672]|[17672]|virtio_set_status=
[725]|: virtio-balloon device status is 7 that means DRIVER OK
2017-03-01T12:54:37.525434+08:00|info|qemu[17672]|[17672]|virtio_set_status=
[725]|: virtio-net device status is 7 that means DRIVER OK
2017-03-01T12:54:37.525484+08:00|info|qemu[17672]|[17672]|virtio_set_status=
[725]|: virtio-blk device status is 7 that means DRIVER OK
2017-03-01T12:54:37.525562+08:00|info|qemu[17672]|[17672]|virtio_set_status=
[725]|: virtio-serial device status is 7 that means DRIVER OK
2017-03-01T12:54:37.527653+08:00|info|qemu[17672]|[17672]|vm_start[981]|: v=
m_state-notify:3ms
2017-03-01T12:54:37.528523+08:00|info|qemu[17672]|[17672]|monitor_qapi_even=
t_emit[479]|: {"timestamp": {"seconds": 1488344077, "microseconds": 527699}=
, "event": "RESUME"}
2017-03-01T12:54:37.530680+08:00|info|qemu[17672]|[33614]|migration_bitmap_=
sync[720]|: this iteration cycle takes 3s, new dirtied data:0MB
2017-03-01T12:54:37.530909+08:00|info|qemu[17672]|[33614]|monitor_qapi_even=
t_emit[479]|: {"timestamp": {"seconds": 1488344077, "microseconds": 530733}=
, "event": "MIGRATION_PASS", "data": {"pass": 3}}
2017-03-01T04:54:37.530997Z qemu-kvm: socket_writev_buffer: Got err=3D32 fo=
r (131583/18446744073709551615)
qemu-kvm: /home/abuild/rpmbuild/BUILD/qemu-kvm-2.6.0/hw/net/virtio_net.c:15=
19: virtio_net_save: Assertion `!n->vhost_started' failed.
2017-03-01 12:54:43.028: shutting down

>From qemu log, qemu received and processed migrate_cancel/cont qmp commands
after guest been stopped and entered the last round of migration. Then
migration thread try to save device state when guest is running(started by
cont command), causes assert and coredump.
This is because in last iter, we call cpu_synchronize_all_states() to
synchronize vcpu states, this call will release qemu_global_mutex and wait
for do_kvm_cpu_synchronize_state() to be executed on target vcpu:
(gdb) bt
#0  0x00007f763d1046d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/lib=
pthread.so.0
#1  0x00007f7643e51d7f in qemu_cond_wait (cond=3D0x7f764445eca0 <qemu_work_=
cond>, mutex=3D0x7f764445eba0 <qemu_global_mutex>) at util/qemu-thread-posi=
x.c:132
#2  0x00007f7643a2e154 in run_on_cpu (cpu=3D0x7f7644e06d80, func=3D0x7f7643=
a46413 <do_kvm_cpu_synchronize_state>, data=3D0x7f7644e06d80) at /mnt/publi=
c/yanghy/qemu-kvm/cpus.c:995
#3  0x00007f7643a46487 in kvm_cpu_synchronize_state (cpu=3D0x7f7644e06d80) =
at /mnt/public/yanghy/qemu-kvm/kvm-all.c:1805
#4  0x00007f7643a2c700 in cpu_synchronize_state (cpu=3D0x7f7644e06d80) at /=
mnt/public/yanghy/qemu-kvm/include/sysemu/kvm.h:457
#5  0x00007f7643a2db0c in cpu_synchronize_all_states () at /mnt/public/yang=
hy/qemu-kvm/cpus.c:766
#6  0x00007f7643a67b5b in qemu_savevm_state_complete_precopy (f=3D0x7f76462=
f2d30, iterable_only=3Dfalse) at /mnt/public/yanghy/qemu-kvm/migration/save=
vm.c:1051
#7  0x00007f7643d121e9 in migration_completion (s=3D0x7f76443e78c0 <current=
_migration.37571>, current_active_state=3D4, old_vm_running=3D0x7f74343fda0=
0, start_time=3D0x7f74343fda08) at migration/migration.c:1753
#8  0x00007f7643d126c5 in migration_thread (opaque=3D0x7f76443e78c0 <curren=
t_migration.37571>) at migration/migration.c:1922
#9  0x00007f763d100dc5 in start_thread () from /lib64/libpthread.so.0
#10 0x00007f763ce2e71d in clone () from /lib64/libc.so.6
(gdb) p iothread_locked
$1 =3D true

and then, qemu main thread been executed, it won't block because migration
thread released the qemu_global_mutex:
(gdb) thr 1
[Switching to thread 1 (Thread 0x7fe298e08bc0 (LWP 30767))]
#0  os_host_main_loop_wait (timeout=3D931565) at main-loop.c:270
270                 QEMU_LOG(LOG_INFO,"***** after qemu_pool_ns: timeout %d=
\n", timeout);
(gdb) p iothread_locked
$2 =3D true
(gdb) l 268
263
264         ret =3D qemu_poll_ns((GPollFD *)gpollfds->data, gpollfds->len, =
timeout);
265
266
267         if (timeout) {
268             qemu_mutex_lock_iothread();
269             if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
270                 QEMU_LOG(LOG_INFO,"***** after qemu_pool_ns: timeout %d=
\n", timeout);
271             }
272         }
(gdb)

So, although we've hold iothread_lock in stop&copy phase of migration, we
can't guarantee the iothread been locked all through the stop & copy phase,
any thoughts on how to solve this problem?


Thanks,
-Gonglei
