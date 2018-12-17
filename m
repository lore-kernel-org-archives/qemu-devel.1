Received: from eggs.gnu.org ([2001:4830:134:3::10]:48732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gYzhi-000066-MX
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gYzTj-0005Oo-VS
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:27:04 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:45328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gYzTj-0005Nh-NY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:27:03 -0500
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 860134193F
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 20:27:02 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a3n8KS8GPGQO for <qemu-devel@nongnu.org>;
	Mon, 17 Dec 2018 23:27:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
	[172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id AEC8C4193A
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:27:01 +0300 (MSK)
From: Roman Bolshakov <r.bolshakov@yadro.com>
Date: Mon, 17 Dec 2018 23:26:02 +0300
Message-ID: <20181217202602.31113-3-r.bolshakov@yadro.com>
In-Reply-To: <20181217202602.31113-1-r.bolshakov@yadro.com>
References: <20181217202602.31113-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 2/2] qemu-thread: Don't block SEGV, ILL and FPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>

If any of these signals happen on macOS, they are not delivered to other
threads and signalfd_compat receives nothing. Indeed, POSIX reference
and sigprocmask(2) note that an attempt to block the signals results in
undefined behaviour. SEGV and FPE can't also be received by signalfd(2)
on Linux.

An ability to retrieve SIGBUS via signalfd(2) is used by QEMU for
memory preallocation therefore we can't unblock it without consequences.
But it's important to leave a remark that the signal is lost on macOS.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 util/qemu-thread-posix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index c6934bd22c..1bf5e65dea 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -524,6 +524,11 @@ void qemu_thread_create(QemuThread *thread, const ch=
ar *name,
=20
     /* Leave signal handling to the iothread.  */
     sigfillset(&set);
+    /* Blocking the signals can result in undefined behaviour. */
+    sigdelset(&set, SIGSEGV);
+    sigdelset(&set, SIGFPE);
+    sigdelset(&set, SIGILL);
+    /* TODO avoid SIGBUS loss on macOS */
     pthread_sigmask(SIG_SETMASK, &set, &oldset);
=20
     qemu_thread_args =3D g_new0(QemuThreadArgs, 1);
--=20
2.19.1
