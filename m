Received: from eggs.gnu.org ([2001:4830:134:3::10]:43552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdIAX-0002fo-V5
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdIAT-0001DP-3H
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:40:46 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46639)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fdIAS-0001CZ-Qm
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:40:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 11 Jul 2018 18:40:25 +0200
Message-Id: <20180711164025.10924-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2] linux-user: fix mmap_find_vma_reserved()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>

The value given by mmap_find_vma_reserved() is used with mmap(),
so it is needed to be aligned with the host page size.

Since commit 18e80c55bb, reserved_va is only aligned to TARGET_PAGE_SIZE,
and it works well if this size is greater or equal to the host page size.

But ppc64 hosts have 64kB page size and when we start a 4kiB page size
guest (like i386), it fails when it tries to mmap the stack:

    mmap stack: Invalid argument

Fixes: 18e80c55bb (linux-user: Tidy and enforce reserved_va initialization)
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2:
      fix typo s/has/as/

 linux-user/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 52b5a618fe..15299e9dd7 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -689,6 +689,11 @@ int main(int argc, char **argv, char **envp)
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
+    /* reserved_va must be aligned with the host page size
+     * as it is used with mmap()
+     */
+    reserved_va &= qemu_host_page_mask;
+
     /*
      * Now that page sizes are configured in tcg_exec_init() we can do
      * proper page alignment for guest_base.
-- 
2.17.1
