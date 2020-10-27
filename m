Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666DEC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B149C22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZ8vP8rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B149C22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMEk-0008Qv-LR
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kXMDW-0007TE-0F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:28:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kXMDT-0002V1-On
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:28:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RAPMgw106682;
 Tue, 27 Oct 2020 10:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=Y2aprb5hAk3ZGgTJcZaMbNLg9W/uk2Ja3C0tiseShJM=;
 b=AZ8vP8rBzUOmdkdcIeM41l/aH5oc5WBCNOxQn8WWuCld0uk4t6CKs/kTR/n8PiEH7Y+X
 zL/fvjUoWwg7BVj55QDtnF1s+pUJxiJhfsUEEM4Vnn2wYXXBayObLeVCYzmV3jOoDUsX
 1B9sOqwHg6iNUziawWMX+RFvYzF2GJLCqr0KFavv/7p+PCNTU3jzmdkXgT4PITR4VX4B
 zwcIBFk6lafMVVzlCdrg8yeJh2mds+BEzsVruZQsIFLyfGvi7CvDVJUYImuQCNgE9+Y3
 W8TLE9XlDb656wXVYSE5IxzNuHwsYx0dk9OMccRLc1SZCi12ssW6YP8pBNMNHVeVKW4X rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 34cc7ks53b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Oct 2020 10:28:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RAPJAU144123;
 Tue, 27 Oct 2020 10:28:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 34cx6vsudb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2020 10:28:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09RASTt4025512;
 Tue, 27 Oct 2020 10:28:29 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 27 Oct 2020 03:28:29 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 871b2c68;
 Tue, 27 Oct 2020 10:28:27 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/i386: -cpu model,-feature,+feature should enable feature
Date: Tue, 27 Oct 2020 10:28:26 +0000
Message-Id: <20201027102826.68489-1-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=3
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270068
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=david.edmondson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:28:32
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: David Edmondson <david.edmondson@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Minus" features are applied after "plus" features, so ensure that a
later "plus" feature causes an earlier "minus" feature to be removed.

This has no effect on the existing "-feature,feature=on" backward
compatibility code (which warns and turns the feature off).

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 target/i386/cpu.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d8606958e..c3dcfb868c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4720,13 +4720,30 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
         GlobalProperty *prop;
 
         /* Compatibility syntax: */
-        if (featurestr[0] == '+') {
-            plus_features = g_list_append(plus_features,
-                                          g_strdup(featurestr + 1));
-            continue;
-        } else if (featurestr[0] == '-') {
-            minus_features = g_list_append(minus_features,
-                                           g_strdup(featurestr + 1));
+        if (featurestr[0] == '+' || featurestr[0] == '-') {
+            const char *feat = featurestr + 1;
+            GList *val;
+            char *data;
+
+            /* Remove any existing +/- setting. */
+            val = g_list_find_custom(minus_features, feat, compare_string);
+            if (val) {
+                data = val->data;
+                minus_features = g_list_remove(minus_features, data);
+                g_free(data);
+            }
+            val = g_list_find_custom(plus_features, feat, compare_string);
+            if (val) {
+                data = val->data;
+                plus_features = g_list_remove(plus_features, data);
+                g_free(data);
+            }
+
+            if (featurestr[0] == '+') {
+                plus_features = g_list_append(plus_features, g_strdup(feat));
+            } else {
+                minus_features = g_list_append(minus_features, g_strdup(feat));
+            }
             continue;
         }
 
-- 
2.28.0


