Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B332DC10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1FF2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rrrl1qWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1FF2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSKI-00082N-Ny
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCn-00063Y-Ui
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCm-00072B-OX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:53:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSCm-00070l-Go
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:53:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqUus147112;
 Mon, 9 Mar 2020 23:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=xeXTfkCIs233YAHIBuNOs5RVrM+SnIVuZZRDkCcUbG8=;
 b=rrrl1qWpMGGG89rzRbjnZnfdaojjnaRIBAD9jOBuCh6K38uptGNjoM1knYgmTej1Thos
 9QBRfWqT6oT97O7MUi0WX7fe1N/OGgr5XRlX4Y1xuBniMnfPpsvNkp1tG81jcqjiuNV1
 avH9eFIATpMPQruPTtHAMzh8O2NNqZM6tTFKMVN8mvhuS4WQCLaKgdHdqXGBHfqkSoqC
 KmmbaU3XP9XyxxG0DChrHGPlAvrdhBqA2ahKMDFEbS8y79e84o3a44PIA3opyxh0/X9e
 yAg9f8TDTgxISo6jP/RJ+qeKLNz987YKOut8C8zQ7QCwPsb/S7T8REqSU6noiLupuJe3 Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ym31ua669-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:53:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqxYu095547;
 Mon, 9 Mar 2020 23:53:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2ymnb1kas9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:53:02 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029NqkGp027472;
 Mon, 9 Mar 2020 23:52:46 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:46 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/14] hw/i386/vmport: Add support for CMD_GETHZ
Date: Tue, 10 Mar 2020 01:54:10 +0200
Message-Id: <20200309235411.76587-14-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=1 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090144
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
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
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
 hw/i386/vmport.c     | 19 +++++++++++++++++++
 include/hw/i386/pc.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 2b0a623f19c1..95d4a23ce9ba 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -150,6 +150,24 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
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
@@ -237,6 +255,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
     vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
+    vmport_register(VMPORT_CMD_GETHZ, vmport_cmd_get_hz, NULL);
     vmport_register(VMPORT_CMD_GETTIMEFULL, vmport_cmd_time_full, NULL);
     vmport_register(VMPORT_CMD_GET_VCPU_INFO, vmport_cmd_get_vcpu_info, NULL);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e880ca39ee3b..679bf429c6a5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -146,6 +146,7 @@ typedef enum {
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
     VMPORT_CMD_VMMOUSE_COMMAND  = 41,
+    VMPORT_CMD_GETHZ            = 45,
     VMPORT_CMD_GETTIMEFULL      = 46,
     VMPORT_CMD_GET_VCPU_INFO    = 68,
     VMPORT_ENTRIES
-- 
2.20.1


