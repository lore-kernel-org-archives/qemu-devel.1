Received: from eggs.gnu.org ([2001:4830:134:3::10]:53437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dk5DV-0006zz-Ul
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dk5DU-0006nS-Fo
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:11:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dk5DU-0006nG-9g
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:11:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dk5DT-00029I-8V
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 09:11:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3F5B62E80CB
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 09:11:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Aug 2017 08:58:52 -0000
From: ChristianEhrhardt <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150339233236.8725.2618271632756711348.malone@soybean.canonical.com>
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

So this is failing I/O that iterates over a channel.
I was tracking down the len, pending and pos used.

I found that this is not completely broken (like no access or generla I/O e=
rror)
It starts at pos 0 and iterated with varying offsets, but works for quite s=
ome time.
Example:

[...]
Thread 1 "qemu-system-x86" hit Breakpoint 2, qemu_fill_buffer (f=3Df@entry=
=3D0xd3b66f3c00) at ./migration/qemu-file.c:295
295         if (len > 0) {
$11183 =3D 28728
$11184 =3D 4040
$11185 =3D {ops =3D 0xd3b3d740a0 <channel_input_ops>, hooks =3D 0x0, opaque=
 =3D 0xd3b75ee490, bytes_xfer =3D 0, xfer_limit =3D 0, pos =3D 107130146, =

  buf_index =3D 0, buf_size =3D 4040, =

  buf =3D "\v\327\a\000\021\000\[...]\000"..., =

  may_free =3D {0}, iov =3D {{iov_base =3D 0x0, iov_len =3D 0} <repeats 64 =
times>}, iovcnt =3D 0, last_error =3D 0}
[...]

Well you could see the whole file read passing by one by one buffer
Yet this isn't particularly fast, so track the one that has len=3D=3D0
 (gdb) b ./migration/qemu-file.c:295 if len =3D=3D 0

And I got it as:
(gdb) p *f
$11195 =3D {ops =3D 0xd3b3d740a0 <channel_input_ops>, hooks =3D 0x0, opaque=
 =3D 0xd3b75ee490, bytes_xfer =3D 0, xfer_limit =3D 0, pos =3D 319638837, =

  buf_index =3D 0, buf_size =3D 0, buf =3D '\000' <repeats 5504 times>..., =
may_free =3D {0}, iov =3D {{iov_base =3D 0x0, iov_len =3D 0} <repeats 64 ti=
mes>}, =

  iovcnt =3D 0, last_error =3D 0}

Here pending =3D=3D 0 so buf_size =3D 0 as well also pos is further down
incremented to 319638837.

Checking in detail I found that I had pending=3D0 and buf_size=3D0 as well =
as non aligned pos entried, but they worked.
So I excluded the buf_size=3D0/pending=3D0 as well as the alignment as reas=
ons.
Maybe it just iterates pos out of the range that is working?

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
