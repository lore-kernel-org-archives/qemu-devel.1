Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7F6C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8C721D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FqATn5+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8C721D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBi7P-0007f5-8R
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6Q-0006Jt-Lv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6O-0005C2-Jy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6O-00050F-BU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcSox085222;
 Tue, 10 Mar 2020 16:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=mei2EqRHDoIbj238QEoyYX9NFE7ZUEKqjZS+ZpUU6U0=;
 b=FqATn5+ONdulJapkNQDmuX+Gx3RjOLqodUtV9lBmGjpSzeVXrvr9DVh94Lpb7kwnAQhn
 pDKMZd1RBnfsY8Gn9flI0VJdJIdoYiWbAKChq+fLgNfQrD6ihf6YvIhg1QvufgrmcH+G
 H9UnLx9VeotI/BBbJIaSZPTCL/ahKK8dkLDF7LBIF+3W8Pq1rpPWsHVytPzLVzpvSj+E
 gbJptTrTQ4sRibA97YfBwxO1CvNuftkx1pllJsw6QJhlMQ/WC+/kg1qPxO6Cr5WBfeTY
 xjqJPj310Lz6I/jxV/fJhYH03n+AHn4S0i4kflziI8eI3L/W7JR2bglfwNlSldEnHqk9 sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ym31ueteg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGbY5H030179;
 Tue, 10 Mar 2020 16:51:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yp8rjyg5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:28 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGpSND031524;
 Tue, 10 Mar 2020 16:51:28 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:27 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/16] hw/i386/vmport: Add device properties
Date: Tue, 10 Mar 2020 18:53:17 +0200
Message-Id: <20200310165332.140774-2-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: ehabkost@redhat.com, mst@redhat.com, Liran Alon <liran.alon@oracle.com>,
 nikita.leshchenko@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change.

This is done as a preparation for the following patches that will
introduce several device properties.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 1f31e27c8aa4..8d7513e2a23c 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -25,6 +25,7 @@
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -154,6 +155,10 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
 }
 
+static Property vmport_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void vmport_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -161,6 +166,7 @@ static void vmport_class_initfn(ObjectClass *klass, void *data)
     dc->realize = vmport_realizefn;
     /* Reason: realize sets global port_state */
     dc->user_creatable = false;
+    device_class_set_props(dc, vmport_properties);
 }
 
 static const TypeInfo vmport_info = {
-- 
2.20.1


