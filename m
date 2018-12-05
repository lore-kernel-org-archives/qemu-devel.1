Received: from eggs.gnu.org ([2001:4830:134:3::10]:43366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gUfns-0005by-Be
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gUfnn-0001nQ-Fa
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:38:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gUfnn-0001mN-6W
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:37:55 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  5 Dec 2018 22:37:23 +0000
Message-Id: <1544049446-6359-1-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 0/3] QEMU changes to do PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, stefanha@redhat.com, maran.wilson@oracle.com, liam.merwick@oracle.com

For certain applications it is desirable to rapidly boot a KVM virtual
machine. In cases where legacy hardware and software support within the
guest is not needed, QEMU should be able to boot directly into the
uncompressed Linux kernel binary with minimal firmware involvement.

There already exists an ABI to allow this for Xen PVH guests and the ABI
is supported by Linux and FreeBSD:

   https://xenbits.xen.org/docs/unstable/misc/pvh.html

Details on the Linux changes: https://lkml.org/lkml/2018/4/16/1002
qboot patches: http://patchwork.ozlabs.org/project/qemu-devel/list/?serie=
s=3D80020

This patch series provides QEMU support to read the ELF header of an
uncompressed kernel binary and get the 32-bit PVH kernel entry point
from an ELF Note.  This is called when initialising the machine state
in pc_memory_init().  Later on in load_linux() if the kernel entry
address is present, the uncompressed kernel binary (ELF) is loaded
and qboot does futher initialisation of the guest (e820, etc.) and
jumps to the kernel entry address and boots the guest.


Us=D1=96ng the method/scripts documented by the NEMU team at

   https://github.com/intel/nemu/wiki/Measuring-Boot-Latency
   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00200.html

below are some timings measured (vmlinux and bzImage from the same build)
Time to get to kernel start is almost halved (95=E1=B9=81s -> 48ms)

QEMU + qboot + vmlinux (PVH + 4.20-rc4)
 qemu_init_end: 41.550521
 fw_start: 41.667139 (+0.116618)
 fw_do_boot: 47.448495 (+5.781356)
 linux_startup_64: 47.720785 (+0.27229)
 linux_start_kernel: 48.399541 (+0.678756)
 linux_start_user: 296.952056 (+248.552515)

QEMU + qboot + bzImage:
 qemu_init_end: 29.209276
 fw_start: 29.317342 (+0.108066)
 linux_start_boot: 36.679362 (+7.36202)
 linux_startup_64: 94.531349 (+57.851987)
 linux_start_kernel: 94.900913 (+0.369564)
 linux_start_user: 401.060971 (+306.160058)

QEMU + bzImage:
 qemu_init_end: 30.424430
 linux_startup_64: 893.770334 (+863.345904)
 linux_start_kernel: 894.17049 (+0.400156)
 linux_start_user: 1208.679768 (+314.509278)


Liam Merwick (3):
  pvh: Add x86/HVM direct boot ABI header file
  pc: Read PVH entry point from ELF note in kernel binary
  pvh: Boot uncompressed kernel using direct boot ABI

 hw/i386/pc.c                | 344 ++++++++++++++++++++++++++++++++++++++=
+++++-
 include/elf.h               |  10 ++
 include/hw/xen/start_info.h | 146 +++++++++++++++++++
 3 files changed, 499 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/xen/start_info.h

--=20
1.8.3.1
