Received: from eggs.gnu.org ([2001:4830:134:3::10]:39259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6s-00033M-7k
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6r-0005WU-AY
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:46 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Dec 2017 17:02:03 +0100
Message-Id: <20171208160207.26494-11-david@redhat.com>
In-Reply-To: <20171208160207.26494-1-david@redhat.com>
References: <20171208160207.26494-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 10/14] s390x/tcg: Implement STORE
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Just like KVM does, we should suppress this instruction:
    When this instruction is not provided, it is
    checked for privileged operation exception and the
    instruction is suppressed by the machine

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 1 +
 target/s390x/translate.c   | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 0c225d5e78..2e47a6b5bc 100644
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
index 8cf35a7b49..16febf4274 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4132,6 +4132,13 @@ static ExitStatus op_schm(DisasContext *s, DisasOps *o)
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
