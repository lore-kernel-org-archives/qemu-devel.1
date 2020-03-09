Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4164CC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099682146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y60/kXvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099682146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSFk-0002bK-8q
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCA-00051h-SH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSC9-0006K7-S4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSC9-0006FG-Jy
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NhE3S016506;
 Mon, 9 Mar 2020 23:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=UVlAki5BrSxj+rUNTGM3HT7wk0gYhvDL4hu8kYSSeLA=;
 b=y60/kXvMSawHrvtUxlMKfJItRQHuMH2N9TdukJJmwOIwEYxMQFb/GtKo+53yUjwV52MB
 QBlVm26oz9c3iRHUa40yniFGsDN6fa+1r+TQ0bdPXvsuLQ2PMRKw1oLEFaj6Wp9vU6Xp
 U+RWyJYDlwwy1h6IIuC/sELkqQZ3xLPwJr30rx/QaF6r8dXNtbOFsg5Pvl7Vk/lYZxlF
 BfHCR9UqT3gGH+3zX3k9zBtw0UWdQO5oKWYlE+RM5Q9Xv/ioHem6REY1NbEXk5PH1QIn
 7AmdSTGCBdlqb18nj+j3FOEIoW3LWweNL/VD2gS2ZzA+331VR2godlRdMEvTDFKtFSrB Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2ym48st17d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029Nh46c037433;
 Mon, 9 Mar 2020 23:52:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2ymndg0bnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:20 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029NqIIq008340;
 Mon, 9 Mar 2020 23:52:18 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:18 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/14] hw/i386/vmport: Add device properties
Date: Tue, 10 Mar 2020 01:54:00 +0200
Message-Id: <20200309235411.76587-4-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 mlxscore=0 suspectscore=1 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090143
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
Cc: ehabkost@redhat.com, mst@redhat.com, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
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
index a78e20040a79..7c21e56081b0 100644
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
@@ -167,6 +168,10 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
 }
 
+static Property vmport_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void vmport_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -174,6 +179,7 @@ static void vmport_class_initfn(ObjectClass *klass, void *data)
     dc->realize = vmport_realizefn;
     /* Reason: realize sets global port_state */
     dc->user_creatable = false;
+    device_class_set_props(dc, vmport_properties);
 }
 
 static const TypeInfo vmport_info = {
-- 
2.20.1


