Received: from eggs.gnu.org ([2001:4830:134:3::10]:51469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIHlV-0001WD-Bf
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIHlR-0006NL-Di
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48765
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dIHlR-0006NB-7G
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56Gs8jo076784
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 12:55:28 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2awx18yp9q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 12:55:28 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 17:55:26 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue,  6 Jun 2017 18:55:09 +0200
In-Reply-To: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170606165510.33057-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 2/3] vmstate: error hint for failed equal
 checks part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Verbose error reporting for the _EQUAL family. Modify the standard _EQUAL
so the hint states the assertion probably failed due to a bug. Introduce
_EQUAL_HINT for specifying a context specific hint.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
Keeping this separate for now because we may want something different
here. E.g. no new macros and adding an extra NULL parameter for all
pre-existing  _EQUAL usages.
---
 include/migration/vmstate.h | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index d90d9b12ca..ed1e1fd047 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -302,6 +302,18 @@ extern const VMStateInfo vmstate_info_qtailq;
     .offset       = vmstate_offset_value(_state, _field, _type),     \
 }
 
+#define VMSTATE_SINGLE_FULL(_field, _state, _test, _version, _info,  \
+                            _type, _err_hint) {                      \
+    .name         = (stringify(_field)),                             \
+    .err_hint     = (_err_hint),                                     \
+    .version_id   = (_version),                                      \
+    .field_exists = (_test),                                         \
+    .size         = sizeof(_type),                                   \
+    .info         = &(_info),                                        \
+    .flags        = VMS_SINGLE,                                      \
+    .offset       = vmstate_offset_value(_state, _field, _type),     \
+}
+
 /* Validate state using a boolean predicate. */
 #define VMSTATE_VALIDATE(_name, _test) { \
     .name         = (_name),                                         \
@@ -808,30 +820,60 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64(_f, _s)                                        \
     VMSTATE_UINT64_V(_f, _s, 0)
 
+#define VMSTATE_UINT8_EQUAL_HINT(_f, _s, _err_hint)                   \
+    VMSTATE_SINGLE_FULL(_f, _s, NULL, 0, vmstate_info_uint8_equal,    \
+                        uint8_t, _err_hint)
+
 #define VMSTATE_UINT8_EQUAL(_f, _s)                                   \
-    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_uint8_equal, uint8_t)
+    VMSTATE_UINT8_EQUAL_HINT(_f, _s, "Bug!?")
+
+#define VMSTATE_UINT16_EQUAL_HINT(_f, _s, _err_hint)                  \
+    VMSTATE_SINGLE_FULL(_f, _s, NULL, 0, vmstate_info_uint16_equal,   \
+                        uint16_t, _err_hint)
 
 #define VMSTATE_UINT16_EQUAL(_f, _s)                                  \
-    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_uint16_equal, uint16_t)
+    VMSTATE_UINT16_EQUAL_HINT(_f, _s, "Bug!?")
+
+#define VMSTATE_UINT16_EQUAL_V_HINT(_f, _s, _v, _err_hint)            \
+    VMSTATE_SINGLE_FULL(_f, _s, NULL, _v, vmstate_info_uint16_equal,  \
+                        uint16_t, _err_hint)
 
 #define VMSTATE_UINT16_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16_equal, uint16_t)
+    VMSTATE_UINT16_EQUAL_V_HINT(_f, _s, _v, "Bug!?")
+
+#define VMSTATE_INT32_EQUAL_HINT(_f, _s, _err_hint)                   \
+    VMSTATE_SINGLE_FULL(_f, _s, NULL, 0, vmstate_info_int32_equal,    \
+                        int32_t, _err_hint)
 
 #define VMSTATE_INT32_EQUAL(_f, _s)                                   \
-    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_equal, int32_t)
+    VMSTATE_INT32_EQUAL_HINT(_f, _s, "Bug!?")
+
+#define VMSTATE_UINT32_EQUAL_V_HINT(_f, _s, _v,  _err_hint)           \
+    VMSTATE_SINGLE_FULL(_f, _s, NULL, _v, vmstate_info_uint32_equal,  \
+                        uint32_t, _err_hint)
 
 #define VMSTATE_UINT32_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32_equal, uint32_t)
+    VMSTATE_UINT32_EQUAL_V_HINT(_f, _s, _v, "Bug!?")
 
 #define VMSTATE_UINT32_EQUAL(_f, _s)                                  \
     VMSTATE_UINT32_EQUAL_V(_f, _s, 0)
 
+#define VMSTATE_UINT32_EQUAL_HINT(_f, _s, _err_hint)                  \
+    VMSTATE_UINT32_EQUAL_V_HINT(_f, _s, 0, _err_hint)
+
+#define VMSTATE_UINT64_EQUAL_V_HINT(_f, _s, _v,  _err_hint)           \
+    VMSTATE_SINGLE_FULL(_f, _s, NULL, _v, vmstate_info_int64_equal,   \
+                        uint64_t, _err_hint)
+
 #define VMSTATE_UINT64_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64_equal, uint64_t)
+    VMSTATE_UINT64_EQUAL_V_HINT(_f, _s, _v, "Bug!?")
 
 #define VMSTATE_UINT64_EQUAL(_f, _s)                                  \
     VMSTATE_UINT64_EQUAL_V(_f, _s, 0)
 
+#define VMSTATE_UINT64_EQUAL_HINT(_f, _s, _err_hint)                  \
+    VMSTATE_UINT64_EQUAL_V_HINT(_f, _s, 0, _err_hint)
+
 #define VMSTATE_INT32_POSITIVE_LE(_f, _s)                             \
     VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_le, int32_t)
 
-- 
2.11.2
