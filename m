Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F62C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428972176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWcy3rxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428972176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z8l-0001pW-Db
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlA-0001W1-Np
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl6-0000Ut-QJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:20 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl6-0000SN-Jk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:16 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y17so5563028wrn.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OyeHkVRk+pDFOc+EaKWT1incM6J5ShZ/3FLqVMsrNwk=;
 b=oWcy3rxTIKuEwInvJvYxNg5QJuqjUVCnXLFAui6zj5t9nDcULsaW7Gz4EF55TaO3jc
 CELoh9QlmlncY5fdB5OIz3Ye9Wtw6k2CIe8pj19yi0BK/yaxft6k8CXq1iFj7JB8BIYi
 cYmkjGLukMUQ1MD8YOGMbJVWiKlzmyhTCnD0rjgeLguWFNVM6lgwh0hYkcAXSd7rDp1u
 zvMlGrKhUvPJQ41ivfNW6CoJimZumlKBx/ZEIcE8q+r2rvW4R1NZpYT2FSKG5X1BrLm7
 yjhAQAhbDJcROMQbs5/jGnHj/FCQNOdMimhR9+f9GEHXy6JudydtLBwlo4YBhLsoNgH9
 rW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=OyeHkVRk+pDFOc+EaKWT1incM6J5ShZ/3FLqVMsrNwk=;
 b=E5wJZpfzUXeOmBIgWFc5vNnnPBg5pUTMPDyfZ2YpOlLqckhvFVpQOAGWjKx1q7f2KG
 Min4GJVXdb9+RhgKxlJWWcp0Ij1cP1jdU1Dt0lo7N2WkIX7RNZ6hpE0Gl2TP0diWVGKB
 IgygM2b1EQ1Z7NbkL2AweQumoiRPi6XtHwwTrE7Jp5wFLVn7mM0ssHFAMycXYivwf8zO
 BPTacTLJ13G9BKtVXQGqmprP1Ep2A13RV9HuIk2iGWgwJY6I/n+gmRNG8T+t4lYh3zXl
 IJhhdf2MBOdgEwboSYIDHvucDcjCAUi+NAmSDS15/FeyOLKrBYiY+E7n1/lbPqTYUO4y
 Od9Q==
X-Gm-Message-State: APjAAAXTzaAZK2YtfGQwNJjDv7kBgyFIj9AcLNvHllJAjP7FLQuNRNUJ
 3MzQtJfWsXIBxZxhmHJTVoxi5062
X-Google-Smtp-Source: APXvYqzt7IoWRWXWz0m/Wyk85be+Ob+eADzFC7RLfjGzx790LTb1hpdaai7KO5rqqTclmjikOpDFyA==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr69712879wro.279.1582631535488; 
 Tue, 25 Feb 2020 03:52:15 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 075/136] make mem_path local variable
Date: Tue, 25 Feb 2020 12:50:05 +0100
Message-Id: <1582631466-13880-75-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

It's no longer used anywhere beside main(),
so make it local variable that is used for CLI compat
purposes to keep -mem-path option working.

Under hood QEMU will use it to create
  memory-backend-file,mem-path=...
backend and use its MemoryRegion as main RAM.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-76-imammedo@redhat.com>
---
 include/sysemu/sysemu.h | 1 -
 vl.c                    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index c0678c1..ae78b2a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -50,7 +50,6 @@ extern uint8_t *boot_splash_filedata;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
-extern const char *mem_path;
 extern int mem_prealloc;
 
 #define MAX_OPTION_ROMS 16
diff --git a/vl.c b/vl.c
index a7edcba..15cc5bd 100644
--- a/vl.c
+++ b/vl.c
@@ -140,7 +140,6 @@ enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int display_opengl;
 const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
-const char *mem_path = NULL;
 int mem_prealloc = 0; /* force preallocation of physical target memory */
 bool enable_mlock = false;
 bool enable_cpu_pm = false;
@@ -2883,6 +2882,7 @@ int main(int argc, char **argv, char **envp)
     Error *err = NULL;
     bool list_data_dirs = false;
     char *dir, **dirs;
+    const char *mem_path = NULL;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
     QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
-- 
1.8.3.1



