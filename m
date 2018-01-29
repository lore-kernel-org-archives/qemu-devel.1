Received: from eggs.gnu.org ([2001:4830:134:3::10]:43032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jonemilj@gmail.com>) id 1eg0sx-0006zW-4K
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jonemilj@gmail.com>) id 1eg0sw-0005Dr-97
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:35 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jonemilj@gmail.com>) id 1eg0sw-0005DR-1Y
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:34 -0500
Received: by mail-lf0-x244.google.com with SMTP id g72so7915247lfg.5
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 20:17:33 -0800 (PST)
From: Jon Emil Jahren <jonemilj@gmail.com>
Date: Mon, 29 Jan 2018 05:16:47 +0100
Message-Id: <20180129041648.30884-2-jonemilj@gmail.com>
In-Reply-To: <20180129041648.30884-1-jonemilj@gmail.com>
References: <20180129041648.30884-1-jonemilj@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] tracetool: Update argument format regex to
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
Cc: stefanha@redhat.com, Jon Emil Jahren <jonemilj@gmail.com>

Using the greedy star matching, arguments like "...%"PRIx64 caused issues
for functions with multiple PRI formats.

The issue was only seen with the ust backend, as it is the only one
using the format regex.

The result for many functions was that the arguments coming after the
greedy star end was left out of the tracepoint, and in some cases some
of the arguments that was traced had the wrong format.

Signed-off-by: Jon Emil Jahren <jonemilj@gmail.com>
---
 scripts/tracetool/__init__.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 0670ec17d5..409b0fa8f1 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -259,8 +259,9 @@ class Event(object):
                                           self.name,
                                           self.args,
                                           fmt)
-
-    _FMT = re.compile("(%[\d\.]*\w+|%.*PRI\S+)")
+    # Star matching on PRI is dangerous as one might have multiple
+    # arguments with that format, hence the non-greedy version of it.
+    _FMT = re.compile("(%[\d\.]*\w+|%.*?PRI\S+)")
 
     def formats(self):
         """List of argument print formats."""
-- 
2.14.3
