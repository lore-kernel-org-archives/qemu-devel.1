Received: from eggs.gnu.org ([2001:4830:134:3::10]:40596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gJMoF-0004P3-4I
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 13:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gJMoB-0002SQ-8s
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 13:07:38 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Sun, 4 Nov 2018 18:07:28 +0000
Message-ID: <20181104180657.7471-2-lbloch@janustech.com>
References: <20181104180657.7471-1-lbloch@janustech.com>
In-Reply-To: <20181104180657.7471-1-lbloch@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 1/1] include: Add a comment to explain the
 origin of sizes' lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, Leonid Bloch <lbloch@janustech.com>

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
+ * The following lookup table is intended to be used when a literal string=
 of
+ * the number of bytes is required (for example if it needs to be stringif=
ied).
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
2.17.1
