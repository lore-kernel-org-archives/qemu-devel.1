Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3325C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFFF2051A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMys+IwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFFF2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNKxY-00018Q-Rj
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 14:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNKsv-000658-KU
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNKsu-0003PG-Hl
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNKsu-0003Oo-Br
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id f13so5759904wrm.13
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CRIV+Q39jqb8M8RfkaJ8QOUQyFaSY22+KDzJSczZeRM=;
 b=lMys+IwJxhrC+8ZIvO+0LQ4mvYqexwpWYwlJYuD70iAq/cg7iCz2oJrQLZ9XSt6Nc5
 31BY+UGiDujpQ2Chnp6YHtbNhgcZcEYU/5sBSDx44tnphuZPT6K+2RsZU9pDXJFQRg9G
 DD4RIxceu/bbqZF2AHFhSSOXZ8ydpY0vfN7oo0vfnrdW2ZcYKV14TPlMLnzWv7Jf0sAf
 0cKBvhuMaWst74NHy2HLZCCoM/qK4GkMMal0kseTi5wYmKducwTMMBPfwviesB3a2687
 dayjWZUe9FHCheCGTHntuCuFcPAYPnWnijIP8UaDBPRPmXbhBBsQPLDEMaRWHRpiMxlH
 Y6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CRIV+Q39jqb8M8RfkaJ8QOUQyFaSY22+KDzJSczZeRM=;
 b=PO+8thH9R4hAcCsuYGZ7n54Qk506oGFpx1OvgAYW4udIr9bnwHZOaqUuBrAw1ucAPz
 t9+WVAwJJIogtFbWbBkZS2dICSXE0OIym9irXDbEdM2ypJTYzORhpIL2qqFlH2llqjXR
 pEtpwAyuLaQl7Wn64WrfkfeV2yDar9LnsFRWx51UZXRCYKR4+aMt9Kpy1N2H9QdbqiNQ
 sRQVlgFNddzDLc7bYwVpKnrLH6crYTDv3B+wxQItUnvuJRRPRQo3FmhpWlHgm29RuREH
 Nm3/nk7QNubA/er41MtmTcKbBandmAckt2qRj9npQO+Ymhyuj+pWrOm7MojOSNDZ14WM
 LmyA==
X-Gm-Message-State: AGi0PuYteW706U085Y544uwl6/sSX5JexurLfyF07fs9H6fXOFPR43Xa
 pO13sQxGeil4Erj4p2DAM8fAo3zyIwj9IQ==
X-Google-Smtp-Source: APiQypIGoQJMif1oQv2gaa57GdIrEaP9MnadTHStUMu7JLcCjiWU0bbd/d7llGjOP021bITS3yrZ1w==
X-Received: by 2002:a05:6000:110a:: with SMTP id
 z10mr7458968wrw.389.1586629779066; 
 Sat, 11 Apr 2020 11:29:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 68sm8910939wrm.65.2020.04.11.11.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 11:29:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0? 3/3] kernel-doc: Use c:struct for Sphinx 3.0 and later
Date: Sat, 11 Apr 2020 19:29:34 +0100
Message-Id: <20200411182934.28678-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411182934.28678-1-peter.maydell@linaro.org>
References: <20200411182934.28678-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel-doc Sphinx plugin and associated script currently emit
'c:type' directives for "struct foo" documentation.

Sphinx 3.0 warns about this:
  /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/exec/memory.h:3: WARNING: Type must be either just a name or a typedef-like declaration.
  If just a name:
    Error in declarator or parameters
    Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
      struct MemoryListener
      ------^
  If typedef-like declaration:
    Error in declarator or parameters
    Invalid C declaration: Expected identifier in nested name. [error at 21]
      struct MemoryListener
      ---------------------^

because it wants us to use the new-in-3.0 'c:struct' instead.

Plumb the Sphinx version through to the kernel-doc script
and use it to select 'c:struct' for newer versions than 3.0.

Fixes: LP:1872113
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/sphinx/kerneldoc.py |  1 +
 scripts/kernel-doc       | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 1159405cb92..3e879402064 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -99,6 +99,7 @@ class KernelDocDirective(Directive):
                 env.note_dependency(os.path.abspath(f))
                 cmd += ['-export-file', f]
 
+        cmd += ['-sphinx-version', sphinx.__version__]
         cmd += [filename]
 
         try:
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 8dc30e01e58..030b5c8691f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -71,6 +71,8 @@ Output selection (mutually exclusive):
 			DOC: sections. May be specified multiple times.
 
 Output selection modifiers:
+  -sphinx-version VER   Generate rST syntax for the specified Sphinx version.
+                        Only works with reStructuredTextFormat.
   -no-doc-sections	Do not output DOC: sections.
   -enable-lineno        Enable output of #define LINENO lines. Only works with
                         reStructuredText format.
@@ -286,6 +288,7 @@ use constant {
 };
 my $output_selection = OUTPUT_ALL;
 my $show_not_found = 0;	# No longer used
+my $sphinx_version = "0.0"; # if not specified, assume old
 
 my @export_file_list;
 
@@ -436,6 +439,8 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	    $enable_lineno = 1;
     } elsif ($cmd eq 'show-not-found') {
 	$show_not_found = 1;  # A no-op but don't fail
+    } elsif ($cmd eq 'sphinx-version') {
+        $sphinx_version = shift @ARGV;
     } else {
 	# Unknown argument
         usage();
@@ -963,7 +968,16 @@ sub output_struct_rst(%) {
     my $oldprefix = $lineprefix;
     my $name = $args{'type'} . " " . $args{'struct'};
 
-    print "\n\n.. c:type:: " . $name . "\n\n";
+    # Sphinx 3.0 and up will emit warnings for "c:type:: struct Foo".
+    # It wants to see "c:struct:: Foo" (and will add the word 'struct' in
+    # the rendered output).
+    if ((split(/\./, $sphinx_version))[0] >= 3) {
+        my $sname = $name;
+        $sname =~ s/^struct //;
+        print "\n\n.. c:struct:: " . $sname . "\n\n";
+    } else {
+        print "\n\n.. c:type:: " . $name . "\n\n";
+    }
     print_lineno($declaration_start_line);
     $lineprefix = "   ";
     output_highlight_rst($args{'purpose'});
-- 
2.20.1


