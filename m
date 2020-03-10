Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768BEC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C3021D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VKC9UDD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C3021D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBiGC-0004CY-Ep
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6u-00076o-BW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6t-0007pe-9D
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6t-0007lS-15
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGdH6w103940;
 Tue, 10 Mar 2020 16:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=+fVJkCYwbJSI1WwvCYdwNV3zcSYtM/0dfrmJW7pdR9g=;
 b=VKC9UDD6vXN+jgTNCTD+HauaND0I2Pqiqap7MzXJjpKl1joWpEOk9ovRFTUZ/L16iQvy
 DcNIqB0rz9ji8IYDVOaYBUNiy7GS3Bca3edlW16QcRJSJvLgBL0CzHRReIEwuol8tbGz
 shplc4VMBG73KdSUPl3d5PdejWmeH14MTCoEAYUxIBb4qQtPiv60R7Z3I03/J83tLUaZ
 GYibnHYh3Sunc5dkLKRPCIxfeqImps3E3vQevltbz1aFSgHgnTnBrmHyzY25qbcvuR0t
 nltBPhwMnbjP3C0Pi4+1K6sx/6bjgKukOvq6WvKQZLQEgEhJbEpocgoBn6RNIUh/9SGN Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yp7hm35sn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:52:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcHAj054490;
 Tue, 10 Mar 2020 16:52:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2yp8psg60t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:52:00 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AGpwoY011670;
 Tue, 10 Mar 2020 16:51:58 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:58 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/16] hw/i386/vmport: Add support for CMD_GET_VCPU_INFO
Date: Tue, 10 Mar 2020 18:53:28 +0200
Message-Id: <20200310165332.140774-13-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=1 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100103
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
 nikita.leshchenko@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Command currently returns that it is unimplemented by setting
the reserved-bit in it's return value.

Following patches will return various useful vCPU information
to guest.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c         | 14 ++++++++++++++
 include/hw/i386/vmport.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 445104c71c2b..30641d3ffb20 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -44,6 +44,13 @@ typedef enum {
    VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for ACE 1.x */
 } VMXType;
 
+/* vCPU features reported by CMD_GET_VCPU_INFO */
+#define VCPU_INFO_SLC64_BIT             0
+#define VCPU_INFO_SYNC_VTSCS_BIT        1
+#define VCPU_INFO_HV_REPLAY_OK_BIT      2
+#define VCPU_INFO_LEGACY_X2APIC_BIT     3
+#define VCPU_INFO_RESERVED_BIT          31
+
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
 typedef struct VMPortState {
@@ -188,6 +195,11 @@ static uint32_t vmport_cmd_time_full(void *opaque, uint32_t addr)
     return VMPORT_MAGIC;
 }
 
+static uint32_t vmport_cmd_get_vcpu_info(void *opaque, uint32_t addr)
+{
+    return 1 << VCPU_INFO_RESERVED_BIT;
+}
+
 /* vmmouse helpers */
 void vmmouse_get_data(uint32_t *data)
 {
@@ -236,6 +248,8 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
         vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
         vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
         vmport_register(VMPORT_CMD_GETTIMEFULL, vmport_cmd_time_full, NULL);
+        vmport_register(VMPORT_CMD_GET_VCPU_INFO, vmport_cmd_get_vcpu_info,
+                        NULL);
     }
 }
 
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index 5d19963ed417..34cc050b1ffa 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -13,6 +13,7 @@ typedef enum {
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
     VMPORT_CMD_VMMOUSE_COMMAND  = 41,
     VMPORT_CMD_GETTIMEFULL      = 46,
+    VMPORT_CMD_GET_VCPU_INFO    = 68,
     VMPORT_ENTRIES
 } VMPortCommand;
 
-- 
2.20.1


