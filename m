Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223EDC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE960206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjQ6P6C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE960206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOV5-0000y3-UX
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOP-0005HI-2a
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOJ-0007D6-9J
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOJ-0007Co-3g
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h26so3664388wrb.7
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CT6aAVcPUz2WZ3lRhtbSp2EjDloFUvZAespPdqcpC9E=;
 b=HjQ6P6C4yF4NvN7JhraDlJHbmOouFej0kqSeTCysuSkPPIAodUe+opKqEXLf7d/uAM
 2M7mGudwijJGz4nh8k693y61Cvmt3fMk1cOsSHPl1UqwAFwZrf1IPLbOSVYKXKMC+aEr
 iO8Euh4aKpE/YtyBzKTBAHcxMPHk1BwL0fIJguzsG9PpZfDc/kPahwEK9HbVF6QzgMuV
 jwoDYz8yyesPd/Hy0fHOxiYN6z+jg3FrGqA286wXE9pGvxqbJnpJih7MD1tOXmk4LMcb
 E04EEv41YlhjN0X8gZmKk9jmdIupAXKpG0xffdD8V+31+WH6q0rQVW+/jC51eY9ueDQw
 Y0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CT6aAVcPUz2WZ3lRhtbSp2EjDloFUvZAespPdqcpC9E=;
 b=oFnW00WIO6XTN3aeEJdN0XxuD9BAa9HsphDjJFY+ywj5cMJAjhJlGOBWeibfNwjm/O
 VTI3lkZ7shoC7ouvR/5j4o8Ek26yNEzSHv9esOJUW2TXm0bk4eo3CKrYgkNEpOeD/cTv
 /tQNuhJtn9Kc9kizSkiUAZxXZfrVMmLrgVUP4vkhSovMpZ1fibZC26E8VLNOVbNybnjE
 EF4zwLpIo4FEBIr7630+xnCZ1eGR10Y5RxyoxHUxJBjLXVgh2Evwc4gqqS8iVLrYpPe+
 6bJU8VXgVP/KtXAvMxV6lcP9CHrgCplE/6bXE/MqtdIiqFpMMCYK1QLIDBeswc5sSiFc
 kp2Q==
X-Gm-Message-State: AGi0PuYXD40x8p24psZ9hMggpSre+t0j6iRpoRUbMG+LW79XWSb11VJc
 2IBrZuOL7KYgh8/rAlkO3UFCMceMvmq1zQ==
X-Google-Smtp-Source: APiQypKG3C43RgNJcUN6r2R1h71f+0t8LnipJIHurLzluICiHimSkVNKstqNgTRbP9q6TIunNeH7sQ==
X-Received: by 2002:adf:e691:: with SMTP id r17mr24723255wrm.421.1586881585571; 
 Tue, 14 Apr 2020 09:26:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] scripts/kernel-doc: Add missing close-paren in
 c:function directives
Date: Tue, 14 Apr 2020 17:26:10 +0100
Message-Id: <20200414162613.4479-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

When kernel-doc generates a 'c:function' directive for a function
one of whose arguments is a function pointer, it fails to print
the close-paren after the argument list of the function pointer
argument, for instance in the memory API documentation:
  .. c:function:: void memory_region_init_resizeable_ram (MemoryRegion * mr, struct Object * owner, const char * name, uint64_t size, uint64_t max_size, void (*resized) (const char*, uint64_t length, void *host, Error ** errp)

which should have a ')' after the 'void *host' which is the
last argument to 'resized'.

Older versions of Sphinx don't try to parse the argumnet
to c:function, but Sphinx 3.0 does do this and will complain:

  /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/exec/memory.h:834: WARNING: Error in declarator or parameters
  Invalid C declaration: Expecting "," or ")" in parameters, got "EOF". [error at 208]
    void memory_region_init_resizeable_ram (MemoryRegion * mr, struct Object * owner, const char * name, uint64_t size, uint64_t max_size, void (*resized) (const char*, uint64_t length, void *host, Error ** errp)
    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------^

Add the missing close-paren.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200411182934.28678-3-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index af470eb3211..8dc30e01e58 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -853,7 +853,7 @@ sub output_function_rst(%) {
 
 	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
 	    # pointer-to-function
-	    print $1 . $parameter . ") (" . $2;
+	    print $1 . $parameter . ") (" . $2 . ")";
 	} else {
 	    print $type . " " . $parameter;
 	}
-- 
2.20.1


