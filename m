Received: from eggs.gnu.org ([2001:4830:134:3::10]:50810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywe-0007ii-9b
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywc-0005ES-Ap
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwywc-0005E0-4T
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 489704E34A
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 23:07:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 20:07:04 -0300
Message-Id: <20170926230709.22958-2-ehabkost@redhat.com>
In-Reply-To: <20170926230709.22958-1-ehabkost@redhat.com>
References: <20170926230709.22958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 1/6] device-crash-test: Make whitelist code a bit
 more flexible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>

Allow test results without the 'log' and 'exitcode' keys.  The
new device_add code won't report exitcode/log because multiple
devices will be tested on a single QEMU run.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index ddc8f72eca..598720ffa9 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -284,9 +284,10 @@ def whitelistResultMatch(wl, r):
     """
     assert whitelistTestCaseMatch(wl, r['testcase'])
     return ((wl.get('exitcode', 1) is None or
-             r['exitcode'] == wl.get('exitcode', 1)) and
+             r.get('exitcode') == wl.get('exitcode', 1)) and
             ('log' not in wl or
-             re.search(wl['log'], r['log'], re.MULTILINE)))
+             ('log' in r and
+              re.search(wl['log'], r['log'], re.MULTILINE))))
 
 
 def checkResultWhitelist(r):
-- 
2.13.5
