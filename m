Received: from eggs.gnu.org ([2001:4830:134:3::10]:49428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g6vwZ-0002e4-LJ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g6vwU-00039f-Kv
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:00:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:41966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g6vwU-00038L-Cu
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:00:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g6vwS-00044C-L1
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 11:00:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 995342E8082
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 11:00:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Oct 2018 10:51:01 -0000
From: Artem Pisarenko <1795369@bugs.launchpad.net>
Reply-To: Bug 1795369 <1795369@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153839106192.31215.12352296438682774073.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1795369] [NEW] Record/replay (icount rr) causes
 emulation hang or exit with error about missing events in log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Test case description:

Guest image is Linux, which just powers off after kernel boots (instead of =
proceeding to user-space /init or /sbin/init).
Base cmdline:
  qemu-system-x86_64 \
    -nodefaults -nographic -machine pc,accel=3Dtcg -m 2048 -cpu qemu64 \
    -kernel bzImage -initrd rootfs -append 'nokaslr console=3DttyS0 rdinit=
=3D/init_poweroff' \
    -serial SERIAL_VALUE \
    -rtc clock=3Dvm,base=3D2000-01-01T00:00:00 \
    -icount 1,sleep=3Doff,rr=3DRR_VALUE,rrfile=3Dicount_rr_capture.bin

Test 1.
When SERIAL_VALUE=3Dnone
Running with RR_VALUE=3Drecord completes successfully.
Running with RR_VALUE=3Dreplay doesn't completes. qemu process just eating =
~100% cpu and memory usage doesn't grow after some moment. I don't see what=
 happens because of problem no.2 (see below).

Test 2.
When SERIAL_VALUE=3Dstdio
Running with RR_VALUE=3Drecord completes successfully.
Running with RR_VALUE=3Dreplay causes exit with error:
"qemu-system-x86_64: Missing character write event in the replay log"

Tests 3,4,5...
SERIAL_VALUE=3Dstdio. Playing with "-rtc" clock and base suboptions, "-icou=
nt" sleep suboptions produces non-repeatable results.
In most cases running with RR_VALUE=3Drecord completes successfully (but ma=
y hang at very begining).
Running with RR_VALUE=3Dreplay with combinations of removing "-rtc base=3D.=
.." and "-icount sleep=3D..." goes better, but at different places of boot =
process it may either hang (as in test 1) or exit with error (as in test 2).
When qemu "hangs", it may also happen differently: either it can be stopped=
 by Ctrl-C, or have to be killed.


Guest image uploaded here: https://drive.google.com/open?id=3D1SHG4HyBdcPut=
c5Au4pyhN8z9w52et51A

QEMU built from master (commit 042938f46e1c477419d1931381fdadffaa49d45e) wi=
th:
<SRC_ROOT>/configure --prefix=3D<INSTALL_ROOT> --target-list=3Dx86_64-softm=
mu --enable-debug --disable-pie --enable-tcg --disable-tcg-interpreter --en=
able-virtfs --disable-docs --disable-guest-agent --disable-modules --disabl=
e-gnutls --disable-nettle --disable-gcrypt --disable-sdl --disable-curses -=
-disable-vnc --disable-vnc-sasl --disable-vnc-jpeg --disable-vnc-png --disa=
ble-cocoa --disable-xen --disable-xen-pci-passthrough --disable-brlapi --di=
sable-curl --disable-fdt --disable-bluez --disable-kvm --disable-hax --disa=
ble-hvf --disable-whpx --disable-rdma --disable-vde --disable-netmap --disa=
ble-cap-ng --disable-spice --disable-rbd --disable-libiscsi --disable-libnf=
s --disable-smartcard --disable-libusb --disable-live-block-migration --dis=
able-usb-redir --disable-glusterfs --disable-tpm --disable-libssh2 --disabl=
e-numa --disable-libxml2 --disable-opengl --disable-virglrenderer --disable=
-qom-cast-debug --disable-tools --disable-vxhs --disable-crypto-afalg --dis=
able-capstone --disable-replication --disable-xfsctl --disable-seccomp --di=
sable-pvrdma --disable-libpmem

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1795369

Title:
  Record/replay (icount rr) causes emulation hang or exit with error
  about missing events in log

Status in QEMU:
  New

Bug description:
  Test case description:

  Guest image is Linux, which just powers off after kernel boots (instead o=
f proceeding to user-space /init or /sbin/init).
  Base cmdline:
    qemu-system-x86_64 \
      -nodefaults -nographic -machine pc,accel=3Dtcg -m 2048 -cpu qemu64 \
      -kernel bzImage -initrd rootfs -append 'nokaslr console=3DttyS0 rdini=
t=3D/init_poweroff' \
      -serial SERIAL_VALUE \
      -rtc clock=3Dvm,base=3D2000-01-01T00:00:00 \
      -icount 1,sleep=3Doff,rr=3DRR_VALUE,rrfile=3Dicount_rr_capture.bin

  Test 1.
  When SERIAL_VALUE=3Dnone
  Running with RR_VALUE=3Drecord completes successfully.
  Running with RR_VALUE=3Dreplay doesn't completes. qemu process just eatin=
g ~100% cpu and memory usage doesn't grow after some moment. I don't see wh=
at happens because of problem no.2 (see below).

  Test 2.
  When SERIAL_VALUE=3Dstdio
  Running with RR_VALUE=3Drecord completes successfully.
  Running with RR_VALUE=3Dreplay causes exit with error:
  "qemu-system-x86_64: Missing character write event in the replay log"

  Tests 3,4,5...
  SERIAL_VALUE=3Dstdio. Playing with "-rtc" clock and base suboptions, "-ic=
ount" sleep suboptions produces non-repeatable results.
  In most cases running with RR_VALUE=3Drecord completes successfully (but =
may hang at very begining).
  Running with RR_VALUE=3Dreplay with combinations of removing "-rtc base=
=3D..." and "-icount sleep=3D..." goes better, but at different places of b=
oot process it may either hang (as in test 1) or exit with error (as in tes=
t 2).
  When qemu "hangs", it may also happen differently: either it can be stopp=
ed by Ctrl-C, or have to be killed.

  =

  Guest image uploaded here: https://drive.google.com/open?id=3D1SHG4HyBdcP=
utc5Au4pyhN8z9w52et51A

  QEMU built from master (commit 042938f46e1c477419d1931381fdadffaa49d45e) =
with:
  <SRC_ROOT>/configure --prefix=3D<INSTALL_ROOT> --target-list=3Dx86_64-sof=
tmmu --enable-debug --disable-pie --enable-tcg --disable-tcg-interpreter --=
enable-virtfs --disable-docs --disable-guest-agent --disable-modules --disa=
ble-gnutls --disable-nettle --disable-gcrypt --disable-sdl --disable-curses=
 --disable-vnc --disable-vnc-sasl --disable-vnc-jpeg --disable-vnc-png --di=
sable-cocoa --disable-xen --disable-xen-pci-passthrough --disable-brlapi --=
disable-curl --disable-fdt --disable-bluez --disable-kvm --disable-hax --di=
sable-hvf --disable-whpx --disable-rdma --disable-vde --disable-netmap --di=
sable-cap-ng --disable-spice --disable-rbd --disable-libiscsi --disable-lib=
nfs --disable-smartcard --disable-libusb --disable-live-block-migration --d=
isable-usb-redir --disable-glusterfs --disable-tpm --disable-libssh2 --disa=
ble-numa --disable-libxml2 --disable-opengl --disable-virglrenderer --disab=
le-qom-cast-debug --disable-tools --disable-vxhs --disable-crypto-afalg --d=
isable-capstone --disable-replication --disable-xfsctl --disable-seccomp --=
disable-pvrdma --disable-libpmem

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1795369/+subscriptions
