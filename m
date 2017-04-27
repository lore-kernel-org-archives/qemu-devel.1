Received: from eggs.gnu.org ([2001:4830:134:3::10]:54579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3qNl-0005Sk-6r
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3qNk-0004LM-Dn
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:51:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 27 Apr 2017 16:51:00 -0400
Message-Id: <20170427205100.9505-3-jsnow@redhat.com>
In-Reply-To: <20170427205100.9505-1-jsnow@redhat.com>
References: <20170427205100.9505-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] iotests: fix exclusion option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, eblake@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

If you are running out-of-tree, the -x option to exclude
a certain iotest is broken.

Replace porcelain usage of ls with a sturdier awk command.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/common | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index fa8e69e..f2a7199 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -86,7 +86,8 @@ s/ .*//p
     elif $xgroup
     then
         # arg after -x
-        [ ! -s $tmp.list ] && ls [0-9][0-9][0-9] [0-9][0-9][0-9][0-9] >$tmp.list 2>/dev/null
+        # Populate $tmp.list with all tests
+        awk '/^[0-9]{3,}/ {print $1}' "${source_iotests}/group" > $tmp.list 2>/dev/null
         group_list=`sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
 s/ .*//p
 }'`
-- 
2.9.3
