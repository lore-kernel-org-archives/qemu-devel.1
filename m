Received: from eggs.gnu.org ([2001:4830:134:3::10]:39793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzRn-00054p-PI
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzRj-0007aN-2D
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:55 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Dec 2017 17:53:52 +0100
Message-Id: <20171207165355.7559-8-david@redhat.com>
In-Reply-To: <20171207165355.7559-1-david@redhat.com>
References: <20171207165355.7559-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 07/10] s390x/tcg: Implement SIGNAL
 ADAPTER instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

KVM suppresses SIGA, setting cc=3. Let's do the same for TCG, so we're at
least equal.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 1 +
 target/s390x/translate.c   | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index c7353e7f11..f7b66b0091 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1056,6 +1056,7 @@
     C(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, rsch, 0)
     C(0xb237, SAL,     S,     Z,   0, 0, 0, 0, sal, 0)
     C(0xb23c, SCHM,    S,     Z,   0, insn, 0, 0, schm, 0)
+    C(0xb274, SIGA,    S,     Z,   0, 0, 0, 0, siga, 0)
     C(0xb23a, STCPS,   S,     Z,   0, 0, 0, 0, stcps, 0)
     C(0xb233, SSCH,    S,     Z,   0, insn, 0, 0, ssch, 0)
     C(0xb239, STCRW,   S,     Z,   0, insn, 0, 0, stcrw, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5c2432678c..1e4079464a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4102,6 +4102,14 @@ static ExitStatus op_schm(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_siga(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    /* From KVM code: Not provided, set CC = 3 for subchannel not operational */
+    gen_op_movi_cc(s, 3);
+    return NO_EXIT;
+}
+
 static ExitStatus op_stcps(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-- 
2.14.3
