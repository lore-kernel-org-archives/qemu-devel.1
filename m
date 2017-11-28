Received: from eggs.gnu.org ([2001:4830:134:3::10]:51159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eJa6B-0006lc-2J
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eJa67-0000Um-RH
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:31 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:9121 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eJa67-0000Tt-F8
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 28 Nov 2017 10:14:08 +0300
Message-Id: <20171128071409.21887-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171128071409.21887-1-vsementsov@virtuozzo.com>
References: <20171128071409.21887-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/4] scripts/qemu.py: tiny enhancement for
 event_wiat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

- add comment
- allow int timeout and disallow bool (which has special
  meaning for pull_event())
- remove unreachable 'return None'

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/qemu.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9bfdf6d37d..8763335254 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -291,7 +291,13 @@ class QEMUMachine(object):
         branch processing on match's value None
            {"foo": {"bar": 1}} matches {"foo": None}
            {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
+
+        @raise QMPTimeoutError: If timeout period elapses.
+        @raise QMPConnectError: If some other error occurred.
         '''
+
+        assert isinstance(timeout, float) or isinstance(timeout, int)
+
         def event_match(event, match=None):
             if match is None:
                 return True
@@ -316,13 +322,11 @@ class QEMUMachine(object):
 
         # Poll for new events
         while True:
-            event = self._qmp.pull_event(wait=timeout)
+            event = self._qmp.pull_event(wait=float(timeout))
             if (event['event'] == name) and event_match(event, match):
                 return event
             self._events.append(event)
 
-        return None
-
     def get_log(self):
         '''
         After self.shutdown or failed qemu execution, this returns the output
-- 
2.11.1
