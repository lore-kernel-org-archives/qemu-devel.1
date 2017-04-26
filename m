Received: from eggs.gnu.org ([2001:4830:134:3::10]:46286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3N7A-0004Hs-5n
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3N77-0006NG-1D
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:36:16 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:47670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d3N76-0006Mh-R6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:36:12 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3C9F9E84E6
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 15:36:11 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 26 Apr 2017 15:36:07 +0200
Message-ID: <149321376763.7874.12797658801011614451.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] configure: fix trace backend list for
 out-of-tree builds
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

Since commit "c53eeaf75a04 configure: eliminate Python dependency for
--help", configure --help fails to produce the list of available trace
backends if invoked out-of-tree. It also spits the following error:

grep: scripts/tracetool/backend/*.py: No such file or directory

This patch simply adds the missing $source_path to fix it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - use "$source_path" instead of $source_path
---
 configure |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index c35acf119261..c434736c2e27 100755
--- a/configure
+++ b/configure
@@ -1271,7 +1271,7 @@ for config in $mak_wilds; do
 done
 
 # Enumerate public trace backends for --help output
-trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
+trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' "$source_path"/scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
 
 if test x"$show_help" = x"yes" ; then
 cat << EOF
