Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA22C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A3920716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dqS7vE88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A3920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRIl-0002Mj-D7
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4Q-0001qH-Rt
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4P-0008SI-FL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4P-0008Re-8F
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGmT6d177797;
 Thu, 12 Mar 2020 16:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jJUFPOWrIE9wRsfSyTb0zaQjtOqO9brM3jP8Gcq1Q7o=;
 b=dqS7vE88yTePCzgH1MIqP5DKkgE/xIwexdCWI5phFPF46mDSBM4K5P8tkeSWomQ8adEC
 evFOR4rzbrq5anGdpkdysdt3YToxHL3o4PeEJ6GYyQqaYHSTXH+zea0c9ezbi6As0ASq
 gP5IEYWcxMgtavykiWyo/5C5u+h75NxEovSwI1lli8G0ZGqDmOp6j1PjJpUdwSt0ZGom
 pH+3Zil35SO1pAuXHjQC8wr53HNptthoU5FI2X1gKcNyyFk+hDnxIlvucjjXhk5CWHy2
 Ilc4c/Mgo3taZ6xUfbhdUdHPlkQu/vU88RM/uweKpu3kFHh7DlACQWwnydjMzrU4dlnl iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yp9v6dw38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoJZ6054771;
 Thu, 12 Mar 2020 16:52:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yqgvdb0cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:26 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGqPiO032140;
 Thu, 12 Mar 2020 16:52:25 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:25 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/16] hw/i386/vmport: Add reference to VMware open-vm-tools
Date: Thu, 12 Mar 2020 18:54:16 +0200
Message-Id: <20200312165431.82118-2-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=798 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=854
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
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This official VMware open-source project can be used as reference to
understand how guest code interacts with VMPort virtual device. Thus,
providing understanding on how device is expected to behave.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 1f31e27c8aa4..b4c5a57bb0e9 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -21,6 +21,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
+/*
+ * Guest code that interacts with this virtual device can be found
+ * in VMware open-vm-tools open-source project:
+ * https://github.com/vmware/open-vm-tools
+ */
+
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
-- 
2.20.1


