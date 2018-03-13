Received: from eggs.gnu.org ([2001:4830:134:3::10]:34174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evo9G-00028B-6H
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evo9B-0004AW-Ax
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:55:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:56640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1evo9B-00048l-4G
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:55:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1evo99-0006g2-Qn
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 17:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C38E32E806B
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 17:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Mar 2018 17:48:25 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1755479 <1755479@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152094809386.3778.6282045564987107259.malonedeb@gac.canonical.com>
Message-Id: <152096330564.15385.12269811726989702954.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1755479] Re: Cortex M:qemu abort with optimized
 code and icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, it looks like we accidentally broke icount. This patch from the mailin=
g list fixes it:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06595.html

though it hasn't been code-reviewed yet.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1755479

Title:
  Cortex M:qemu abort with optimized code and icount

Status in QEMU:
  New

Bug description:
  A basic program runs fine if compiled with flag -O0 with gcc, but trigger=
s a qemu abort when compiled with -O1 and run with icount:
  "qemu: fatal: IO on conditional branch instruction"

  I also noticed the problem on C source like this with -O0:
  "int foo =3D *bar; bar++;" : OK
  "int foo =3D *bar++;" : FAIL (!!!)

  Optimized binary attached to this ticket.

  command line:
  qemu-system-arm -M lm3s6965evb -nographic -kernel hello.bin -serial file:=
$(tty) -icount 4 -cpu cortex-m4
  (working fine without icount)

  version: =

  QEMU emulator version 2.11.50 (v2.11.0-2146-gd9bbfea-dirty)

  Compilation options:
  ./configure --target-list=3Darm-softmmu --disable-slirp --disable-blobs -=
-disable-docs --disable-guest-agent --disable-gnutls --disable-nettle --dis=
able-gcrypt --disable-sdl --disable-gtk --disable-vnc --disable-virtfs --di=
sable-mpath --disable-xen --disable-brlapi --disable-curl --disable-bluez -=
-disable-kvm --disable-hax --disable-hvf --disable-whpx --disable-rdma --di=
sable-vde --disable-netmap --disable-linux-aio --disable-cap-ng --disable-a=
ttr --disable-vhost-net --disable-spice --disable-rbd --disable-libiscsi --=
disable-libnfs --disable-smartcard --disable-libusb --disable-live-block-mi=
gration --disable-usb-redir --disable-lzo --disable-snappy --disable-bzip2 =
--disable-seccomp --disable-glusterfs --disable-tpm --disable-libssh2 --dis=
able-numa --disable-libxml2 --disable-tcmalloc --disable-jemalloc --disable=
-replication --disable-vhost-vsock --disable-opengl --disable-virglrenderer=
 --disable-xfsctl --disable-qom-cast-debug --disable-vxhs --disable-crypto-=
afalg --disable-vhost-user --disable-capstone --disable-pie --extra-cflags=
=3D-mtune=3Dnative

  I have also tested previous versions:
  - stock qemu-system-arm 2.5.0 from ubuntu 16.04: OK
  - git version: QEMU emulator version 2.10.0 (v2.10.2-dirty): OK
  - git version: QEMU emulator version 2.10.90 (v2.11.0-rc0-dirty): FAIL

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1755479/+subscriptions
