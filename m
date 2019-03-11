Received: from eggs.gnu.org ([209.51.188.92]:47647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PGu-00030K-Fc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PGi-0002Ld-2l
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:25 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:38776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1h3PGd-0002Dw-Ky
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:16 -0400
Received: by mail-qt1-x842.google.com with SMTP id s1so6129039qte.5
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:03:14 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 11 Mar 2019 14:02:11 -0400
Message-Id: <20190311180216.18811-2-jandryuk@gmail.com>
In-Reply-To: <20190311180216.18811-1-jandryuk@gmail.com>
References: <20190311180216.18811-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/6] xen: Introduce -xen-stubdom option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, marmarek@invisiblethingslab.com, Jason Andryuk <jandryuk@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

With Xen, QEMU can run isolated in a dedicated service VM - a stubdom.
There are a few differences when running in a stubdom compared to dom0.
Add the -xen-stubdom option to select this mode at runtime.  The default
is off.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 include/hw/xen/xen.h | 6 ++++++
 qemu-options.hx      | 7 +++++++
 vl.c                 | 8 ++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index ba039c146d..fed3611623 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -21,6 +21,7 @@ enum xen_mode {
 extern uint32_t xen_domid;
 extern enum xen_mode xen_mode;
 extern bool xen_domid_restrict;
+extern bool xen_stubdom;
 
 extern bool xen_allowed;
 
@@ -29,6 +30,11 @@ static inline bool xen_enabled(void)
     return xen_allowed;
 }
 
+static inline bool xen_stubdom_enabled(void)
+{
+    return xen_stubdom;
+}
+
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 void xen_piix3_set_irq(void *opaque, int irq_num, int level);
 void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len);
diff --git a/qemu-options.hx b/qemu-options.hx
index 1cf9aac1fe..ba56c3dd9a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3386,6 +3386,10 @@ DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
     "                        to specified domain id. (Does not affect\n"
     "                        xenpv machine type).\n",
     QEMU_ARCH_ALL)
+DEF("xen-stubdom", 0, QEMU_OPTION_xen_stubdom,
+    "-xen-stubdom    specify QEMU is running in a stubdom, so certain\n"
+    "                behavior changes. (Does not affect xenpv machine type).\n",
+    QEMU_ARCH_ALL)
 STEXI
 @item -xen-domid @var{id}
 @findex -xen-domid
@@ -3396,6 +3400,9 @@ Attach to existing xen domain.
 libxl will use this when starting QEMU (XEN only).
 @findex -xen-domid-restrict
 Restrict set of available xen operations to specified domain id (XEN only).
+@findex -xen-stubdom
+@item -xen-stubdom
+Run qemu in stubdom-mode (XEN only).
 ETEXI
 
 DEF("no-reboot", 0, QEMU_OPTION_no_reboot, \
diff --git a/vl.c b/vl.c
index 4a350de5cd..0d04319d9b 100644
--- a/vl.c
+++ b/vl.c
@@ -206,6 +206,7 @@ bool xen_allowed;
 uint32_t xen_domid;
 enum xen_mode xen_mode = XEN_EMULATE;
 bool xen_domid_restrict;
+bool xen_stubdom;
 
 static int has_defaults = 1;
 static int default_serial = 1;
@@ -3796,6 +3797,13 @@ int main(int argc, char **argv, char **envp)
                 }
                 xen_domid_restrict = true;
                 break;
+            case QEMU_OPTION_xen_stubdom:
+                if (!(xen_available())) {
+                    error_report("Option not supported for this target");
+                    exit(1);
+                }
+                xen_stubdom = true;
+                break;
             case QEMU_OPTION_trace:
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
-- 
2.20.1
