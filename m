Received: from eggs.gnu.org ([2001:4830:134:3::10]:46724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebriJ-0008Qn-NL
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebriJ-0007ow-0E
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:27 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 17 Jan 2018 18:40:35 +0100
Message-Id: <20180117174047.6382-7-david@redhat.com>
In-Reply-To: <20180117174047.6382-1-david@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/18] s390x/flic: no need to call
 s390_io_interrupt() from flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

We can directly call the right function.

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index bdc8ec7607..d6ed1d7380 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -108,6 +108,7 @@ static int qemu_s390_inject_airq(S390FLICState *fs, uint8_t type,
                                  uint8_t isc, uint8_t flags)
 {
     QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
+    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
     bool flag = flags & S390_ADAPTER_SUPPRESSIBLE;
     uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
 
@@ -116,7 +117,7 @@ static int qemu_s390_inject_airq(S390FLICState *fs, uint8_t type,
         return 0;
     }
 
-    s390_io_interrupt(0, 0, 0, io_int_word);
+    fsc->inject_io(fs, 0, 0, 0, io_int_word);
 
     if (flag && (flic->simm & AIS_MODE_MASK(isc))) {
         flic->nimm |= AIS_MODE_MASK(isc);
-- 
2.14.3
