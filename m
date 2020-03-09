Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2229EC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEA82146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LMuZLQUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEA82146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSIv-0006ma-4Q
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCP-0005K5-0G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCO-0006cC-1j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSCN-0006bP-Q1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqU9k147088;
 Mon, 9 Mar 2020 23:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=I5npdYFmXraRVLDDtm1dc6rep91PsCndpTDMy4mO0yQ=;
 b=LMuZLQUoDqT/352gwR5l8WyDMu7vUP5+Zc3rVXkGguHsPIHs8xoR+2v2+x98WT2qe/Yz
 h5zPUwTk9uc7R77oENF/Zato0Fi1cE7hZfc0W40qHPVqL4QkIoF1OTk21sbRbdMEDzbf
 7iPsl+vdVzAjiUFMWbE06G2c5FSoom8UgbHu/m5XKGH/leJiJv66CW4LWcuEYhRQXoKS
 zjZxAL4z0LpHroCa23YhhpWym5KafT1wDdXIz6oJrOGqOKo9yRQnQEiw/8v5yfZ0xCSL
 R2qyMn19dUDAXINLCSzaQ4XzF8iN5yvKTn4hC2YMaT0RyJ/99ENmh2JoP1rm56Z2QxL9 SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2ym31ua65j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NhI5V120943;
 Mon, 9 Mar 2020 23:52:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2ymn3hcgrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:37 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029NqalC008367;
 Mon, 9 Mar 2020 23:52:36 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:36 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/14] hw/i386/vmport: Add support for CMD_GETTIMEFULL
Date: Tue, 10 Mar 2020 01:54:06 +0200
Message-Id: <20200309235411.76587-10-liran.alon@oracle.com>
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

Similar to CMD_GETTIME but lacks the 136-year overflow issue,
by returning full 64-bit of host uSeconds.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c     | 17 +++++++++++++++++
 include/hw/i386/pc.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 21253933215b..26231fc9d718 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -157,6 +157,22 @@ static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
     return (uint32_t)tv.tv_sec;
 }
 
+static uint32_t vmport_cmd_time_full(void *opaque, uint32_t addr)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    qemu_timeval tv;
+
+    if (qemu_gettimeofday(&tv) < 0) {
+        return UINT32_MAX;
+    }
+
+    cpu->env.regs[R_ESI] = (uint32_t)((uint64_t)tv.tv_sec >> 32);
+    cpu->env.regs[R_EDX] = (uint32_t)tv.tv_sec;
+    cpu->env.regs[R_EBX] = (uint32_t)tv.tv_usec;
+    cpu->env.regs[R_ECX] = port_state->max_time_lag_us;
+    return VMPORT_MAGIC;
+}
+
 /* vmmouse helpers */
 void vmmouse_get_data(uint32_t *data)
 {
@@ -202,6 +218,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
     vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
+    vmport_register(VMPORT_CMD_GETTIMEFULL, vmport_cmd_time_full, NULL);
 }
 
 static Property vmport_properties[] = {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3ab3541b3a90..14d321e3cbbe 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -146,6 +146,7 @@ typedef enum {
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
     VMPORT_CMD_VMMOUSE_COMMAND  = 41,
+    VMPORT_CMD_GETTIMEFULL      = 46,
     VMPORT_ENTRIES
 } VMPortCommand;
 
-- 
2.20.1


