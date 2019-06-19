Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FC9C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782D0206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RZj5w+ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782D0206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdWs4-0002XC-QX
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWpG-0000GL-5j
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWpE-0002Ze-Ul
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:24:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdWpC-0002Uf-2M; Wed, 19 Jun 2019 05:24:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9OCh3177697;
 Wed, 19 Jun 2019 09:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=oQR4xmjeWzbZhcXNjv3T066XNj13Gh9vtd86d476e9c=;
 b=RZj5w+ewlTDavhf2pni6SvJQS1y7QTsdx4UsUyY7Th9n7uIPUs0I1ORb91liyFVVem3g
 ifGfT+Stx8epyduls5jSCuXle47IDuGRbTvctS901ImDk3D5DSjebbp4f2dDP2oBt/RD
 Mv385y4cQQg2er96QNHZ/uu/Fiv0x15ppeMeWEfGt644GDPVqXkelNt1/d3mjSRx7p2v
 KPWP3GYDCUk3omNf33Ik07gdd/BFOV+m0xBO6ZKRXhxq1Dh2HZUuFX1wAUebxsCJ8nYN
 GNtFvpWlYprNSazr7vxThpqaUMZtbdqhpIjzZ86OnGJFETCt/r5se9cS/srsbtvY6n5R XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t7809a8xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:24:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9NbxL182104;
 Wed, 19 Jun 2019 09:24:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2t77ymyr9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:24:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J9OALs001961;
 Wed, 19 Jun 2019 09:24:10 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 02:24:10 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 19 Jun 2019 12:23:50 +0300
Message-Id: <20190619092352.23583-3-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [SeaBIOS] [PATCH v3 2/4] boot: Reorder functions in
 boot.c
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

Currently glob_prefix() and build_pci_path() are under the "Boot
priority ordering" section.
Move them to a new "Helper search functions" section since we will reuse
them in the next commit.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 src/boot.c | 94 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/src/boot.c b/src/boot.c
index a2cb167c..70f639f4 100644
--- a/src/boot.c
+++ b/src/boot.c
@@ -22,6 +22,55 @@
 #include "util.h" // irqtimer_calc
 #include "tcgbios.h" // tpm_*
 
+/****************************************************************
+ * Helper search functions
+ ****************************************************************/
+
+// See if 'str' starts with 'glob' - if glob contains an '*' character
+// it will match any number of characters in str that aren't a '/' or
+// the next glob character.
+static char *
+glob_prefix(const char *glob, const char *str)
+{
+    for (;;) {
+        if (!*glob && (!*str || *str == '/'))
+            return (char*)str;
+        if (*glob == '*') {
+            if (!*str || *str == '/' || *str == glob[1])
+                glob++;
+            else
+                str++;
+            continue;
+        }
+        if (*glob != *str)
+            return NULL;
+        glob++;
+        str++;
+    }
+}
+
+#define FW_PCI_DOMAIN "/pci@i0cf8"
+
+static char *
+build_pci_path(char *buf, int max, const char *devname, struct pci_device *pci)
+{
+    // Build the string path of a bdf - for example: /pci@i0cf8/isa@1,2
+    char *p = buf;
+    if (pci->parent) {
+        p = build_pci_path(p, max, "pci-bridge", pci->parent);
+    } else {
+        p += snprintf(p, buf+max-p, "%s", FW_PCI_DOMAIN);
+        if (pci->rootbus)
+            p += snprintf(p, buf+max-p, ",%x", pci->rootbus);
+    }
+
+    int dev = pci_bdf_to_dev(pci->bdf), fn = pci_bdf_to_fn(pci->bdf);
+    p += snprintf(p, buf+max-p, "/%s@%x", devname, dev);
+    if (fn)
+        p += snprintf(p, buf+max-p, ",%x", fn);
+    return p;
+}
+
 
 /****************************************************************
  * Boot device logical geometry
@@ -141,29 +190,6 @@ loadBootOrder(void)
     } while (f);
 }
 
-// See if 'str' starts with 'glob' - if glob contains an '*' character
-// it will match any number of characters in str that aren't a '/' or
-// the next glob character.
-static char *
-glob_prefix(const char *glob, const char *str)
-{
-    for (;;) {
-        if (!*glob && (!*str || *str == '/'))
-            return (char*)str;
-        if (*glob == '*') {
-            if (!*str || *str == '/' || *str == glob[1])
-                glob++;
-            else
-                str++;
-            continue;
-        }
-        if (*glob != *str)
-            return NULL;
-        glob++;
-        str++;
-    }
-}
-
 // Search the bootorder list for the given glob pattern.
 static int
 find_prio(const char *glob)
@@ -176,28 +202,6 @@ find_prio(const char *glob)
     return -1;
 }
 
-#define FW_PCI_DOMAIN "/pci@i0cf8"
-
-static char *
-build_pci_path(char *buf, int max, const char *devname, struct pci_device *pci)
-{
-    // Build the string path of a bdf - for example: /pci@i0cf8/isa@1,2
-    char *p = buf;
-    if (pci->parent) {
-        p = build_pci_path(p, max, "pci-bridge", pci->parent);
-    } else {
-        p += snprintf(p, buf+max-p, "%s", FW_PCI_DOMAIN);
-        if (pci->rootbus)
-            p += snprintf(p, buf+max-p, ",%x", pci->rootbus);
-    }
-
-    int dev = pci_bdf_to_dev(pci->bdf), fn = pci_bdf_to_fn(pci->bdf);
-    p += snprintf(p, buf+max-p, "/%s@%x", devname, dev);
-    if (fn)
-        p += snprintf(p, buf+max-p, ",%x", fn);
-    return p;
-}
-
 int bootprio_find_pci_device(struct pci_device *pci)
 {
     if (CONFIG_CSM)
-- 
2.13.3


