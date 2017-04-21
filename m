Received: from eggs.gnu.org ([2001:4830:134:3::10]:40700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBZ-00012U-Di
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBW-0000eP-Ar
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d1TBW-0000e9-1l
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3L7cXIC064958
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:52 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29y9tnrhf8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:52 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 21 Apr 2017 08:40:49 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 21 Apr 2017 09:40:31 +0200
In-Reply-To: <20170421074038.774-1-cornelia.huck@de.ibm.com>
References: <20170421074038.774-1-cornelia.huck@de.ibm.com>
Message-Id: <20170421074038.774-5-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 04/11] s390x/css: introduce read-only property
 type for device ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Let's introduce a read-only property type that handles device ids of the
CssDevId type used for channel devices for future use. e.g. exposing the
busid of an I/O subchannel that is assigned to a ccw device.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c         | 7 +++++++
 include/hw/s390x/css.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 37caa98195..f966ce2d15 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1894,6 +1894,13 @@ PropertyInfo css_devid_propinfo = {
     .set = set_css_devid,
 };
 
+PropertyInfo css_devid_ro_propinfo = {
+    .name = "str",
+    .description = "Read-only identifier of an I/O device in the channel "
+                   "subsystem, example: fe.1.23ab",
+    .get = get_css_devid,
+};
+
 SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp)
 {
     uint16_t schid = 0;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index c96c862057..e88f24b868 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -172,6 +172,11 @@ extern PropertyInfo css_devid_propinfo;
 #define DEFINE_PROP_CSS_DEV_ID(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, css_devid_propinfo, CssDevId)
 
+extern PropertyInfo css_devid_ro_propinfo;
+
+#define DEFINE_PROP_CSS_DEV_ID_RO(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, css_devid_ro_propinfo, CssDevId)
+
 /**
  * Create a subchannel for the given bus id.
  *
-- 
2.11.0
