Received: from eggs.gnu.org ([2001:4830:134:3::10]:34389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gK1Ph-0001jA-QH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gK1Ny-0003yG-ML
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:27:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gK1Ny-0003x0-FY
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:27:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1FFF30BCCD5
	for <qemu-devel@nongnu.org>; Tue,  6 Nov 2018 13:27:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  6 Nov 2018 14:27:06 +0100
Message-Id: <1541510826-21031-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts/device-crash-test: Remove known crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

Looks like we've fixed them all already in the past months, e.g. with:

 f7d6bfcdc0fe49040aac3ac131a319cb5427957e
 spapr_pci: fail gracefully with non-pseries machine types

 2363d5ee231bf047479422d56d3b85b7d37a7c23
 hw/ppc/spapr_cpu_core: Add a proper check for spapr machine

 ef0e8fc768a561dd13a86420b3268f6f3d5d0621
 iommu: Don't crash if machine is not PC_MACHINE

 8929fc3a55f33a103adddf9cfd010bcf2b255c7d
 hw/block/pflash_cfi*.c: fix confusing assert fail message

... so we can remove these entries from the ERROR_WHITELIST now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 At least I was not able to reproduce these crashes with the script
 anymore... but please double-check whether I'm right.

 scripts/device-crash-test | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e93a7c0..549162a 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -182,21 +182,6 @@ ERROR_WHITELIST = [
     # other exitcode=1 failures not listed above will just generate INFO messages:
     {'exitcode':1, 'loglevel':logging.INFO},
 
-    # KNOWN CRASHES:
-    # Known crashes will generate error messages, but won't be fatal.
-    # Those entries must be removed once we fix the crashes.
-    {'exitcode':-6, 'log':r"Device 'serial0' is in use", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"qemu_net_client_setup: Assertion `!peer->peer' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r'RAMBlock "[\w.-]+" already registered', 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"find_ram_offset: Assertion `size != 0' failed.", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"add_cpreg_to_hashtable: code should not be reached", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"qemu_alloc_display: Assertion `surface->image != NULL' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"Unexpected error in error_set_from_qdev_prop_error", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"Object .* is not an instance of type spapr-machine", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
-
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
 ]
-- 
1.8.3.1
