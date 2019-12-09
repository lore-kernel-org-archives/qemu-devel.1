Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3D6C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B654206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPvCuArR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B654206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieJNI-0001CL-6E
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieJMV-0000VV-3o
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieJMR-0004CO-NF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:46:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieJMR-0004AP-J3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575899162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gxSwZyfeXxijSS52FpvVEEVrVieTj0X+VbLn4u/MPlA=;
 b=cPvCuArRulQSABAb1qbQ2T/tlyjogvfP9ESsqav4Ayx0L8gJejSqNGLoXNfzzToXCd/f1y
 jPjeY3FMDdNDaSFDXIq93Whq4I3xLEgcbIXQAJHNqQapGjVwWfs+5TtJbi3D/D474Bznyf
 1bcHOtwy4HORrRMnY8clbSnxA1wOou0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-2wA0zExYMlaUMLVu6bu2QQ-1; Mon, 09 Dec 2019 08:46:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D11B5801E74;
 Mon,  9 Dec 2019 13:45:59 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-146.brq.redhat.com [10.40.205.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 345A81001938;
 Mon,  9 Dec 2019 13:45:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Display helpful message when hflags mismatch
Date: Mon,  9 Dec 2019 14:45:52 +0100
Message-Id: <20191209134552.27733-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2wA0zExYMlaUMLVu6bu2QQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of crashing in a confuse way, give some hint to the user
about why we aborted. He might report the issue without having
to use a debugger.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0bf8f53d4b..6bfb62672b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11348,6 +11348,20 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, =
int el)
     env->hflags =3D rebuild_hflags_a64(env, el, fp_el, mmu_idx);
 }
=20
+static inline void assert_hflags_rebuild_correctly(CPUARMState *env)
+{
+#ifdef CONFIG_DEBUG_TCG
+    uint32_t env_flags_current =3D env->hflags;
+    uint32_t env_flags_rebuilt =3D rebuild_hflags_internal(env);
+
+    if (unlikely(env_flags_current !=3D env_flags_rebuilt)) {
+        fprintf(stderr, "TCG hflags mismatch (current:0x%08x rebuilt:0x%08=
x)\n",
+                env_flags_current, env_flags_rebuilt);
+        abort();
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
@@ -11355,9 +11369,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_=
ulong *pc,
     uint32_t pstate_for_ss;
=20
     *cs_base =3D 0;
-#ifdef CONFIG_DEBUG_TCG
-    assert(flags =3D=3D rebuild_hflags_internal(env));
-#endif
+    assert_hflags_rebuild_correctly(env);
=20
     if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc =3D env->pc;
--=20
2.21.0


