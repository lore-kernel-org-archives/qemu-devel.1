Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DFBC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E50A2085A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z41coFLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E50A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIsV-0007jJ-KQ
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkz-0005zX-Fk
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIky-0004O5-C1
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:29 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIky-0004Nr-7g
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:28 -0400
Received: by mail-ot1-x343.google.com with SMTP id k18so8368442otr.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1WE3bBdYSXJrRK7mJcEb6kzPO19OfCWH98w1USfvuLI=;
 b=Z41coFLcit1TJUSm2DITt/S3umZupphV9koQnYcZ4kOY0OS6t1u68v+l3DOntlcC9J
 kFFRh+eUS/zxIkbKs5ccfoeJghLo8Pn+YhcD3JkKvYgUypCtzwMhf03p0Di0iwCza9kw
 yLrsluK489hQqjpMUQ52ZSHixaaaCbDIgshn5WIMDKgpd5yTMkajEf7TorWQqtSeeKY0
 xWB17Kec37RdkXClw9TSNuHlZoE7T+f7wSJzhXvEEtXl5qacGR5SGPj+JSaMKfa2GZD/
 zpiLXhWRwslBauXnxRoADj/18T0ZHa3cnvxu+FCoHtukCdOFjy0eHebkCyDGZyHyiYbO
 t4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1WE3bBdYSXJrRK7mJcEb6kzPO19OfCWH98w1USfvuLI=;
 b=WKVrv80jS61AFITuWw7qb77AKm7Ok3FJc4zeAcPlRNpiZ37ft9u+BT55jzedtb2vCM
 XDSBJDmWPfYfj3VyuBvQ7qG0a26N1Q5rrZqKtysi9611nAYBHMND9JyvWMW3NRQLTtYi
 lk58YRwSY2wPvpV1SUitD0xIMXQ64eiphNZtm9Ezoc4K0YNqXoxfB27zxuR2HHndbn/L
 Bw5iRShDbzapiROO+4s+UsY9JbcEx/OvSuSpLDYyjJ5GeEpqy7JF0in+j6LBQmkvrAUX
 ZHTFf361xn2ZbEQVqlNi1jy9BbMFZHEm9CdmbvDFW5490v40sMxxcUPqZW8fFrULRTX9
 A10g==
X-Gm-Message-State: APjAAAXXao56FG+pLddkRV6V1I3d6Qhxx5egswEJUUV2Xn7aPeDOfxrk
 GPv23fICVbBENeVs8FjP0JIDU2SA
X-Google-Smtp-Source: APXvYqzpr1e8qc8IBucNc3quEye7PTiX0XPsfjbQbsi4oEA4q+PPqGqEktcdMgdB3C2/SKk8J3CcxA==
X-Received: by 2002:a05:6830:200e:: with SMTP id
 e14mr19227814otp.245.1565410407564; 
 Fri, 09 Aug 2019 21:13:27 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:27 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:37 -0400
Message-Id: <20190810041255.6820-22-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [RFC PATCH v2 21/39] target/i386: introduce insn.h
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This header is intended to eventually list all supported instructions
along with some useful details (e.g. mnemonics, opcode, operands etc.)
It shall be used (along with some preprocessor magic) anytime we need
to automatically generate code for every instruction.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/insn.h | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 target/i386/insn.h

diff --git a/target/i386/insn.h b/target/i386/insn.h
new file mode 100644
index 0000000000..4b48c0c0e1
--- /dev/null
+++ b/target/i386/insn.h
@@ -0,0 +1,87 @@
+#ifndef INSN
+#   define INSN(mnem, prefix, opcode, feat)
+#endif /* INSN */
+
+#ifndef INSN_R
+#   define INSN_R(mnem, prefix, opcode, feat, opR1)
+#endif /* INSN_R */
+
+#ifndef INSN_RR
+#   define INSN_RR(mnem, prefix, opcode, feat, opR1, opR2)
+#endif /* INSN_RR */
+
+#ifndef INSN_W
+#   define INSN_W(mnem, prefix, opcode, feat, opW1)
+#endif /* INSN_W */
+
+#ifndef INSN_WR
+#   define INSN_WR(mnem, prefix, opcode, feat, opW1, opR1)
+#endif /* INSN_WR */
+
+#ifndef INSN_WRR
+#   define INSN_WRR(mnem, prefix, opcode, feat, opW1, opR1, opR2)
+#endif /* INSN_WRR */
+
+#ifndef INSN_WRRR
+#   define INSN_WRRR(mnem, prefix, opcode, feat, opW1, opR1, opR2, opR3)
+#endif /* INSN_WRRR */
+
+#ifndef INSN_GRP
+#   define INSN_GRP(grpname, prefix, opcode)
+#endif /* INSN_GRP */
+
+#ifndef INSN_GRP_BEGIN
+#   define INSN_GRP_BEGIN(grpname)
+#endif /* INSN_GRP_BEGIN */
+
+#ifndef INSN_GRPMEMB
+#   define INSN_GRPMEMB(grpname, mnem, opcode, feat)
+#endif /* INSN_GRPMEMB */
+
+#ifndef INSN_GRPMEMB_R
+#   define INSN_GRPMEMB_R(grpname, mnem, opcode, feat, opR1)
+#endif /* INSN_GRPMEMB_R */
+
+#ifndef INSN_GRPMEMB_RR
+#   define INSN_GRPMEMB_RR(grpname, mnem, opcode, feat, opR1, opR2)
+#endif /* INSN_GRPMEMB_RR */
+
+#ifndef INSN_GRPMEMB_W
+#   define INSN_GRPMEMB_W(grpname, mnem, opcode, feat, opW1)
+#endif /* INSN_GRPMEMB_W */
+
+#ifndef INSN_GRPMEMB_WR
+#   define INSN_GRPMEMB_WR(grpname, mnem, opcode, feat, opW1, opR1)
+#endif /* INSN_GRPMEMB_WR */
+
+#ifndef INSN_GRPMEMB_WRR
+#   define INSN_GRPMEMB_WRR(grpname, mnem, opcode, feat, opW1, opR1, opR2)
+#endif /* INSN_GRPMEMB_WRR */
+
+#ifndef INSN_GRPMEMB_WRRR
+#   define INSN_GRPMEMB_WRRR(grpname, mnem, opcode, feat, opW1, opR1, opR2, opR3)
+#endif /* INSN_GRPMEMB_WRRR */
+
+#ifndef INSN_GRP_END
+#   define INSN_GRP_END(grpname)
+#endif /* INSN_GRP_END */
+
+#undef LEG
+#undef VEX
+#undef INSN
+#undef INSN_R
+#undef INSN_RR
+#undef INSN_W
+#undef INSN_WR
+#undef INSN_WRR
+#undef INSN_WRRR
+#undef INSN_GRP
+#undef INSN_GRP_BEGIN
+#undef INSN_GRPMEMB
+#undef INSN_GRPMEMB_R
+#undef INSN_GRPMEMB_RR
+#undef INSN_GRPMEMB_W
+#undef INSN_GRPMEMB_WR
+#undef INSN_GRPMEMB_WRR
+#undef INSN_GRPMEMB_WRRR
+#undef INSN_GRP_END
-- 
2.20.1


