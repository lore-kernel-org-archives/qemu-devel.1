Received: from eggs.gnu.org ([2001:4830:134:3::10]:51515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0v6X-0007ll-6X
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0v6U-0002gT-3I
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:22:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 15:21:51 -0500
Message-Id: <20180327202152.1799131-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] dump: Fix build with newer gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

gcc 8 on rawhide is picky enough to complain:

/home/dummy/qemu/dump.c: In function 'create_header32':
/home/dummy/qemu/dump.c:817:5: error: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Werror=stringop-truncation]
     strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

But we already have SIG_LEN defined as the right length without needing
to do a strlen(), and memcpy() is better than strncpy() when we know
we do not want a trailing NUL byte.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dump.c b/dump.c
index 669f715274d..b54cd42b217 100644
--- a/dump.c
+++ b/dump.c
@@ -814,7 +814,7 @@ static void create_header32(DumpState *s, Error **errp)
     size = sizeof(DiskDumpHeader32);
     dh = g_malloc0(size);

-    strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
+    memcpy(dh->signature, KDUMP_SIGNATURE, SIG_LEN);
     dh->header_version = cpu_to_dump32(s, 6);
     block_size = s->dump_info.page_size;
     dh->block_size = cpu_to_dump32(s, block_size);
@@ -926,7 +926,7 @@ static void create_header64(DumpState *s, Error **errp)
     size = sizeof(DiskDumpHeader64);
     dh = g_malloc0(size);

-    strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
+    memcpy(dh->signature, KDUMP_SIGNATURE, SIG_LEN);
     dh->header_version = cpu_to_dump32(s, 6);
     block_size = s->dump_info.page_size;
     dh->block_size = cpu_to_dump32(s, block_size);
-- 
2.14.3
