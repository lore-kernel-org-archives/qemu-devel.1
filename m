Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F4C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 14:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B94720663
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 14:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t/wXeCGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B94720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG1tc-0007Rq-Pp
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 10:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eyal.moscovici@oracle.com>) id 1jFwdt-0005oN-Fp
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eyal.moscovici@oracle.com>) id 1jFwds-00014O-Fj
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:11:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jFwdq-00012v-3i; Sun, 22 Mar 2020 05:11:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02M9Avbj096079;
 Sun, 22 Mar 2020 09:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=JPEMsm1Gf3umvspm/9mkoTaF1cxu2wRXZXQlNMDFP4M=;
 b=t/wXeCGTmNigR/VJftwMe4fF9KSK9rVy/Mo2UzY6sSd8ns97+JUIE73rvN293DI7Htxr
 Esybd4+wiqm8yb4DKdinc4FX8bkfLrCKDB4nt4xOLittRYIQ3bqEN/jkyrt2nedHQD9z
 iyBq0YxOoEA1lIY8kidBE76OnvF9eTdMJUpKU3uGHm0v0uSWC7qluDho3whn0uDfiVWP
 z7D/O+Nq96M1e+OvqwwOZkFFQ96nlntFFcpzo4fC7cORQp/yI97zrTQ2FQd82i9d+OYK
 R286AqJ7XOrGd3NbrSzrt6G7Qg/fwa5vLL/06segYLlBVNuF/aj9E6U70F3GhvKKatcw kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2ywabqtq59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Mar 2020 09:11:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02M92vbX158679;
 Sun, 22 Mar 2020 09:11:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2ywvd9xncw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Mar 2020 09:11:32 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02M9BVDK003693;
 Sun, 22 Mar 2020 09:11:31 GMT
Received: from localhost.localdomain (/10.74.126.182)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 22 Mar 2020 02:11:30 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qemu-img: refactor dump_map_entry JSON format output
Date: Sun, 22 Mar 2020 11:11:16 +0200
Message-Id: <20200322091117.79443-2-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200322091117.79443-1-eyal.moscovici@oracle.com>
References: <20200322091117.79443-1-eyal.moscovici@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 suspectscore=1 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003220053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=1
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220053
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
X-Mailman-Approved-At: Sun, 22 Mar 2020 10:44:45 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com,
 Eyal Moscovici <eyal.moscovici@oracle.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously dump_map_entry identified whether we need to start a new JSON
array based on whether start address == 0. In this refactor we remove
this assumption as in following patches we will allow map to start from
an arbitrary position.

Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 qemu-img.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index afddf33f08..9cf8576217 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2860,9 +2860,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
         }
         break;
     case OFORMAT_JSON:
-        printf("%s{ \"start\": %"PRId64", \"length\": %"PRId64","
+        printf("{ \"start\": %"PRId64", \"length\": %"PRId64","
                " \"depth\": %"PRId64", \"zero\": %s, \"data\": %s",
-               (e->start == 0 ? "[" : ",\n"),
                e->start, e->length, e->depth,
                e->zero ? "true" : "false",
                e->data ? "true" : "false");
@@ -2871,8 +2870,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
         }
         putchar('}');
 
-        if (!next) {
-            printf("]\n");
+        if (next) {
+            printf(",\n");
         }
         break;
     }
@@ -3047,6 +3046,8 @@ static int img_map(int argc, char **argv)
 
     if (output_format == OFORMAT_HUMAN) {
         printf("%-16s%-16s%-16s%s\n", "Offset", "Length", "Mapped to", "File");
+    } else if (output_format == OFORMAT_JSON) {
+        printf("[");
     }
 
     length = blk_getlength(blk);
@@ -3078,6 +3079,9 @@ static int img_map(int argc, char **argv)
     }
 
     ret = dump_map_entry(output_format, &curr, NULL);
+    if (output_format == OFORMAT_JSON) {
+        printf("]\n");
+    }
 
 out:
     blk_unref(blk);
-- 
2.17.2 (Apple Git-113)


