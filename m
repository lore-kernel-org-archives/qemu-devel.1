Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F324DC2D0E7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10DF20772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaddUt6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10DF20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJa1I-0000vu-Rd
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyj-0004FR-G0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyi-0002As-Ed
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJZyi-0002Aa-8Z
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id 65so29784059wrl.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L6skE25jv77X3Ic3q30MQuACWpAXjktUtUIdWwwluKc=;
 b=qaddUt6gSnfHtUbqDT8fOIjsUNFsxdg2jY032MjTS8Zc3Fkzy+uCiHF7IUyOY9TT3P
 igJF8E+F/vNAOD5so1Q7I3sFuMjso/YvUBbU65qpg00cGmcXqGd1VIsAYOPZ53kxLa66
 Cd6sjMit8Hcqofi+3GCryuvhPk39ryUd1lipzLvF5qCy1GdMF7iPjHd9rkRKoUQonGff
 eRe8lUfhNphDBBQpUXM6Bsqh818DS9SNjBcdjs1JyC9Xa0eGsz9mrcBnzGvShrXSI4Hg
 Gxxh6ZsPcrAo6vDmJ7jTWLNtEMyWwLb8aCukw4rl7ZNRFbovcwSU6OBVQ5AJZuAH0D3N
 ++Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L6skE25jv77X3Ic3q30MQuACWpAXjktUtUIdWwwluKc=;
 b=tBDwtU53SV5LH9pNvl9htFCqMrONxelXQgy86LeBMif1zjbX6zBMWUhgoPP8Amf8na
 q6SnKcvyQsactUU5L3E+aNZLaH/FateBal+Eqaerj8QkJpS6/0wZtXzAyJXo9XG+YL5r
 Pace7b2+jy5BCASy2t0onTX+xqTMHZAKGyUqMVs4Muh4pMYzqaSPJJhaqLitpBcMP3vC
 dPJXMIE3QWd/bsI7+WuQXCxOmxmpMnyC1XfPsHkBtUJffZ+bLzK0UKO38ptNhbgJbGz8
 a2PT/SDocXMrjoAOok3zSqTpaK33sYIKNqnlBOs8tav0znd6R0bntmFoq1K3DEs/j3Up
 MH/Q==
X-Gm-Message-State: ANhLgQ1KoP9b3SARGrAZJz+EEGbnZWm9vDt+PUhEnQJ/dLgLI52WBtlO
 pqmG2oCvL3U7QYihZitRw/sXTQ==
X-Google-Smtp-Source: ADFU+vtQkvOfjACd8KkaSTd0VIWTUba0nb7zGH/a+DnZfcLlOiOf+zQ5meYxRi2t5lhVNzYa6uVRiw==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr11313672wrr.51.1585734487218; 
 Wed, 01 Apr 2020 02:48:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b82sm1073589wme.25.2020.04.01.02.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 02:48:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 933431FF90;
 Wed,  1 Apr 2020 10:48:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 04/10] linux-user: more debug for init_guest_space
Date: Wed,  1 Apr 2020 10:47:53 +0100
Message-Id: <20200401094759.5835-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401094759.5835-1-alex.bennee@linaro.org>
References: <20200401094759.5835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Searching for memory space can cause problems so lets extend the
CPU_LOG_PAGE output so you can watch init_guest_space fail to
allocate memory. A more involved fix is actually required to make this
function play nicely with the large guard pages the sanitiser likes to
use.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8198be04460..619c054cc48 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2172,6 +2172,8 @@ unsigned long init_guest_space(unsigned long host_start,
 
         /* Check to see if the address is valid.  */
         if (host_start && real_start != current_start) {
+            qemu_log_mask(CPU_LOG_PAGE, "invalid %lx && %lx != %lx\n",
+                          host_start, real_start, current_start);
             goto try_again;
         }
 
@@ -2240,7 +2242,11 @@ unsigned long init_guest_space(unsigned long host_start,
          * probably a bad strategy if not, which means we got here
          * because of trouble with ARM commpage setup.
          */
-        munmap((void *)real_start, real_size);
+        if (munmap((void *)real_start, real_size) != 0) {
+            error_report("%s: failed to unmap %lx:%lx (%s)", __func__,
+                         real_start, real_size, strerror(errno));
+            abort();
+        }
         current_start += align;
         if (host_start == current_start) {
             /* Theoretically possible if host doesn't have any suitably
-- 
2.20.1


