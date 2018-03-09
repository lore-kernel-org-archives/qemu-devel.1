Received: from eggs.gnu.org ([2001:4830:134:3::10]:50299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdL-00007R-Iw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdK-0006tA-Gu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOdK-0006sv-8m
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:54 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:25 -0300
Message-Id: <20180309202827.12085-7-ehabkost@redhat.com>
In-Reply-To: <20180309202827.12085-1-ehabkost@redhat.com>
References: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 6/8] device-crash-test: Use WARN for known
 crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>

We're going to run device-crash-test on "make check", so it's
better to make the script less noisy on known errors.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index f406890519..ed9a552fa1 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -228,28 +228,28 @@ ERROR_WHITELIST = [
     {'exitcode':1, 'loglevel':logging.INFO},
 
     # KNOWN CRASHES:
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
-    {'exitcode':-6, 'device':'isa-fdc', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'gus', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'sb16', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'cs4231a', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'mioe3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'pcm3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'kvaser_pci', 'loglevel':logging.ERROR, 'expected':True},
+    # Known crashes will generate warn messages
+    # FIXME: all those crashes MUST be fixed, and all these entries MUST be removed
+    {'exitcode':-6, 'log':r"Device 'serial0' is in use", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"qemu_net_client_setup: Assertion `!peer->peer' failed", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r'RAMBlock "[\w.-]+" already registered', 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"find_ram_offset: Assertion `size != 0' failed.", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"add_cpreg_to_hashtable: code should not be reached", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"qemu_alloc_display: Assertion `surface->image != NULL' failed", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"Unexpected error in error_set_from_qdev_prop_error", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"Object .* is not an instance of type spapr-machine", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.WARN},
+    {'exitcode':-6, 'device':'isa-fdc', 'loglevel':logging.WARN, 'expected':True},
+    {'exitcode':-11, 'device':'gus', 'loglevel':logging.WARN, 'expected':True},
+    {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.WARN, 'expected':True},
+    {'exitcode':-11, 'device':'sb16', 'loglevel':logging.WARN, 'expected':True},
+    {'exitcode':-11, 'device':'cs4231a', 'loglevel':logging.WARN, 'expected':True},
+    {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.WARN, 'expected':True},
+    {'exitcode':-11, 'device':'mioe3680_pci', 'loglevel':logging.WARN, 'expected':True},
+    {'exitcode':-11, 'device':'pcm3680_pci', 'loglevel':logging.WARN, 'expected':True},
+    {'exitcode':-11, 'device':'kvaser_pci', 'loglevel':logging.WARN, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
-- 
2.14.3
