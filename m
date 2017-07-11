Received: from eggs.gnu.org ([2001:4830:134:3::10]:52083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlNe-00065x-Lo
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlNb-0000SC-FE
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:58:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 10 Jul 2017 23:57:02 -0300
Message-Id: <20170711025703.24194-3-f4bug@amsat.org>
In-Reply-To: <20170711025703.24194-1-f4bug@amsat.org>
References: <20170711025703.24194-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/3] xen/mapcache: disable Xen on arm*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-arm@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Anthony Perard <anthony.perard@citrix.com>, Marcelo Tosatti <mtosatti@redhat.com>, xen-arm@lists.xen.org, Anoob Soman <anoob.soman@citrix.com>, Juergen Gross <jgross@suse.com>, Anthony Xu <anthony.xu@intel.com>, Paul Durrant <paul.durrant@citrix.com>

linking on Linux debian/stretch/arm[64] with libxen-4.8:

    exec.o: In function `reclaim_ramblock':
    qemu/exec.c:2071: undefined reference to `xen_invalidate_map_cache_entry'
    exec.o: In function `qemu_map_ram_ptr':
    qemu/exec.c:2177: undefined reference to `xen_map_cache'
    qemu/exec.c:2174: undefined reference to `xen_map_cache'
    exec.o: In function `qemu_ram_block_from_host':
    qemu/exec.c:2242: undefined reference to `xen_ram_addr_from_mapcache'
    qemu/exec.c:2242: undefined reference to `xen_ram_addr_from_mapcache'
    exec.o: In function `qemu_ram_ptr_length':
    qemu/exec.c:2210: undefined reference to `xen_map_cache'
    qemu/exec.c:2207: undefined reference to `xen_map_cache'
    exec.o: In function `address_space_unmap':
    qemu/exec.c:3357: undefined reference to `xen_invalidate_map_cache_entry'
    collect2: error: ld returned 1 exit status
    Makefile:197: recipe for target 'qemu-system-aarch64' failed
    make[1]: *** [qemu-system-aarch64] Error 1

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/sysemu/xen-mapcache.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index 01daaad00c..75f0988e04 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -12,7 +12,9 @@
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr start_addr,
                                                      ram_addr_t size,
                                                      void *opaque);
-#ifdef CONFIG_XEN
+/* FIXME ARM supported since Xen 4.3? */
+#if defined(CONFIG_XEN) /* XXX supported_xen_target() wrong? */ && \
+    !defined(HOST_ARM) && !defined(HOST_AARCH64)
 
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
-- 
2.13.2
