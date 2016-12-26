Received: from eggs.gnu.org ([2001:4830:134:3::10]:49422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl7-0007nw-0K
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl2-0001yq-Oq
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:41 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:44295)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl2-0001yc-Bz
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:36 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 26 Dec 2016 22:24:35 +0100
Message-Id: <148278747515.1404.6538173443841279200.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
References: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] trace: Lock vCPU list when initializing
 dynamic tracing state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Fixes potential corruption when a vCPU is hot-(un)plugged while
initializing the current one.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 trace/control-target.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 7ebf6e0bcb..e2e138a3f0 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -79,7 +79,7 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
     }
 }
=20
-static bool adding_first_cpu(void)
+static bool adding_first_cpu1(void)
 {
     CPUState *cpu;
     size_t count =3D 0;
@@ -92,6 +92,15 @@ static bool adding_first_cpu(void)
     return true;
 }
=20
+static bool adding_first_cpu(void)
+{
+    bool res;
+    cpu_list_lock();
+    res =3D adding_first_cpu1();
+    cpu_list_unlock();
+    return res;
+}
+
 void trace_init_vcpu(CPUState *vcpu)
 {
     TraceEventIter iter;
