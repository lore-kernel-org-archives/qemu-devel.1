Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B45C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926B420CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nk+6brHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926B420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KwN-0006Pv-Lk
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmV-00076s-Mq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmU-0003aE-LA
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmU-0003YI-Bx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqWdf017600;
 Mon, 24 Feb 2020 20:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=aH/ojVyVEyKqh6zftKolf+OBhqt+5U2sgLUcxOuQt80=;
 b=nk+6brHs0RFk46A4V2ulhGQ5RPbU9K/uLhokuMaRJxDbX2Ij6KNbEUdhAiDLdT936Y1f
 aoRKplpz3d+lEveDmi8pLYmICwsHpgmOM0OC8cirlYQs74KGNM9y3ownETT3pfwrCNqY
 WghrpjUBwlB2VqhKJwNNUbYC2Kk5XFfQn3OzjFV1NdB86xWw1aG2paWme7Qh/RcGDL2l
 HIUhDmE6RMYkJq+rfJAEhLWQsPrr6UGtpFfqFAg8cHRip44vtAPdvpYEkycA9OTPe0KD
 SB/EKVM2T1/o362uDTOVXaM+Tal+xxnBOqQ+irjraZJOAy5XfVxnszlDJcY8mwMwrd7e XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yavxrhygx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKucGi072891;
 Mon, 24 Feb 2020 20:56:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2ybduv6d72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:40 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuUng028530;
 Mon, 24 Feb 2020 20:56:30 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:30 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 22/50] multi-process: remote: use fd for socket from parent
 process
Date: Mon, 24 Feb 2020 15:55:13 -0500
Message-Id: <c6ae6ec982d3b64a35daefbe34d9815185e38067.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
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
index 3a67cb9..455cfb6 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -51,6 +51,7 @@
 #include "block/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
@@ -400,6 +401,7 @@ finalize_loop:
 int main(int argc, char *argv[])
 {
     Error *err = NULL;
+    int fd = -1;
 
     module_call_init(MODULE_INIT_QOM);
 
@@ -424,7 +426,13 @@ int main(int argc, char *argv[])
         return -1;
     }
 
-    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
+    fd = qemu_parse_fd(argv[1]);
+    if (fd == -1) {
+        printf("Failed to parse fd for remote process.\n");
+        return -EINVAL;
+    }
+
+    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, fd);
     mpqemu_link_set_callback(mpqemu_link, process_msg);
 
     mpqemu_start_coms(mpqemu_link);
-- 
1.8.3.1


