Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3E9C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 01:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE212084E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 01:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMy1VDn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE212084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45007 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF7Ii-0002vF-Kn
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 21:17:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hF7F3-0008Ue-29
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hF7F1-0000kx-BJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:14:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hF7F1-0000kL-2W
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:13:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id 4so13300837wmf.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ZdbakEXzpU8tzbmrc5OWOUi1IpM4Ik4V2F+KY4JS/+8=;
	b=lMy1VDn7OuYpE6GgJ54z83fk5KgXAaX72NJRbwjy3WIro110VUcP4gfmwll5f/aLJc
	kKNVN5IvfL794oS56xSi0HgSLOXZLCu7+Du32Fo+i8uK3WHSZ3Dzl+UgBgbUnSNu/gI9
	+kGPFeCMQTnQi93QoSbrUrgjGoyhJ09jKCDVf8fQmPthDq9Ky8pP6UOAWTucjSJuJ65h
	I7PWh1uJIY5iBnIODOHr6BUfOIW+WxVAsENAvvDeX6q2etBqUCbd2hFOiUKTeLUaIgER
	MR+1yjToll4dauX6Y50U3hGt+n75vPo4jnCCx1l2bMrDDQrteRDLxZ/M5giWw+Z8pUHC
	Uk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZdbakEXzpU8tzbmrc5OWOUi1IpM4Ik4V2F+KY4JS/+8=;
	b=WmcLqnslaTpNNavrm9xGV08gG02hQofQWGB8x5zJuttviIWu73hc4OaxmpuhC1OIRD
	PpiO2BeH15Krs2xIhoqE8HST4WSRSxe1D9QAgfqItULIjRqcobSsMP698Qqp+1TwgpP+
	srDbciVhcDySneP7Giha2mWXVCdyRvq9pv7kZDARmv/fuIlvOd/T8E2HwP2E+0pBDbix
	mMhJmdNiis1KSK2w+vwTe0SPi4SsehUXWq79kduTCDFDgFw+LdN1x2kN3rX9g9h2NULs
	z20EOINswOmkCKSC1YSdDqTjOBMUuFhc2f9cdqEZN+A+DWbGNci9N178zL7pQykVvMtm
	tDxQ==
X-Gm-Message-State: APjAAAVJTUJBHk+hr8GQt3FlsS6hJbPgfBMXul1aHXncUWQRXNI1zF8I
	mQ+crgZyvbZsu12tmnIY6vxngXMXXsbz
X-Google-Smtp-Source: APXvYqxhxo/1C/1CrBp3KwQy+VPHEEXCaoSLtzxGUaaG8WtN8UWMHjGHAqxZ5PzZwqA0z3cNcZ9m3g==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr13543481wmj.37.1555118037084; 
	Fri, 12 Apr 2019 18:13:57 -0700 (PDT)
Received: from ninjahub.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	g13sm7398293wmh.11.2019.04.12.18.13.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 12 Apr 2019 18:13:56 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Apr 2019 02:13:02 +0100
Message-Id: <20190413011302.6610-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413011302.6610-1-jbi.octave@gmail.com>
References: <20190413011302.6610-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v4 3/3] target/mips: wrap lines to fix
 checkpatch errors
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
Cc: arikalo@wavecomp.com, Jules Irenge <jbi.octave@gmail.com>,
	aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190413011302.yTEKrS6EZZvLstI91ys4Ddkzm5p0D6yv5REC11AmD8M@z>

Wrap lines to fix errors issued by checkpatch.pl tool
"ERROR: line over 90 characters"
within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 57af560e34..c1abce33c3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -72,15 +72,28 @@ struct CPUMIPSFPUContext {
 #define FCR31_FS 24
 #define FCR31_ABS2008 19
 #define FCR31_NAN2008 18
-#define SET_FP_COND(num, env)     do { ((env).fcr31) |= ((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
-#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &= ~((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
-#define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | (((env).fcr31 >> 23) & 0x1))
+#define SET_FP_COND(num, env)     do { ((env).fcr31) |= \
+                                       ((num) ? (1 << ((num) + 24)) :\
+                                        (1 << 23));\
+                                     } while (0)
+#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &= \
+                                       ~((num) ? (1 << ((num) + 24)) :\
+                                         (1 << 23));\
+                                     } while (0)
+#define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) |\
+                                  (((env).fcr31 >> 23) & 0x1))
 #define GET_FP_CAUSE(reg)        (((reg) >> 12) & 0x3f)
 #define GET_FP_ENABLE(reg)       (((reg) >>  7) & 0x1f)
 #define GET_FP_FLAGS(reg)        (((reg) >>  2) & 0x1f)
-#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) | ((v & 0x3f) << 12); } while (0)
-#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | ((v & 0x1f) << 7); } while (0)
-#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | ((v & 0x1f) << 2); } while (0)
+#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) |\
+                                       ((v & 0x3f) << 12); \
+                                     } while (0)
+#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) |\
+                                               ((v & 0x1f) << 7); \
+                                     } while (0)
+#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) |\
+                                               ((v & 0x1f) << 2); \
+                                     } while (0)
 #define UPDATE_FP_FLAGS(reg, v)   do { (reg) |= ((v & 0x1f) << 2); } while (0)
 #define FP_INEXACT        1
 #define FP_UNDERFLOW      2
-- 
2.20.1


