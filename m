Received: from eggs.gnu.org ([2001:4830:134:3::10]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egBzn-0000JZ-Cl
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egBzm-0007KF-Gg
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:09:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1egBzm-0007Jq-An
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:09:22 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 29 Jan 2018 16:07:40 +0000
Message-Id: <20180129160740.1195-4-stefanha@redhat.com>
In-Reply-To: <20180129160740.1195-1-stefanha@redhat.com>
References: <20180129160740.1195-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] tracetool: report error on foo() instead of
 foo(void)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

C functions with no arguments must be declared foo(void) instead of
foo().  The tracetool argument list parser has never accepted an empty
argument list.  This patch adds a clear error message for this error
case.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180110202553.31889-4-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index e3685bd0ca..1a9733da9a 100644
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
