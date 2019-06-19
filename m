Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F584C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBA2208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMb2IimZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBA2208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSoe-0005vu-Ii
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34420)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0003uC-Ie
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmR-0001eo-Lv
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:09 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hdSmP-0001dC-Ob
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:05 -0400
Received: by mail-yb1-xb44.google.com with SMTP id v104so7061841ybi.12
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2AL1b+nMXBf7cujyRtXqMsJ+EqszwrRf6hdCVJcNcgk=;
 b=aMb2IimZL2r6VQHh2dR+iKTXQXASyiRNX6y/XDqg2TNVsOxrjyONpkUGNZm37+cW3V
 Kchl5gvfDBwfDF8ZkQR0Nqiv5Mpvc7yo4OmYX+//t92yQGEjkCOeYJbjv2SiSKDnBJtA
 Rv/t85GnGnZfWVem42i7OxUkr/WRvjgwUFv9phAea6mMC09lLTKiTHQRdq8vETYw2xF5
 Ej2JI1366Rf1zoQIzjkS+XRbvLW9yt2ncHvN0JU1p7rk9g6a7acetr3hxcB4ipEq5icB
 Rl49pH5zCKcc88P4ljuNyfv5p5k4Fd/cVjoEMilCHeNKv+IFl4bpTHGUVJKeqHELcccL
 0dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2AL1b+nMXBf7cujyRtXqMsJ+EqszwrRf6hdCVJcNcgk=;
 b=U6p/oz2Ej0QxvgtTOtL2c8CvBaF5dTpzpmLrMHHjx2Q+yJT5AN203KjsA59FZE6NUH
 5MGsMGdezWZvVZIhEr1F93ph8C88V9aImxm+qr75yj6lKduynnnoO/TA8HamBE6xSi5H
 5c+4L3fpB0fwyiMPhCn6LPoOxUx1WPs8w7vLcmcndkdxbzAQzsf8QCv8ou43oMkw/XSO
 rYtpvvRZBz9Iw4u95aXIjFU/5mhTsw07ogCwibUdeVBykj70LsoNIjIlUf+ukE00FtYl
 WoUP3fDiIf+JTayZOjq1/PZXkfdVQWiBinsochjLvPwbBHWBVc3+vaRAD3NdgJv/s9EA
 Am6Q==
X-Gm-Message-State: APjAAAVuCcRGysE4/xpJaocF+W0Xg0IFyMeoGRi2UKMpQBVhrR9f8J2q
 p0n4gW57kwLYNkLRCS9XK0GIVq3q
X-Google-Smtp-Source: APXvYqyGrJIzp0FKOlN6d7zRMGMNPeugaKgK1XCn5WVhk2jJxDCOyr1DapNBNmvQiB3/oHx2ah2T1w==
X-Received: by 2002:a25:e80b:: with SMTP id k11mr4060163ybd.434.1560920704814; 
 Tue, 18 Jun 2019 22:05:04 -0700 (PDT)
Received: from localhost.localdomain (67-9-99-67.biz.bhn.net. [67.9.99.67])
 by smtp.gmail.com with ESMTPSA id e12sm1714426ywe.85.2019.06.18.22.05.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 22:05:04 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 01:04:43 -0400
Message-Id: <20190619050447.22201-4-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619050447.22201-1-jan.bobek@gmail.com>
References: <20190619050447.22201-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU RFC PATCH v1 3/7] risugen_x86_emit: add module
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

The helper module risugen_x86_emit.pm exports a single function
"parse_emitblock", which serves to capture and return instruction
constraints described by "emit" blocks in an x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen             |  2 +-
 risugen_x86_emit.pm | 85 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 risugen_x86_emit.pm

diff --git a/risugen b/risugen
index e690b18..fe3d00e 100755
--- a/risugen
+++ b/risugen
@@ -43,7 +43,7 @@ my @pattern_re = ();            # include pattern
 my @not_pattern_re = ();        # exclude pattern
 
 # Valid block names (keys in blocks hash)
-my %valid_blockname = ( constraints => 1, memory => 1 );
+my %valid_blockname = ( constraints => 1, memory => 1, emit => 1 );
 
 sub parse_risu_directive($$@)
 {
diff --git a/risugen_x86_emit.pm b/risugen_x86_emit.pm
new file mode 100644
index 0000000..0e3cc1c
--- /dev/null
+++ b/risugen_x86_emit.pm
@@ -0,0 +1,85 @@
+#!/usr/bin/perl -w
+###############################################################################
+# Copyright (c) 2019 Linaro Limited
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Jan Bobek - initial implementation
+###############################################################################
+
+# risugen_x86_emit -- risugen_x86's helper module for emit blocks
+package risugen_x86_emit;
+
+use strict;
+use warnings;
+
+use risugen_common;
+use risugen_x86_asm;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(parse_emitblock);
+
+my $emit_opts;
+
+sub rep(%)
+{
+    my (%opts) = @_;
+    $emit_opts->{rep} = \%opts;
+}
+
+sub repne(%)
+{
+    my (%opts) = @_;
+    $emit_opts->{repne} = \%opts;
+}
+
+sub data16(%)
+{
+    my (%opts) = @_;
+    $emit_opts->{data16} = \%opts;
+}
+
+sub rex(%)
+{
+    my (%opts) = @_;
+    $emit_opts->{rex} = \%opts;
+}
+
+sub modrm(%)
+{
+    my (%opts) = @_;
+    $emit_opts->{modrm} = \%opts;
+}
+
+sub mem(%)
+{
+    my (%opts) = @_;
+    $emit_opts->{mem} = \%opts;
+}
+
+sub imm(%)
+{
+    my (%opts) = @_;
+    $emit_opts->{imm} = \%opts;
+}
+
+sub parse_emitblock($$)
+{
+    my ($rec, $insn) = @_;
+    my $insnname = $rec->{name};
+    my $opcode = $insn->{opcode}{value};
+
+    $emit_opts = {};
+
+    my $emitblock = $rec->{blocks}{"emit"};
+    if (defined $emitblock) {
+        eval_with_fields($insnname, $opcode, $rec, "emit", $emitblock);
+    }
+
+    return $emit_opts;
+}
+
+1;
-- 
2.20.1


