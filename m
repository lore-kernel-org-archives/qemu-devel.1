Received: from eggs.gnu.org ([2001:4830:134:3::10]:48516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIj-0006wc-DB
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIY-0003fh-OB
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:37 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:13 +0200
Message-Id: <1502117160-24655-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 09/56] balloon: Make balloon size unsigned
 in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Sizes should use QAPI type 'size' (uint64_t).  balloon parameter
@value is 'int' (int64_t).  qmp_balloon() implicitly converts to
ram_addr_t, i.e. uint64_t.  BALLOON_CHANGE parameter @actual and
BalloonInfo member @actual are also 'int'.
virtio_balloon_set_config() and virtio_balloon_stat() implicitly
convert from ram_addr_t.

Change all three to 'size', and adjust the code using them.

balloon now accepts size values between 2^63 and 2^64-1.  It accepts
negative values as before, because that's how the QObject input
visitor works for backward compatibility.

Doing the same for HMP's balloon deserves its own commit (the next
one).

BALLOON_CHANGE and query-balloon now report sizes above 2^63-1
correctly instead of their (negative) two's complement.

So does HMP's "info balloon".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 balloon.c        | 2 +-
 hmp.c            | 2 +-
 qapi-schema.json | 4 ++--
 qapi/event.json  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/balloon.c b/balloon.c
index 1d720ff..2ecca76 100644
--- a/balloon.c
+++ b/balloon.c
@@ -102,7 +102,7 @@ BalloonInfo *qmp_query_balloon(Error **errp)
     return info;
 }
 
-void qmp_balloon(int64_t target, Error **errp)
+void qmp_balloon(uint64_t target, Error **errp)
 {
     if (!have_balloon(errp)) {
         return;
diff --git a/hmp.c b/hmp.c
index 8257dd0..4556045 100644
--- a/hmp.c
+++ b/hmp.c
@@ -781,7 +781,7 @@ void hmp_info_balloon(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    monitor_printf(mon, "balloon: actual=%" PRId64 "\n", info->actual >> 20);
+    monitor_printf(mon, "balloon: actual=%" PRIu64 "\n", info->actual >> 20);
 
     qapi_free_BalloonInfo(info);
 }
diff --git a/qapi-schema.json b/qapi-schema.json
index 3ad2bc0..23eb60d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2003,7 +2003,7 @@
 # Since: 0.14.0
 #
 ##
-{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
+{ 'struct': 'BalloonInfo', 'data': {'actual': 'size' } }
 
 ##
 # @query-balloon:
@@ -2603,7 +2603,7 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'balloon', 'data': {'value': 'int'} }
+{ 'command': 'balloon', 'data': {'value': 'size'} }
 
 ##
 # @Abort:
diff --git a/qapi/event.json b/qapi/event.json
index 6d22b02..9dfc70b 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -488,7 +488,7 @@
 #
 ##
 { 'event': 'BALLOON_CHANGE',
-  'data': { 'actual': 'int' } }
+  'data': { 'actual': 'size' } }
 
 ##
 # @GUEST_PANICKED:
-- 
2.7.5
