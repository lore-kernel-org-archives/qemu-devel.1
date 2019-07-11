Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB2C742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038ED20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyiNWNd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038ED20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhf6-0000we-UC
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40495)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-00029C-8x
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdL-000494-Rj
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:50 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdL-0003cm-8S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:47 -0400
Received: by mail-yb1-xb41.google.com with SMTP id s41so470681ybe.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lqe6VIFxpb+xpXuhAI3VXMfPIK6JnWNZWQa5OWBVxWY=;
 b=VyiNWNd0BIVQFDy9TXw4u6h2DfwdTnwE1tp3WFHrxq1WutLZF0ahXy9qOsy0PRo+02
 l15scZfBxsQjC9apWjcwQidQkTQALe/JF2LTR4DLVYHUsGojF6WNGNyH2YgcqCWio6at
 gFCPR9b2pzHsaWTybj8yIaliSWqSC6D+GZ+KIFvA6U78xJhJy9D85gevauLsHSJd5KHn
 yNxtU8KAPWtyfKee/2aKEUVNx8+mAv79AXppIAC+PkOkYy4XweqbWemvkePdB+iD9mUh
 5JA5Jl+Wlb9UNde8+dX7ZKgA3epj0Ea6IhjKditZfqsbk0+M6ragMFdwmDhBrtxdeJVJ
 In5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lqe6VIFxpb+xpXuhAI3VXMfPIK6JnWNZWQa5OWBVxWY=;
 b=U3Ce9MLvF9nlbUhBK+7KUkR9Wh5OyOn1k8Swetff8QEKXQv7XDiWHwdijF9CCEjZx2
 tgBHKLbdtg7rQSLh36ahhIuwtzxEhJ8YXfFV0DzllOzFNER6LjSA4jLGUrluqHwueA1M
 E2ziIrBBQKWDcRSZZezISIBQIFPgmEngKp/HHO6nu87y/oyuaL4cRCQWT+wRt7vkz2+a
 DfjhrWeofXvpumEQlKZ750VddXCkKT62oTkOrjJadv4iy+YmT+Z5SqYj4tSF9mPSQ0sM
 QuZWT0I2HegtF5/C4upZ23Opu0r8KGp6WocB9xkrkE3kWA5rePH7Pb0DGRrz443wvw2y
 kwEA==
X-Gm-Message-State: APjAAAVMau5g5T3OVwJwPIL83N0a417gf8DekAIm/q8+QLY3wU/2G61e
 PJeuq3EDdtByp1KQjoj9Fy5ch9MW
X-Google-Smtp-Source: APXvYqyAGmx4+t7/Wz1/qaxDJC+BwKRQvTnfZiSYh0/9hw8wvGi0vj4RqEdLC/wfDFigbthxxa6vIw==
X-Received: by 2002:a25:728a:: with SMTP id n132mr4169152ybc.440.1562884393474; 
 Thu, 11 Jul 2019 15:33:13 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:13 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:43 -0400
Message-Id: <20190711223300.6061-2-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RISU PATCH v3 01/18] risugen_common: add helper
 functions insnv, randint
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

insnv allows emitting variable-length instructions in little-endian or
big-endian byte order; it subsumes functionality of former insn16()
and insn32() functions.

randint can reliably generate signed or unsigned integers of arbitrary
width.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen_common.pm | 55 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/risugen_common.pm b/risugen_common.pm
index 71ee996..d63250a 100644
--- a/risugen_common.pm
+++ b/risugen_common.pm
@@ -23,8 +23,9 @@ BEGIN {
     require Exporter;
 
     our @ISA = qw(Exporter);
-    our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16 $bytecount
-                   progress_start progress_update progress_end
+    our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16
+                   $bytecount insnv randint progress_start
+                   progress_update progress_end
                    eval_with_fields is_pow_of_2 sextract ctz
                    dump_insn_details);
 }
@@ -37,7 +38,7 @@ my $bigendian = 0;
 # (default is little endian, 0).
 sub set_endian
 {
-    $bigendian = @_;
+    ($bigendian) = @_;
 }
 
 sub open_bin
@@ -52,18 +53,58 @@ sub close_bin
     close(BIN) or die "can't close output file: $!";
 }
 
+sub insnv(%)
+{
+    my (%args) = @_;
+
+    # Default to big-endian order, so that the instruction bytes are
+    # emitted in the same order as they are written in the
+    # configuration file.
+    $args{bigendian} = 1 unless defined $args{bigendian};
+
+    for (my $bitcur = 0; $bitcur < $args{width}; $bitcur += 8) {
+        my $value = $args{value} >> ($args{bigendian}
+                                     ? $args{width} - $bitcur - 8
+                                     : $bitcur);
+
+        print BIN pack("C", $value & 0xff);
+        $bytecount += 1;
+    }
+}
+
 sub insn32($)
 {
     my ($insn) = @_;
-    print BIN pack($bigendian ? "N" : "V", $insn);
-    $bytecount += 4;
+    insnv(value => $insn, width => 32, bigendian => $bigendian);
 }
 
 sub insn16($)
 {
     my ($insn) = @_;
-    print BIN pack($bigendian ? "n" : "v", $insn);
-    $bytecount += 2;
+    insnv(value => $insn, width => 16, bigendian => $bigendian);
+}
+
+sub randint
+{
+    my (%args) = @_;
+    my $width = $args{width};
+
+    if ($width > 32) {
+        # Generate at most 32 bits at once; Perl's rand() does not
+        # behave well with ranges that are too large.
+        my $lower = randint(%args, width => 32);
+        my $upper = randint(%args, width => $args{width} - 32);
+        # Use arithmetic rather than bitwise operators, since bitwise
+        # ops turn signed integers into unsigned.
+        return $upper * (1 << 32) + $lower;
+    } elsif ($width > 0) {
+        my $halfrange = 1 << ($width - 1);
+        my $value = int(rand(2 * $halfrange));
+        $value -= $halfrange if defined $args{signed} && $args{signed};
+        return $value;
+    } else {
+        return 0;
+    }
 }
 
 # Progress bar implementation
-- 
2.20.1


