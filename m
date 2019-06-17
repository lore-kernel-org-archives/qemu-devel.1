Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D26C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2094E2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="skC2ZNvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2094E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwcd-000795-EH
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59080)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBc-0005jN-17
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBa-0002Bi-OX
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBY-00026g-Kg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI96fL066293;
 Mon, 17 Jun 2019 18:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=fzWDbqWeYkychPkQmnwoxt/Uk7kD+2/Z9WON2aFL7qw=;
 b=skC2ZNvdkn+cyfxlfXSRQ5rexBnXNJp94uSqYDePEWBHw6meSd0/6DJeJbzMZwf5QkMI
 zj5NmMGi1TWuOK/avCW33FpT17EhLIAXL5N97lDKIhRSw96iCiNlgwVI5YqCZJoBXvbf
 UsAk8dnGjh1+aL0iy9cRaEHPOTdvpBIJGmTdvd80na840VabeD0QgPYmpHRj12DI6bao
 p3UViyR3ppvdASf6mdwscPEJe1Q5vYdFSJXttNFwn1X+6e27N6zHYERLe5GQWoBo9Ez6
 GM+u9KRhjuipuJOvZ8tO8KuN/Sid+5pHXixWT6jNmmqONe2YoibDg1+IW5uBGZl+50q4 nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF56o050154;
 Mon, 17 Jun 2019 18:16:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t5h5t9fyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:46 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGjlU025381;
 Mon, 17 Jun 2019 18:16:45 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:45 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:43 -0700
Message-Id: <20190617181643.30325-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 26/35] multi-process: remote: use fd for
 socket from parent process
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 remote/remote-main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 8db2f36b90..5c26339ed7 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -63,6 +63,7 @@
 #include "block/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -439,6 +440,7 @@ finalize_loop:
 int main(int argc, char *argv[])
 {
     Error *err = NULL;
+    int fd = -1;
 
     module_call_init(MODULE_INIT_QOM);
 
@@ -463,7 +465,13 @@ int main(int argc, char *argv[])
         return -1;
     }
 
-    proxy_link_set_sock(proxy_link, STDIN_FILENO);
+    fd = qemu_parse_fd(argv[1]);
+    if (fd == -1) {
+        printf("Failed to parse fd for remote process.\n");
+        return -EINVAL;
+    }
+
+    proxy_link_set_sock(proxy_link, fd);
     proxy_link_set_callback(proxy_link, process_msg);
 
     start_handler(proxy_link);
-- 
2.17.1


