Received: from eggs.gnu.org ([2001:4830:134:3::10]:51386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLrK7-0000sP-Uk
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLrK4-0006v8-6m
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:02:20 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Dec 2017 15:01:46 +0100
Message-Id: <20171204140150.20483-6-david@redhat.com>
In-Reply-To: <20171204140150.20483-1-david@redhat.com>
References: <20171204140150.20483-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 5/9] s390x/tcg: Implement STORE
 CHANNEL PATH STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Just like KVM does, we should suppress this instruction:
    When this instruction is not provided, it is
    checked for privileged operation exception and the
    instruction is suppressed by the machine

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 1 +
 target/s390x/translate.c   | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index e21d226092..c7353e7f11 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1056,6 +1056,7 @@
     C(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, rsch, 0)
     C(0xb237, SAL,     S,     Z,   0, 0, 0, 0, sal, 0)
     C(0xb23c, SCHM,    S,     Z,   0, insn, 0, 0, schm, 0)
+    C(0xb23a, STCPS,   S,     Z,   0, 0, 0, 0, stcps, 0)
     C(0xb233, SSCH,    S,     Z,   0, insn, 0, 0, ssch, 0)
     C(0xb239, STCRW,   S,     Z,   0, insn, 0, 0, stcrw, 0)
     C(0xb234, STSCH,   S,     Z,   0, insn, 0, 0, stsch, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index bd3fc6448e..5c2432678c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4102,6 +4102,13 @@ static ExitStatus op_schm(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_stcps(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    /* The instruction is suppressed if not provided. */
+    return NO_EXIT;
+}
+
 static ExitStatus op_ssch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-- 
2.14.3
