Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1230CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44DB20671
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t3sDYKkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44DB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYrdL-0003n6-Qh
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 09:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYrb5-0000sK-SI; Wed, 13 May 2020 09:38:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYrb4-0005Cs-Tj; Wed, 13 May 2020 09:38:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DDXLNG023714;
 Wed, 13 May 2020 13:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=77A/CYmGa98C84EcFMSMiHGqtvwGQtvTRfrn9v78drw=;
 b=t3sDYKkl1x+cuwCUHsuIO+hLP/TrxiLZ7jfYMtbFxD7NIK2TalSpEzx0Bq1KHTmjvesA
 ZIS/79YRlT0yrOYfOU/ZwXyH+K+yI9rUvShQREYZHL+i4u3dkggHy31uERWdJOJUfit0
 jmdpp6e2NzHnMsJds+9zbbf/jMYhNLQ1WDaGeJTgjeqxBCYtxAU3XlGfUJq7OxuaSKkT
 ylaPaXKZd67U/4/lc2As/IUWCWCSsTplTyoXad3OLZEPfnsObpAWF2O2Ph18xvZVhqNN
 4HidKEijcqp0vyBUjXxu075EzJd2zl0qwtnfRYDFGm8RBosx7appl55O36lb6gxZqqC+ VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 3100xwc80q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 May 2020 13:38:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DDYYVX036375;
 Wed, 13 May 2020 13:36:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 3100ym3mxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 13:36:51 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04DDapgI003418;
 Wed, 13 May 2020 13:36:51 GMT
Received: from localhost.localdomain (/10.74.123.68)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 May 2020 06:36:50 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: 
Subject: [PATCH v3 3/4] qemu-img: refactor dump_map_entry JSON format output
Date: Wed, 13 May 2020 16:36:28 +0300
Message-Id: <20200513133629.18508-4-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200513133629.18508-1-eyal.moscovici@oracle.com>
References: <20200513133629.18508-1-eyal.moscovici@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130121
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=eyal.moscovici@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 08:03:36
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
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
index 23e90a99e1..80340cb218 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2901,9 +2901,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
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
@@ -2912,8 +2911,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
         }
         putchar('}');
 
-        if (!next) {
-            printf("]\n");
+        if (next) {
+            puts(",");
         }
         break;
     }
@@ -3088,6 +3087,8 @@ static int img_map(int argc, char **argv)
 
     if (output_format == OFORMAT_HUMAN) {
         printf("%-16s%-16s%-16s%s\n", "Offset", "Length", "Mapped to", "File");
+    } else if (output_format == OFORMAT_JSON) {
+        putchar('[');
     }
 
     length = blk_getlength(blk);
@@ -3124,6 +3125,9 @@ static int img_map(int argc, char **argv)
     }
 
     ret = dump_map_entry(output_format, &curr, NULL);
+    if (output_format == OFORMAT_JSON) {
+        puts("]");
+    }
 
 out:
     blk_unref(blk);
-- 
2.17.2 (Apple Git-113)


