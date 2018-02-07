Received: from eggs.gnu.org ([2001:4830:134:3::10]:59575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1N-0001PC-7I
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1I-0004ex-2H
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP1H-0004dN-T8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05E2E40201A0
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B8C4B2024CA5
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  7 Feb 2018 13:39:51 +0100
Message-Id: <20180207124009.12376-3-armbru@redhat.com>
In-Reply-To: <20180207124009.12376-1-armbru@redhat.com>
References: <20180207124009.12376-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 02/20] Use #include "..." for our own headers,
 <...> for others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

System headers should be included with <...>, our own headers with
"...".  Offenders tracked down with an ugly, brittle and probably
buggy Perl script.  Previous iteration was commit a9c94277f0.

Delete inclusions of "string.h" and "strings.h" instead of fixing them
to <string.h> and <strings.h>, because we always include these via
osdep.h.

Put the cleaned up system header includes first.

While there, separate #include from file comment with exactly one
blank line.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180201111846.21846-2-armbru@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c             | 4 ++--
 hw/ide/sii3112.c                                      | 4 ++--
 hw/s390x/s390-ccw.c                                   | 3 ++-
 include/hw/loader-fit.h                               | 2 +-
 include/hw/registerfields.h                           | 2 +-
 include/hw/s390x/storage-attributes.h                 | 2 +-
 target/i386/hax-all.c                                 | 1 -
 target/i386/hvf/hvf.c                                 | 1 -
 target/i386/hvf/x86_decode.c                          | 1 -
 target/i386/hvf/x86_mmu.c                             | 6 ++----
 target/i386/hvf/x86_task.c                            | 1 -
 target/s390x/gen-features.c                           | 6 ++----
 target/xtensa/core-dc232b/xtensa-modules.c            | 2 +-
 target/xtensa/core-dc233c/xtensa-modules.c            | 2 +-
 target/xtensa/core-de212/xtensa-modules.c             | 2 +-
 target/xtensa/core-fsf/xtensa-modules.c               | 2 +-
 target/xtensa/core-sample_controller/xtensa-modules.c | 2 +-
 target/xtensa/xtensa-isa.h                            | 2 +-
 vl.c                                                  | 2 +-
 19 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
index 54c1191db0..02c29019d1 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -11,10 +11,10 @@
  */
 
 #include "qemu/osdep.h"
+#include <iscsi/iscsi.h>
+#include <iscsi/scsi-lowlevel.h>
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "standard-headers/linux/virtio_scsi.h"
-#include "iscsi/iscsi.h"
-#include "iscsi/scsi-lowlevel.h"
 
 #include <glib.h>
 
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 17aa930e39..e3896c65b4 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -12,8 +12,8 @@
  * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
  */
 
-#include <qemu/osdep.h>
-#include <hw/ide/pci.h>
+#include "qemu/osdep.h"
+#include "hw/ide/pci.h"
 #include "trace.h"
 
 #define TYPE_SII3112_PCI "sii3112"
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 4a9d4d2534..7fc1c603c0 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -10,10 +10,11 @@
  * or (at your option) any later version. See the COPYING file in the
  * top-level directory.
  */
+
 #include "qemu/osdep.h"
+#include <libgen.h>
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "libgen.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-ccw.h"
diff --git a/include/hw/loader-fit.h b/include/hw/loader-fit.h
index 9e2a068a20..0284c3e02c 100644
--- a/include/hw/loader-fit.h
+++ b/include/hw/loader-fit.h
@@ -20,7 +20,7 @@
 #ifndef HW_LOADER_FIT_H
 #define HW_LOADER_FIT_H
 
-#include <exec/hwaddr.h>
+#include "exec/hwaddr.h"
 
 struct fit_loader_match {
     const char *compatible;
diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index 44e0b94edf..2659a58737 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -11,7 +11,7 @@
 #ifndef REGISTERFIELDS_H
 #define REGISTERFIELDS_H
 
-#include <qemu/bitops.h>
+#include "qemu/bitops.h"
 
 /* Define constants for a 32 bit register */
 
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 9be954d163..d6403a0a7e 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -12,7 +12,7 @@
 #ifndef S390_STORAGE_ATTRIBUTES_H
 #define S390_STORAGE_ATTRIBUTES_H
 
-#include <hw/qdev.h>
+#include "hw/qdev.h"
 #include "monitor/monitor.h"
 
 #define TYPE_S390_STATTRIB "s390-storage_attributes"
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 934ec4afd1..bc9a12c1ee 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -30,7 +30,6 @@
 #include "exec/ioport.h"
 
 #include "qemu-common.h"
-#include "strings.h"
 #include "hax-i386.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 010866ed22..aef3d83bb9 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -43,7 +43,6 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
 #include "qemu/main-loop.h"
-#include "strings.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
 #include "target/i386/cpu.h"
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index bf93e8207d..2d7540fe7c 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -21,7 +21,6 @@
 #include "qemu-common.h"
 #include "panic.h"
 #include "x86_decode.h"
-#include "string.h"
 #include "vmx.h"
 #include "x86_mmu.h"
 #include "x86_descr.h"
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 5c1f35acd0..c6be2cca35 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -15,18 +15,16 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
+#include <memory.h>
 #include "panic.h"
-
 #include "qemu-common.h"
 #include "cpu.h"
 #include "x86.h"
 #include "x86_mmu.h"
-#include "string.h"
 #include "vmcs.h"
 #include "vmx.h"
-
-#include "memory.h"
 #include "exec/address-spaces.h"
 
 #define pte_present(pte) (pte & PT_PRESENT)
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index d7f665f8fa..4abf3db25e 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -32,7 +32,6 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
 #include "qemu/main-loop.h"
-#include "strings.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
 #include "target/i386/cpu.h"
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 0570f597ec..bd483333ae 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -9,12 +9,10 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
  * your option) any later version. See the COPYING file in the top-level
  * directory.
- *
  */
 
-
-#include "inttypes.h"
-#include "stdio.h"
+#include <inttypes.h>
+#include <stdio.h>
 #include "cpu_features_def.h"
 
 #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
diff --git a/target/xtensa/core-dc232b/xtensa-modules.c b/target/xtensa/core-dc232b/xtensa-modules.c
index 2e103cd2f5..0af43c84bb 100644
--- a/target/xtensa/core-dc232b/xtensa-modules.c
+++ b/target/xtensa/core-dc232b/xtensa-modules.c
@@ -18,7 +18,7 @@
    Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
    02110-1301, USA.  */
 
-#include <xtensa-isa.h>
+#include "xtensa-isa.h"
 #include "xtensa-isa-internal.h"
 
 

diff --git a/target/xtensa/core-dc233c/xtensa-modules.c b/target/xtensa/core-dc233c/xtensa-modules.c
index 2728311c9a..8a41e73659 100644
--- a/target/xtensa/core-dc233c/xtensa-modules.c
+++ b/target/xtensa/core-dc233c/xtensa-modules.c
@@ -21,7 +21,7 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
-#include <xtensa-isa.h>
+#include "xtensa-isa.h"
 #include "xtensa-isa-internal.h"
 
 

diff --git a/target/xtensa/core-de212/xtensa-modules.c b/target/xtensa/core-de212/xtensa-modules.c
index 4a8735889e..21f3bd8797 100644
--- a/target/xtensa/core-de212/xtensa-modules.c
+++ b/target/xtensa/core-de212/xtensa-modules.c
@@ -21,7 +21,7 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
-#include <xtensa-isa.h>
+#include "xtensa-isa.h"
 #include "xtensa-isa-internal.h"
 
 

diff --git a/target/xtensa/core-fsf/xtensa-modules.c b/target/xtensa/core-fsf/xtensa-modules.c
index 238800d823..9621f5142a 100644
--- a/target/xtensa/core-fsf/xtensa-modules.c
+++ b/target/xtensa/core-fsf/xtensa-modules.c
@@ -18,7 +18,7 @@
    Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
    02110-1301, USA.  */
 
-#include <xtensa-isa.h>
+#include "xtensa-isa.h"
 #include "xtensa-isa-internal.h"
 
 

diff --git a/target/xtensa/core-sample_controller/xtensa-modules.c b/target/xtensa/core-sample_controller/xtensa-modules.c
index 2f000199b8..39810e532a 100644
--- a/target/xtensa/core-sample_controller/xtensa-modules.c
+++ b/target/xtensa/core-sample_controller/xtensa-modules.c
@@ -21,7 +21,7 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
-#include <xtensa-isa.h>
+#include "xtensa-isa.h"
 #include "xtensa-isa-internal.h"
 
 

diff --git a/target/xtensa/xtensa-isa.h b/target/xtensa/xtensa-isa.h
index d06614c187..0f0211f841 100644
--- a/target/xtensa/xtensa-isa.h
+++ b/target/xtensa/xtensa-isa.h
@@ -1 +1 @@
-#include <hw/xtensa/xtensa-isa.h>
+#include "hw/xtensa/xtensa-isa.h"
diff --git a/vl.c b/vl.c
index e517a8d995..d7e4d97814 100644
--- a/vl.c
+++ b/vl.c
@@ -28,8 +28,8 @@
 #include "qemu/uuid.h"
 
 #ifdef CONFIG_SECCOMP
+#include <sys/prctl.h>
 #include "sysemu/seccomp.h"
-#include "sys/prctl.h"
 #endif
 
 #ifdef CONFIG_SDL
-- 
2.13.6
