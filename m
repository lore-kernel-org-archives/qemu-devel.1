Received: from eggs.gnu.org ([209.51.188.92]:42036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h3KqD-00054N-DH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h3KqA-00042W-3M
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:19:41 -0400
Date: Mon, 11 Mar 2019 14:09:26 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190311130926.GS9131@angien.pipo.sk>
References: <20190308153757.25794-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MdJ3p2aQbVp3YFXz"
Content-Disposition: inline
In-Reply-To: <20190308153757.25794-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/8] file-posix: Make auto-read-only dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org


--MdJ3p2aQbVp3YFXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2019 at 16:37:49 +0100, Kevin Wolf wrote:
> We introduced the auto-read-only option to fix the problem that block
> jobs that reopen a backing file read-write don't work any more when all
> nodes are created individually with -blockdev. The reason is that
> bs->file of these backing files doesn't inherit the read-only option
> from the format layer node any more if it's created separately.
>=20
> The way auto-read-only was designed to fix this is that it just always
> opens the file node read-write if it can, so reopening the format layer
> node is enough to make the backing file writable when necessary.
>=20
> This works in principle, but not when libvirt uses sVirt: Then QEMU
> doesn't even have the permissions to open the image file read-write
> until libvirt performs an operation where write access is needed.
>=20
> This series changes auto-read-only so that it works dynamically and
> automatically reopens the file read-only or read-write depending on the
> permissions that users attached to the node requested.

While testing this series by attempting a non-active layer block-commit
I've got an assertion failure:

qemu-system-x86_64: block/file-posix.c:2715: raw_check_perm: Assertion `!s-=
>perm_change_fd' failed.

Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
0x00007f69fe08753f in raise () from target:/lib64/libc.so.6

Thread 1 (Thread 0x7f69f3b08680 (LWP 2694)):
#0  0x00007f69fe08753f in raise () from target:/lib64/libc.so.6
#1  0x00007f69fe071895 in abort () from target:/lib64/libc.so.6
#2  0x00007f69fe071769 in __assert_fail_base.cold.0 ()
   from target:/lib64/libc.so.6
#3  0x00007f69fe07f9f6 in __assert_fail () from target:/lib64/libc.so.6
#4  0x00005563cfeea7e9 in raw_check_perm (bs=3D0x5563d1f90100, perm=3D11, s=
hared=3D21, errp=3D0x7fffc280c0f0) at block/file-posix.c:2715
#5  0x00005563cfe9aab4 in bdrv_check_perm (bs=3Dbs@entry=3D0x5563d1f90100, =
q=3D0x5563d2bd0170, q@entry=3D0xbed88f135e2a5600, cumulative_perms=3D11, cu=
mulative_shared_perms=3D21, ignore_children=3Dignore_children@entry=3D0x7f6=
9a47f9710, errp=3Derrp@entry=3D0x7fffc280c0f0) at block.c:1790
#6  0x00005563cfe9a875 in bdrv_check_update_perm (bs=3D0x5563d1f90100, q=3D=
0xbed88f135e2a5600, q@entry=3D0x5563d2bd0170, new_used_perm=3Dnew_used_perm=
@entry=3D11, new_shared_perm=3Dnew_shared_perm@entry=3D21, ignore_children=
=3Dignore_children@entry=3D0x7f69a47f9710, errp=3Derrp@entry=3D0x7fffc280c0=
f0) at block.c:1976
#7  0x00005563cfe9a9ba in bdrv_child_check_perm (c=3Dc@entry=3D0x5563d1eb9d=
d0, q=3Dq@entry=3D0x5563d2bd0170, perm=3D11, shared=3D21, ignore_children=
=3D0x7f69a47f9710, ignore_children@entry=3D0x5563d1a57810, errp=3Derrp@entr=
y=3D0x7fffc280c0f0) at block.c:1989
#8  0x00005563cfe9ab44 in bdrv_check_perm (bs=3D0x5563d1f943a0, bs@entry=3D=
0xb, q=3D0x5563d2bd0170, q@entry=3D0xbed88f135e2a5600, cumulative_perms=3D0=
, cumulative_shared_perms=3D31, ignore_children=3Dignore_children@entry=3D0=
x5563d1a57810, errp=3D0x7fffc280c0f0, errp@entry=3D0x15) at block.c:1806
#9  0x00005563cfe9a875 in bdrv_check_update_perm (bs=3D0xb, q=3D0xbed88f135=
e2a5600, q@entry=3D0x5563d2bd0170, new_used_perm=3Dnew_used_perm@entry=3D0,=
 new_shared_perm=3Dnew_shared_perm@entry=3D31, ignore_children=3Dignore_chi=
ldren@entry=3D0x5563d1a57810, errp=3D0x15, errp@entry=3D0x7fffc280c0f0) at =
block.c:1976
#10 0x00005563cfe9a9ba in bdrv_child_check_perm (c=3Dc@entry=3D0x5563d1eb99=
10, q=3Dq@entry=3D0x5563d2bd0170, perm=3D0, shared=3D31, ignore_children=3D=
0x5563d1a57810, ignore_children@entry=3D0x5563d32dfd40, errp=3Derrp@entry=
=3D0x7fffc280c0f0) at block.c:1989
#11 0x00005563cfe9ab44 in bdrv_check_perm (bs=3D0x5563d2011320, bs@entry=3D=
0x0, q=3D0x5563d2bd0170, q@entry=3D0xbed88f135e2a5600, cumulative_perms=3D0=
, cumulative_shared_perms=3D6, ignore_children=3Dignore_children@entry=3D0x=
5563d32dfd40, errp=3D0x7fffc280c0f0, errp@entry=3D0x1f) at block.c:1806
#12 0x00005563cfe9a875 in bdrv_check_update_perm (bs=3D0x0, q=3D0xbed88f135=
e2a5600, q@entry=3D0x5563d2bd0170, new_used_perm=3Dnew_used_perm@entry=3D0,=
 new_shared_perm=3Dnew_shared_perm@entry=3D31, ignore_children=3Dignore_chi=
ldren@entry=3D0x5563d32dfd40, errp=3D0x1f, errp@entry=3D0x7fffc280c0f0) at =
block.c:1976
#13 0x00005563cfe9a9ba in bdrv_child_check_perm (c=3Dc@entry=3D0x5563d1d966=
90, q=3Dq@entry=3D0x5563d2bd0170, perm=3D0, shared=3D31, ignore_children=3D=
0x5563d32dfd40, ignore_children@entry=3D0x5563d32dfe00, errp=3Derrp@entry=
=3D0x7fffc280c0f0) at block.c:1989
#14 0x00005563cfe9ab44 in bdrv_check_perm (bs=3D0x5563d2092340, bs@entry=3D=
0x0, q=3D0x5563d2bd0170, q@entry=3D0xbed88f135e2a5600, cumulative_perms=3D0=
, cumulative_shared_perms=3D6, ignore_children=3Dignore_children@entry=3D0x=
5563d32dfe00, errp=3D0x7fffc280c0f0, errp@entry=3D0x1f) at block.c:1806
#15 0x00005563cfe9a875 in bdrv_check_update_perm (bs=3D0x0, q=3D0xbed88f135=
e2a5600, q@entry=3D0x5563d2bd0170, new_used_perm=3Dnew_used_perm@entry=3D0,=
 new_shared_perm=3Dnew_shared_perm@entry=3D31, ignore_children=3Dignore_chi=
ldren@entry=3D0x5563d32dfe00, errp=3D0x1f, errp@entry=3D0x7fffc280c0f0) at =
block.c:1976
#16 0x00005563cfe9a9ba in bdrv_child_check_perm (c=3Dc@entry=3D0x5563d37424=
d0, q=3Dq@entry=3D0x5563d2bd0170, perm=3D0, shared=3D31, ignore_children=3D=
0x5563d32dfe00, ignore_children@entry=3D0x5563d32dfb40, errp=3Derrp@entry=
=3D0x7fffc280c0f0) at block.c:1989
#17 0x00005563cfe9ab44 in bdrv_check_perm (bs=3D0x5563d2fea010, bs@entry=3D=
0x0, q=3D0x5563d2bd0170, q@entry=3D0xbed88f135e2a5600, cumulative_perms=3D1=
, cumulative_shared_perms=3D21, ignore_children=3Dignore_children@entry=3D0=
x5563d32dfb40, errp=3D0x7fffc280c0f0, errp@entry=3D0x1f) at block.c:1806
#18 0x00005563cfe9a875 in bdrv_check_update_perm (bs=3D0x0, q=3D0xbed88f135=
e2a5600, q@entry=3D0x5563d2bd0170, new_used_perm=3Dnew_used_perm@entry=3D1,=
 new_shared_perm=3Dnew_shared_perm@entry=3D21, ignore_children=3Dignore_chi=
ldren@entry=3D0x5563d32dfb40, errp=3D0x1f, errp@entry=3D0x7fffc280c0f0) at =
block.c:1976
#19 0x00005563cfe9a9ba in bdrv_child_check_perm (c=3Dc@entry=3D0x5563d1e17a=
50, q=3Dq@entry=3D0x5563d2bd0170, perm=3D1, shared=3D21, ignore_children=3D=
0x5563d32dfb40, ignore_children@entry=3D0x0, errp=3Derrp@entry=3D0x7fffc280=
c0f0) at block.c:1989
#20 0x00005563cfe9ab44 in bdrv_check_perm (bs=3D0x5563d2113340, q=3Dq@entry=
=3D0x5563d2bd0170, cumulative_perms=3D1, cumulative_shared_perms=3D21, igno=
re_children=3Dignore_children@entry=3D0x0, errp=3Derrp@entry=3D0x7fffc280c0=
f0) at block.c:1806
#21 0x00005563cfe9f317 in bdrv_reopen_multiple (ctx=3D<optimized out>, bs_q=
ueue=3D0x5563d2bd0170, errp=3Derrp@entry=3D0x7fffc280c0f0) at block.c:3167
#22 0x00005563cfe9f451 in bdrv_reopen_set_read_only (bs=3Dbs@entry=3D0x5563=
d2113340, read_only=3Dread_only@entry=3Dfalse, errp=3Derrp@entry=3D0x7fffc2=
80c0f0) at block.c:5293
#23 0x00005563cfe9f4fd in bdrv_backing_update_filename (c=3D<optimized out>=
, base=3D0x5563d1f943a0, filename=3D0x5563d1f943d1 "/tmp/commit0.qcow2", er=
rp=3D0x7fffc280c0f0) at block.c:1119
#24 0x00005563cfe9f66f in bdrv_drop_intermediate (top=3D0x5563d2fea010, bas=
e=3D0x5563d1f943a0, backing_file_str=3D0x5563d1f943d1 "/tmp/commit0.qcow2")=
 at block.c:4018
#25 0x00005563cfea4689 in job_prepare (job=3D0x5563d2539880) at job.c:771
#26 job_txn_apply (txn=3D<optimized out>, fn=3D<optimized out>) at job.c:146
#27 job_do_finalize (job=3D0x5563d2539880) at job.c:788
#28 0x00005563cfea4941 in job_completed_txn_success (job=3D0x5563d2539880) =
at job.c:842
#29 job_completed (job=3D0x5563d2539880) at job.c:855
#30 job_completed (job=3D0x5563d2539880) at job.c:846
#31 0x00005563cfea49a0 in job_exit (opaque=3D0x5563d2539880) at job.c:874
#32 0x00005563cff991de in aio_bh_call (bh=3D0x7f69a0004800) at util/async.c=
:118
#33 aio_bh_poll (ctx=3Dctx@entry=3D0x5563d1beb7a0) at util/async.c:118
#34 0x00005563cff9c790 in aio_dispatch (ctx=3D0x5563d1beb7a0) at util/aio-p=
osix.c:460
#35 0x00005563cff990be in aio_ctx_dispatch (source=3D<optimized out>, callb=
ack=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:261
#36 0x00007f6a0013506d in g_main_context_dispatch () from target:/lib64/lib=
glib-2.0.so.0
#37 0x00005563cff9b9a8 in glib_pollfds_poll () at util/main-loop.c:215
#38 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-loop.c:=
238
#39 main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:514
#40 0x00005563cfcac499 in main_loop () at vl.c:1923
#41 0x00005563cfb4c943 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at vl.c:4579


This is the log of QEMU monitor interactions by libvirtd:

[trimmed boring startup of qemu]
2019-03-11 12:57:10.485+0000: 3228: info : qemuMonitorIOWrite:553 : QEMU_MO=
NITOR_IO_WRITE: mon=3D0x7fcff4027880 buf=3D{"execute":"cont","id":"libvirt-=
18"}^M
2019-03-11 12:57:10.485+0000: 3228: info : qemuMonitorJSONIOProcessLine:219=
 : QEMU_MONITOR_RECV_EVENT: mon=3D0x7fcff4027880 event=3D{"timestamp": {"se=
conds": 1552309030, "microseconds": 485648}, "event": "RESUME"}
2019-03-11 12:57:10.486+0000: 3228: info : qemuMonitorJSONIOProcessLine:224=
 : QEMU_MONITOR_RECV_REPLY: mon=3D0x7fcff4027880 reply=3D{"return": {}, "id=
": "libvirt-18"}
2019-03-11 12:57:20.398+0000: 3243: info : qemuMonitorSend:1085 : QEMU_MONI=
TOR_SEND_MSG: mon=3D0x7fcff4027880 msg=3D{"execute":"block-commit","argumen=
ts":{"device":"libvirt-2-format","job-id":"commit-vdb-libvirt-10-format","t=
op-node":"libvirt-10-format","base-node":"libvirt-12-format","auto-finalize=
":true,"auto-dismiss":false},"id":"libvirt-19"}^M
2019-03-11 12:57:20.398+0000: 3228: info : qemuMonitorIOWrite:553 : QEMU_MO=
NITOR_IO_WRITE: mon=3D0x7fcff4027880 buf=3D{"execute":"block-commit","argum=
ents":{"device":"libvirt-2-format","job-id":"commit-vdb-libvirt-10-format",=
"top-node":"libvirt-10-format","base-node":"libvirt-12-format","auto-finali=
ze":true,"auto-dismiss":false},"id":"libvirt-19"}^M
2019-03-11 12:57:20.400+0000: 3228: info : qemuMonitorJSONIOProcessLine:219=
 : QEMU_MONITOR_RECV_EVENT: mon=3D0x7fcff4027880 event=3D{"timestamp": {"se=
conds": 1552309040, "microseconds": 400150}, "event": "JOB_STATUS_CHANGE", =
"data": {"status": "created", "id": "commit-vdb-libvirt-10-format"}}
2019-03-11 12:57:20.400+0000: 3228: info : qemuMonitorJSONIOProcessLine:219=
 : QEMU_MONITOR_RECV_EVENT: mon=3D0x7fcff4027880 event=3D{"timestamp": {"se=
conds": 1552309040, "microseconds": 400643}, "event": "JOB_STATUS_CHANGE", =
"data": {"status": "running", "id": "commit-vdb-libvirt-10-format"}}
2019-03-11 12:57:20.400+0000: 3228: info : qemuMonitorJSONIOProcessLine:224=
 : QEMU_MONITOR_RECV_REPLY: mon=3D0x7fcff4027880 reply=3D{"return": {}, "id=
": "libvirt-19"}
2019-03-11 12:57:20.400+0000: 3228: info : qemuMonitorJSONIOProcessLine:219=
 : QEMU_MONITOR_RECV_EVENT: mon=3D0x7fcff4027880 event=3D{"timestamp": {"se=
conds": 1552309040, "microseconds": 400800}, "event": "JOB_STATUS_CHANGE", =
"data": {"status": "waiting", "id": "commit-vdb-libvirt-10-format"}}
2019-03-11 12:57:20.401+0000: 3228: info : qemuMonitorJSONIOProcessLine:219=
 : QEMU_MONITOR_RECV_EVENT: mon=3D0x7fcff4027880 event=3D{"timestamp": {"se=
conds": 1552309040, "microseconds": 400825}, "event": "JOB_STATUS_CHANGE", =
"data": {"status": "pending", "id": "commit-vdb-libvirt-10-format"}}
2019-03-11 12:57:20.737+0000: 3386: info : qemuMonitorClose:1007 : QEMU_MON=
ITOR_CLOSE: mon=3D0x7fcff4027880 refs=3D1

The following command line was used:

LC_ALL=3DC \
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin \
QEMU_AUDIO_DRV=3Dspice \
/home/pipo/git/qemu.git/x86_64-softmmu/qemu-system-x86_64 \
-name guest=3Dupstream-bj,debug-threads=3Don \
-S \
-object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/do=
main-23-upstream-bj/master-key.aes \
-machine pc-i440fx-2.9,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=
=3Doff \
-m 1000 \
-realtime mlock=3Doff \
-smp 2,maxcpus=3D8,sockets=3D8,cores=3D1,threads=3D1 \
-object memory-backend-file,id=3Dram-node0,mem-path=3D/var/lib/libvirt/qemu=
/ram/libvirt/qemu/23-upstream-bj/ram-node0,share=3Dyes,size=3D524288000,hos=
t-nodes=3D0,policy=3Dbind \
-numa node,nodeid=3D0,cpus=3D0,cpus=3D2,cpus=3D4,cpus=3D6,memdev=3Dram-node=
0 \
-object memory-backend-file,id=3Dram-node1,mem-path=3D/var/lib/libvirt/qemu=
/ram/libvirt/qemu/23-upstream-bj/ram-node1,share=3Dyes,size=3D524288000,hos=
t-nodes=3D0,policy=3Dbind \
-numa node,nodeid=3D1,cpus=3D1,cpus=3D3,cpus=3D5,cpus=3D7,memdev=3Dram-node=
1 \
-uuid 841752b8-9452-4078-a62b-8fd9a9af011c \
-no-user-config \
-nodefaults \
-chardev socket,id=3Dcharmonitor,fd=3D29,server,nowait \
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
-rtc base=3Dutc,driftfix=3Dslew \
-global kvm-pit.lost_tick_policy=3Ddelay \
-no-hpet \
-no-shutdown \
-global PIIX4_PM.disable_s3=3D1 \
-global PIIX4_PM.disable_s4=3D1 \
-boot menu=3Don,strict=3Don \
-device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7 \
-device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifun=
ction=3Don,addr=3D0x6 \
-device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0=
x6.0x1 \
-device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0=
x6.0x2 \
-device lsi,id=3Dscsi0,bus=3Dpci.0,addr=3D0x9 \
-device ahci,id=3Dsata0,bus=3Dpci.0,addr=3D0xb \
-device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 \
-blockdev '{"driver":"file","filename":"/var/lib/libvirt/images/systemrescu=
ecd-x86-4.9.5.iso","node-name":"libvirt-4-storage","auto-read-only":true,"d=
iscard":"unmap"}' \
-blockdev '{"node-name":"libvirt-4-format","read-only":true,"driver":"raw",=
"file":"libvirt-4-storage"}' \
-device ide-cd,bus=3Dide.0,unit=3D0,drive=3Dlibvirt-4-format,id=3Dide0-0-0,=
bootindex=3D1 \
-blockdev '{"driver":"file","filename":"/tmp/pull0.qcow2","node-name":"libv=
irt-16-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-16-format","read-only":true,"driver":"qcow=
2","file":"libvirt-16-storage","backing":null}' \
-blockdev '{"driver":"file","filename":"/tmp/pull1.qcow2","node-name":"libv=
irt-15-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-15-format","read-only":true,"driver":"qcow=
2","file":"libvirt-15-storage","backing":"libvirt-16-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/pull2.qcow2","node-name":"libv=
irt-14-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-14-format","read-only":true,"driver":"qcow=
2","file":"libvirt-14-storage","backing":"libvirt-15-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/pull3.qcow2","node-name":"libv=
irt-13-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-13-format","read-only":true,"driver":"qcow=
2","file":"libvirt-13-storage","backing":"libvirt-14-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/pull4.qcow2","node-name":"libv=
irt-3-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-3-format","read-only":false,"driver":"qcow=
2","file":"libvirt-3-storage","backing":"libvirt-13-format"}' \
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xa,drive=3Dlibvirt-3-=
format,id=3Dvirtio-disk0 \
-blockdev '{"driver":"file","filename":"/tmp/commit0.qcow2","node-name":"li=
bvirt-12-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-12-format","read-only":true,"driver":"qcow=
2","file":"libvirt-12-storage","backing":null}' \
-blockdev '{"driver":"file","filename":"/tmp/commit1.qcow2","node-name":"li=
bvirt-11-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-11-format","read-only":true,"driver":"qcow=
2","file":"libvirt-11-storage","backing":"libvirt-12-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/commit2.qcow2","node-name":"li=
bvirt-10-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-10-format","read-only":true,"driver":"qcow=
2","file":"libvirt-10-storage","backing":"libvirt-11-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/commit3.qcow2","node-name":"li=
bvirt-9-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-9-format","read-only":true,"driver":"qcow2=
","file":"libvirt-9-storage","backing":"libvirt-10-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/commit4.qcow2","node-name":"li=
bvirt-2-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-2-format","read-only":false,"driver":"qcow=
2","file":"libvirt-2-storage","backing":"libvirt-9-format"}' \
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xc,drive=3Dlibvirt-2-=
format,id=3Dvirtio-disk1 \
-blockdev '{"driver":"file","filename":"/tmp/copy0.qcow2","node-name":"libv=
irt-8-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-8-format","read-only":true,"driver":"qcow2=
","file":"libvirt-8-storage","backing":null}' \
-blockdev '{"driver":"file","filename":"/tmp/copy1.qcow2","node-name":"libv=
irt-7-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-7-format","read-only":true,"driver":"qcow2=
","file":"libvirt-7-storage","backing":"libvirt-8-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/copy2.qcow2","node-name":"libv=
irt-6-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-6-format","read-only":true,"driver":"qcow2=
","file":"libvirt-6-storage","backing":"libvirt-7-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/copy3.qcow2","node-name":"libv=
irt-5-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-5-format","read-only":true,"driver":"qcow2=
","file":"libvirt-5-storage","backing":"libvirt-6-format"}' \
-blockdev '{"driver":"file","filename":"/tmp/copy4.qcow2","node-name":"libv=
irt-1-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-1-format","read-only":false,"driver":"qcow=
2","file":"libvirt-1-storage","backing":"libvirt-5-format"}' \
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xd,drive=3Dlibvirt-1-=
format,id=3Dvirtio-disk2 \
-netdev tap,fd=3D31,id=3Dhostnet0,vhost=3Don,vhostfd=3D32 \
-device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:36:bd:3b,=
bus=3Dpci.0,addr=3D0x3 \
-netdev tap,fd=3D33,id=3Dhostnet1 \
-device rtl8139,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00:2e:f1:27,bus=3Dp=
ci.0,addr=3D0x8 \
-chardev pty,id=3Dcharserial0 \
-device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
-chardev socket,id=3Dcharchannel0,fd=3D34,server,nowait \
-device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0=
,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
-chardev spicevmc,id=3Dcharchannel1,name=3Dvdagent \
-device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchannel1=
,id=3Dchannel1,name=3Dcom.redhat.spice.0 \
-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 \
-spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=3Do=
ff,seamless-migration=3Don \
-device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64=
_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 \
-device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 \
-device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 \
-chardev spicevmc,id=3Dcharredir0,name=3Dusbredir \
-device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 \
-chardev spicevmc,id=3Dcharredir1,name=3Dusbredir \
-device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 \
-object rng-random,id=3Dobjrng0,filename=3D/dev/random \
-device virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.0,addr=3D0x7 \
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcec=
ontrol=3Ddeny \
-msg timestamp=3Don


--MdJ3p2aQbVp3YFXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyGXgMACgkQHGwCByjY
1GojphAAzECmFq0OSxAMB0zKs4ncJzOKcnU9I3iuI0JuKcPS4X6T/Ywh9zQjkioe
0/45O+B16vUrccop2RbJ5T18lCsTZbKck62/xgOk1dySEQtdsm4FirbU92XYZ1YB
w9o4KdoJSoV+/9xdZHQCPzVOftT0DlTiB5SaNSsx1F6+vEbKupkR54jsDvbtuCwR
ZGwwV3pZjSwQcQAbRQI6tmNgHT26xOsRDGufWlhCgWZm82HwB7gQURfwvg5uwhYl
eVFYCK/+PfFwlvf5j/mfjb/0Sh/ihle5IAQGvjfyGqwdcCVWTucg9JAz5NZw55nO
VLmde+G4MTwwwR6Ovsb1qK2lJp5xxM0mt5C15CBiF4HMKemFuNBY/pCyBc11QMcS
dzj3J68ZIGWTg3s8lIW4hdidOCvDUl4jQ4TulibXDVNij34xCTxDGv5Tn3k1FYD+
Hf7vKl5nxhaeVSDG4hUhkM9syKOPCfApXj+9XZUL02qiqc0DRxspuJtX9LqlPOus
lnJet75bxgC+cu+rvvUSGj6tAFo8KJN6QtRVHhHfSlLb+WMQGX5O6+n/MDFnRvoT
TwCSV9y5YAsjX4y20Ohdfqq/gPS4aRL40/RS7jf39INb3UgiCjzZHw/vABjq8vB4
eLiNA+F9F6PTXyUO98BMvRWp50sAb3dOeDyG4u7y1sp/B0j3neo=
=um6O
-----END PGP SIGNATURE-----

--MdJ3p2aQbVp3YFXz--
