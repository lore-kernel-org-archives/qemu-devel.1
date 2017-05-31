Received: from eggs.gnu.org ([2001:4830:134:3::10]:37356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dG9OK-0002NG-4Y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dG9OJ-0003PJ-Bl
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dG9OJ-0003Ou-6G
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:47 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 31 May 2017 21:34:34 +0200
Message-Id: <20170531193434.6918-3-david@redhat.com>
In-Reply-To: <20170531193434.6918-1-david@redhat.com>
References: <20170531193434.6918-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/2] s390x/cpumodel: improve defintion
 search without an IBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, david@redhat.com

Currently, under z/VM on a 0x2827, QEMU will detect a 0x2828 if no
IBC value is provided. QEMU will simply take the last model of that HW
generation, which happens to be the BC version.

Let's improve our search for that case by selecting the latest CPU
definition that matches the CPU type. This might still detect e.g. a
GA2 version on a GA1 system, but as we don't have further information at
hand, there isn't too much we can do about it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 9e23535..b6220c8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -184,6 +184,7 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features)
 {
     const S390CPUDef *last_compatible = NULL;
+    const S390CPUDef *matching_cpu_type = NULL;
     int i;
 
     if (!gen) {
@@ -218,8 +219,16 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
         if (def->type == type && def->ec_ga == ec_ga) {
             return def;
         }
+        /* remember if we've at least seen one with the same cpu type */
+        if (def->type == type) {
+            matching_cpu_type = def;
+        }
         last_compatible = def;
     }
+    /* prefer the model with the same cpu type, esp. don't take the BC for EC */
+    if (matching_cpu_type) {
+        return matching_cpu_type;
+    }
     return last_compatible;
 }
 
-- 
2.9.3
