Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B889C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1300207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cMg+1qMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1300207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haztS-0002fR-TD
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazmr-00051P-79
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazmp-0000nP-US
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:43:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hazmm-0000kR-Vx; Wed, 12 Jun 2019 05:43:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9YCr0193645;
 Wed, 12 Jun 2019 09:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=VuvUHYBiIoed7M4Qt45n2olUqtuKHAeuaxDDCAKVfqc=;
 b=cMg+1qMszT1ezlOCHUiBMHPzpG+g0Ybi9S+r7GoE7V3GQ6mWVtrmW7pqTR1ie7+8bpKb
 X3KmLNMk3omRJF6A4KFdjSm0VsGjbebJNlD3qWim++cWEIGsU+Egk04fegt0tRYItDpB
 zo1wtzw3FJXeVjJ45sDbN4jMtgNLomooOYdjwteKY4+m0dk7yL9UBE2zYVhwLsxNrKO4
 HCJIttI4CUVCIx55td1Yja+QJhXL23yaatfIeolM1g4/4pCI5OTJ0EM2/NZCvlE0QsCE
 zq4yK6cOzthBGPK+jPZNA7HOhAi2HEfruT7k1tuNkjUjPZm0aJIWqbqSWdWYeFx+zsxe Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t05nqt88w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9gTNG116553;
 Wed, 12 Jun 2019 09:43:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t0p9rsgp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:13 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5C9hC8I028727;
 Wed, 12 Jun 2019 09:43:12 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 02:43:12 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 12 Jun 2019 12:42:32 +0300
Message-Id: <20190612094237.47462-4-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
References: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120066
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [QEMU] [PATCH 3/8] bootdevice: Add interface to gather
 LCHS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: liran.alon@oracle.com, shmuel.eiderman@oracle.com, karl.heubaum@oracle.com,
 arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an interface to provide direct logical CHS values for boot devices.
We will use this interface in the next commits.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c            | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sysemu.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/bootdevice.c b/bootdevice.c
index 1d225202f9..bc5e1c2de4 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -343,3 +343,58 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
     /* initialize devices' bootindex property to -1 */
     object_property_set_int(obj, -1, name, NULL);
 }
+
+typedef struct FWLCHSEntry FWLCHSEntry;
+
+struct FWLCHSEntry {
+    QTAILQ_ENTRY(FWLCHSEntry) link;
+    DeviceState *dev;
+    char *suffix;
+    uint32_t lcyls;
+    uint32_t lheads;
+    uint32_t lsecs;
+};
+
+static QTAILQ_HEAD(, FWLCHSEntry) fw_lchs =
+    QTAILQ_HEAD_INITIALIZER(fw_lchs);
+
+void add_boot_device_lchs(DeviceState *dev, const char *suffix,
+                          uint32_t lcyls, uint32_t lheads, uint32_t lsecs)
+{
+    FWLCHSEntry *node;
+
+    if (!lcyls && !lheads && !lsecs) {
+        return;
+    }
+
+    assert(dev != NULL || suffix != NULL);
+
+    node = g_malloc0(sizeof(FWLCHSEntry));
+    node->suffix = g_strdup(suffix);
+    node->dev = dev;
+    node->lcyls = lcyls;
+    node->lheads = lheads;
+    node->lsecs = lsecs;
+
+    QTAILQ_INSERT_TAIL(&fw_lchs, node, link);
+}
+
+void del_boot_device_lchs(DeviceState *dev, const char *suffix)
+{
+    FWLCHSEntry *i;
+
+    if (dev == NULL) {
+        return;
+    }
+
+    QTAILQ_FOREACH(i, &fw_lchs, link) {
+        if ((!suffix || !g_strcmp0(i->suffix, suffix)) &&
+             i->dev == dev) {
+            QTAILQ_REMOVE(&fw_lchs, i, link);
+            g_free(i->suffix);
+            g_free(i);
+
+            break;
+        }
+    }
+}
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 61579ae71e..173dfbb539 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -171,6 +171,9 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                                    DeviceState *dev, Error **errp);
 void restore_boot_order(void *opaque);
 void validate_bootdevices(const char *devices, Error **errp);
+void add_boot_device_lchs(DeviceState *dev, const char *suffix,
+                          uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
+void del_boot_device_lchs(DeviceState *dev, const char *suffix);
 
 /* handler to set the boot_device order for a specific type of MachineClass */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
-- 
2.13.3


