Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F5C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BA02067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hbbyynu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BA02067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRPi-0003o4-UJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4r-0003A3-P3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4p-0000ho-HZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4p-0000gG-9M
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGnL9Y189371;
 Thu, 12 Mar 2020 16:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=CJX0wXT6ama/s82l6lvlfrAh3F5DjKdESQjYU/CyJcw=;
 b=Hbbyynu8qKEcec9GYy7KC0QukP1j0jiZ2Qjc2/vz0cA6UbdizFUgtDAv7/dP6WKqQsID
 WrrK3MHx/NR3iHOLS82B2cvXog6vOMDNGHYS1LVD2q2hlWcbJrgZGlZEWdJmqxdPmyxb
 U0rIejbazFPtKjn3CEY/hHyoH4Upnx0aunI69qjney6KYh2vIV/TxZnQECs0ZIDXXQ5a
 ivBJ6+xlQhcNtzHPQ1LhMXrAhmqhziBkhtwmGNJC7HxD0etj4ONTDo/SDYv5Ayp6iWnz
 iVA52288cv2pMo2R3znLTguvZbGz+vPFurAh5bhe/a65YqDU/c/8PJrnY198UJ5zz1Hy QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yqkg8a03u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGnKVe003220;
 Thu, 12 Mar 2020 16:52:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2yp8p7yqrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:52 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGqpn6032412;
 Thu, 12 Mar 2020 16:52:51 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:50 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/16] hw/i386/vmport: Add support for CMD_GETTIMEFULL
Date: Thu, 12 Mar 2020 18:54:26 +0200
Message-Id: <20200312165431.82118-12-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxlogscore=884
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0
 mlxlogscore=930 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=1 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
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

Similar to CMD_GETTIME but lacks the 136-year overflow issue,
by returning full 64-bit of host uSeconds.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c         | 17 +++++++++++++++++
 include/hw/i386/vmport.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index c5b659c59343..7e57eda4b526 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -183,6 +183,22 @@ static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
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
@@ -230,6 +246,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
         vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
         vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
+        vmport_register(VMPORT_CMD_GETTIMEFULL, vmport_cmd_time_full, NULL);
     }
 }
 
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index 50416c8c8f3e..5d19963ed417 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -12,6 +12,7 @@ typedef enum {
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
     VMPORT_CMD_VMMOUSE_COMMAND  = 41,
+    VMPORT_CMD_GETTIMEFULL      = 46,
     VMPORT_ENTRIES
 } VMPortCommand;
 
-- 
2.20.1


