Received: from eggs.gnu.org ([2001:4830:134:3::10]:55475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dk7On-0002Es-GH
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dk7Ok-0002Ie-6N
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:31:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:58739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dk7Oj-0002IA-Vm
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:31:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dk7Oh-0003fJ-86
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 11:31:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 13B8E2E80D2
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 11:31:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Aug 2017 11:14:16 -0000
From: ChristianEhrhardt <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150340045615.16960.1843317285899726298.malone@gac.canonical.com>
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

Stack from qemu_fill_buffer to qio_channel_socket_readv
#0  qio_channel_socket_readv (ioc=3D<optimized out>, iov=3D<optimized out>,=
 niov=3D<optimized out>, fds=3D0x0, nfds=3D0x0, errp=3D0x0)
    at ./io/channel-socket.c:477
#1  0x0000001486ec97e2 in qio_channel_read (ioc=3Dioc@entry=3D0x148a73a6c0, =

    buf=3Dbuf@entry=3D\060\nLw", buflen=3Dbuflen@entry=3D28728, errp=3Derrp=
@entry=3D0x0) at ./io/channel.c:112
#2  0x0000001486e005ec in channel_get_buffer (opaque=3D<optimized out>, =

    buf=3D0x1489844c00 "\060\nLw", pos=3D<optimized out>, size=3D28728) at =
./migration/qemu-file-channel.c:80
#3  0x0000001486dff095 in qemu_fill_buffer (f=3Df@entry=3D0x1489843c00) at =
./migration/qemu-file.c:293

I checked that sioc->fd, &msg, sflags) is in fact the socket.
With e.g. with this fd being 27
tcp    ESTAB      1405050 0      ::ffff:10.22.69.30:49152                  =
 ::ffff:10.22.69.157:49804                 users:(("qemu-system-x86",pid=3D=
29273,fd=3D27)) ino:3345152 sk:30 <->
         skmem:(r1420644,rb1495660,t0,tb332800,f668,w0,o0,bl0,d14) ts sack =
cubic wscale:7,7 rto:200 rtt:0.04/0.02 ato:80 mss:8948 cwnd:10 bytes_receiv=
ed:1981460 segs_out:37 segs_in:247 data_segs_in:231 send 17896.0Mbps lastsn=
d:254728 lastrcv:250372 lastack:250372 rcv_rtt:0.205 rcv_space:115461 minrt=
t:0.04

I need to break on the fail of that recvmsg in qio_channel_socket_readv
# the following does not work due to optimization the ret value is only aro=
und later
b io/channel-socket.c:478 if ret < 0
But catching it "inside" the if works
b io/channel-socket.c:479


Take the following with a grain of salt, this is very threaded and noisy to=
 debug.

Once I hit it the recmsg returned "-1", that was on f->pos =3D 311641887
But at the same time I could confirm (via ss) that the socket itself is sti=
ll open on source and target of the migration.

-1  is EAGAIN and returns QIO_CHANNEL_ERR_BLOCK
That seems to arrive in nbd_rwv nbd/common.c:44).
And led to "qio_channel_yield"

There are a few corouting switches in between so I hope I'm not loosing any=
thing.
But that first ret<0 actually worked, it seems the yield and retry got it w=
orking.

I got back to qemu_fill_buffer iterating further after this.
This hit ret<0 in qio_channel_socket_readv again at f->pos 311641887.

This time on returning the QIO_CHANNEL_ERR_BLOCK it returned to "./migratio=
n/qemu-file-channel.c:81".
That was interesting as it is different than before.
After this it seemed to become a death spiral - recmsg returned -1 every ti=
me (still on the same offset).
It passed back through the nbd_rwv which called qio_channel_yield for multi=
ple times.

Then it continued and later on on 321998304 is the last I saw.
It did no more pass b io/channel-socket.c:479 at all, but then led to the e=
xit.

Hmm, I might have lost myself on the coroutine switches - but it is odd at =
least.
Trying to redo less interactive and with a bit more prep ...
Maybe the results are more reliable then ...

Getting back with more later ...

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
