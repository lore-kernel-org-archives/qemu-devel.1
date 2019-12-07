Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E2C43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 22:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B659206DB
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 22:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="GdP+3YiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B659206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idi82-0005gK-IO
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 17:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1idi77-00056Q-VE
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 16:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1idi76-0005vg-Rj
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 16:59:45 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:48122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>)
 id 1idi73-0005XS-RL; Sat, 07 Dec 2019 16:59:42 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
 by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xB7Lqhhu025275; Sat, 7 Dec 2019 13:59:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=xW05YTkIRCYTxTqOS/to29lMMTs58JaQaauZT+J+ic4=;
 b=GdP+3YiJE+VoSJG/2P7Hr74tvn609K8ilAbemu5jRlmyyJR53pG+ariwEkB0TgpLS1vV
 xQAiscDZudM13oupX0W+XaTgI7wnoNwsitfJoyS5zjNVYIGs5Vy5cyTbclUL0tJOkWNF
 /5pOs+JlEem3HRBAkKg7t70OA8SHPJNeW7HRGU9Q2lKunWIT2GBDO/qCYGTTtw2cXMbd
 +TOGMzKZYYlJDMeHOPTeXfVP3+7TGKXJYL9YRJCsMMevZh+eXWRQZkLeaTS34hAEqqqG
 yaazGPZ+8TMQ/zgo6qwlOqwwn6IvnUAlaU2IamL9uIB2UpUzAsz4IshaRA6HqcfOwklu oQ== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com
 [17.40.76.5])
 by nwk-aaemail-lapp03.apple.com with ESMTP id 2wr9g77tqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Sat, 07 Dec 2019 13:59:40 -0800
Received: from nwk-mmpp-sz13.apple.com
 (nwk-mmpp-sz13.apple.com [17.128.115.216]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q25002OLX3F3O60@ma1-mtap-s01.corp.apple.com>; Sat,
 07 Dec 2019 13:59:39 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz13.apple.com by
 nwk-mmpp-sz13.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q2500000WSPHT00@nwk-mmpp-sz13.apple.com>; Sat,
 07 Dec 2019 13:59:39 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 4907c3113c1994319c5a45cf48172c47
X-Va-R-CD: 049db61aa4ae8bfa4a677129663acd63
X-Va-CD: 0
X-Va-ID: 5d11f14b-1ac4-4cee-a4de-65110a386df6
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 4907c3113c1994319c5a45cf48172c47
X-V-R-CD: 049db61aa4ae8bfa4a677129663acd63
X-V-CD: 0
X-V-ID: a13f7062-f9f5-4c1d-9e0e-b4fa942e2e0d
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-07_07:,, signatures=0
Received: from pontoon.com (unknown [17.234.90.1]) by nwk-mmpp-sz13.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit
 (built May 7
 2019)) with ESMTPSA id <0Q2500CV0X3ENI70@nwk-mmpp-sz13.apple.com>; Sat,
 07 Dec 2019 13:59:39 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: liran.alon@oracle.com, pbonzini@redhat.com, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v2] Fix some comment spelling errors.
Date: Sat, 07 Dec 2019 13:59:36 -0800
Message-id: <d3c21b23934809f90350f11c56cabb6ca5041925.1575755966.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-07_07:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.68
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
Reviewed-by: Stefan Weil <sw@weilnetz.de>
---
 target/i386/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 2699eed94e..ee342ddd50 100644
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
@@ -271,9 +271,9 @@ static int cpu_pre_save(void *opaque)
      * distinguish between a pending and injected exception
      * and we don't need to store seperately the exception payload.
      *
-     * In order to preserve better backwards-compatabile migration,
+     * In order to preserve better backwards-compatible migration,
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


