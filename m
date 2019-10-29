Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFB0CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192F920717
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXsY0Hhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192F920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUIc-0004Pr-Oh
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 12:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGl-00021M-95
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGi-0004qb-W4
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iPUGi-0004ps-PF
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so3079289wms.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GITb2fVxR4h7bhXASG9JI0LI0GYSIzOlpGLPA3IIb7s=;
 b=jXsY0HhufsYULXbU62RmeyPN/p7asApD9MExBHme1qh6fpYeqW6e6SNf+pJqMt3EgW
 NL1s0Zhf6Gzi1cD/SfyFtAwSb14IrrZnbHpSA437Hdj3lnbCfzun0lgFSy2jWo7bAsYP
 e0QJqbD5h1US5hf32Tf0/we7eRoZyKwMD0Yfyns1oQqIV2A7NsodgTMRCUKoQZsUDH0U
 7Gn6ZvZayHU/xcrPgXJUsjcWeSqGfcy8pWLOAOh1jMH6nDGZumQc6xgw9lkfMgZzJWlw
 Yt2kh5ESOP7ZXoX1tIpB5BWEpGL69Mi5mOZlZejFc+iDiAQCxP6x5u84//m/Cws5+da0
 xZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GITb2fVxR4h7bhXASG9JI0LI0GYSIzOlpGLPA3IIb7s=;
 b=XCkfUcTATtqC0pqiog4NyFKCDua8ppyhkic1NzIiOkVIbQDL/4cyzmBQ+pUNAMiYSz
 tWYzJCtG/yBq0mKNb172Q8PdFaYKdW8RcVmLZJT4WJWus57ijg0ZBsXJNFbWIrqtrGnc
 Ft2KTJ5Vg4FAz2HoTzCxH3aHt4XDzy1cUZHkZOZzSi93SNMCRj5r69JgZQXKIqMK1yCP
 YyZvc9K0KXP4xcbZ/8LMupUyUzjGIAVA2tYRNIJVDByDncJhpeV+UZajDA72stAuYVZV
 9FxngTWc6vegyOB6Nbl1xKbEPLquuh36nMeqXI3LkBQwLrj3PvJfmvXha2/lTqWbpOnO
 Pf+g==
X-Gm-Message-State: APjAAAVHAeG3pPWnQZlLjg6lc1tXUktk7cSFVhAvoDoGEpfGo9FUOgem
 sY74K2GIs+/V9I3RDvbARNFL/Z4cp7c=
X-Google-Smtp-Source: APXvYqyhpATNDrQxDDPQfyYAURZeM/pYbJmJo8xOR1VRrWDY5RyQf1dUFkP4yfILCgWosHnGULcIIA==
X-Received: by 2002:a1c:7f54:: with SMTP id a81mr4984392wmd.48.1572366171324; 
 Tue, 29 Oct 2019 09:22:51 -0700 (PDT)
Received: from donizetti.metropole.lan (94.222.26.109.rev.sfr.net.
 [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id q12sm9285661wrw.91.2019.10.29.09.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 09:22:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] docs: tweak kernel-doc for QEMU coding standards
Date: Tue, 29 Oct 2019 17:22:44 +0100
Message-Id: <20191029162248.13383-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029162248.13383-1-pbonzini@redhat.com>
References: <20191029162248.13383-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Surprisingly, QEMU does have a pretty consistent doc comment style and
it is not very different from the Linux kernel's.  Of the documentation
"sigils", only "#" separates the QEMU doc comment style from Linux's,
and it has 200+ instances vs. 6 for the kernel's '&struct foo' (all in
accel/tcg/translate-all.c), so it's clear that the two standards are
different in this respect.  In addition, our structs are typedefed and
recognized by CamelCase names.

Adjust kernel-doc's parser for these two aspects of the QEMU coding
standards.  The patch has been valid, with hardly any change, for over
two years, so it should not be an issue to keep kernel-doc in sync with
the Linux copy.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kernel-doc | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 81dc91760b..af470eb321 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -215,12 +215,12 @@ my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
 my $type_env = '(\$\w+)';
-my $type_enum = '\&(enum\s*([_\w]+))';
-my $type_struct = '\&(struct\s*([_\w]+))';
-my $type_typedef = '\&(typedef\s*([_\w]+))';
-my $type_union = '\&(union\s*([_\w]+))';
-my $type_member = '\&([_\w]+)(\.|->)([_\w]+)';
-my $type_fallback = '\&([_\w]+)';
+my $type_enum = '#(enum\s*([_\w]+))';
+my $type_struct = '#(struct\s*([_\w]+))';
+my $type_typedef = '#(([A-Z][_\w]*))';
+my $type_union = '#(union\s*([_\w]+))';
+my $type_member = '#([_\w]+)(\.|->)([_\w]+)';
+my $type_fallback = '(?!)';    # this never matches
 my $type_member_func = $type_member . '\(\)';
 
 # Output conversion substitutions.
@@ -1050,6 +1050,14 @@ sub output_blockhead {
 sub dump_declaration($$) {
     no strict 'refs';
     my ($prototype, $file) = @_;
+    if ($decl_type eq 'type name') {
+       if ($prototype =~ /^(enum|struct|union)\s+/) {
+	   $decl_type = $1;
+	} else {
+	   return;
+       }
+    }
+
     my $func = "dump_" . $decl_type;
     &$func(@_);
 }
@@ -1878,7 +1886,7 @@ sub process_name($$) {
     }
     elsif (/$doc_decl/o) {
 	$identifier = $1;
-	if (/\s*([\w\s]+?)(\(\))?\s*-/) {
+	if (/\s*([\w\s]+?)(\s*-|:)/) {
 	    $identifier = $1;
 	}
 
@@ -1888,7 +1896,7 @@ sub process_name($$) {
 	$contents = "";
 	$section = $section_default;
 	$new_start_line = $. + 1;
-	if (/-(.*)/) {
+	if (/[-:](.*)/) {
 	    # strip leading/trailing/multiple spaces
 	    $descr= $1;
 	    $descr =~ s/^\s*//;
@@ -1906,7 +1914,9 @@ sub process_name($$) {
 	    ++$warnings;
 	}
 
-	if ($identifier =~ m/^struct\b/) {
+	if ($identifier =~ m/^[A-Z]/) {
+	    $decl_type = 'type name';
+	} elsif ($identifier =~ m/^struct\b/) {
 	    $decl_type = 'struct';
 	} elsif ($identifier =~ m/^union\b/) {
 	    $decl_type = 'union';
-- 
2.21.0



