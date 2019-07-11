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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F8C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B637C20645
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrSWGET7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhdE-00014U-89
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhd2-0000cp-2i
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhcy-0003nU-8F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:25 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhcv-0003fq-S6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:22 -0400
Received: by mail-yb1-xb42.google.com with SMTP id s41so470756ybe.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ctqvTfqT7Ubb65t8HNXXqwuoSxzAReasBqWUr5W5NVg=;
 b=HrSWGET7uicruYcsffXuHfwf16GGWd0kbNuXWtfsI6HSbMHQkNkyx1djVjYtKIZJFd
 9QDRfiUOPm57Yu//DxpecZHMcNyAGAeIt+l8+trJK5xaEd6yVbi6Mnfdv0Cx9Y22kFpL
 MJBC2GMm9zTxHavD3W3UhnlDS6U5TzpHCNmrk0qRlzpENJOCxZeHQunwy1QduqWHvm/E
 RECI6DoJ6090EFNzcSAGyXkkcQkYpPJZQItYA/GvWcdk0gFd4eDI3bWKA4OKpplmmGue
 /8L8nGSN5vP46cnEHHk19Ao/jnWkxMfzJeYejGKoOh4n0EoKR5LAN+jtNvB2t6VysNEn
 7Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ctqvTfqT7Ubb65t8HNXXqwuoSxzAReasBqWUr5W5NVg=;
 b=ME39qke8+bOs83GIMjhpphHKc6Vho14pyM0JrgovkZkh0Fc50+9gCa8q7RJQVoR176
 dFIy3HKTU1LeoLLbKNnwAaCDns27qNzSAft3Sny2PZ3cnfE635fYqonv+qNFhjAM215C
 PdXq2uYqEdmOZB8aS1hFHn5ZJrFnqQInzxMKjBnAdNomEjdDBddUB5UfcAcEEE+l4aZO
 VnprqDwf/oF/yn8+r3n+GCaExT9NKekCmSdhUV7QbvauTcPo+8EcPiaEoBThrXodnUqB
 Uhn24pDolEDJhok1Pw1E0/Yujbd9vmvxLSRDCeQhUkr4q+/DmQrN3cYizrNRzWuT33WL
 hP3g==
X-Gm-Message-State: APjAAAXF4H/Fp1FCQefcGHyMC4jXeE7ejbbZGulFGcjLxNwaPgBF0OOx
 rNVI9rmE1DKrYyu3xKEDhWbqYtSV
X-Google-Smtp-Source: APXvYqwYL36h+W7AMhM9WHtN6vkZ1jLwFAqx549FCtCqHbs1mIjLpxEA5hoK+EKygy8OLKeLsjun2w==
X-Received: by 2002:a25:aab2:: with SMTP id t47mr3903149ybi.342.1562884398745; 
 Thu, 11 Jul 2019 15:33:18 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:18 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:51 -0400
Message-Id: <20190711223300.6061-10-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU PATCH v3 09/18] risugen: add --xfeatures option
 for x86
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

The --xfeatures option is modelled after identically-named option to
RISU itself; it allows the user to specify which vector registers
should be initialized, so that the test image doesn't try to access
registers which may not be present at runtime. Note that it is still
the user's responsibility to filter out the test instructions using
these registers.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/risugen b/risugen
index 50920eb..76424e1 100755
--- a/risugen
+++ b/risugen
@@ -311,6 +311,9 @@ Valid options:
     --sve        : enable sve floating point
     --be         : generate instructions in Big-Endian byte order (ppc64 only).
     --x86_64     : generate 64-bit (rather than 32-bit) code. (x86 only)
+    --xfeatures {none|mmx|sse|avx} : what SIMD registers should be
+                   initialized. The initialization is cumulative,
+                   i.e. AVX includes both MMX and SSE. (x86 only)
     --help       : print this message
 EOT
 }
@@ -324,6 +327,7 @@ sub main()
     my $sve_enabled = 0;
     my $big_endian = 0;
     my $is_x86_64 = 0;
+    my $xfeatures = 'none';
     my ($infile, $outfile);
 
     GetOptions( "help" => sub { usage(); exit(0); },
@@ -342,6 +346,14 @@ sub main()
                 "no-fp" => sub { $fp_enabled = 0; },
                 "sve" => sub { $sve_enabled = 1; },
                 "x86_64" => sub { $is_x86_64 = 1; },
+                "xfeatures=s" => sub {
+                    $xfeatures = $_[1];
+                    die "value for xfeatures must be one of 'none', 'mmx', 'sse', 'avx' (got '$xfeatures')\n"
+                        unless ($xfeatures eq 'none'
+                                || $xfeatures eq 'mmx'
+                                || $xfeatures eq 'sse'
+                                || $xfeatures eq 'avx');
+                },
         ) or return 1;
     # allow "--pattern re,re" and "--pattern re --pattern re"
     @pattern_re = split(/,/,join(',',@pattern_re));
@@ -377,6 +389,7 @@ sub main()
         'subarch' => $full_arch[1] || '',
         'bigendian' => $big_endian,
         'x86_64' => $is_x86_64,
+        'xfeatures' => $xfeatures,
     );
 
     write_test_code(\%params);
-- 
2.20.1


