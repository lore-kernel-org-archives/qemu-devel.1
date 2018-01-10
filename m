Received: from eggs.gnu.org ([2001:4830:134:3::10]:34225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZMx5-0001Ux-Nh
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZMx1-0001c9-PQ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZMx1-0001ZW-I9
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 10 Jan 2018 20:25:53 +0000
Message-Id: <20180110202553.31889-4-stefanha@redhat.com>
In-Reply-To: <20180110202553.31889-1-stefanha@redhat.com>
References: <20180110202553.31889-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] tracetool: report error on foo() instead
 of foo(void)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

C functions with no arguments must be declared foo(void) instead of
foo().  The tracetool argument list parser has never accepted an empty
argument list.  This patch adds a clear error message for this error
case.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 5db1f5c395..8e9efba78f 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -75,6 +75,8 @@ class Arguments:
         res = []
         for arg in arg_str.split(","):
             arg = arg.strip()
+            if not arg:
+                raise ValueError("Empty argument (did you forget to use 'void'?)")
             if arg == 'void':
                 continue
 
-- 
2.14.3
