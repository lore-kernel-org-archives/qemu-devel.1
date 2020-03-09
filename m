Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51588C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130B82146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yftAGqTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130B82146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSFD-0001O3-7z
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSEI-00004x-Ap
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSEH-0008Mw-6D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSEG-0008MT-V9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NrLth077552;
 Mon, 9 Mar 2020 23:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=QSP5saFzEDgsn5bThEih2l0XfjK5e/tXIVv97DZzaxU=;
 b=yftAGqTPVMpsDu6QkeqwQMmblCtgYV7pSJnxs3OPFghevMu4axoaB3O3o80kJ+yYQKmf
 DYlJXgjOvUaYq+OYRjBC7oK8G9Ouhe6OjejO9pmMaP6fllj1oYiNC5TOc1VIBRapxt1Q
 AXdB+kBL8MhA2Qqa7svUebxp6rl6bbF4KuVU8Z3mshomhbP+bK46J+TUmASMlH536MRl
 4qGPhih17y/vClDK/B6tOZZeM+XJ17w/+JMPRYOlAWY5xQuB9wers/5PPO9HDKhwnWc5
 3q4ecaPj3bVqiDxpdvKXmMJP6f3NHkcKcHvJB4Q2/esAAX0lZp1xhA3Rzj8w0pByMb4K tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2ym48st1bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:54:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NhI9G120936;
 Mon, 9 Mar 2020 23:52:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2ymn3hcgm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:34 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029NqXCr027364;
 Mon, 9 Mar 2020 23:52:33 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:33 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/14] hw/i386/vmport: Add support for CMD_GETTIME
Date: Tue, 10 Mar 2020 01:54:05 +0200
Message-Id: <20200309235411.76587-9-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090144
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

This command is used by guest to gettimeofday() from host.
See usage example in open-vm-tools TimeSyncReadHost() function.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c     | 21 +++++++++++++++++++++
 include/hw/i386/pc.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 7687f3368a55..21253933215b 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -53,6 +53,7 @@ typedef struct VMPortState {
 
     uint32_t vmx_version;
     uint8_t vmx_type;
+    uint32_t max_time_lag_us;
 } VMPortState;
 
 static VMPortState *port_state;
@@ -142,6 +143,20 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
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
@@ -186,6 +201,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMPORT_CMD_GETVERSION, vmport_cmd_get_version, NULL);
     vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
+    vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
 }
 
 static Property vmport_properties[] = {
@@ -193,6 +209,11 @@ static Property vmport_properties[] = {
     DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
     DEFINE_PROP_UINT8("vmx-type", VMPortState, vmx_type,
                       VMX_TYPE_SCALABLE_SERVER),
+    /*
+     * Max amount of time lag that can go uncorrected.
+     * Value taken from VMware Workstation 5.5.
+     **/
+    DEFINE_PROP_UINT32("max-time-lag", VMPortState, max_time_lag_us, 1000000),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ea87eb93511e..3ab3541b3a90 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -142,6 +142,7 @@ typedef enum {
     VMPORT_CMD_GETVERSION       = 10,
     VMPORT_CMD_GETBIOSUUID      = 19,
     VMPORT_CMD_GETRAMSIZE       = 20,
+    VMPORT_CMD_GETTIME          = 23,
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
     VMPORT_CMD_VMMOUSE_COMMAND  = 41,
-- 
2.20.1


