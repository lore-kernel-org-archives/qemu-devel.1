Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694C7C43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 02:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F2D217F4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 02:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="KRyS+wvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F2D217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idPvm-0001H9-Bb
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 21:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1idPud-0000kx-DR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 21:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1idPuc-0008AB-BB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 21:33:39 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:57618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>)
 id 1idPuZ-0007iv-J2; Fri, 06 Dec 2019 21:33:35 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
 by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xB72WFxP042064; Fri, 6 Dec 2019 18:33:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=tCSB5uOKLEox3K6K+aLs93+U7ucV7iPrx4x4KZDF2n0=;
 b=KRyS+wvVooeoQWZfMvKvPbJJf+nHY40O20WJ4xa5CP3qxIDvtrG8DSXymjKc6at9l5e3
 FOUHz48nN3AJiPDuiC3D5tUqgSaWoHoSLeJp5ec657KkEL+Yzfo5tkK+CsQpw1LlmTQ5
 YgLQWP2o5AmRbiS7SH5SftzfK/4hcAgs53JJpmyhd9DFB/Q0176uDtOuzFUaTY6iGMVn
 RBAAyJmR9ZlDRNYAQEgMoMS9DU15bNLYZh3R4E4bzX4RaXoJHylZUfQFnpzAWlSUhOhz
 AcQSw4ACXPW5LB0xXPUgr/COYwvrj6PEQPBYQEmiJiQXX+pt+JXuEl5xpgyhxKyMB7XH 2Q== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by nwk-aaemail-lapp02.apple.com with ESMTP id 2wknw6vmv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 06 Dec 2019 18:33:32 -0800
Received: from nwk-mmpp-sz12.apple.com
 (nwk-mmpp-sz12.apple.com [17.128.115.204]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q24005JQF3VNA80@ma1-mtap-s03.corp.apple.com>; Fri,
 06 Dec 2019 18:33:32 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz12.apple.com by
 nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q2400F00EQA3200@nwk-mmpp-sz12.apple.com>; Fri,
 06 Dec 2019 18:33:31 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 
X-Va-E-CD: 
X-Va-R-CD: 
X-Va-CD: 0
X-Va-ID: c025b2cc-3337-4fbb-bc8b-1ad71b7df0bd
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 36058438670e30bb75b386a3291a5519
X-V-R-CD: 28211e39a4a0c84d37f6c238b7f92cd3
X-V-CD: 0
X-V-ID: e1874f02-32e4-4c42-8577-955ae1d98350
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-06_08:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.217]) by nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q2400HE0F3V0L50@nwk-mmpp-sz12.apple.com>; Fri,
 06 Dec 2019 18:33:31 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: liran.alon@oracle.com, pbonzini@redhat.com, qemu-trivial@nongnu.org
Subject: [PATCH] Fix some comment spelling errors.
Date: Fri, 06 Dec 2019 18:33:30 -0800
Message-id: <086c197db928384b8697edfa64755e2cb46c8100.1575685843.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-06_08:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.67
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 2699eed94e..f21823f179 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -261,7 +261,7 @@ static int cpu_pre_save(void *opaque)
      * intercepted anymore.
      *
      * Furthermore, when a L2 exception is intercepted by L1
-     * hypervisor, it's exception payload (CR2/DR6 on #PF/#DB)
+     * hypervisor, its exception payload (CR2/DR6 on #PF/#DB)
      * should not be set yet in the respective vCPU register.
      * Thus, in case an exception is pending, it is
      * important to save the exception payload seperately.
@@ -273,7 +273,7 @@ static int cpu_pre_save(void *opaque)
      *
      * In order to preserve better backwards-compatabile migration,
      * convert a pending exception to an injected exception in
-     * case it is not important to distingiush between them
+     * case it is not important to distinguish between them
      * as described above.
      */
     if (env->exception_pending && !(env->hflags & HF_GUEST_MASK)) {
@@ -415,7 +415,7 @@ static bool exception_info_needed(void *opaque)
 
     /*
      * It is important to save exception-info only in case
-     * we need to distingiush between a pending and injected
+     * we need to distinguish between a pending and injected
      * exception. Which is only required in case there is a
      * pending exception and vCPU is running L2.
      * For more info, refer to comment in cpu_pre_save().
-- 
2.24.0


