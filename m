Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97974C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662E82145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUIUjWob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662E82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIZo-0004NA-1x
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60102)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYk-0000IG-81
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYi-0003MC-MP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYi-0003Jh-D7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id v19so17670155wmj.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=KIJAmLbllmYJ3+/5atxAnv6JwBGCasb1tyGUjSZJRAI=;
 b=WUIUjWobFWPjdMXAG844rOO9ELRCyAlMZbq2nq2qN4/NtmCl/pVVP6HQ2xWi48FvaY
 87mgputi8vcvt15JtSVQdNObZtjFBNBob+tjmJMg2WGeghrQ2TDutgYT9UdeYiS9xwfj
 MEXub1Sr/NUfTXwWZCZlpjNrZRXAlK6RXst4KkLZulFnZ6QWVNAYaEd6zZyDm9jWD/BF
 S40kB32h96R5D5bV/ToI/iWGdQADcMr17Hs67ZlEcqAYvy++INOljNZUPlaEsi087qUC
 uSjOl8FWG8bLBxkdf718tQH7uljfKUWAVVwLOLe4Imsl5tdz5W/9R5jxCbDww6aZgZgq
 5s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=KIJAmLbllmYJ3+/5atxAnv6JwBGCasb1tyGUjSZJRAI=;
 b=rDb8Ci6Qb0ocT2ZvpVrLzVcUBCXTBImPryutQ4fbMh3s2rKs9Qqj+2Ml9l9UfJuTQ0
 5S0xJ5a6aHMFDNP5s0Afqm2eXm2Vya9IrCcbuLUbHD3img0rH8mVg9Vmo3EuWZqAvHk/
 Xo5XJz9R0RnPRKoGejUqxb3QsyIdUIbUFnwunPBWSIwSkDNAezxi0jSfeG3q3jRXbnSS
 LsqHCLe45Sn/IlUu00Yg7tJaNxH2JHG6r54A9zXyPsugsPb7ctue3EIgzdQln2hJCJsS
 N2kMDRI6+KPZAw3Kt2H9uQk42ZCXvfIUqtCZrT9dClI/omesfRN+XtOtLGboR77FXZ9M
 L5IQ==
X-Gm-Message-State: APjAAAUMZChlqIv2eOhZW2LIL1zduFqSNgyUgquFZFuSPYQtuf9bhVPx
 5Qvwagt7ekTdoi039/UmljsvUVlmVNw=
X-Google-Smtp-Source: APXvYqz4bqiP/CMEMBtqgqbGL1b5TlG1SKKmAlthyM5kmj6xKAR7/IEo6ld1aV8j90HntX7TD6iFOQ==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr29407803wmk.10.1563264693198; 
 Tue, 16 Jul 2019 01:11:33 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:11 +0200
Message-Id: <1563264677-39718-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 13/19] checkpatch: detect doubly-encoded UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copy and pasting from Thunderbird's "view source" window results in double
encoding of multibyte UTF-8 sequences.  The appearance of those sequences is
very peculiar, so detect it and give an error despite the (low) possibility
of false positives.

As the major offender, I am also adding the same check to my applypatch-msg
and commit-msg hooks, but this will also cause patchew to croak loudly when
this mistake happens.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1558099140-53240-1-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2f81371..d24c944 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -262,6 +262,19 @@ our $UTF8	= qr{
 	| $NON_ASCII_UTF8
 }x;
 
+# some readers default to ISO-8859-1 when showing email source. detect
+# when UTF-8 is incorrectly interpreted as ISO-8859-1 and reencoded back.
+# False positives are possible but very unlikely.
+our $UTF8_MOJIBAKE = qr{
+	\xC3[\x82-\x9F] \xC2[\x80-\xBF]                    # c2-df 80-bf
+	| \xC3\xA0 \xC2[\xA0-\xBF] \xC2[\x80-\xBF]         # e0 a0-bf 80-bf
+	| \xC3[\xA1-\xAC\xAE\xAF] (?: \xC2[\x80-\xBF]){2}  # e1-ec/ee/ef 80-bf 80-bf
+	| \xC3\xAD \xC2[\x80-\x9F] \xC2[\x80-\xBF]         # ed 80-9f 80-bf
+	| \xC3\xB0 \xC2[\x90-\xBF] (?: \xC2[\x80-\xBF]){2} # f0 90-bf 80-bf 80-bf
+	| \xC3[\xB1-\xB3] (?: \xC2[\x80-\xBF]){3}          # f1-f3 80-bf 80-bf 80-bf
+	| \xC3\xB4 \xC2[\x80-\x8F] (?: \xC2[\x80-\xBF]){2} # f4 80-b8 80-bf 80-bf
+}x;
+
 # There are still some false positives, but this catches most
 # common cases.
 our $typeTypedefs = qr{(?x:
@@ -1506,6 +1519,9 @@ sub process {
 			ERROR("Invalid UTF-8, patch and commit message should be encoded in UTF-8\n" . $hereptr);
 		}
 
+		if ($rawline =~ m/$UTF8_MOJIBAKE/) {
+			ERROR("Doubly-encoded UTF-8\n" . $herecurr);
+		}
 # Check if it's the start of a commit log
 # (not a header line and we haven't seen the patch filename)
 		if ($in_header_lines && $realfile =~ /^$/ &&
-- 
1.8.3.1



