Received: from eggs.gnu.org ([2001:4830:134:3::10]:60107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfT1-00080l-Fh
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfT0-00015A-AQ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSfT0-00014l-53
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C449B818BAF6
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:19:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Jun 2018 10:19:45 +0100
Message-Id: <20180612091948.14367-5-dgilbert@redhat.com>
In-Reply-To: <20180612091948.14367-1-dgilbert@redhat.com>
References: <20180612091948.14367-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/7] qmp: Enable a few commands in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

From: Igor Mammedov <imammedo@redhat.com>

Commands query-chardev, query-version, query-name, query-uuid,
query-iothreads, query-memdev are informational and do not depend on
the machine being initialized.  Make them available in preconfig
runstate to make the latter a little bit more useful.
The generic qom commands don't depend on the machine being initialized
either; so enabled qom-list, qom-get, qom-set, qom-list-types,
qom-list-properties.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 qapi/char.json |  3 ++-
 qapi/misc.json | 27 +++++++++++++++++----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index ae19dcd1ed..60f31d83fc 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -62,7 +62,8 @@
 #    }
 #
 ##
-{ 'command': 'query-chardev', 'returns': ['ChardevInfo'] }
+{ 'command': 'query-chardev', 'returns': ['ChardevInfo'],
+  'allow-preconfig': true }
 
 ##
 # @ChardevBackendInfo:
diff --git a/qapi/misc.json b/qapi/misc.json
index f83a63a0ab..fa86831ec3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,7 +117,8 @@
 #    }
 #
 ##
-{ 'command': 'query-version', 'returns': 'VersionInfo' }
+{ 'command': 'query-version', 'returns': 'VersionInfo',
+  'allow-preconfig': true }
 
 ##
 # @CommandInfo:
@@ -241,7 +242,7 @@
 # <- { "return": { "name": "qemu-name" } }
 #
 ##
-{ 'command': 'query-name', 'returns': 'NameInfo' }
+{ 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
 ##
 # @KvmInfo:
@@ -301,7 +302,7 @@
 # <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
 #
 ##
-{ 'command': 'query-uuid', 'returns': 'UuidInfo' }
+{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
 
 ##
 # @EventInfo:
@@ -710,7 +711,8 @@
 #    }
 #
 ##
-{ 'command': 'query-iothreads', 'returns': ['IOThreadInfo'] }
+{ 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
+  'allow-preconfig': true }
 
 ##
 # @BalloonInfo:
@@ -1408,7 +1410,8 @@
 ##
 { 'command': 'qom-list',
   'data': { 'path': 'str' },
-  'returns': [ 'ObjectPropertyInfo' ] }
+  'returns': [ 'ObjectPropertyInfo' ],
+  'allow-preconfig': true }
 
 ##
 # @qom-get:
@@ -1444,7 +1447,8 @@
 ##
 { 'command': 'qom-get',
   'data': { 'path': 'str', 'property': 'str' },
-  'returns': 'any' }
+  'returns': 'any',
+  'allow-preconfig': true }
 
 ##
 # @qom-set:
@@ -1461,7 +1465,8 @@
 # Since: 1.2
 ##
 { 'command': 'qom-set',
-  'data': { 'path': 'str', 'property': 'str', 'value': 'any' } }
+  'data': { 'path': 'str', 'property': 'str', 'value': 'any' },
+  'allow-preconfig': true }
 
 ##
 # @change:
@@ -1543,7 +1548,8 @@
 ##
 { 'command': 'qom-list-types',
   'data': { '*implements': 'str', '*abstract': 'bool' },
-  'returns': [ 'ObjectTypeInfo' ] }
+  'returns': [ 'ObjectTypeInfo' ],
+  'allow-preconfig': true }
 
 ##
 # @device-list-properties:
@@ -1581,7 +1587,8 @@
 ##
 { 'command': 'qom-list-properties',
   'data': { 'typename': 'str'},
-  'returns': [ 'ObjectPropertyInfo' ] }
+  'returns': [ 'ObjectPropertyInfo' ],
+  'allow-preconfig': true }
 
 ##
 # @xen-set-global-dirty-log:
@@ -2902,7 +2909,7 @@
 #    }
 #
 ##
-{ 'command': 'query-memdev', 'returns': ['Memdev'] }
+{ 'command': 'query-memdev', 'returns': ['Memdev'], 'allow-preconfig': true }
 
 ##
 # @PCDIMMDeviceInfo:
-- 
2.17.1
