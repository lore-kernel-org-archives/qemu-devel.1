Received: from eggs.gnu.org ([2001:4830:134:3::10]:43671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQA9-0003lJ-1T
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQA8-00031M-1F
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:16:21 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 16 Jan 2018 13:15:58 +0100
Message-Id: <1516104958-3881-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1516104958-3881-1-git-send-email-thuth@redhat.com>
References: <1516104958-3881-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] ppc: Deprecate qemu-system-ppcemb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, BALATON Zoltan <balaton@eik.bme.hu>

qemu-system-ppcemb has been once split of qemu-system-ppc to support
CPU page sizes < 4096 for some of the embedded 4xx PowerPC CPUs.
However, there was hardly any OS available in the wild that really
used such small page sizes (Linux uses 4096 on PPC), so there is
no known recent use case for this separate build anymore. It's
rather cumbersome to maintain a separate set of config switches for
this, and it's wasting compile and test time of all the developers
who have to build all QEMU targets to verify that their changes did
not break anything.

Except for the small CPU page sizes, qemu-system-ppc can be used as
a full replacement for qemu-system-ppcemb since it contains all the
embedded 4xx PPC boards and CPUs, too. Thus let's start the deprecation
process for qemu-system-ppcemb to see whether somebody still needs
the small page sizes or whether we could finally remove this unloved
separate build.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi               | 6 ++++++
 target/ppc/translate_init.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index a3d2054..ae38f0a 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2757,6 +2757,12 @@ The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
 The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
 or ``ivshmem-doorbell`` device types.
 
+@subsection Page size support < 4k for embedded PowerPC CPUs (since 2.12.0)
+
+qemu-system-ppcemb will be removed. qemu-system-ppc (or qemu-system-ppc64)
+should be used instead. That means that embedded 4xx PowerPC CPUs will not
+support page sizes < 4096 any longer.
+
 @section System emulator machines
 
 @subsection Xilinx EP108 (since 2.11.0)
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 70ff15a..ab70b3a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10634,6 +10634,11 @@ static void ppc_cpu_register_types(void)
 {
     type_register_static(&ppc_cpu_type_info);
     type_register_static(&ppc_vhyp_type_info);
+
+#ifdef TARGET_PPCEMB
+    warn_report("qemu-system-ppcemb is deprecated, "
+                "please use qemu-system-ppc instead.");
+#endif
 }
 
 type_init(ppc_cpu_register_types)
-- 
1.8.3.1
