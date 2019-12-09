Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5AC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAFF2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr5dUEfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAFF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKi8-0006bO-0S
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKY0-0003WQ-1c
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXy-0001Sd-R1
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:03 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXy-0001Pe-IR
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:02 -0500
Received: by mail-wm1-x342.google.com with SMTP id c20so13811675wmb.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=53drGG/4V0NylixgL3iQIcLKYE+QBnEUf/GWyCKPtTs=;
 b=jr5dUEfWqZWGuVQP0ushn49uADQ6CKq9GI2D2Ot3F9/RlzXrS33s2rucjwq2CAW0oe
 Y54HSOc1rJ3vM5FHErklLh7EOHQ+JUuk0RUZYOyH60tHB2jX8kDOeZso7scia3d3lh77
 YDfyiP2Q3VIt2oYjt+tGHZ3GgHh+fg9h7wIDqmVaQ14MR+FA2imjtu/tHbJCm+rFnWJD
 zEQ909duDpSoMFF8xm3pzM338N+kmrxtF0JMsfzRkCjJwmwmbQ9zXAE+B3utm5+/nQFJ
 JMw7y4hfSCw4mF/O+hSL7BbBB6UWKgF6zexfbhy1kmwTSD38Kr9eKF1bg11AbkqOnjyR
 AYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=53drGG/4V0NylixgL3iQIcLKYE+QBnEUf/GWyCKPtTs=;
 b=lswx4Kifke909SVaKapjzPcU5KjrA6JAYU/znOSL8Tp+13wx2oEVXpxXpzFEGs9R2V
 BuEV4SPzOu0CPOi0hWf8sDJhGKfq85KEQemUgEWkpAcdKMcQWDIfZj4fy/3o2HvimWaq
 7+SU00k55iQFgjMh11W1tzrnV/Z7zygFbsDxbM2FhRVRYEHKvfOB3RaZRPBLZPEzM5iW
 gu5kVFj3i8uGAEfABj99POWxQpbJ9ur4InDLwr5fmsbuqb1G63PqCLgPrwqhuSqQwF5x
 e6r9rkHcO5hMYeVGIjXHGm14fgaH8I0asibFN7v3cwQMXDMwlnG+M7/R8JHUfH7uafeG
 L37g==
X-Gm-Message-State: APjAAAUicWZy2/KTbuxQTC7/Fmr0QwxUP0D3ss5rgQV1qLn9MI7wpN4h
 IVybm6pIHqnOpE36gf/qaruct2U8
X-Google-Smtp-Source: APXvYqxwQZEegqIDm4mke6EArHQ0ixXjxMtLERoY9pm7vA8ziCkRL8Kp+FEiWwI7iEGUarGcJTbyjQ==
X-Received: by 2002:a1c:2705:: with SMTP id n5mr26671754wmn.68.1575903720906; 
 Mon, 09 Dec 2019 07:02:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.02.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:02:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/18] accel: pass object to accel_init_machine
Date: Mon,  9 Dec 2019 16:01:39 +0100
Message-Id: <1575903705-12925-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: thuth@redhat.com, elmarco@redhat.com
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
index f18b26b..078ab7a 100644
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



