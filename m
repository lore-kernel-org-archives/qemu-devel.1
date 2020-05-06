Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B1C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC7320643
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bzhan7eY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC7320643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRkk-0003QK-WA
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWRhb-0007AA-L1; Wed, 06 May 2020 17:35:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWRhZ-0007ob-5z; Wed, 06 May 2020 17:35:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046LJSHo100003;
 Wed, 6 May 2020 21:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=wYBItL0O1HkGz9n/QNq2NII3wXKWScs2S1KCgSg+tyg=;
 b=Bzhan7eYLMAbpDdA91UuqJmOVkOCoTfPYlV6hIgtJWAFkvh8O+8UtRAz+ULpO1srq+fp
 vv+1gQ1mEp5RgkFJbi/NC5t9lUSZALS/37nMqC7DgLAnK+Ag0UrBrA4DqWxdxPD8XY6F
 9QKdQ1frJSUEolfoeSslV0H25gBevIYl0uIK2h3+gEklK0Bl9xhCN394Xz4fHfc4R2Jd
 ytRaBk7jyq38+vK9eppZrqKfTBSl0DMHVyOvj6Faj+ZuAHjyXJO30IRL0DRLvOgt1lmM
 WPN0ZqJqvKC4mAM6HwjuU69y6qHRuZNaRWSr+5wpEMZca4mKPp4FEPvD/Yy31OPkaoq5 6g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 30usgq3y98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 21:35:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046LZ1pD118799;
 Wed, 6 May 2020 21:35:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 30sjdwduf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 21:35:33 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046LZWQs016525;
 Wed, 6 May 2020 21:35:32 GMT
Received: from localhost.localdomain (/10.74.121.228)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 May 2020 14:35:31 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: 
Subject: [PATCH v2 4/5] qemu-img: refactor dump_map_entry JSON format output
Date: Thu,  7 May 2020 00:34:58 +0300
Message-Id: <20200506213459.44743-5-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200506213459.44743-1-eyal.moscovici@oracle.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060172
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=eyal.moscovici@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 17:35:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Moscovici <eyal.moscovici@oracle.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously dump_map_entry identified whether we need to start a new JSON
array based on whether start address == 0. In this refactor we remove
this assumption as in following patches we will allow map to start from
an arbitrary position.

Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 qemu-img.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a1b507a0be..0a140fe564 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2896,9 +2896,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
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
@@ -2907,8 +2906,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
         }
         putchar('}');
 
-        if (!next) {
-            printf("]\n");
+        if (next) {
+            puts(",");
         }
         break;
     }
@@ -3083,6 +3082,8 @@ static int img_map(int argc, char **argv)
 
     if (output_format == OFORMAT_HUMAN) {
         printf("%-16s%-16s%-16s%s\n", "Offset", "Length", "Mapped to", "File");
+    } else if (output_format == OFORMAT_JSON) {
+        putchar('[');
     }
 
     length = blk_getlength(blk);
@@ -3119,6 +3120,9 @@ static int img_map(int argc, char **argv)
     }
 
     ret = dump_map_entry(output_format, &curr, NULL);
+    if (output_format == OFORMAT_JSON) {
+        puts("]");
+    }
 
 out:
     blk_unref(blk);
-- 
2.17.2 (Apple Git-113)


