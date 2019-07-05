Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C1BC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320BC20449
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RFj8+UhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320BC20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVeo-00061D-HC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hjVQM-0001Pk-8D
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hjVQL-000086-8g
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hjVQJ-0008NL-Fa
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65L3rJF119866;
 Fri, 5 Jul 2019 21:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=mRUp3UE+E2D0bvC2nURNQ62ackyCJAb7LpNyWjews3I=;
 b=RFj8+UhJbo1BBp1h12iKJIXOQNTeexWnR0f+i5LWCPlInVaiVNGfRoXDTRIUlpOQ2tuJ
 TbdlKAqdFum1h1SubbkStuyQtA+eKI+YrBeCVANNy86MX2V8oztylKlPbD+idZr/9+9X
 ZXmXrT5fp9C4iZ2IO+4mDMziFcKQdSUo9ynAIgPGp/nTIx/vrNgkiX55OTP9/vBnVxYE
 0GQalW4pnYN4URSz35AZ/NeoKRh3zZzRfTQNX2FUdbqlYL0/98us078Evzq9if31yHIf
 8HXIsJ8s9vjo6FleER/dVTRCfHpF9SLzIwGGwYz0TDwrFVZB300XIfQbZexIEqYuFwbB 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2te61emgg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jul 2019 21:07:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65L2Tb0107276;
 Fri, 5 Jul 2019 21:07:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2thxrvm495-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jul 2019 21:07:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x65L72ls025541;
 Fri, 5 Jul 2019 21:07:02 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Jul 2019 14:07:02 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Sat,  6 Jul 2019 00:06:35 +0300
Message-Id: <20190705210636.3095-4-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705210636.3095-1-liran.alon@oracle.com>
References: <20190705210636.3095-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=661
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907050266
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=705 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907050266
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH 3/4] target/i386: kvm: Save nested-state only
 in case vCPU have set VMXON region
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
Cc: pbonzini@redhat.com, Joao Martins <joao.m.martins@oracle.com>,
 Liran Alon <liran.alon@oracle.com>, ehabkost@redhat.com, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having (nested_state->hdr.vmx.vmxon_pa != -1ull) signals that vCPU have set
at some point in time a VMXON region. Note that even though when vCPU enters
SMM mode it temporarily exit VMX operation, KVM still reports (vmxon_pa != -1ull).
Therefore, this field can be used as a reliable indicator on when we require to
send VMX nested-state as part of migration stream.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/machine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 851b249d1a39..20bda9f80154 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -997,9 +997,8 @@ static bool vmx_nested_state_needed(void *opaque)
 {
     struct kvm_nested_state *nested_state = opaque;
 
-    return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
-            ((nested_state->hdr.vmx.vmxon_pa != -1ull) ||
-             (nested_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON)));
+    return (nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
+           (nested_state->hdr.vmx.vmxon_pa != -1ull);
 }
 
 static const VMStateDescription vmstate_vmx_nested_state = {
-- 
2.20.1


