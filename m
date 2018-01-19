Received: from eggs.gnu.org ([2001:4830:134:3::10]:40797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTA9-0001j9-Nu
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTA8-00005w-Nd
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:41 -0500
Received: from ozlabs.org ([103.22.144.67]:33343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ecTA8-0008Uy-Cd
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 19 Jan 2018 20:40:06 +1100
Message-Id: <20180119094015.28266-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180119094015.28266-1-david@gibson.dropbear.id.au>
References: <20180119094015.28266-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/13] ppc: Deprecate qemu-system-ppcemb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, lvivier@redhat.com, agraf@suse.de, qemu-ppc@nognu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 qemu-doc.texi               | 6 ++++++
 target/ppc/translate_init.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3e9eb819a6..b13c6332fd 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2766,6 +2766,12 @@ The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
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
index 70ff15a51a..ab70b3a25c 100644
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
2.14.3
