Received: from eggs.gnu.org ([2001:4830:134:3::10]:36547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uu2-00089j-21
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utx-0007yg-5V
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:53 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utw-0007wt-VP
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:49 -0400
Received: by mail-wm0-x241.google.com with SMTP id g8so4834676wmd.2
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:19 +0200
Message-Id: <1523034681-33787-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/20] dump: Fix build with newer gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

gcc 8 on rawhide is picky enough to complain:

/home/dummy/qemu/dump.c: In function 'create_header32':
/home/dummy/qemu/dump.c:817:5: error: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Werror=stringop-truncation]
     strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

But we already have SIG_LEN defined as the right length without needing
to do a strlen(), and memcpy() is better than strncpy() when we know
we do not want a trailing NUL byte.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dump.c b/dump.c
index 669f715..b54cd42 100644
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
1.8.3.1
