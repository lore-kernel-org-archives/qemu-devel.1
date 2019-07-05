Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F4DC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D662133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkGFfgrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D662133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUFu-0007Dn-EP
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55582)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEJ-0005Lo-PN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEI-00045h-QP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEI-00044v-JY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id v19so10720893wmj.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=2QJXgDdeciu+QM4e3C1K2WEVvDtyNAWGx3hRO2WruJ0=;
 b=CkGFfgrWkeR0F5/L12QMTojPnvYcn1XgG+NGFGw7TwxeU3f23UxO7GGrJh9n3UieAc
 YMLV8SKzEEgDGk3NZ6XPPQnLLbCLGeQgwqhdaiXs9rqRUWk5a1HC+10s54vn5vN8XO0/
 HnuVraVzo0RlFmkBxKhAI+E3MkU1aiX/swHsnm9F+cTweiQhXef5/o9r+ltDIIGZclET
 eM1T9XcC8ESpWORvPd/49patx2hrfEIpCc1K3cdXawhW9xScLq9RrcbTuWko7SQ5dpJt
 1gPYOSQojKupG5uhG+E3ZCpC7Dksen++Lwj+DOyghfbZzEJzvOrWZCOHKJNqUgC9CtCm
 bLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=2QJXgDdeciu+QM4e3C1K2WEVvDtyNAWGx3hRO2WruJ0=;
 b=Wu33JwVqxZV3LD8/NyGnwlt0VcAR7wl9/tKGw/0VhyhmQPZe4oD06J7k9uwmnF6NyA
 9iDI2WlX7BYZK9W8TGfVVy7cLK4bIj1EQfUn8Yl7LfIosbrw5BgxY8j8CHn1EJa5TS8X
 zfNwruNxY7+Y0aZQp+O9JRTyaUvI0ZjcilnCFzmhbCwtuIpauLjC3AGAPjxXopG9E7y9
 QzZ4Sww1ostfJ+sOgUHrBRDhGrD3y8I0Vhvakj2Yfi005VF3aZwWWzbOOJ6wkPo3lVzL
 5jkx2sNviEFP3trcD95IP/qPpi44LkbyPRFO+oQVO9RMc30SZouNSEWMcVVDQKYgsj3d
 UOLA==
X-Gm-Message-State: APjAAAWGAE9NZVts6qzeDpNQeSh68HOapZntfAdG8s0nwSmF+MdNv4HP
 EYlpuY83tTAuSZZlMxpbhwkbQ8IuyLI=
X-Google-Smtp-Source: APXvYqzWdlsqdj+6q4vWtPe1t8sXQw/xpmWrEkuSyfn8oIhF3fPC6LlPE3Y5vovo77AYKtRKMZDFzw==
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr4681860wme.43.1562356245333; 
 Fri, 05 Jul 2019 12:50:45 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:29 +0200
Message-Id: <1562356239-19391-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 02/12] checkpatch: do not warn for multiline
 parenthesized returned value
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

While indeed we do not want to have

    return (a);

it is less clear that this applies to

    return (a &&
            b);

Some editors indent more nicely if you have parentheses, and some people's
eyes may appreciate that as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1561116534-21814-1-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c2aaf42..2f81371 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2296,7 +2296,8 @@ sub process {
 			       $value =~ s/\([^\(\)]*\)/1/) {
 			}
 #print "value<$value>\n";
-			if ($value =~ /^\s*(?:$Ident|-?$Constant)\s*$/) {
+			if ($value =~ /^\s*(?:$Ident|-?$Constant)\s*$/ &&
+			    $line =~ /;$/) {
 				ERROR("return is not a function, parentheses are not required\n" . $herecurr);
 
 			} elsif ($spacing !~ /\s+/) {
-- 
1.8.3.1



