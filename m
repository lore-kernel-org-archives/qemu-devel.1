Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4608C2BBC7
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F56E2051A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gISqeKjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F56E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNKtz-0006vv-OW
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 14:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNKsu-00064v-Lt
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNKst-0003Of-Lv
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNKst-0003OE-Ft
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id v8so7063717wma.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cpLtHaTY+G/TD4kqalXzNVJElnY3acdoI1jKCfsmqWw=;
 b=gISqeKjpJggBy2pSD4148Z7KxiSHHhXr06aemZPoK0c+IQ8N+uWAVFox3PBfOeAObf
 YH3IWXq28Vd8uQUuaW67Hjtf1K9ZDc8qgzYQ9rZ7K/JXhotmoP9xx/u8MuNaX62SdeXM
 7I/9X52YHq8B3vBZmWWaTec91KwvC5Y+K9D8uq6Q+M980h/ONnHCha6va4fB9erj3n13
 7vw7uhBvBTcG2fTIyDmYZ0g51E6gwRvGGQrzSG7fYSNRp9le2lWJ7Kwv+Hb0qUlfMZsF
 6Z33JvpQyP51GjclL49LNAaknW38WvNIr1CJLDkLEhDeBoZp0w91ujx5He0+JDQmmN6u
 V/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cpLtHaTY+G/TD4kqalXzNVJElnY3acdoI1jKCfsmqWw=;
 b=I4umPSCelNWD9aqhoE6qJOgwQOQFZt3csLLj24j5pKNA2kvFfRvwBdyfZkNbM3O23l
 KB6tlQ6gnWOpb3lRsLnQWc+ozZyXo6KuCMahNrC+Wvyd7g0FgdStipsa75KkiBXGUpL+
 D+kthRXT4trrpxXO0zBc+qBEZ00UC9slIcr9i4BCoYZtSGz99ayKjs4wkq0RSCAe8Ai2
 m+GKJrKkD0H2SsggkNzpunlUrDqr99wFSPZ9A+HUFQpQJzQPZ6xr0tw5cFdNdlNqjv1b
 OHRY4myI/HTJ6uX5T6zL4KLlaMssszHCPByX5NihbjlzRuuuwHavcxK6Yq7rW2j4X3be
 TduQ==
X-Gm-Message-State: AGi0PuaFyZMsZibsYZNDZrTGH8eyq0+Pg7AsonA8vgdXSHgB5zymDox+
 DQeJryIFW2sxcxMc6B10D88No1uDrhvyYw==
X-Google-Smtp-Source: APiQypIiDRNqiGiMXXdgsMDqhRzJN4SqLGl21C7+eZnR1LusBqTFKdaqxrsKXLG214Fu6khcABDsiQ==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr2014125wma.66.1586629778214; 
 Sat, 11 Apr 2020 11:29:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 68sm8910939wrm.65.2020.04.11.11.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 11:29:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0? 2/3] scripts/kernel-doc: Add missing close-paren in
 c:function directives
Date: Sat, 11 Apr 2020 19:29:33 +0100
Message-Id: <20200411182934.28678-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411182934.28678-1-peter.maydell@linaro.org>
References: <20200411182934.28678-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

When kernel-doc generates a 'c:function' directive for a function
one of whose arguments is a function pointer, it fails to print
the close-paren after the argument list of the function pointer
argument, for instance:
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


