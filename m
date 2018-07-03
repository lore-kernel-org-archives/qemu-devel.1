Received: from eggs.gnu.org ([2001:4830:134:3::10]:41337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSJ1-0008Qv-SC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIx-000106-L6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIx-0000zS-CB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnBuS069462
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dpc66aw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:42 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:41 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:10 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180703205221.24788-4-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/14] qga: add mountpoint usage info to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Chen Hanxiao <chenhanxiao@gmail.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

This patch adds support for getting the usage of mounted
filesystem.
The usage of fs stored as used_bytes and total_bytes.
It's very useful when we try to monitor guest's filesystem.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 15 +++++++++++++++
 qga/qapi-schema.json |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 9284e71666..ae8535e497 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -46,6 +46,7 @@ extern char **environ;
 #include <arpa/inet.h>
 #include <sys/socket.h>
 #include <net/if.h>
+#include <sys/statvfs.h>
=20
 #ifdef FIFREEZE
 #define CONFIG_FSFREEZE
@@ -1072,6 +1073,8 @@ static GuestFilesystemInfo *build_guest_fsinfo(stru=
ct FsMount *mount,
                                                Error **errp)
 {
     GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));
+    struct statvfs buf;
+    unsigned long used, nonroot_total, fr_size;
     char *devpath =3D g_strdup_printf("/sys/dev/block/%u:%u",
                                     mount->devmajor, mount->devminor);
=20
@@ -1079,7 +1082,19 @@ static GuestFilesystemInfo *build_guest_fsinfo(str=
uct FsMount *mount,
     fs->type =3D g_strdup(mount->devtype);
     build_guest_fsinfo_for_device(devpath, fs, errp);
=20
+    if (statvfs(fs->mountpoint, &buf) =3D=3D 0) {
+        fr_size =3D buf.f_frsize;
+        used =3D buf.f_blocks - buf.f_bfree;
+        nonroot_total =3D used + buf.f_bavail;
+        fs->used_bytes =3D used * fr_size;
+        fs->total_bytes =3D nonroot_total * fr_size;
+
+        fs->has_total_bytes =3D true;
+        fs->has_used_bytes =3D true;
+    }
+
     g_free(devpath);
+
     return fs;
 }
=20
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 1045cef386..2df6356b8c 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -848,6 +848,8 @@
 # @name: disk name
 # @mountpoint: mount point path
 # @type: file system type string
+# @used-bytes: file system used bytes (since 3.0)
+# @total-bytes: non-root file system total bytes (since 3.0)
 # @disk: an array of disk hardware information that the volume lies on,
 #        which may be empty if the disk type is not supported
 #
@@ -855,6 +857,7 @@
 ##
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
+           '*used-bytes': 'uint64', '*total-bytes': 'uint64',
            'disk': ['GuestDiskAddress']} }
=20
 ##
--=20
2.11.0
