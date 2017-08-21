Received: from eggs.gnu.org ([2001:4830:134:3::10]:46999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djoMP-0006xx-0A
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djoMN-0005qk-RU
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:11:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:48999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1djoMN-0005pL-LF
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:11:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1djoMM-00057R-56
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 15:11:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 189B92E80D4
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 15:11:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2017 14:55:33 -0000
From: ChristianEhrhardt <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150332733337.17173.6465015779417839926.malone@gac.canonical.com>
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

Since the qemu "lives" in that time I can try to debug what happens.
With strace to sniff where things could be I see right before the end:
     0.000203 recvmsg(27, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{io=
v_base=3D"", iov_len=3D32768}], msg_iovlen=3D1, msg_controllen=3D0, msg_fla=
gs=3DMSG_CMSG_CLOEXEC}, MSG_CMSG_CLOEXEC) =3D 0 <0.000014>
     0.000049 futex(0xca65dacf4, FUTEX_CMP_REQUEUE_PRIVATE, 1, 2147483647, =
0xca4785a80, 20) =3D 1 <0.000016>
     0.000038 getpid()                  =3D 29750 <0.000023>
     0.000011 tgkill(29750, 29760, SIGUSR1) =3D 0 <0.000030>
     0.000012 futex(0xca4785a80, FUTEX_WAKE_PRIVATE, 1) =3D 1 <0.000048>
     0.000010 futex(0xca47b46e4, FUTEX_WAIT_PRIVATE, 19, NULL) =3D 0 <0.002=
215>
     0.000032 sendmsg(21, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{io=
v_base=3D"{\"timestamp\": {\"seconds\": 1503322067, \"microseconds\": 61317=
8}, \"event\": \"MIGRATION\", \"data\": {\"status\": \"failed\"}}\r\n", iov=
_len=3D116}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=3D0}, 0) =3D 11=
6 <0.000024>
     0.000074 write(2, "2017-08-21T13:27:47.613276Z qemu-system-x86_64: loa=
d of migration failed: Input/output error\n", 93) =3D 93 <0.000022>
     0.000055 close(27)                 =3D 0 <0.000090>

Now 29750 is the main process/tgid and 29760 is the third process started o=
n the migration.
It is the one that does the vcpu ioctl's so I assume this is just the one r=
epresenting the vpu.
Well gdb should be more useful so looking with that.

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
