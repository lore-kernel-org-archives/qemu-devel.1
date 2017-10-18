Received: from eggs.gnu.org ([2001:4830:134:3::10]:59363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4iwF-0008Vu-Of
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4iwB-0001Hj-RZ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:38:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e4iwB-0001GL-Lg
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:38:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 18 Oct 2017 15:38:41 +0800
Message-Id: <20171018073841.30062-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: Fix PATH for ccache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Before bcd7f06f57fb6f780a3e2f7a46c22b6f6c8238aa we source /etc/profile
so the PATH included the right paths to ccache binaries. Now we need to
update $PATH explicitly from run script.

Keep the old /usr/lib around just so that in the future, ccache from 32
bit images will just work.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/run | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/run b/tests/docker/run
index 642084bcb8..9dd362bb98 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -18,7 +18,7 @@ fi
 BASE="$(dirname $(readlink -e $0))"
 
 # Prepare the environment
-export PATH=/usr/lib/ccache:$PATH
+export PATH=/usr/lib/ccache:/usr/lib64/ccache:$PATH
 
 if test -n "$J"; then
     export MAKEFLAGS="$MAKEFLAGS -j$J"
-- 
2.13.5
