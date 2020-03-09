Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA80C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8662146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MVLX2yLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8662146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSD5-00068V-9j
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCA-00051i-Sg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSC9-0006Jn-Ov
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSC9-0006Io-GU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqOu7028643;
 Mon, 9 Mar 2020 23:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=OFUlKCstA1w3vOK18OxhdCFfRTEmtmBiXOvstPi0cP8=;
 b=MVLX2yLkCWSPQqCXNl1NhKZC8QDHC7LZuk5AVxw9hr/DW6B4L9BWlNjx35TVVIIPHP6+
 ooToBIgmzhHXBg4oPoxxK9PLJQljFNBfUZj3reYAXswjUbfE9JsuipdQ0vyuUjksRAZi
 6cPsiGkOzOo+VGAqRQPeLXzfdw5VybAG3r6WAEbnn/LvnYdYVqrH4SlQ9zuDu3fc6vnH
 +tbM1HF54SB0qd3R50ZDADTzbvr0xePfA+XOG5wB6nM2SA6NHnSydzReHiIcJ9cBDuP0
 k5lT4Y3IUjweF4POHn2SWeeVyvVdQqEr3TsrhVx9pOIh9wOazcAF0QxYjHjMwFoGiGv1 Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ym3jqj5kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NpvHY101571;
 Mon, 9 Mar 2020 23:52:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ymun81c5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029NqLgd008343;
 Mon, 9 Mar 2020 23:52:21 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:20 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/14] hw/i386/vmport: Introduce vmx-version property
Date: Tue, 10 Mar 2020 01:54:01 +0200
Message-Id: <20200309235411.76587-5-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=1 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090144
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

Instead of hard-coding the VMX version, make it a VMPORT object property.
This would allow user to control it's value via "-global vmport.vmx-version=X".

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 7c21e56081b0..a2c8ff4b59cf 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -44,6 +44,8 @@ typedef struct VMPortState {
     MemoryRegion io;
     VMPortReadFunc *func[VMPORT_ENTRIES];
     void *opaque[VMPORT_ENTRIES];
+
+    uint32_t vmx_version;
 } VMPortState;
 
 static VMPortState *port_state;
@@ -112,7 +114,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     X86CPU *cpu = X86_CPU(current_cpu);
 
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
-    return 6;
+    return port_state->vmx_version;
 }
 
 static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
@@ -169,6 +171,8 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
 }
 
 static Property vmport_properties[] = {
+    /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
+    DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


