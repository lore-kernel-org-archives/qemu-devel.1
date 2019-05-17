Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B3DC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56AE020833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AE020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRcmP-0001Ir-Kv
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:20:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRcla-00011u-OR
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRclZ-0000vf-O1
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hRclX-0000lV-Qu
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:19:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 970763DBC5;
	Fri, 17 May 2019 13:19:03 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 92DD37C0AC;
	Fri, 17 May 2019 13:19:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 15:19:00 +0200
Message-Id: <1558099140-53240-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 17 May 2019 13:19:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] checkpatch: detect doubly-encoded UTF-8
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
Cc: peter.maydell@linaro.org
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
---
 scripts/checkpatch.pl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88682cb..b27e1de 100755
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


