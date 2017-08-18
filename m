Received: from eggs.gnu.org ([2001:4830:134:3::10]:42349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikq3-0000Vf-94
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikq0-00063u-1N
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dikpz-00063f-Qq
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:13:35 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 19:05:24 +0200
Message-Id: <20170818170526.13496-10-apahim@redhat.com>
In-Reply-To: <20170818170526.13496-1-apahim@redhat.com>
References: <20170818170526.13496-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v7 09/11] qemu.py: launch vm only if it's not
 running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

A new call to launch() with a running VM will fall in exception and
consequently call shutdown().

This patch makes launch() to raise an exception when it's called with VM
already running.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9ae65e454e..46e8ff3232 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -170,6 +170,9 @@ class QEMUMachine(object):
         self._iolog = None
         self._qemu_full_args = None
         devnull = open(os.path.devnull, 'rb')
+        if self.is_running():
+            raise QEMULaunchError('VM already running')
+
         try:
             self._pre_launch()
             self._qemu_full_args = (self._wrapper + [self._binary] +
-- 
2.13.5
