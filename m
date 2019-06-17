Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F59C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CF3208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A2okq+D9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CF3208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcw1G-0004ZV-HP
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hcvsw-0005fv-Ok
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hcvss-0003S4-Vn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hcvss-0003RZ-M9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HHs6kO148245;
 Mon, 17 Jun 2019 17:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=49HRpG9G1+QXdfmmlaxcFNw0+wgkBMXI7yMkggaZdA8=;
 b=A2okq+D9xdwl+t0WEfkcPWvWMBc7wD0saM5Z/6+jHSbeTBlaw+IR7/o49p03iLVPqElm
 2v8B69hzCZ08Ts7Ab+kU86o4GRMi65SWQHWnagBIr3D/mnBmcvp8Sn+sIAmmX6jPcwbw
 k5wkLx4w7P5V94/Cz2NWG2OIfT7RcIChx09w4ZmlzaaAiNT7gToYFm0qTwMo74mOzMxL
 DownXIdc9oTM8bN9er+pmvQw5AA9HBkfc9C/TJuAlOGRJRwQzSjVFzH+s1MuDMOcov4F
 Wn6fE3mcDDt96jNOLxrULRkhPuU1mwpq1Va7raiyMJjo29Zou5/NuDZXK8axfLomvqLb 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t4saq7w43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 17:57:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HHvWaX130537;
 Mon, 17 Jun 2019 17:57:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2t59gdc0hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 17:57:32 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HHvUZF029068;
 Mon, 17 Jun 2019 17:57:30 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 10:57:29 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:56:52 +0300
Message-Id: <20190617175658.135869-4-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617175658.135869-1-liran.alon@oracle.com>
References: <20190617175658.135869-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170160
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [QEMU PATCH v3 3/9] KVM: i386: Re-inject #DB to guest
 with updated DR6
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
 Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If userspace (QEMU) debug guest, when #DB is raised in guest and
intercepted by KVM, KVM forwards information on #DB to userspace
instead of injecting #DB to guest.
While doing so, KVM don't update vCPU DR6 but instead report the #DB DR6
value to userspace for further handling.
See KVM's handle_exception() DB_VECTOR handler.

QEMU handler for this case is kvm_handle_debug(). This handler basically
checks if #DB is related to one of user set hardware breakpoints and if
not, it re-inject #DB into guest.
The re-injection is done by setting env->exception_injected to #DB which
will later be passed as events.exception.nr to KVM_SET_VCPU_EVENTS ioctl
by kvm_put_vcpu_events().

However, in case userspace re-injects #DB, KVM expects userspace to set
vCPU DR6 as reported to userspace when #DB was intercepted! Otherwise,
KVM_REQ_EVENT handler will inject #DB with wrong DR6 to guest.

Fix this issue by updating vCPU DR6 appropriately when re-inject #DB to
guest.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 738dd91ff3cc..c8fd53055d37 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3558,6 +3558,9 @@ static int kvm_handle_debug(X86CPU *cpu,
         /* pass to guest */
         env->exception_injected = arch_info->exception;
         env->has_error_code = 0;
+        if (arch_info->exception == EXCP01_DB) {
+            env->dr[6] = arch_info->dr6;
+        }
     }
 
     return ret;
-- 
2.20.1


