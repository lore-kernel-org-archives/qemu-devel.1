Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57734C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E88622CF6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E88622CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwR30-0007MH-Fk
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwR1H-0004xy-Fu
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:07:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwR1F-0005Pz-50
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:07:23 -0400
Received: from 2.general.paelzer.uk.vpn ([10.172.196.173]
 helo=Keschdeichel.fritz.box) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwR1C-0001KP-I4; Fri, 17 Jul 2020 14:07:18 +0000
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH] accel/tcg: reduce default code gen buffer on small hosts
Date: Fri, 17 Jul 2020 16:07:14 +0200
Message-Id: <20200717140714.124263-1-christian.ehrhardt@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 09:40:52
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v5.0.0 and 600e17b2 "accel/tcg: increase default code gen buffer
size for 64 bit" in particular qemu with TCG regularly gets OOM Killed
on small hosts.

The former 47a2def4 "accel/tcg: remove link between guest ram and TCG
cache size" removed the link to guest size which is right, but at least
some connection to the host size needs to be retained to avoid growing
out of control on common CI setups which run at 1-2G host sizes.

The lower value of 1/8th of the host memory size and the default (of
currently 1G) will be taken to initialize the TB. There already is a
Min/Max check in place to not reach ridiculously small values.

Fixes: 600e17b2

Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
---
 accel/tcg/translate-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2afa46bd2b..ffcd67060e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -977,6 +977,29 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
     /* Size the buffer.  */
     if (tb_size == 0) {
         tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        /*
+         * A static default of 1G turned out to break (OOM Kill) many common
+         * CI setups that run at 1-2G Host memory size.
+         * At the same time the former default of ram_size/4 wasted performance
+         * on large host systems when running small guests.
+         * Common CI guest sizes are 0.5-1G which meant ~128M-256M TB size.
+         * A Default of 1/8th of the host size will get small hosts a
+         * similar TB size than they had prior to v5.0 and common bare metal
+         * systems (>=8G) the new 1G default that was set in v5.0
+         */
+#if defined _SC_PHYS_PAGES && defined _SC_PAGESIZE
+        {
+            unsigned long max = DEFAULT_CODE_GEN_BUFFER_SIZE;
+            double pages = (double)sysconf(_SC_PHYS_PAGES);
+
+            if (pages > 0 && pagesize > 0) {
+                max = (unsigned long)((pages * qemu_real_host_page_size) / 8);
+            }
+            if (max < DEFAULT_CODE_GEN_BUFFER_SIZE) {
+                tb_size = max;
+            }
+        }
+#endif
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;
-- 
2.27.0


