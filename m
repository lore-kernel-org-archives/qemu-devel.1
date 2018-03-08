Received: from eggs.gnu.org ([2001:4830:134:3::10]:40288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuF-0005NG-Vk
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuC-0005xV-Ro
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:43 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:13 +0100
Message-Id: <20180308180423.941-2-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/11] hw/s390x/ipl: Bail out if the network
 bootloader can not be found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

If QEMU fails to load 's390-netboot.img', the guest firmware currently
loops forever and just floods the console with "Network boot device
detected" messages. The code in ipl.c apparently already tried to stop
the VM with vm_stop() in this case, but this is in vain since the run
state is later reset due to a call to vm_start() from vl.c again.
To avoid the ugly firmware loop, let's simply exit QEMU directly instead
since it just does not make sense to continue if the required firmware
image can not be loaded. While we're at it, also add the file name of
the netboot binary to the error message, so that the user has a better
hint about what is missing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1519725913-24852-1-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 798e99aadf..8512aaacf7 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -380,7 +380,8 @@ static int load_netboot_image(Error **errp)
 
     netboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->netboot_fw);
     if (netboot_filename == NULL) {
-        error_setg(errp, "Could not find network bootloader");
+        error_setg(errp, "Could not find network bootloader '%s'",
+                   ipl->netboot_fw);
         goto unref_mr;
     }
 
@@ -489,7 +490,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
     if (ipl->netboot) {
         if (load_netboot_image(&err) < 0) {
             error_report_err(err);
-            vm_stop(RUN_STATE_INTERNAL_ERROR);
+            exit(1);
         }
         ipl->qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
     }
-- 
2.13.6
