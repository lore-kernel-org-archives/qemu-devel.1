Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B96C47257
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFF920787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSIoKMz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFF920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUalU-0000RZ-SE
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 14:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jUakm-0008P1-Kb
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jUakm-0004T9-7A
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:51:16 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jUakk-0004Sj-LH; Fri, 01 May 2020 14:51:14 -0400
Received: by mail-ej1-x642.google.com with SMTP id n4so8205349ejs.11;
 Fri, 01 May 2020 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bogZN8N5/13l3adL8ZsZpxO2RLLZrlrHhT8ypcKbysI=;
 b=vSIoKMz3glFIamNaw7v4ZkDyj2YQWACo/j22K3HXgUiMvcPyEWttT1/8vAl3FL/meY
 Udt6tVsqfeoIEbu2NeElSt6YaPmJW/yHfn0LOwC+ZEHcakHQM7wpW2uu7nkJo3EVTCIY
 YbjPoeFPd/LGxv6HvUMybP69FGMTS1hyNl+bw5GZyUrTdrQmEqLnnr8VLZza4yO2oyOu
 2JnKnbiHfJ036hIQVqrGb2KC22HOugPJ6bbuJIaQqwxIj3EA/Wiv8r3yf15AQdEb634d
 NbO7og38fy+NX3uIOUb9BNdR2tEs5noUSskK1IGaNjFk0ktYfP12J6bTX/3hHs/xOs+B
 pH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bogZN8N5/13l3adL8ZsZpxO2RLLZrlrHhT8ypcKbysI=;
 b=knbXhl9WQlfUE6xfhLZIaIgp2JImiycs3N8Tv7CTTT1WZ3nvU3QTCjgdyaD00PAhZ9
 AXc3TN7At9QUeQ1TIirCvY78RzWmTt95sodUydeKF8QsJitRWT/H+JXllEe8SptSRIKK
 0FzSPN6/BwNXK6GAV/MKcPGv1qiWErygx1QH8umIJ+ZDUiJ9uxeekebAU4FKmLbNgfOX
 XYvig4pTu3poN2YIqA70Z+7IGwZa/U04APAgQ7fLiPNbf3czhqbiiOS0O8pWwMaSSmP2
 MTvSRzch56cc/+OxZy70tpkEdVNF09hCo0ZKcVhYkxkFhT4TMjNGBNgi2P74thM5zi8X
 WyHg==
X-Gm-Message-State: AGi0Pubbb7qbyggl+aRxjLOSHtB5Wq5f1KtNCL5t20DoWpetdc3Fxz7R
 4jvpu5BIrY9QyYHLKqrD88TtA/2kuXJ9Ag==
X-Google-Smtp-Source: APiQypJ2UXqAqLOJiTxeQwNrMIaxdvNheew9wbWUqMd1LAJYH7Kwga635azKxN1HQwZu5aLuMKn8Rg==
X-Received: by 2002:a17:906:1a06:: with SMTP id
 i6mr4508219ejf.90.1588359072177; 
 Fri, 01 May 2020 11:51:12 -0700 (PDT)
Received: from josecmpc.home (a109-50-182-159.cpe.netcabo.pt. [109.50.182.159])
 by smtp.gmail.com with ESMTPSA id jx1sm430752ejb.87.2020.05.01.11.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 11:51:11 -0700 (PDT)
From: Jose Martins <josemartins90@gmail.com>
To: qemu-riscv@nongnu.org
Subject: [PATCH v2] target/riscv: fix check of guest pa top bits
Date: Fri,  1 May 2020 19:51:06 +0100
Message-Id: <20200501185106.88767-1-josemartins90@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=josemartins90@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::642
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
Cc: Jose Martins <josemartins90@gmail.com>, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The spec states that on sv39x4 guest physical  "address bits 63:41 must
all be zeros, or else a guest-page-fault exception occurs.".  However,
the check performed for these top bits of the virtual address on the
second stage is the same as the one performed for virtual addresses on
the first stage except with the 2-bit extension, effectively creating
the same kind of "hole" in the guest's physical address space. I believe
the following patch fixes this issue:

Signed-off-by: Jose Martins <josemartins90@gmail.com>
---
 target/riscv/cpu_helper.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 247304d850..ae22c30bdd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -426,15 +426,21 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int va_bits = PGSHIFT + levels * ptidxbits + widened;
     target_ulong mask, masked_msbs;
 
-    if (TARGET_LONG_BITS > (va_bits - 1)) {
-        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+    if (!first_stage) {
+        if ((addr >> va_bits) != 0) {
+            return TRANSLATE_FAIL;
+        }
     } else {
-        mask = 0;
-    }
-    masked_msbs = (addr >> (va_bits - 1)) & mask;
+        if (TARGET_LONG_BITS > (va_bits - 1)) {
+            mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+        } else {
+            mask = 0;
+        }
+        masked_msbs = (addr >> (va_bits - 1)) & mask;
 
-    if (masked_msbs != 0 && masked_msbs != mask) {
-        return TRANSLATE_FAIL;
+        if (masked_msbs != 0 && masked_msbs != mask) {
+            return TRANSLATE_FAIL;
+        }
     }
 
     int ptshift = (levels - 1) * ptidxbits;
-- 
2.25.1


