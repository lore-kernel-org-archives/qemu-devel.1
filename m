Received: from eggs.gnu.org ([2001:4830:134:3::10]:48477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwjr-0005IB-4S
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwji-0002Mq-0u
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:24 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:62881)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwjb-0002I8-8A
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:11 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 15 Oct 2018 14:51:57 +0800
Message-Id: <20181015065157.3634-3-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 3/3] show-fixed-bugs.sh: Modern shell scripting
 (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Various shell files contain a mix between obsolete `` and
modern $(); use of `` is only required when using /bin/sh
on Solaris. It would be nice to convert to using $()
everywhere, or at least in all bash scripts, as well as in
all scripts that are known to not be run on Solaris.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 scripts/show-fixed-bugs.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/show-fixed-bugs.sh b/scripts/show-fixed-bugs.sh
index 36f306898f..a095a4d6ba 100755
--- a/scripts/show-fixed-bugs.sh
+++ b/scripts/show-fixed-bugs.sh
@@ -23,10 +23,10 @@ while getopts "s:e:cbh" opt; do
 done
 
 if [ "x$start" = "x" ]; then
-    start=`git tag -l 'v[0-9]*\.[0-9]*\.0' | tail -n 2 | head -n 1`
+    start=$(git tag -l 'v[0-9]*\.[0-9]*\.0' | tail -n 2 | head -n 1)
 fi
 if [ "x$end" = "x" ]; then
-    end=`git tag -l  'v[0-9]*\.[0-9]*\.0' | tail -n 1`
+    end=$(git tag -l  'v[0-9]*\.[0-9]*\.0' | tail -n 1)
 fi
 
 if [ "x$start" = "x" ] || [ "x$end" = "x" ]; then
@@ -38,9 +38,9 @@ fi
 echo "Searching git log for bugs in the range $start..$end"
 
 urlstr='https://bugs.launchpad.net/\(bugs\|qemu/+bug\)/'
-bug_urls=`git log $start..$end \
+bug_urls=$(git log $start..$end \
   | sed -n '\,'"$urlstr"', s,\(.*\)\('"$urlstr"'\)\([0-9]*\).*,\2\4,p' \
-  | sort -u`
+  | sort -u)
 
 echo Found bug URLs:
 for i in $bug_urls ; do echo " $i" ; done
@@ -68,7 +68,7 @@ elif [ "x$show_in_browser" = "x1" ]; then
         bugbrowser=xdg-open
     elif command -v gnome-open >/dev/null 2>&1; then
         bugbrowser=gnome-open
-    elif [ "`uname`" = "Darwin" ]; then
+    elif [ "$(uname)" = "Darwin" ]; then
         bugbrowser=open
     elif command -v sensible-browser >/dev/null 2>&1; then
         bugbrowser=sensible-browser
-- 
2.17.1
