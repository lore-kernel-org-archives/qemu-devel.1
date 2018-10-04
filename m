Received: from eggs.gnu.org ([2001:4830:134:3::10]:60635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1g84eE-0007CE-Qm
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1g84eA-0006VI-JO
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:30:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1g84eA-00066b-9Y
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:30:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w94EOmF1097310
	for <qemu-devel@nongnu.org>; Thu, 4 Oct 2018 10:30:22 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mwksj2yqj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 10:30:22 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Thu, 4 Oct 2018 08:30:15 -0600
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Thu,  4 Oct 2018 11:30:09 -0300
Message-Id: <20181004143009.24693-1-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] tracetool: Include thread id information in
 log backend
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

Currently the log backend prints the process id of QEMU at the start
of each output line, but since threads share the same PID there is no
clear distinction between their outputs.

Having the thread id present in the log makes it easier to see when
output comes from different threads. E.g.:

12423@1538597569.672527:qemu_mutex_lock waiting on mutex 0x1103ee60 (/root/qemu/util/main-loop.c:236)
...
12430@1538597569.503928:qemu_mutex_unlock released mutex 0x1103ee60 (/root/qemu/cpus.c:1238)
12431@1538597569.503937:qemu_mutex_locked taken mutex 0x1103ee60 (/root/qemu/cpus.c:1257)
^here

In the above, 12423 is the main process id and 12430 & 12431 are the
two vcpu threads.

 (qemu) info cpus
 * CPU #0: thread_id=12430
   CPU #1: thread_id=12431

Suggested-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 scripts/tracetool/backend/log.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 6751f41bc5..33c95af8e9 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -39,7 +39,7 @@ def generate_h(event, group):
         '        struct timeval _now;',
         '        gettimeofday(&_now, NULL);',
         '        qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
-        '                 getpid(),',
+        '                 qemu_get_thread_id(),',
         '                 (size_t)_now.tv_sec, (size_t)_now.tv_usec',
         '                 %(argnames)s);',
         '    }',
-- 
2.17.1
