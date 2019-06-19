Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90749C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAA32173E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uc/h6i/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAA32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hddUJ-00005F-Rj
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 12:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hddLy-0002g6-Rn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hddLw-0006qk-AO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hddLv-0006mr-WD
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGDhCo030752;
 Wed, 19 Jun 2019 16:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=BWi35KhlexcWG60HSgIA6eOXZUlIDa6NkY02SiUCb8o=;
 b=uc/h6i/RICxxocMpbyap1Dq6BrvtbJ95h8CG94lhCAvhPW0m2nOH3jgUHDBkKPogRZ88
 vjGgYj76w6RfXZ9pic671YpQG6pxnr0u8cHQ4bI190I+1TSTAssy8ofRc4ncjUHb43Rp
 MUf5Lmnk5iyImpH62rvscB0zyAmM46slVBC5x0TYXtOytly+t6Antnvi9atfZrnMR9jY
 /7wqyxLmzvD+3gbTIC02WDiPTRUbn/PeyCrMwRr45oMjuoKfw6myVdVhIZ6JWEhIG3kC
 uxwg/wxsERsjxkvUK4NfsbxoqG3RtuRObFmzvG8k9UCjhZ7hkyUGN5ZN08Ggcink+yDr 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2t7809cemk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGLbao133007;
 Wed, 19 Jun 2019 16:22:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2t77yn6py7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JGMK4C024737;
 Wed, 19 Jun 2019 16:22:20 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 09:22:19 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 19:21:37 +0300
Message-Id: <20190619162140.133674-8-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619162140.133674-1-liran.alon@oracle.com>
References: <20190619162140.133674-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190131
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [QEMU PATCH v4 07/10] vmstate: Add support for kernel
 integer types
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, dgilbert@redhat.com, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 include/migration/vmstate.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 9224370ed59a..ca68584eba4d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -797,6 +797,19 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
 
+#ifdef CONFIG_LINUX
+
+#define VMSTATE_U8_V(_f, _s, _v)                                   \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint8, __u8)
+#define VMSTATE_U16_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16, __u16)
+#define VMSTATE_U32_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32, __u32)
+#define VMSTATE_U64_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, __u64)
+
+#endif
+
 #define VMSTATE_BOOL(_f, _s)                                          \
     VMSTATE_BOOL_V(_f, _s, 0)
 
@@ -818,6 +831,19 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64(_f, _s)                                        \
     VMSTATE_UINT64_V(_f, _s, 0)
 
+#ifdef CONFIG_LINUX
+
+#define VMSTATE_U8(_f, _s)                                         \
+    VMSTATE_U8_V(_f, _s, 0)
+#define VMSTATE_U16(_f, _s)                                        \
+    VMSTATE_U16_V(_f, _s, 0)
+#define VMSTATE_U32(_f, _s)                                        \
+    VMSTATE_U32_V(_f, _s, 0)
+#define VMSTATE_U64(_f, _s)                                        \
+    VMSTATE_U64_V(_f, _s, 0)
+
+#endif
+
 #define VMSTATE_UINT8_EQUAL(_f, _s, _err_hint)                        \
     VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
                         vmstate_info_uint8_equal, uint8_t, _err_hint)
-- 
2.20.1


