Received: from eggs.gnu.org ([2001:4830:134:3::10]:41861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1eXwS1-0003UM-HD
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 16:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1eXwRy-0007kG-Bq
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 16:56:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1eXwRy-0007i3-5m
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 16:56:22 -0500
From: Cole Robinson <crobinso@redhat.com>
Date: Sat,  6 Jan 2018 16:56:13 -0500
Message-Id: <00583a19439a026a47fcb4d12cb185130347c636.1515275715.git.crobinso@redhat.com>
Subject: [Qemu-devel] [PATCH v2] scripts/make-release: Don't archive .git
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

 scripts/make-release | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/make-release b/scripts/make-release
index 3917df7142..7cbce29475 100755
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
 tar cfj roms/u-boot.tar.bz2 -C roms u-boot && rm -rf roms/u-boot
 popd
-tar cfj ${destination}.tar.bz2 ${destination}
+tar --exclude=.git -cjf ${destination}.tar.bz2 ${destination}
 rm -rf ${destination}
-- 
2.14.3
