Received: from eggs.gnu.org ([2001:4830:134:3::10]:42034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBa-0001qn-QO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBX-00012X-Eb
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58861
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBX-00012E-7l
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jfFZ079855
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:10 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm78yw9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:10 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:09 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:05 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-12-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 11/67] qemu-char: avoid segfault if user lacks
 of permisson of a given logfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Lin Ma <lma@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Lin Ma <lma@suse.com>

Function qemu_chr_alloc returns NULL if it failed to open logfile by any reason,
says no write permission. For backends tty, stdio and msmouse, They need to
check this return value to avoid segfault in this case.

Signed-off-by: Lin Ma <lma@suse.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-Id: <20160914062250.22226-1-lma@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 71200fb9664c2967a1cdd22b68b0da3a8b2b3eb7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 backends/msmouse.c | 3 +++
 qemu-char.c        | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/backends/msmouse.c b/backends/msmouse.c
index aeb9055..aceb6dc 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -159,6 +159,9 @@ static CharDriverState *qemu_chr_open_msmouse(const char *id,
     CharDriverState *chr;
 
     chr = qemu_chr_alloc(common, errp);
+    if (!chr) {
+        return NULL;
+    }
     chr->chr_write = msmouse_chr_write;
     chr->chr_close = msmouse_chr_close;
     chr->chr_accept_input = msmouse_chr_accept_input;
diff --git a/qemu-char.c b/qemu-char.c
index 5f82ebb..fdb23f5 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1223,6 +1223,9 @@ static CharDriverState *qemu_chr_open_stdio(const char *id,
     sigaction(SIGCONT, &act, NULL);
 
     chr = qemu_chr_open_fd(0, 1, common, errp);
+    if (!chr) {
+        return NULL;
+    }
     chr->chr_close = qemu_chr_close_stdio;
     chr->chr_set_echo = qemu_chr_set_echo_stdio;
     if (opts->has_signal) {
@@ -1679,6 +1682,9 @@ static CharDriverState *qemu_chr_open_tty_fd(int fd,
 
     tty_serial_init(fd, 115200, 'N', 8, 1);
     chr = qemu_chr_open_fd(fd, fd, backend, errp);
+    if (!chr) {
+        return NULL;
+    }
     chr->chr_ioctl = tty_serial_ioctl;
     chr->chr_close = qemu_chr_close_tty;
     return chr;
-- 
1.9.1
