Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51565C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145232146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A0NVaput"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145232146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSER-0008U6-7w
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCA-00051g-FC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSC9-0006JQ-Fa
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSC9-0006Id-9A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqOid028646;
 Mon, 9 Mar 2020 23:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=RiGzcldj+3+tktzDcpK75N8cjWY3hW0sB90AU/C1KRI=;
 b=A0NVaput3oU8d5xhNyfVSuzfo0XZ3KZVdIL5hIv1cnKjR0s0UfjnbCnXZ7WcGM86aaFA
 8yEJ+rBFhMW9A9sRR7Gda2n7b7ZwveUNg+/M+JATjyyWBDgBKSidEBy3xA+GccZdiHLb
 P65+1jUi23+LZAj0VQ4yXNUCb/VPQjwRFS+AVS/P/bx2Lek/NWuXXo4CGM2tdPuKKu6v
 EK9sOMUtUw5hE79jyHBGYmb0MKZkARAkuld9d1EUsxL0DTXqzFU6EdMGkPytPv2T8w0z
 muq7k3Uw2Zk6OwELASBcsPweKqbBjW1BRgSUwrzYUBWRxQkjdHfAM2O4TqOY+NkNFD1I Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2ym3jqj5kt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029Nh6MC037556;
 Mon, 9 Mar 2020 23:52:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2ymndg0bfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029NqGl4010809;
 Mon, 9 Mar 2020 23:52:16 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:16 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/14] hw/i386/vmport: Set EAX to -1 on failed and unsupported
 commands
Date: Tue, 10 Mar 2020 01:53:59 +0200
Message-Id: <20200309235411.76587-3-liran.alon@oracle.com>
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

This is used as a signal for VMware Tools to know if a command it
attempted to invoke, failed or is unsupported. As a result, VMware Tools
will either report failure to user or fallback to another backdoor command
in attempt to perform some operation.

A few examples:
* open-vm-tools TimeSyncReadHost() function fallbacks to
CMD_GETTIMEFULL command when CMD_GETTIMEFULL_WITH_LAG
fails/unsupported.
* open-vm-tools Hostinfo_NestingSupported() function verifies
EAX != -1 to check for success.
* open-vm-tools Hostinfo_VCPUInfoBackdoor() functions checks
if reserved-bit is set to indicate command is unimplemented.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 9319720e8204..a78e20040a79 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -72,6 +72,7 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
 
     eax = env->regs[R_EAX];
     if (eax != VMPORT_MAGIC) {
+        eax = UINT32_MAX;
         goto out;
     }
 
@@ -79,6 +80,7 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
     trace_vmport_command(command);
     if (command >= VMPORT_ENTRIES || !s->func[command]) {
         qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
+        eax = UINT32_MAX;
         goto out;
     }
 
-- 
2.20.1


