Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164D0C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D794C2070C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm0R3BqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D794C2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hutda-00075k-4W
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 03:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutcl-0005sb-7v
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutck-0002Fq-CZ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hutck-0002FD-6Z
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so12165798wru.10
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nzam9gYUF60MRs/2JS9aPYlPKRjnWzxCy94vlOEn3tw=;
 b=Pm0R3BqRKOySZUrZsvVy6cp5kC6cLZtY6s7Xph81K1pNQ6VES8+tWuCSkmrH7ZKA/S
 jTAB7UXFWQc+Z9sYAZxbIjZRM3ESGEYYja8Qd4UgtYK/s+WCzVttSFw6FWXXuoeXG7Mh
 ISeAgP+pIc40O/lWwC+jwV4rh5IPl3684uVlQtMi+PI8mJ0Ob0olLtp3SYIf2DPc7JSJ
 XScvnXhy7mCML3gGFFMFUrUqRHwemnpRz9CPqpD2m9ZqMb9xFe2M5WB6DObnjRQRhzI1
 f8ZEAUqxNJ+0rdA5yufxOk9oy79ViJckRO9+a2BLkwJeW6hPoLXRsTP1uNqnocI41H2R
 wpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nzam9gYUF60MRs/2JS9aPYlPKRjnWzxCy94vlOEn3tw=;
 b=WUqL3gnTVgUfu9TopCaKwR04Fn8tCLHDqxmTsReH1fXRot4aeGYydjITN/T7iKdEKg
 Pau/NqObIP4Pw7/Z/bC9TLrgLnetnUjL9SaI72BOn1j1Abi6bx+MxR50KSJ8LM7X+BUX
 ZfRjY3r9ic0Zzj3F/qhwaasL3WuTnVqJA/TFlc6NMHj609A+yMq1/7bhK6iKcmF7jQ4D
 ZQK4ga66olhAj8/lXkOez0HCK9jKuQmEd5ms2lFZQpcJuQmv7EVRReQP2qDvV6m4CAPJ
 61SYOPqmzJV/VVT+MSzOsW6Z0IWK7YBNadmSewmX55WuTPmryH4bErGbYE1oixm8IlFf
 KK7Q==
X-Gm-Message-State: APjAAAVBaIX761iz9pSRmM+7Cz0XQSofArPoChRKTV1HXYGkzuMDPSk8
 uruHlWCeeA8OVmJQpFyO9uQhCKOB
X-Google-Smtp-Source: APXvYqyq0ha7QOPPcJuAOs8YdWnKWqvpmCInwiV151T3/g2rdRznRe53Z+HfR4pdzn6uFzqH6NEcgg==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr2759267wrw.15.1565075468989;
 Tue, 06 Aug 2019 00:11:08 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id z6sm74944037wrw.2.2019.08.06.00.11.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 00:11:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 09:11:04 +0200
Message-Id: <1565075466-14943-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565075466-14943-1-git-send-email-pbonzini@redhat.com>
References: <1565075466-14943-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 1/3] module: use g_hash_table_add()
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The hashtable is used like a set, use the convenience
g_hash_table_add() function.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/module.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/util/module.c b/util/module.c
index 142db7e..ca9885c 100644
--- a/util/module.c
+++ b/util/module.c
@@ -179,11 +179,10 @@ void module_load_one(const char *prefix, const char *lib_name)
 
     module_name = g_strdup_printf("%s%s", prefix, lib_name);
 
-    if (g_hash_table_lookup(loaded_modules, module_name)) {
+    if (!g_hash_table_add(loaded_modules, module_name)) {
         g_free(module_name);
         return;
     }
-    g_hash_table_insert(loaded_modules, module_name, module_name);
 
     exec_dir = qemu_get_exec_dir();
     search_dir = getenv("QEMU_MODULE_DIR");
-- 
1.8.3.1



