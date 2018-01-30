Received: from eggs.gnu.org ([2001:4830:134:3::10]:60190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1egbgG-0006Y7-0p
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 14:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1egbfB-00013P-Vs
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 14:34:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1egbfB-0000qN-NU
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 14:33:49 -0500
From: Cole Robinson <crobinso@redhat.com>
Date: Tue, 30 Jan 2018 14:33:35 -0500
Message-Id: <2a250f8d59f1eedd7728d94a9dae1a6de54d0c14.1517340741.git.crobinso@redhat.com>
Subject: [Qemu-devel] [PATCH v3] scripts/make-release: Don't archive .git
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
Cc: mdroth@linux.vnet.ibm.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, thuth@redhat.com, Cole Robinson <crobinso@redhat.com>

As was last done in 379e21c25, we don't want .git files for
submodules here, which we aren't presently doing for capstone and
keycodemapdb.

Rather than delete the offending files before archiving, ask tar
to --exclude=.git

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
v2:
    Use armbru's --exclude suggestion, requires tweaking
    existing tar options a bit.

v3:
    thuth's suggestion to use --exclude for both tar commands

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
2.14.3
