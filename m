Received: from eggs.gnu.org ([2001:4830:134:3::10]:52934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZK-00084N-HX
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZI-0004xw-Uk
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:38 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:43 +0200
Message-Id: <20181004152857.14525-2-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] hw/s390x/ipl: Fix alignment problems of
 S390IPLState members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The IplParameterBlock and QemuIplParameters structures are declared with
QEMU_PACKED, so the compiler assumes that the structures do not need to
be aligned in memory. Since the are listed after a "bool" within the
S390IPLState, the IplParameterBlock and QemuIplParameters are also indeed
mis-aligned in memory. This causes problems on Sparc during migration, since
we use VMSTATE_UINT16 in vmstate_iplb to access the devno member for example,
and the corresponding migration functions (like qemu_get_be16s) then try to
access a 16-bit value from a misaligned memory address.
The easiest solution to fix this problem is to move the packed structures
to the beginning of the S390IPLState, right after the DeviceState of course
which has to stay first for QOM reasons. But since DeviceState is a non-packed
struct, we can be sure that it will be padded to the correct alignment at the
end. If not, the QEMU_BUILD_BUG_MSG in this patch will tell us.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1538036615-32542-2-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 4e87b89418..b3a07a12d8 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -132,15 +132,15 @@ typedef struct QemuIplParameters QemuIplParameters;
 struct S390IPLState {
     /*< private >*/
     DeviceState parent_obj;
+    IplParameterBlock iplb;
+    QemuIplParameters qipl;
     uint64_t start_addr;
     uint64_t compat_start_addr;
     uint64_t bios_start_addr;
     uint64_t compat_bios_start_addr;
     bool enforce_bios;
-    IplParameterBlock iplb;
     bool iplb_valid;
     bool netboot;
-    QemuIplParameters qipl;
     /* reset related properties don't have to be migrated or reset */
     enum s390_reset reset_type;
     int reset_cpu_index;
@@ -157,6 +157,7 @@ struct S390IPLState {
     bool iplbext_migration;
 };
 typedef struct S390IPLState S390IPLState;
+QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
-- 
2.14.4
