Received: from eggs.gnu.org ([2001:4830:134:3::10]:53188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e6v39-0003sY-Bs
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e6v35-0003Z5-GE
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:59:03 -0400
Received: from ozlabs.ru ([107.173.13.209]:59970)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e6v35-0003Ya-AN
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:58:59 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 24 Oct 2017 19:58:53 +1100
Message-Id: <20171024085853.32615-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu] git-submodule.sh: Do not try writing
 to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Daniel P. Berrange" <berrange@redhat.com>

The new git-submodule.sh script writes .git-submodule-status to
the source directory every time no matter what. This makes it conditional.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I compile out of tree on a remote guest system where I mount the
source directory as "readonly" and build directory as "rw" and
scripts/git-submodule.sh tries writing to the source directory even when
I manually update modules on a host machine which is quite annoying.

Is this something acceptable? Or I am missing something here?

---
 scripts/git-submodule.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index d8fbc7e47e..b642994a67 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -33,6 +33,8 @@ status)
     ;;
 update)
     git submodule update --init $modules 1>/dev/null 2>&1
-    git submodule status $modules > "${substat}"
+    substat_tmp=$(mktemp)
+    git submodule status $modules > "$substat_tmp"
+    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"
     ;;
 esac
-- 
2.11.0
