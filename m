Received: from eggs.gnu.org ([2001:4830:134:3::10]:40290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuF-0005NH-W2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuC-0005xN-OL
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:43 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:14 +0100
Message-Id: <20180308180423.941-3-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/11] s390/ipl: only print boot menu error if
 -boot menu=on was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

It is possible that certain QEMU configurations may not
create an IPLB (such as when -kernel is provided). In
this case, a misleading error message will be printed
stating that the "boot menu is not supported for this
device type".

To amend this, only print this message iff boot menu=on
was provided on the commandline. Otherwise, return silently.

While we're at it, remove trailing periods from error
messages.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Message-Id: <1519760121-24594-1-git-send-email-walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 8512aaacf7..fdeaec3a58 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -234,7 +234,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     if (!get_boot_device(0)) {
         if (boot_menu) {
             error_report("boot menu requires a bootindex to be specified for "
-                         "the IPL device.");
+                         "the IPL device");
         }
         return;
     }
@@ -250,7 +250,9 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     case S390_IPL_TYPE_QEMU_SCSI:
         break;
     default:
-        error_report("boot menu is not supported for this device type.");
+        if (boot_menu) {
+            error_report("boot menu is not supported for this device type");
+        }
         return;
     }
 
@@ -263,13 +265,13 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     tmp = qemu_opt_get(opts, "splash-time");
 
     if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
-        error_report("splash-time is invalid, forcing it to 0.");
+        error_report("splash-time is invalid, forcing it to 0");
         *timeout = 0;
         return;
     }
 
     if (splash_time > 0xffffffff) {
-        error_report("splash-time is too large, forcing it to max value.");
+        error_report("splash-time is too large, forcing it to max value");
         *timeout = 0xffffffff;
         return;
     }
-- 
2.13.6
