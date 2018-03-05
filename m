Received: from eggs.gnu.org ([2001:4830:134:3::10]:36211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eslgM-0008CY-8E
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eslgJ-0007F4-1U
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:41:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eslgI-0007EW-Qb
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:41:14 -0500
Date: Mon, 5 Mar 2018 08:41:11 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180305084111.GM2450@redhat.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <1519998711-73430-1-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The attached patch is also needed to avoid crashes during various
math-heavy test suites.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-softfloat-fix-crash-on-int-conversion-of-SNaN.patch"

>From 8465cbda688cdc65dfe4037608c14cac087eae03 Mon Sep 17 00:00:00 2001
From: Stef O'Rear <sorear2@gmail.com>
Date: Sat, 3 Mar 2018 03:46:00 -0800
Subject: [PATCH] softfloat: fix crash on int conversion of SNaN

Signed-off-by: Stef O'Rear <sorear2@gmail.com>
---
 fpu/softfloat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e7fb0d357a..1da1db377e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1342,6 +1342,8 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
+    case float_class_dnan:
+    case float_class_msnan:
         return max;
     case float_class_inf:
         return p.sign ? min : max;
@@ -1430,6 +1432,8 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
+    case float_class_dnan:
+    case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
     case float_class_inf:
-- 
2.15.1


--xgyAXRrhYN0wYx8y--
