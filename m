Received: from eggs.gnu.org ([2001:4830:134:3::10]:56205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eS4jc-0003CU-SW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eS4ja-0007WX-Nv
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:34:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1eS4ja-0007VR-F9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:34:18 -0500
From: Jack Schwartz <jack.schwartz@oracle.com>
Date: Thu, 21 Dec 2017 09:25:14 -0800
Message-Id: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
Subject: [Qemu-devel] [PATCH QEMU v1 0/4] multiboot: bss_end_addr can be
 zero / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, daniel.kiper@oracle.com, konrad.wilk@oracle.com

Properly account for the possibility of multiboot kernels with a zero
bss_end_addr.  The Multiboot Specification, section 3.1.3 allows for
kernels without a bss section, by allowing a zeroed bss_end_addr multiboot
header field.

Do some cleanup to multiboot.c as well:
- Remove some unused variables.
- Use more intuitive header names when displaying fields in messages.
- Change fprintf(stderr...) to error_report

Testing:
  1) Ran the "make check" test suite.
  2) Booted multiboot kernel with bss_end_addr=0.  (I rolled my own
     grub multiboot.elf test "kernel" by modifying source.)  Verified
     with gdb that new code that reads addresses/offsets from multiboot
     header was accessed.
  3) Booted multiboot kernel with non-zero bss_end_addr.
  4) Uncommented DEBUG_MULTIBOOT in multiboot.c and verified messages worked.
  5) Code has soaked in an internal repo for two months.

	Thanks,
	Jack

Jack Schwartz (4):
  multiboot: bss_end_addr can be zero
  multiboot: Remove unused variables from multiboot.c
  multiboot: Use header names when displaying fields
  multiboot: fprintf(stderr...) -> error_report()

 hw/i386/multiboot.c | 77 ++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

-- 
1.8.3.1
