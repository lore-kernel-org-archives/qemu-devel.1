Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F26C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B7820714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B7820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJC5s-0002Mb-33
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chengang@emindsoft.com.cn>) id 1jJC3Y-0007UA-UU
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chengang@emindsoft.com.cn>) id 1jJC3X-0003Os-27
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:15:32 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:45638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jJC3W-0003EO-NE
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:15:31 -0400
Received: from localhost (unknown [192.168.167.172])
 by lucky1.263xmail.com (Postfix) with ESMTP id 977CDAB4BD;
 Tue, 31 Mar 2020 16:15:14 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [223.72.79.229])
 by smtp.263.net (postfix) whith ESMTP id
 P18336T140718232278784S1585642507954077_; 
 Tue, 31 Mar 2020 16:15:14 +0800 (CST)
X-UNIQUE-TAG: <0aa00fb0e1ca73e2d1a6cbcec3b9f006>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: riku.voipio@iki.fi
X-SENDER-IP: 223.72.79.229
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: riku.voipio@iki.fi,
	laurent@vivier.eu
Subject: [PATCH] linux-user: main: Let each env have its own gdt table
Date: Tue, 31 Mar 2020 16:15:06 +0800
Message-Id: <20200331081506.29037-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.157.147.133
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
Cc: chengang@emindsoft.com.cn, qemu-devel@nongnu.org, gang.chen.5i5j@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

It is a temporary fix for thread LTS which need switch the ldt related
index in gdt table for stable-4.1 branch.

Welcome anyone providing the complete fix.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 linux-user/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8ffc525195..cad261fc7b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -194,12 +194,17 @@ CPUArchState *cpu_copy(CPUArchState *env)
     CPUArchState *new_env =3D new_cpu->env_ptr;
     CPUBreakpoint *bp;
     CPUWatchpoint *wp;
+    int size =3D sizeof(uint64_t) * TARGET_GDT_ENTRIES;
=20
     /* Reset non arch specific state */
     cpu_reset(new_cpu);
=20
     memcpy(new_env, env, sizeof(CPUArchState));
=20
+    new_env->gdt.base =3D target_mmap(0, size, PROT_READ | PROT_WRITE,
+                                     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0)=
;
+    memcpy(g2h(new_env->gdt.base), g2h(env->gdt.base), size);
+
     /* Clone all break/watchpoints.
        Note: Once we support ptrace with hw-debug register access, make =
sure
        BP_CPU break/watchpoints are handled correctly on clone. */
--=20
2.24.0.308.g228f53135a




