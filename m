Received: from eggs.gnu.org ([2001:4830:134:3::10]:50440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1ZU-00052J-3L
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1ZP-0001nW-5l
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gX1ZO-0001iP-UN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:16:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 12 Dec 2018 10:16:31 +0000
Message-Id: <20181212101632.2600-2-stefanha@redhat.com>
In-Reply-To: <20181212101632.2600-1-stefanha@redhat.com>
References: <20181212101632.2600-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] tracetool: Include thread id information in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@linux.ibm.com>

From: Fabiano Rosas <farosas@linux.ibm.com>

Currently the log backend prints the process id of QEMU at the start
of each output line, but since threads share the same PID there is no
clear distinction between their outputs.

Having the thread id present in the log makes it easier to see when
output comes from different threads. E.g.:

12423@1538597569.672527:qemu_mutex_lock waiting on mutex 0x1103ee60 (/roo=
t/qemu/util/main-loop.c:236)
...
12430@1538597569.503928:qemu_mutex_unlock released mutex 0x1103ee60 (/roo=
t/qemu/cpus.c:1238)
12431@1538597569.503937:qemu_mutex_locked taken mutex 0x1103ee60 (/root/q=
emu/cpus.c:1257)
^here

In the above, 12423 is the main process id and 12430 & 12431 are the
two vcpu threads.

 (qemu) info cpus
 * CPU #0: thread_id=3D12430
   CPU #1: thread_id=3D12431

Suggested-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/backend/log.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
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
--=20
2.19.2
