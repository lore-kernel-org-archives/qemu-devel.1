Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB9C282DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E57205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E57205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=polepetko.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNUX-0000r9-Dl
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:47:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1hGNT7-0000BP-Ug
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1hGNT6-0001Jz-JN
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:45:45 -0400
Received: from [77.247.229.177] (port=48276 helo=neth.polepetko.eu)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pixo@polepetko.eu>)
	id 1hGNT6-0001DC-8e; Tue, 16 Apr 2019 08:45:44 -0400
Received: from localhost.localdomain (unknown [77.247.229.177])
	(Authenticated sender: pixo@polepetko.eu)
	by neth.polepetko.eu (Postfix) with ESMTPSA id 06CCA2A6F04;
	Tue, 16 Apr 2019 14:39:34 +0200 (CEST)
From: Stanislav Lanci <pixo@polepetko.eu>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 14:38:33 +0200
Message-Id: <20190416123833.60649-1-pixo@polepetko.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 77.247.229.177
Subject: [Qemu-devel] [PATCH] Pass through cache information for TOPOEXT CPUs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Stanislav Lanci <pixo@polepetko.eu>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416123833.ub6EKljUJ-G0OtZt9s8PgGBtL1TqkAet016Mhm-w4kY@z>

Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d210..bc0559fc51 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4546,6 +4546,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
         break;
     case 0x8000001D:
         *eax =3D 0;
+        /* pass through cache information */
+        if (cpu->cache_info_passthrough) {
+            host_cpuid(index, count, eax, ebx, ecx, edx);
+            break;
+        }
         switch (count) {
         case 0: /* L1 dcache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs=
,
--=20
2.21.0


