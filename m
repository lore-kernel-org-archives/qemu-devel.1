Received: from eggs.gnu.org ([2001:4830:134:3::10]:39381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1enoAn-0004XQ-BU
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1enoAi-0002ua-Q9
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1enoAi-0002te-Lf
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:08 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 19 Feb 2018 16:19:53 +0000
Message-Id: <20180219161955.29572-2-stefanha@redhat.com>
In-Reply-To: <20180219161955.29572-1-stefanha@redhat.com>
References: <20180219161955.29572-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] tracetool: Update argument format regex to
 non-greedy star
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jon Emil Jahren <jonemilj@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Jon Emil Jahren <jonemilj@gmail.com>

Using the greedy star matching, arguments like "...%"PRIx64 caused issues
for functions with multiple PRI formats.

The issue was only seen with the ust backend, as it is the only one
using the format regex.

The result for many functions was that the arguments coming after the
greedy star end was left out of the tracepoint, and in some cases some
of the arguments that was traced had the wrong format.

Signed-off-by: Jon Emil Jahren <jonemilj@gmail.com>
Message-id: 20180129041648.30884-2-jonemilj@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 1a9733da9a..3646c2b9fc 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -261,8 +261,9 @@ class Event(object):
                                           self.name,
                                           self.args,
                                           fmt)
-
-    _FMT = re.compile("(%[\d\.]*\w+|%.*PRI\S+)")
+    # Star matching on PRI is dangerous as one might have multiple
+    # arguments with that format, hence the non-greedy version of it.
+    _FMT = re.compile("(%[\d\.]*\w+|%.*?PRI\S+)")
 
     def formats(self):
         """List conversion specifiers in the argument print format string."""
-- 
2.14.3
