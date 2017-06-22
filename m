Received: from eggs.gnu.org ([2001:4830:134:3::10]:41823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO4cb-00010W-76
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO4cW-0004FD-Od
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:06:17 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:47439)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dO4cW-0004CC-I8
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:06:12 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2B31210C642
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 18:06:04 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 22 Jun 2017 18:06:00 +0200
Message-ID: <149814756006.27338.8723356702388175951.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] Separate function types from opaque types in
 include/qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Function types cannot reside in the same sorted list as opaque types since
they may depend on a type which would be defined later.

Of course, the same problem could arise if a function type depends on
another function type with greater alphabetical order. Hopefully we
don't have that at this time.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/qemu/typedefs.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index f745d5faf7fd..cd3e369ae01a 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -1,10 +1,9 @@
 #ifndef QEMU_TYPEDEFS_H
 #define QEMU_TYPEDEFS_H
 
-/* A load of opaque types so that device init declarations don't have to
-   pull in all the real definitions.  */
-
-/* Please keep this list in alphabetical order */
+/* First list is for opaque types only, second one for function types.
+ * Please keep both lists in alphabetical order.
+ */
 typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
@@ -96,7 +95,8 @@ typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef struct node_info NodeInfo;
+
+typedef int  LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
-typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 
 #endif /* QEMU_TYPEDEFS_H */
