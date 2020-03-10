Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA7C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945CC20873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cYc/oiJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945CC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36907 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBi7v-0000TA-OU
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi70-0007DZ-Bw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6z-00087i-6O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6y-00087B-VY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcYtv010737;
 Tue, 10 Mar 2020 16:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=g4SQtpo7MYbyBBQYcudURHtE+SSi+DfpnUAsPR5I+sQ=;
 b=cYc/oiJkDjETmAQGJjDi4/UxDSgXcJCLUwj4rJK+6Vzy34i6CGpdou3x7aBSsp7ju9sG
 KAVFpfu1Itx4sHa1rO85izqpqfKlrjWtfQ1SIqCrSb/KV5P9oAKwNySv2mAJreBjT6fi
 2oJQZmjI7aiUqwI330jZxBikhVFYqWoizrI+dDx7t76aKeFQ4oj9CotMchISj+NIW0hw
 GfpVIz7Dox/J1ND+u6A6goidqduP7ztbreR1PYZC7MDW9M6aIrcbgWVh+20yk2lb/Mog
 1h6b7Mj8FbxGoE7daKv2+gj3IAbehUY3fHc4Gm8Z68bx8bAEj+B15miGkE0Qs50TgJIe UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yp9v61vey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:52:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGbbhS030468;
 Tue, 10 Mar 2020 16:52:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yp8rjyjps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:52:06 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGq53x030957;
 Tue, 10 Mar 2020 16:52:05 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:52:05 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/16] hw/i386/vmport: Add support for CMD_GETHZ
Date: Tue, 10 Mar 2020 18:53:31 +0200
Message-Id: <20200310165332.140774-16-liran.alon@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
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
 nikita.leshchenko@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This command returns to guest information on LAPIC bus frequency and TSC
frequency.

One can see how this interface is used by Linux vmware_platform_setup()
introduced in Linux commit 88b094fb8d4f ("x86: Hypervisor detection and
get tsc_freq from hypervisor").

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c         | 19 +++++++++++++++++++
 include/hw/i386/vmport.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 6ca03273066e..76fd49c52058 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -165,6 +165,24 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
     return ram_size;
 }
 
+static uint32_t vmport_cmd_get_hz(void *opaque, uint32_t addr)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+
+    if (cpu->env.tsc_khz && cpu->env.apic_bus_freq) {
+        uint64_t tsc_freq = (uint64_t)cpu->env.tsc_khz * 1000;
+
+        cpu->env.regs[R_ECX] = cpu->env.apic_bus_freq;
+        cpu->env.regs[R_EBX] = (uint32_t)(tsc_freq >> 32);
+        cpu->env.regs[R_EAX] = (uint32_t)tsc_freq;
+    } else {
+        /* Signal cmd as not supported */
+        cpu->env.regs[R_EBX] = UINT32_MAX;
+    }
+
+    return cpu->env.regs[R_EAX];
+}
+
 static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
@@ -254,6 +272,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     if (s->version > 1) {
         vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
         vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
+        vmport_register(VMPORT_CMD_GETHZ, vmport_cmd_get_hz, NULL);
         vmport_register(VMPORT_CMD_GETTIMEFULL, vmport_cmd_time_full, NULL);
         vmport_register(VMPORT_CMD_GET_VCPU_INFO, vmport_cmd_get_vcpu_info,
                         NULL);
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index 34cc050b1ffa..aee809521aa0 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -12,6 +12,7 @@ typedef enum {
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
     VMPORT_CMD_VMMOUSE_COMMAND  = 41,
+    VMPORT_CMD_GETHZ            = 45,
     VMPORT_CMD_GETTIMEFULL      = 46,
     VMPORT_CMD_GET_VCPU_INFO    = 68,
     VMPORT_ENTRIES
-- 
2.20.1


