Received: from eggs.gnu.org ([2001:4830:134:3::10]:43885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ii-0005Eo-AP
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8if-0007xb-Ks
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60746
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8if-0007x0-F6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:53 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEJcV056297
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:53 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fygjbwcmx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:52 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:52 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:47 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180206191515.25830-27-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 26/54] linux-user: Fix locking order in
 fork_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

Our locking order is that the tb lock should be taken
inside the mmap_lock, but fork_start() grabs locks the
other way around. This means that if a heavily multithreaded
guest process (such as Java) calls fork() it can deadlock,
with the thread that called fork() stuck in fork_start()
with the tb lock and waiting for the mmap lock, but some
other thread in tb_find() with the mmap lock and waiting
for the tb lock. The cpu_list_lock() should also always be
taken last, not first.

Fix this by making fork_start() grab the locks in the
right order. The order in which we drop locks doesn't
matter, so we leave fork_end() the way it is.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <1512397331-15238-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 024949caf32805f4cc3e7d363a80084b47aac1f6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 6286661bd3..146ee3e4ba 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -128,9 +128,9 @@ int cpu_get_pic_interrupt(CPUX86State *env)
 /* Make sure everything is in a consistent state for calling fork().  */
 void fork_start(void)
 {
-    cpu_list_lock();
-    qemu_mutex_lock(&tb_ctx.tb_lock);
     mmap_fork_start();
+    qemu_mutex_lock(&tb_ctx.tb_lock);
+    cpu_list_lock();
 }
=20
 void fork_end(int child)
--=20
2.11.0
