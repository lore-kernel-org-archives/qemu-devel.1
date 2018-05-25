Received: from eggs.gnu.org ([2001:4830:134:3::10]:38490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7ve-0001mf-TN
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7va-0008Hj-2K
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fM7vZ-0008Ft-Pi
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:22 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 25 May 2018 10:17:44 +0200
Message-Id: <20180525081754.29506-4-laurent@vivier.eu>
In-Reply-To: <20180525081754.29506-1-laurent@vivier.eu>
References: <20180525081754.29506-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 03/13] linux-user: update comments to point to
 tcg_exec_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

cpu_init() was replaced by cpu_create() since 2.12 but comments
weren't updated. So update stale comments to point that page
sizes arei actually initialized by tcg_exec_init(). Also move
another qemu_host_page_size related comment before tcg_exec_init()
where it belongs.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1526557877-293151-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 bsd-user/main.c   | 7 ++++---
 linux-user/main.c | 5 ++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 283dc6fd25..da3b833975 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -898,9 +898,10 @@ int main(int argc, char **argv)
         cpu_model = "any";
 #endif
     }
+
+    /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
-    /* NOTE: we need to init the CPU at this stage to get
-       qemu_host_page_size */
+
     cpu_type = parse_cpu_model(cpu_model);
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
@@ -917,7 +918,7 @@ int main(int argc, char **argv)
     envlist_free(envlist);
 
     /*
-     * Now that page sizes are configured in cpu_init() we can do
+     * Now that page sizes are configured in tcg_exec_init() we can do
      * proper page alignment for guest_base.
      */
     guest_base = HOST_PAGE_ALIGN(guest_base);
diff --git a/linux-user/main.c b/linux-user/main.c
index 32347545c9..78d6d3e7eb 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -671,9 +671,8 @@ int main(int argc, char **argv, char **envp)
     }
     cpu_type = parse_cpu_model(cpu_model);
 
+    /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
-    /* NOTE: we need to init the CPU at this stage to get
-       qemu_host_page_size */
 
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
@@ -693,7 +692,7 @@ int main(int argc, char **argv, char **envp)
     envlist_free(envlist);
 
     /*
-     * Now that page sizes are configured in cpu_init() we can do
+     * Now that page sizes are configured in tcg_exec_init() we can do
      * proper page alignment for guest_base.
      */
     guest_base = HOST_PAGE_ALIGN(guest_base);
-- 
2.14.3
