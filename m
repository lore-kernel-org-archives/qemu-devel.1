Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81st-000411-H4
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iO-0003Sw-5m
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iN-0003Sl-VE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so5058522wro.7
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:43 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:29 +0200
Message-Id: <a6f46215ee85cc76a74d06ce14b628861fb9bab5.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <cover.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 02/11] qga-win: handle NULL values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Handle returned NULLs properly to:
- avoid crashes in serialization.
- properly report errors to the caller

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 9c959122d9..49fc747298 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -735,6 +735,12 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     }
     fs->type = g_strdup(fs_name);
     fs->disk = build_guest_disk_info(guid, errp);
+    if (fs->disk == NULL) {
+        g_free(fs);
+        fs = NULL;
+        goto free;
+    }
+
 free:
     g_free(mnt_point);
     return fs;
@@ -755,7 +761,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
     do {
         GuestFilesystemInfo *info = build_guest_fsinfo(guid, errp);
         if (info == NULL) {
-            continue;
+            goto out;
         }
         new = g_malloc(sizeof(*ret));
         new->value = info;
@@ -767,6 +773,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
         error_setg_win32(errp, GetLastError(), "failed to find next volume");
     }
 
+out:
     FindVolumeClose(vol_h);
     return ret;
 }
-- 
2.19.0
