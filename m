Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D87C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C33A206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b8FYI4Ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C33A206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRLp-0000gZ-Jd
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4n-0002xQ-87
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4l-0000Wi-Qt
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4l-0000UE-Iu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGmcS9177888;
 Thu, 12 Mar 2020 16:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=FKCUnH7M6yII73DL3cJNRCcCrSaiey8Karm452GgPFQ=;
 b=b8FYI4FfGn/0xCb0BrMT8cYLXgwxkTYi93pTwWk3Bw/Sq6UdgyUAITps+GRtK4REMaYI
 iY4Z1S2mZia1uTkRBC7Heu5CQt74q2ezD5XyU9CAVCI21SdTVeBGGNK54O4MMRJ7Xtfi
 /CKsS+XCBbEiNfal9cPrcC6aGbFgxIdyV5nFwt1vqAGHdYD1EpjlgsGuumQKl+424vTL
 S22qdhv9nVB3/RGLSo6pTIoSlg2gWU3fY3xX2NcJpJ7J7wTxg2qUZOTGBytCHVeDLipm
 X44SRHphPsRC5rIon/L46Pvnra6oz0VsnJXZduZ37ebwCxL3r6RNKZDJpXqpZFgz/AGf LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2yp9v6dw5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoOpd065919;
 Thu, 12 Mar 2020 16:52:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2yqkvn0g09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:48 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CGqmaV030549;
 Thu, 12 Mar 2020 16:52:48 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:48 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
Date: Thu, 12 Mar 2020 18:54:25 +0200
Message-Id: <20200312165431.82118-11-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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

This command is used by guest to gettimeofday() from host.
See usage example in open-vm-tools TimeSyncReadHost() function.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c         | 21 +++++++++++++++++++++
 include/hw/i386/vmport.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 3fb8a8bd458a..c5b659c59343 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -66,6 +66,7 @@ typedef struct VMPortState {
 
     uint32_t vmware_vmx_version;
     uint8_t vmware_vmx_type;
+    uint32_t max_time_lag_us;
 
     uint32_t compat_flags;
 } VMPortState;
@@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
     return ram_size;
 }
 
+static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    qemu_timeval tv;
+
+    if (qemu_gettimeofday(&tv) < 0) {
+        return UINT32_MAX;
+    }
+
+    cpu->env.regs[R_EBX] = (uint32_t)tv.tv_usec;
+    cpu->env.regs[R_ECX] = port_state->max_time_lag_us;
+    return (uint32_t)tv.tv_sec;
+}
+
 /* vmmouse helpers */
 void vmmouse_get_data(uint32_t *data)
 {
@@ -214,6 +229,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
     if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
         vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
+        vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
     }
 }
 
@@ -249,6 +265,11 @@ static Property vmport_properties[] = {
      * 5 - ACE 1.x (Deprecated)
      */
     DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_type, 2),
+    /*
+     * Max amount of time lag that can go uncorrected.
+     * Value taken from VMware Workstation 5.5.
+     **/
+    DEFINE_PROP_UINT32("max-time-lag", VMPortState, max_time_lag_us, 1000000),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index 7f33512ca6f0..50416c8c8f3e 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -8,6 +8,7 @@ typedef enum {
     VMPORT_CMD_GETVERSION       = 10,
     VMPORT_CMD_GETBIOSUUID      = 19,
     VMPORT_CMD_GETRAMSIZE       = 20,
+    VMPORT_CMD_GETTIME          = 23,
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
     VMPORT_CMD_VMMOUSE_COMMAND  = 41,
-- 
2.20.1


