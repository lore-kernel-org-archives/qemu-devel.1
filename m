Received: from eggs.gnu.org ([2001:4830:134:3::10]:52501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhxm-0004Pf-Pv
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhxl-0007Do-Fq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:42:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:44 +0100
Message-Id: <20181105163744.25139-37-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/36] include: Add a comment to explain the
 origin of sizes' lookup table
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

The lookup table for power-of-two sizes was added in commit 540b8492618eb
for the purpose of having convenient shortcuts for these sizes in cases
when the literal number has to be present at compile time, and
expressions as '(1 * KiB)' can not be used. One such case is the
stringification of sizes. Beyond that, it is convenient to use these
shortcuts for all power-of-two sizes, even if they don't have to be
literal numbers.

Despite its convenience, this table introduced 55 lines of "dumb" code,
the purpose and origin of which are obscure without reading the message
of the commit which introduced it. This patch fixes that by adding a
comment to the code itself with a brief explanation for the reasoning
behind this table. This comment includes the short AWK script that
generated the table, so that anyone who's interested could make sure
that the values in it are correct (otherwise these values look as if
they were typed manually).

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/units.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/qemu/units.h b/include/qemu/units.h
index 68a7758650..1c959d182e 100644
--- a/include/qemu/units.h
+++ b/include/qemu/units.h
@@ -17,6 +17,24 @@
 #define PiB     (INT64_C(1) << 50)
 #define EiB     (INT64_C(1) << 60)
=20
+/*
+ * The following lookup table is intended to be used when a literal stri=
ng of
+ * the number of bytes is required (for example if it needs to be string=
ified).
+ * It can also be used for generic shortcuts of power-of-two sizes.
+ * This table is generated using the AWK script below:
+ *
+ *  BEGIN {
+ *      suffix=3D"KMGTPE";
+ *      for(i=3D10; i<64; i++) {
+ *          val=3D2**i;
+ *          s=3Dsubstr(suffix, int(i/10), 1);
+ *          n=3D2**(i%10);
+ *          pad=3D21-int(log(n)/log(10));
+ *          printf("#define S_%d%siB %*d\n", n, s, pad, val);
+ *      }
+ *  }
+ */
+
 #define S_1KiB                  1024
 #define S_2KiB                  2048
 #define S_4KiB                  4096
--=20
2.19.1
