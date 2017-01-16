Received: from eggs.gnu.org ([2001:4830:134:3::10]:42234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7ap-0004sw-2i
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7ao-0005H4-7Y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7ao-0005Gs-2Y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:44:53 +0000
Message-Id: <20170116134455.28636-3-stefanha@redhat.com>
In-Reply-To: <20170116134455.28636-1-stefanha@redhat.com>
References: <20170116134455.28636-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] trace: Lock vCPU list when initializing
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

Fixes potential corruption when a vCPU is hot-(un)plugged while
initializing the current one.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Message-id: 148278747515.1404.6538173443841279200.stgit@fimbulvetr.bsc.es
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control-target.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 7ebf6e0..e2e138a 100644
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
--=20
2.9.3
