Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F48C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2CB20665
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ULR4M9dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2CB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg7Pi-0005ix-2R
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7ED-00026s-4n
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg7EB-0002VU-TJ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:40:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hg7E8-00025u-Kr; Wed, 26 Jun 2019 08:40:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCd7ko108915;
 Wed, 26 Jun 2019 12:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=iHOxrB7sQtoFEk7ueVdptFxfU4bhLQrvkAX6+XMXujI=;
 b=ULR4M9dzEUJe0XBKUeI0ovjuiaFxUcM7qn7Fdr5hDihvJlI3YNU2zO0khgjNIrqVHjk3
 fgoY9Wk7mTWKK298Wth2sM5HOgp5k5S+tOpKDORNCEIFLVAjBi/uUKRyBnpAWGm24RVx
 Q+a/fFzzCWJM2HQPuUEnkPMHATsBffsk2DLKG7rpUMJgofYQTgSyi/MhQVzkw10PS0Ln
 hCgNvVwGzLjPhdPY7nkBkiMhTmWg6V/0KF1HMdPVuw1tX1iPQF+fwT0Zi19jDe6fiEen
 IcbNcl/YHgosu9Q/0NpTyL/tGBXz7OGJaOCXc91hySV3v56sdH/vEE1eAAEeE1XqoN/+ yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2t9c9pt2nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:40:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCdf79100737;
 Wed, 26 Jun 2019 12:40:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2t9accp243-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 12:40:33 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QCeVPg001946;
 Wed, 26 Jun 2019 12:40:32 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 05:40:31 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 26 Jun 2019 15:39:46 +0300
Message-Id: <20190626123948.10199-7-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260151
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [QEMU] [PATCH v5 6/8] bootdevice: Refactor
 get_boot_devices_list
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

Move device name construction to a separate function.

We will reuse this function in the following commit to pass logical CHS
parameters through fw_cfg much like we currently pass bootindex.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c | 61 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index bc5e1c2de4..2b12fb85a4 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -202,6 +202,39 @@ DeviceState *get_boot_device(uint32_t position)
     return res;
 }
 
+static char *get_boot_device_path(DeviceState *dev, bool ignore_suffixes,
+                                  char *suffix)
+{
+    char *devpath = NULL, *s = NULL, *d, *bootpath;
+
+    if (dev) {
+        devpath = qdev_get_fw_dev_path(dev);
+        assert(devpath);
+    }
+
+    if (!ignore_suffixes) {
+        if (dev) {
+            d = qdev_get_own_fw_dev_path_from_handler(dev->parent_bus, dev);
+            if (d) {
+                assert(!suffix);
+                s = d;
+            } else {
+                s = g_strdup(suffix);
+            }
+        } else {
+            s = g_strdup(suffix);
+        }
+    }
+
+    bootpath = g_strdup_printf("%s%s",
+                               devpath ? devpath : "",
+                               s ? s : "");
+    g_free(devpath);
+    g_free(s);
+
+    return bootpath;
+}
+
 /*
  * This function returns null terminated string that consist of new line
  * separated device paths.
@@ -218,36 +251,10 @@ char *get_boot_devices_list(size_t *size)
     bool ignore_suffixes = mc->ignore_boot_device_suffixes;
 
     QTAILQ_FOREACH(i, &fw_boot_order, link) {
-        char *devpath = NULL,  *suffix = NULL;
         char *bootpath;
-        char *d;
         size_t len;
 
-        if (i->dev) {
-            devpath = qdev_get_fw_dev_path(i->dev);
-            assert(devpath);
-        }
-
-        if (!ignore_suffixes) {
-            if (i->dev) {
-                d = qdev_get_own_fw_dev_path_from_handler(i->dev->parent_bus,
-                                                          i->dev);
-                if (d) {
-                    assert(!i->suffix);
-                    suffix = d;
-                } else {
-                    suffix = g_strdup(i->suffix);
-                }
-            } else {
-                suffix = g_strdup(i->suffix);
-            }
-        }
-
-        bootpath = g_strdup_printf("%s%s",
-                                   devpath ? devpath : "",
-                                   suffix ? suffix : "");
-        g_free(devpath);
-        g_free(suffix);
+        bootpath = get_boot_device_path(i->dev, ignore_suffixes, i->suffix);
 
         if (total) {
             list[total-1] = '\n';
-- 
2.13.3


