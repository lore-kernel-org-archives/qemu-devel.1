Received: from eggs.gnu.org ([2001:4830:134:3::10]:53406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dk5DR-0006wk-RM
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dk5DQ-0006lJ-Kn
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:11:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:36984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dk5DQ-0006is-Dl
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:11:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dk5DP-00026G-7Q
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 09:11:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 34AAA2E80CB
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 09:11:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Aug 2017 08:54:10 -0000
From: ChristianEhrhardt <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150339205095.10750.5063429381666274296.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711602] Re: --copy-storage-all failing with qemu
 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Via a watchpoints I found that the error is set by qemu_fill_buffer.

b qemu_loadvm_state
handle SIGUSR1 nostop noprint pass
c
# on the break check and watch the status
(gdb) p f
$1 =3D (QEMUFile *) 0xb9babb3c00
(gdb) p *f
$2 =3D {ops =3D 0xb9b89880a0 <channel_input_ops>, hooks =3D 0x0, opaque =3D=
 0xb9bbabfe00, bytes_xfer =3D 0, xfer_limit =3D 0, pos =3D 0, buf_index =3D=
 0, =

  buf_size =3D 0, buf =3D '\000' <repeats 32767 times>, may_free =3D {0}, i=
ov =3D {{iov_base =3D 0x0, iov_len =3D 0} <repeats 64 times>}, iovcnt =3D 0=
, =

  last_error =3D 0}

# ok still no err, set watchpoint
(gdb) p &(f->last_error)
$4 =3D (int *) 0xb9babbc044
(gdb) watch *(int *) 0xb9babbc044
Hardware watchpoint 2: *(int *) 0xb9babbc044

# This catches the following
Thread 1 "qemu-system-x86" hit Hardware watchpoint 2: *(int *) 0xb9babbc044

Old value =3D 0
New value =3D -5
0x000000b9b82bd0ec in qemu_file_set_error (ret=3D-5, f=3D0xb9babb3c00) at .=
/migration/qemu-file.c:125
warning: Source file is more recent than executable.
125             f->last_error =3D ret;
(gdb) bt
#0  0x000000b9b82bd0ec in qemu_file_set_error (ret=3D-5, f=3D0xb9babb3c00) =
at ./migration/qemu-file.c:125
#1  qemu_fill_buffer (f=3D0xb9babb3c00) at ./migration/qemu-file.c:299
#2  0x000000b9b82bdbb1 in qemu_peek_byte (f=3D0xb9babb3c00, offset=3D0) at =
./migration/qemu-file.c:553
#3  0x000000b9b82bdc1b in qemu_get_byte (f=3Df@entry=3D0xb9babb3c00) at ./m=
igration/qemu-file.c:566
#4  0x000000b9b82b5853 in qemu_loadvm_state_main (f=3Df@entry=3D0xb9babb3c0=
0, mis=3D0xb9b8a4f700 <mis_current>) at ./migration/savevm.c:1947
#5  0x000000b9b82b864f in qemu_loadvm_state (f=3Df@entry=3D0xb9babb3c00) at=
 ./migration/savevm.c:2032
#6  0x000000b9b82af5c3 in process_incoming_migration_co (opaque=3D0xb9babb3=
c00) at ./migration/migration.c:320
#7  0x000000b9b83e42a6 in coroutine_trampoline (i0=3D<optimized out>, i1=3D=
<optimized out>) at ./util/coroutine-ucontext.c:79
#8  0x00007fbf3702fac0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#9  0x00007fffe3f9f800 in ?? ()
#10 0x0000000000000000 in ?? ()

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711602

Title:
  --copy-storage-all failing with qemu 2.10

Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  Confirmed
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  We fixed an issue around disk locking already in regard to qemu-nbd
  [1], but there still seem to be issues.

  $ virsh migrate --live --copy-storage-all kvmguest-artful-normal qemu+ssh=
://10.22.69.196/system
  error: internal error: qemu unexpectedly closed the monitor: 2017-08-18T1=
2:10:29.800397Z qemu-system-x86_64: -chardev pty,id=3Dcharserial0: char dev=
ice redirected to /dev/pts/0 (label charserial0)
  2017-08-18T12:10:48.545776Z qemu-system-x86_64: load of migration failed:=
 Input/output error

  Source libvirt log for the guest:
  2017-08-18 12:09:08.251+0000: initiating migration
  2017-08-18T12:09:08.809023Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer
  2017-08-18T12:09:08.809481Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer

  Target libvirt log for the guest:
  2017-08-18T12:09:08.730911Z qemu-system-x86_64: load of migration failed:=
 Input/output error
  2017-08-18 12:09:09.010+0000: shutting down, reason=3Dcrashed

  Given the timing it seems that the actual copy now works (it is busy ~10 =
seconds on my environment which would be the copy).
  Also we don't see the old errors we saw before, but afterwards on the act=
ual take-over it fails.

  Dmesg has no related denials as often apparmor is in the mix.

  Need to check libvirt logs of source [2] and target [3] in Detail.

  [1]: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02200.html
  [2]: http://paste.ubuntu.com/25339356/
  [3]: http://paste.ubuntu.com/25339358/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711602/+subscriptions
