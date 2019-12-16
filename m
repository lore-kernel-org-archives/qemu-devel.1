Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CACC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA40206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl5Yi/S/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA40206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtgW-0006N7-1A
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFB-000560-EI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFA-0007VH-91
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:13 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFA-0007TJ-22
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:12 -0500
Received: by mail-wr1-x433.google.com with SMTP id c9so8037595wrw.8
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E/1LFy6wDBBmXAA/JB6bEc3nrfnmKGczXUnvs9Wqjvo=;
 b=Sl5Yi/S/arVByrSgAAyiJc7DBwNpLYpoK+646OGHYRnSUIZwRDryf584Ubn3gZCzKl
 zlP8FTGFurRvgfmCvC3GCuiFJuCLTCNES3rtpU2ruNsW7KD1IdfZqojp86ULLYhlTwM7
 aCh/WVYg349ft5RdUbhRTyxejgtt6Fhgxm4N2XLSrbwQyMFV0c2A9CMB8TRiZ/AXluV0
 8vgs8MXrIjSbrcF/2epq44Ez/iWcQlVqPjnnZGJARvHx//lIFOsfv8Ft9kZR1Mp8yB5K
 3MqlLw98wR+fzT04LKbZ73+jY68mr9v94suRhM9f/kDg5DT5IlI40/mx/EV4Y5gYdXyH
 88/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=E/1LFy6wDBBmXAA/JB6bEc3nrfnmKGczXUnvs9Wqjvo=;
 b=erC19hdtx/WQjikFIHzpY6zZkmUgVdB6NVRaPnSGyB1aoTTmDWzSdLVjC+j9zgv81j
 EwDFp6h7SXgpQHBhdHWYHb1uYoEIs0vyxaoOAQAOW9GnSPITatqSCB+tvECTKMOW6FtK
 8tk2QHilEQFpWjASSxmmkgaa9pj7BZkJac0SSzJ05B33eWLcdwutx7I1L1FdS4jQp4cM
 +ceSPTDE/lVGeKf2AihvaiIRPqYMi5Xc6IEFM/r7IGZfY8SonC2fQyvyDzCPQkJUGH3f
 ldmhwPV+4gvwiJscV7w7YS/tw6Bn2m4t0h/Tm1x97BOfKxWs41uRxcv5zy4MdDg45E4m
 lXQQ==
X-Gm-Message-State: APjAAAXHHx6E/DXtOqEhjYSLXhRDSf6h7DON8pHzAnhkgC3Fy4PRFrJx
 lIzcFshjAQyDJzlMbcCSfOPd82Mn
X-Google-Smtp-Source: APXvYqxWXAJRzppdYxpHkehM90HuzpIHn2yxPAAHF3WVnIIavosVsKoGE1gjjqq5Mp5u/XdeXdflwQ==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr31116335wrp.322.1576513750735; 
 Mon, 16 Dec 2019 08:29:10 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/62] accel: pass object to accel_init_machine
Date: Mon, 16 Dec 2019 17:28:07 +0100
Message-Id: <1576513726-53700-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

We will have to set QOM properties before accel_init_machine, based on the
options provided to -accel.  Construct the object outside it so that it
will be possible to iterate on properties between object_new_with_class
and accel_init_machine.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c          | 4 ++--
 include/sysemu/accel.h | 2 +-
 vl.c                   | 4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index dd38a46..1c5c3a6 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -46,9 +46,9 @@ AccelClass *accel_find(const char *opt_name)
     return ac;
 }
 
-int accel_init_machine(AccelClass *acc, MachineState *ms)
+int accel_init_machine(AccelState *accel, MachineState *ms)
 {
-    AccelState *accel = ACCEL(object_new_with_class(OBJECT_CLASS(acc)));
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
     int ret;
     ms->accelerator = accel;
     *(acc->allowed) = true;
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 90b6213..22cac0f 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -67,7 +67,7 @@ typedef struct AccelClass {
 extern unsigned long tcg_tb_size;
 
 AccelClass *accel_find(const char *opt_name);
-int accel_init_machine(AccelClass *acc, MachineState *ms);
+int accel_init_machine(AccelState *accel, MachineState *ms);
 
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
diff --git a/vl.c b/vl.c
index dab6001..0378b90 100644
--- a/vl.c
+++ b/vl.c
@@ -2841,6 +2841,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     bool *p_init_failed = opaque;
     const char *acc = qemu_opt_get(opts, "accel");
     AccelClass *ac = accel_find(acc);
+    AccelState *accel;
     int ret;
 
     if (!ac) {
@@ -2848,7 +2849,8 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         error_report("invalid accelerator %s", acc);
         return 0;
     }
-    ret = accel_init_machine(ac, current_machine);
+    accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+    ret = accel_init_machine(accel, current_machine);
     if (ret < 0) {
         *p_init_failed = true;
         error_report("failed to initialize %s: %s",
-- 
1.8.3.1



