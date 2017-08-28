Received: from eggs.gnu.org ([2001:4830:134:3::10]:42023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9J0-0004tc-5B
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Iz-000133-ET
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:34 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:37141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dm9Iz-00012j-9r
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:33 -0400
Received: by mail-vk0-x243.google.com with SMTP id z187so1877434vkd.4
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 18:57:33 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Sun, 27 Aug 2017 20:56:46 -0500
Message-Id: <20170828015654.2530-7-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH 06/14] hvf: add compilation rules to
 Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This commit adds to target/i386/Makefile.objs the necessary rules so
that the new files for hvf are compiled by the build system.
It also adds handling of the -enable-hvf argument in the main function
in vl.c.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 target/i386/Makefile.objs | 1 +
 vl.c                      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 6a26e9d9f0..0bef89c099 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -12,4 +12,5 @@ obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
 ifdef CONFIG_DARWIN
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
+obj-$(CONFIG_HVF) += hvf-utils/ hvf-all.o
 endif
diff --git a/vl.c b/vl.c
index 8e247cc2a2..de7d2a3858 100644
--- a/vl.c
+++ b/vl.c
@@ -3751,6 +3751,13 @@ int main(int argc, char **argv, char **envp)
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=hax", false);
                 break;
+#if defined(__APPLE__)
+            case QEMU_OPTION_enable_hvf:
+                olist = qemu_find_opts("machine");
+                qemu_opts_parse_noisily(olist, "accel=hvf", false);
+                hvf_disable(0);
+                break;
+#endif
             case QEMU_OPTION_M:
             case QEMU_OPTION_machine:
                 olist = qemu_find_opts("machine");
-- 
2.14.1
