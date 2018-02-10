Received: from eggs.gnu.org ([2001:4830:134:3::10]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQHT-0007JV-La
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQHQ-0003Gj-6y
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:13:07 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:55:02 +0300
Message-Id: <d0081e8f260d012d050405d1e549b445948d1451.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 07/17] scripts/make-release: Don't archive .git
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Cole Robinson <crobinso@redhat.com>

As was last done in 379e21c25, we don't want .git files for
submodules here, which we aren't presently doing for capstone and
keycodemapdb.

Rather than delete the offending files before archiving, ask tar
to --exclude=.git

Signed-off-by: Cole Robinson <crobinso@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 scripts/make-release | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/make-release b/scripts/make-release
index 3917df7142..04fa9defdc 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -19,11 +19,10 @@ pushd ${destination}
 git checkout "v${version}"
 git submodule update --init
 (cd roms/seabios && git describe --tags --long --dirty > .version)
-rm -rf .git roms/*/.git dtc/.git pixman/.git
 # FIXME: The following line is a workaround for avoiding filename collisions
 # when unpacking u-boot sources on case-insensitive filesystems. Once we
 # update to something with u-boot commit 610eec7f0 we can drop this line.
-tar cfj roms/u-boot.tar.bz2 -C roms u-boot && rm -rf roms/u-boot
+tar --exclude=.git -cjf roms/u-boot.tar.bz2 -C roms u-boot && rm -rf roms/u-boot
 popd
-tar cfj ${destination}.tar.bz2 ${destination}
+tar --exclude=.git -cjf ${destination}.tar.bz2 ${destination}
 rm -rf ${destination}
-- 
2.11.0
