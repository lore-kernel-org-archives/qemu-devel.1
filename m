Received: from eggs.gnu.org ([2001:4830:134:3::10]:57909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rD-0002XF-LB
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0007Ja-Pb
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:50 +0200
Message-Id: <20181001171901.11004-13-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/23] include: Add a lookup table of sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Leonid Bloch <lbloch@janustech.com>

Adding a lookup table for the powers of two, with the appropriate size
prefixes. This is needed when a size has to be stringified, in which
case something like '(1 * KiB)' would become a literal '(1 * (1L << 10))'
string. Powers of two are used very often for sizes, so such a table
will also make it easier and more intuitive to write them.

This table is generatred using the following AWK script:

BEGIN {
	suffix="KMGTPE";
	for(i=10; i<64; i++) {
		val=2**i;
		s=substr(suffix, int(i/10), 1);
		n=2**(i%10);
		pad=21-int(log(n)/log(10));
		printf("#define S_%d%siB %*d\n", n, s, pad, val);
	}
}

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/units.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/qemu/units.h b/include/qemu/units.h
index 692db3fbb2..68a7758650 100644
--- a/include/qemu/units.h
+++ b/include/qemu/units.h
@@ -17,4 +17,59 @@
 #define PiB     (INT64_C(1) << 50)
 #define EiB     (INT64_C(1) << 60)
 
+#define S_1KiB                  1024
+#define S_2KiB                  2048
+#define S_4KiB                  4096
+#define S_8KiB                  8192
+#define S_16KiB                16384
+#define S_32KiB                32768
+#define S_64KiB                65536
+#define S_128KiB              131072
+#define S_256KiB              262144
+#define S_512KiB              524288
+#define S_1MiB               1048576
+#define S_2MiB               2097152
+#define S_4MiB               4194304
+#define S_8MiB               8388608
+#define S_16MiB             16777216
+#define S_32MiB             33554432
+#define S_64MiB             67108864
+#define S_128MiB           134217728
+#define S_256MiB           268435456
+#define S_512MiB           536870912
+#define S_1GiB            1073741824
+#define S_2GiB            2147483648
+#define S_4GiB            4294967296
+#define S_8GiB            8589934592
+#define S_16GiB          17179869184
+#define S_32GiB          34359738368
+#define S_64GiB          68719476736
+#define S_128GiB        137438953472
+#define S_256GiB        274877906944
+#define S_512GiB        549755813888
+#define S_1TiB         1099511627776
+#define S_2TiB         2199023255552
+#define S_4TiB         4398046511104
+#define S_8TiB         8796093022208
+#define S_16TiB       17592186044416
+#define S_32TiB       35184372088832
+#define S_64TiB       70368744177664
+#define S_128TiB     140737488355328
+#define S_256TiB     281474976710656
+#define S_512TiB     562949953421312
+#define S_1PiB      1125899906842624
+#define S_2PiB      2251799813685248
+#define S_4PiB      4503599627370496
+#define S_8PiB      9007199254740992
+#define S_16PiB    18014398509481984
+#define S_32PiB    36028797018963968
+#define S_64PiB    72057594037927936
+#define S_128PiB  144115188075855872
+#define S_256PiB  288230376151711744
+#define S_512PiB  576460752303423488
+#define S_1EiB   1152921504606846976
+#define S_2EiB   2305843009213693952
+#define S_4EiB   4611686018427387904
+#define S_8EiB   9223372036854775808
+
 #endif
-- 
2.13.6
