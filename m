Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15665C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61D1208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQT1IvT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61D1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hho4V-0006aZ-5r
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56628)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2p-0004tL-BK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2o-0004Uo-4Y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:59 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:35604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2o-0004Ue-07
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:58 -0400
Received: by mail-yb1-xb42.google.com with SMTP id p85so3332590yba.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LcJuHjY62NJio9do3DWquEyjV/4nLnI3M2tOGcRLLgo=;
 b=HQT1IvT/VjeAh3Al7jYpzC7EC7MDZ3JVXhtQnkNQyBprEORb39GH6bMFaX+s2bQ9Wu
 mphtafIp0JjLxSniPui3EQxYnusIwF/Y4iOpJKURsLRjOelwTH1HeYAWbXatEKT4MaL9
 pTRAFa849OVexd5uX+gXDLzhcdAvZ8NBXOuosQAqeZvZfx6OmdZzw6jVCvVTe2Qcsr4U
 OR9wkFXsRs3IWwo+snYx1yqrVtNvfYTgDI2Vkuo7Vdb5PKDd5HRxuPwl78QxklPaBVJw
 WNTwZyy73q73LshCbl87W718LJh/oea8qT41L1g4tV7VIMc9v493yGV9ie7Rey67aBXn
 jAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LcJuHjY62NJio9do3DWquEyjV/4nLnI3M2tOGcRLLgo=;
 b=pi8BtHuNmYKqXdrzKQLj+oIK6XjPKd+NvxAUZv+REO0rIFUQ2s+2b2oWRs+eR9TUyy
 2ofFodCNk5cuWBrAiOi+NFDujJgdV9jtKfGUPFo3IRnO3oMbxhDQcmHoA9ROlBEBgIhD
 peXn6ThcBsb9uaLXJkVpjSzmuAxzVWln2tKsjoAmNr9cCyEIRD29OrFUTZN4kzHJV1jN
 SbvdCvQ/tAGeetBrRrZ4W6u4SfZzPa72Q3yjoOMh0lV2Zc1/nti5/ruCFYyTo52vI0s2
 /3rZONF5767/+UDiiEeDQmE8XHIUQGF8Z3F/69cqoZSJZV5RJBARidkJUNE+U+62xBIz
 GZUw==
X-Gm-Message-State: APjAAAVmx7m5NPwxFtsUWxFsGaXOChANob6t4jgRAw4A9ht5+6E/To+1
 QA9UBylj1UQCTmWzJp4urwJyyLQF
X-Google-Smtp-Source: APXvYqyLlOvJwX/sAxOc8IMkXYAK53rtquQjBkoGIHRQ6QU29sUpwmJs7pgAGB8NR1H57hEsT6yEqQ==
X-Received: by 2002:a25:d38a:: with SMTP id e132mr2830720ybf.404.1561955757408; 
 Sun, 30 Jun 2019 21:35:57 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.35.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:35:57 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:25 -0400
Message-Id: <20190701043536.26019-4-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU RFC PATCH v2 03/14] risugen_x86_emit: add module
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
 risugen_x86_emit.pm | 91 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)
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
index 0000000..127a524
--- /dev/null
+++ b/risugen_x86_emit.pm
@@ -0,0 +1,91 @@
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
+sub vex(%)
+{
+    my (%opts) = @_;
+    $emit_opts->{vex} = \%opts;
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


