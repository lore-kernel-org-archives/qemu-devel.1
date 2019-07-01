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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A512C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC84208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW8Krlrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC84208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hho7x-0001ei-Fk
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56611)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2n-0004tE-MU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2m-0004Tu-H2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:57 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:37617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2m-0004TY-C6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:56 -0400
Received: by mail-yb1-xb42.google.com with SMTP id l22so3629246ybf.4
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=liyGMfmhycaZ3/V3dGPSjjHCU+qnWveeLZ45quM65dU=;
 b=AW8Krlrm9cwM40wtC/fhxqMgCOxlAIAJV7GOu3ZOkLkJyaRgxOdygv+yLyplgnzjJk
 sm1AFgR+DKzamouOn6edeQjnMGWVF4DQmZrvYoWbiKXtyWrA3T85Hy4M2rWRD2fQeAXX
 e2t+JSQMii/j1TN0m6gXCV+hmXH5vSXom3kLpWuq7rZu6AWcd/yapqDgdzBfxc3UQbbu
 0gttVwyC5ydVGedX3TsH0wYcovwE0IQKXD3MM/sGWmMR+4zOmerhAhXyi0j0cFMR9v9/
 1ktxcICC8oeCUa8q7Cqm3hPLBuZJA2Rsi0wjaqStEGAFRNmr1Pf/TkDttOOxM5x3G5VW
 6BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=liyGMfmhycaZ3/V3dGPSjjHCU+qnWveeLZ45quM65dU=;
 b=H8Anx4QpZ5663oYw29PFKiJgLkniYIkhgNx/dwukycq00Dc7FwSntXlU3QrIyXP6r7
 eD1K1inbLdJ9AG7XNY/kL9gDByUxVvLwmsbfVdO6v74fMLsBs3s83B6A8Hw3ou3qXLUP
 JSGXiKk2ktqt9vNXhRgizkm1vULA3A6GLdADOF0U/PnQnYMDZjNzn0Cyp1AGwuAl2NQG
 mvDNA2chuEhpk68nSxz3z8pPZDlTAl/st4aVBKUmN5pQNyPtDSkBEDOPoPFQ21EshXp5
 Mk6+R9FLKrnTLEXUOhg8Y+3l0ofgfLGEJU+dEMnrlFChOXdwSEKeWbGZIoNzGIFyxamD
 e/MQ==
X-Gm-Message-State: APjAAAV4ZtmqCo6Am9v9plXnoHLFPipHsLudDKMINNr/01CAa1sKk8yx
 21Tbzn0cPsbGVjzFcoaRxNll853Z
X-Google-Smtp-Source: APXvYqzDIUYPTSC0Jt3PQFx7dqDr/C/2oCHyL42kGXdGB9tQzioCj/guBZp9a5BDlO5cadi0/j4DmA==
X-Received: by 2002:a25:aab0:: with SMTP id t45mr14038514ybi.201.1561955755659; 
 Sun, 30 Jun 2019 21:35:55 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.35.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:35:55 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:23 -0400
Message-Id: <20190701043536.26019-2-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU RFC PATCH v2 01/14] risugen_common: add insnv,
 randint_constr, rand_fill
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

Add three common utility functions:

- insnv allows emitting variable-length instructions in little-endian
  or big-endian byte order; it subsumes functionality of former
  insn16() and insn32() functions.

- randint_constr allows generating random integers according to
  several constraints passed as arguments.

- rand_fill uses randint_constr to fill a given hash with
  (optionally constrained) random values.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen_common.pm | 107 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/risugen_common.pm b/risugen_common.pm
index 71ee996..c5d861e 100644
--- a/risugen_common.pm
+++ b/risugen_common.pm
@@ -23,7 +23,8 @@ BEGIN {
     require Exporter;
 
     our @ISA = qw(Exporter);
-    our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16 $bytecount
+    our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16
+                   $bytecount insnv randint_constr rand_fill
                    progress_start progress_update progress_end
                    eval_with_fields is_pow_of_2 sextract ctz
                    dump_insn_details);
@@ -37,7 +38,7 @@ my $bigendian = 0;
 # (default is little endian, 0).
 sub set_endian
 {
-    $bigendian = @_;
+    ($bigendian) = @_;
 }
 
 sub open_bin
@@ -52,18 +53,112 @@ sub close_bin
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
+    my $bitcur = 0;
+    my $bitend = 8 * $args{len};
+    while ($bitcur < $bitend) {
+        my $format;
+        my $bitlen;
+
+        if ($bitcur + 64 <= $bitend) {
+            $format = "Q";
+            $bitlen = 64;
+        } elsif ($bitcur + 32 <= $bitend) {
+            $format = "L";
+            $bitlen = 32;
+        } elsif ($bitcur + 16 <= $bitend) {
+            $format = "S";
+            $bitlen = 16;
+        } else {
+            $format = "C";
+            $bitlen = 8;
+        }
+
+        $format .= ($args{bigendian} ? ">" : "<") if $bitlen > 8;
+
+        my $bitmask = (1 << $bitlen) - 1;
+        my $value = $args{value} >> ($args{bigendian}
+                                     ? $bitend - $bitcur - $bitlen
+                                     : $bitcur);
+
+        print BIN pack($format, $value & $bitmask);
+        $bytecount += $bitlen / 8;
+
+        $bitcur += $bitlen;
+    }
+}
+
 sub insn32($)
 {
     my ($insn) = @_;
-    print BIN pack($bigendian ? "N" : "V", $insn);
-    $bytecount += 4;
+    insnv(value => $insn, len => 4, bigendian => $bigendian);
 }
 
 sub insn16($)
 {
     my ($insn) = @_;
-    print BIN pack($bigendian ? "n" : "v", $insn);
-    $bytecount += 2;
+    insnv(value => $insn, len => 2, bigendian => $bigendian);
+}
+
+sub randint_constr(%)
+{
+    my (%args) = @_;
+    my $bitlen = $args{bitlen};
+    my $halfrange = 1 << ($bitlen - 1);
+
+    while (1) {
+        my $value = int(rand(2 * $halfrange));
+        $value -= $halfrange if defined $args{signed} && $args{signed};
+        $value &= ~$args{fixedbitmask} if defined $args{fixedbitmask};
+        $value |= $args{fixedbits} if defined $args{fixedbits};
+
+        if (defined $args{constraint}) {
+            # The idea is: if the most significant bit of
+            # $args{constraint} is zero, $args{constraint} is the
+            # value we want to return; if the most significant bit is
+            # one, ~$args{constraint} (its bit inversion) is the value
+            # we want to *avoid*, so we try again.
+
+            if (!($args{constraint} >> 63)) {
+                $value = $args{constraint};
+            } elsif ($value == ~$args{constraint}) {
+                next;
+            }
+        }
+
+        return $value;
+    }
+}
+
+sub rand_fill($$)
+{
+    my ($target, $constraints) = @_;
+
+    for (keys %{$target}) {
+        my %args = (bitlen => $target->{$_}{bitlen});
+
+        $args{fixedbits} = $target->{$_}{fixedbits}
+            if defined $target->{$_}{fixedbits};
+        $args{fixedbitmask} = $target->{$_}{fixedbitmask}
+            if defined $target->{$_}{fixedbitmask};
+        $args{signed} = $target->{$_}{signed}
+            if defined $target->{$_}{signed};
+
+        $args{constraint} = $constraints->{$_}
+            if defined $constraints->{$_};
+
+        $target->{$_} = randint_constr(%args);
+    }
+
+    return $target;
 }
 
 # Progress bar implementation
-- 
2.20.1


