Received: from eggs.gnu.org ([2001:4830:134:3::10]:49648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaV-0000CQ-Od
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaU-0008Ln-06
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxaT-0008LO-SD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:20 +0100
Message-Id: <20180629175330.19391-2-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 01/11] simpletrace: Convert name from mapping
 record to str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

The rest of the code assumes that idtoname is a (int -> str)
dictionary, so convert the data accordingly.

This is necessary to make the script work with Python 3 (where
reads from a binary file return 'bytes' objects, not 'str').

Fixes the following error:

  $ python3 ./scripts/simpletrace.py trace-events-all trace-27445
  b'object_class_dynamic_cast_assert' event is logged but is not \
  declared in the trace events file, try using trace-events-all instead.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-id: 20180619194549.15584-1-ehabkost@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.17.1
