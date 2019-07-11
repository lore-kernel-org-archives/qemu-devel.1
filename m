Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDAFC742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD9520872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJlsUwED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD9520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhei-0007aP-RB
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdL-0001wT-IY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdH-00045X-5z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:45 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:45649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdD-0003dp-EN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:40 -0400
Received: by mail-yb1-xb43.google.com with SMTP id s41so470716ybe.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0MQK5PQyLrAN/NCGPcpa91CbMqRWCs9MXSvOrpJv4xM=;
 b=IJlsUwEDCvrwng0E69CwEUqJlwsc3dQ/TEmS/gdo8x9WIfpdZwZbFYDUNlJQe06D8e
 mrQLvpaO6UPYnXNjXxtdDVQWKjhGJWs2hQjuTcQ4vUbAJenkO8sLvdO74GOayqred9EN
 cQPUZ9TYwdSQY/lFoQXcj5TT38f0uDeIDKLoCypZwLhGdDoI/WPCOLKqK1Z8WPP6Avt9
 1WTvv9tnZfoUSEzSNYaQT9GXhuLhL19d3w8pRfCoYGN/pvzqrm1+jv+1v1dIBF9+gNPB
 f9ws5q1hfn7aJcxa4bVLDi9l4nt3h0qAX9NY7uxlCAxKIoCxO0is9jyv4gZvn4DT3UL6
 SCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0MQK5PQyLrAN/NCGPcpa91CbMqRWCs9MXSvOrpJv4xM=;
 b=UObST5tfUXoCf5Xd2fcHW/4XpdrIHdI45+pzadmrRvFQhhlCXKE2guANNS7zfEYXuL
 +/n5Nd87Ck1sXgje6+vZZ6RKJbpNieLrRYUqYatZaTpMhJ/AByEWtrcFkYFVh3cPxiVo
 lErv3USGfrYyU4/QjE820Jxfdm+5LDGrI3FefiFcEAWpNeBsx9AUhvulprpj8ubrcqN6
 BywgEj7HQ6BZCdjDO1EJNUX3HJzQp9oe7fq7/bJchE6JMW4WNXUnDGh2GbtL7lzhckzE
 f2U3pJh0eaTxFF+3Gxuk1M+w4czZ7RHeW2hB0w3W/VsG7JdWTL9KdKiTHO5Gq6V1XaJ7
 6gUg==
X-Gm-Message-State: APjAAAX8m0z4pBmD3ui0QnGuiLqa5DLA+3s8+d0/GZ6Zs8a2yqQY81aG
 4t0pEPQq8ERza7gD8vwPArFPmInf
X-Google-Smtp-Source: APXvYqw1FdC96Eub+JI+Dtwy2tK+f9x3JLcLBtiQVtfAWYbUus3ApUGyj/aHOpEYOQtdBuAkZfSzTg==
X-Received: by 2002:a25:ae63:: with SMTP id g35mr4037215ybe.111.1562884396016; 
 Thu, 11 Jul 2019 15:33:16 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:15 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:47 -0400
Message-Id: <20190711223300.6061-6-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RISU PATCH v3 05/18] risugen_x86_memory: add module
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

The module risugen_x86_memory.pm provides environment for evaluating
x86 "!memory" blocks. This is facilitated by the single exported
function eval_memory_block.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen_x86_memory.pm | 87 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 risugen_x86_memory.pm

diff --git a/risugen_x86_memory.pm b/risugen_x86_memory.pm
new file mode 100644
index 0000000..6aa6877
--- /dev/null
+++ b/risugen_x86_memory.pm
@@ -0,0 +1,87 @@
+#!/usr/bin/perl -w
+###############################################################################
+# Copyright (c) 2019 Jan Bobek
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Jan Bobek - initial implementation
+###############################################################################
+
+# risugen_x86_memory -- risugen_x86's helper module for "!memory" blocks
+package risugen_x86_memory;
+
+use strict;
+use warnings;
+
+use risugen_common;
+use risugen_x86_asm;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(eval_memory_block);
+
+my %memory_opts;
+
+sub load(%)
+{
+    my (%args) = @_;
+
+    @memory_opts{keys %args} = values %args;
+    $memory_opts{is_write}   = 0;
+}
+
+sub store(%)
+{
+    my (%args) = @_;
+
+    @memory_opts{keys %args} = values %args;
+    $memory_opts{is_write}   = 1;
+}
+
+sub eval_memory_block(%)
+{
+    my (%args) = @_;
+    my $rec = $args{rec};
+    my $insn = $args{insn};
+    my $insnname = $rec->{name};
+    my $opcode = $insn->{opcode}{value};
+
+    # Setup reasonable defaults
+    %memory_opts           = ();
+    $memory_opts{size}     = 0;
+    $memory_opts{align}    = 1;
+    $memory_opts{disp}     = 0;
+    $memory_opts{ss}       = 0;
+    $memory_opts{value}    = 0;
+    $memory_opts{mask}     = 0;
+    $memory_opts{rollback} = 0;
+    $memory_opts{is_write} = 0;
+
+    if (defined $insn->{modrm}) {
+        my $modrm = $insn->{modrm};
+
+        $memory_opts{ss}     = $modrm->{ss}          if defined $modrm->{ss};
+        $memory_opts{index}  = $modrm->{index}       if defined $modrm->{index};
+        $memory_opts{vindex} = $modrm->{vindex}      if defined $modrm->{vindex};
+        $memory_opts{base}   = $modrm->{base}        if defined $modrm->{base};
+        $memory_opts{disp}   = $modrm->{disp}{value} if defined $modrm->{disp};
+
+        $memory_opts{rollback} = defined $modrm->{base};
+    }
+
+    my $memory = $rec->{blocks}{"memory"};
+    if (defined $memory) {
+        # Evaluate in an environment with variables set corresponding
+        # to the variable fields.
+        my %env = extract_fields($opcode, $rec);
+        # set the variable $_ to the instruction in question
+        $env{_} = $insn;
+
+        eval_block($insnname, "memory", $memory, \%env);
+    }
+    return %memory_opts;
+}
+
+1;
-- 
2.20.1


