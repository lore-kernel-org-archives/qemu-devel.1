Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYYEC-0007p9-2v
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYYEB-0007qU-1t
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:12:08 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 31 Jan 2017 14:11:59 +0100
Message-Id: <1485868319-16151-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1485868319-16151-1-git-send-email-thuth@redhat.com>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've registered
 the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

When running with KVM on POWER, we register some CPU types during
the initialization function of the ppc64 KVM code (which unfortunately
also can not be done via a type_init() like it is done on x86). So to
be able to see these updates in the CPU help text, the code that calls
list_cpus() has to be run after configure_accelerator(). This move should
be fine since the "cpu_model" variable is also never used before the call
to configure_accelerator(), and thus there should not be any unwanted
side effects in the code before configure_accelerator() if the user
started QEMU with "-cpu ?" or "-cpu help".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 0b72b12..315c5c3 100644
--- a/vl.c
+++ b/vl.c
@@ -4055,11 +4055,6 @@ int main(int argc, char **argv, char **envp)
         qemu_set_hw_version(machine_class->hw_version);
     }
 
-    if (cpu_model && is_help_option(cpu_model)) {
-        list_cpus(stdout, &fprintf, cpu_model);
-        exit(0);
-    }
-
     if (!trace_init_backends()) {
         exit(1);
     }
@@ -4298,6 +4293,11 @@ int main(int argc, char **argv, char **envp)
 
     configure_accelerator(current_machine);
 
+    if (cpu_model && is_help_option(cpu_model)) {
+        list_cpus(stdout, &fprintf, cpu_model);
+        exit(0);
+    }
+
     if (qtest_chrdev) {
         qtest_init(qtest_chrdev, qtest_log, &error_fatal);
     }
-- 
1.8.3.1
