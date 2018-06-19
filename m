Received: from eggs.gnu.org ([2001:4830:134:3::10]:56888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVMZh-0007vl-QL
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVMZe-0000Kq-Lf
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:45:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fVMZe-0000Jk-FZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F035E87621
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 19:45:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Jun 2018 16:45:49 -0300
Message-Id: <20180619194549.15584-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] simpletrace: Convert name from mapping record
 to str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>

The rest of the code assumes that idtoname is a (int -> str)
dictionary, so convert the data accordingly.

This is necessary to make the script work with Python 3 (where
reads from a binary file return 'bytes' objects, not 'str').

Fixes the following error:

  $ python3 ./scripts/simpletrace.py trace-events-all trace-27445
  b'object_class_dynamic_cast_assert' event is logged but is not \
  declared in the trace events file, try using trace-events-all instead.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/simpletrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index d4a50a1e2b..4ad34f90cd 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -70,7 +70,7 @@ def get_record(edict, idtoname, rechdr, fobj):
 def get_mapping(fobj):
     (event_id, ) = struct.unpack('=Q', fobj.read(8))
     (len, ) = struct.unpack('=L', fobj.read(4))
-    name = fobj.read(len)
+    name = fobj.read(len).decode()
 
     return (event_id, name)
 
-- 
2.18.0.rc1.1.g3f1ff2140
