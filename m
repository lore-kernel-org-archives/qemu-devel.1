Received: from eggs.gnu.org ([2001:4830:134:3::10]:51618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yz-0001UT-JX
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yu-0007Sy-6h
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:27:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb1yu-0007Sb-0H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:27:08 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 10:26:15 +0000
Message-Id: <20180115102621.9183-8-berrange@redhat.com>
In-Reply-To: <20180115102621.9183-1-berrange@redhat.com>
References: <20180115102621.9183-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/13] qapi: ensure stable sort ordering
 when checking QAPI entities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Some early python 3.x versions will have different default
ordering when calling the 'values()' method on a dict, compared
to python 2.x and later 3.x versions. Explicitly sort the items
to get a stable ordering.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index b6a7b5139f..6266447eb0 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1678,7 +1678,7 @@ class QAPISchema(object):
                 assert False
 
     def check(self):
-        for ent in self._entity_dict.values():
+        for (name, ent) in sorted(self._entity_dict.items()):
             ent.check(self)
 
     def visit(self, visitor):
-- 
2.14.3
