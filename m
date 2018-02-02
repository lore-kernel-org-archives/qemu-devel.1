Received: from eggs.gnu.org ([208.118.235.92]:55980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdNk-0002k9-CI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdMG-0005dz-9T
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdMF-0005cg-Ut
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:32 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:33 +0100
Message-Id: <20180202130336.24719-19-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 18/21] qapi/common: Fix guardname() for
 funny filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

guardname() fails to return a valid C identifier for arguments
containing anything but [A-Za-z0-9_.-'].  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 7ffffc78d9..7d497b5b17 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1860,7 +1860,7 @@ def mcgen(code, **kwds):
 
 
 def guardname(filename):
-    return c_name(filename, protect=False).upper()
+    return re.sub(r'[^A-Za-z0-9_]', '_', filename).upper()
 
 
 def guardstart(name):
-- 
2.13.6
