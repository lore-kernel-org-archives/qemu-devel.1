Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA479C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59EF2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0W5Ep70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59EF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKfJ-0002sp-BN
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXy-0003Uy-RY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXx-0001P9-Ev
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXx-0001O2-7j
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:01 -0500
Received: by mail-wr1-x442.google.com with SMTP id q10so16552802wrm.11
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6qXoUB/YRk1ySecNiPXq+1y/hNOC/soS4r9Rs8Dke6E=;
 b=X0W5Ep70jUlMGedUun6qCWcddOQsPjHk/ig5Xpw8Zr3ipLMvyB6smrh6quF4LZfDuP
 bu9phFUTJlHV322N+e9RtykFVt2GLDoame53IQj3d2uVouoV3SfdBr/O2h1SlqKIAObQ
 BchFR3LeQUrQMpGoMk0lZZrJBBSXJZPlvKSA2+mWzCTL6dOIL1aErIavBuBN+WKEW5rP
 p01Cb+PS1mkRimmyvJpV28gIW8naXjY8arCimgXkBtZM0tz/yXqXuvCA2HvpdHpVa/mr
 V19SCmsHJnHK94qgvnb4XGOs4gJ04Axi+dotc70bDVIZm/+8JGM2bDy+5vbs2o2f1uUD
 akCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6qXoUB/YRk1ySecNiPXq+1y/hNOC/soS4r9Rs8Dke6E=;
 b=aPnhu8easGoedVofgBMDKgkXoAHbuaTyw6b9rUyH1TywRX6aRP83t0AyD08y9ySSDL
 H0QQEQ2Z2p1tAOWLbYQV1E2JlrI/TAoS9djkv0RN+mSr8EMRtxdIzVw7VtR1BQZnJMAm
 uHPbV7LNL4VrY8ub/bW/bbhafu83byMQzjOxHqLYs57cuZjbGm41BGYotQu0t7Je6T8Y
 3vj/f6BjXThBM2blMoKnAWkRyet0DHY2qsUm0gkqTbrbscGGzAhGBfgV0vSdMeEfwuvP
 npquaDjyEhsC82eXUt3Qw3HEjT0DiB6mZUmDVC+J7XZk/ZLt9Z/nenT5qq6VEOzGYp/o
 ZO1Q==
X-Gm-Message-State: APjAAAX9sJbTEpM7GqFHqJ+SE9pays5ctwj3os2gwYh9jP+S4d8H9Rv3
 PI1LA/NMC8Mswkhr7VXsLUIs2SnV
X-Google-Smtp-Source: APXvYqxUS7GlGTm4Siwz3xa6EhUWMblKv88ZPrCyZt//UQDimR5+xUhQ6tV5Ea/+gTs+383L+5pG+w==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr2859529wrj.68.1575903719949;
 Mon, 09 Dec 2019 07:01:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/18] qom: add object_new_with_class
Date: Mon,  9 Dec 2019 16:01:38 +0100
Message-Id: <1575903705-12925-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to CPU and machine classes, "-accel" class names are mangled,
so we have to first get a class via accel_find and then instantiate it.
Provide a new function to instantiate a class without going through
object_class_get_name, and use it for CPUs and machines already.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c             |  4 +---
 include/qom/object.h      | 12 ++++++++++++
 qom/object.c              |  5 +++++
 target/i386/cpu.c         |  8 ++++----
 target/s390x/cpu_models.c |  4 ++--
 vl.c                      |  3 +--
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 60c3827..dd38a46 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -48,9 +48,7 @@ AccelClass *accel_find(const char *opt_name)
 
 int accel_init_machine(AccelClass *acc, MachineState *ms)
 {
-    ObjectClass *oc = OBJECT_CLASS(acc);
-    const char *cname = object_class_get_name(oc);
-    AccelState *accel = ACCEL(object_new(cname));
+    AccelState *accel = ACCEL(object_new_with_class(OBJECT_CLASS(acc)));
     int ret;
     ms->accelerator = accel;
     *(acc->allowed) = true;
diff --git a/include/qom/object.h b/include/qom/object.h
index 230b18f..f9ad692 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -593,6 +593,18 @@ struct InterfaceClass
                                              __FILE__, __LINE__, __func__))
 
 /**
+ * object_new_with_class:
+ * @klass: The class to instantiate.
+ *
+ * This function will initialize a new object using heap allocated memory.
+ * The returned object has a reference count of 1, and will be freed when
+ * the last reference is dropped.
+ *
+ * Returns: The newly allocated and instantiated object.
+ */
+Object *object_new_with_class(ObjectClass *klass);
+
+/**
  * object_new:
  * @typename: The name of the type of the object to instantiate.
  *
diff --git a/qom/object.c b/qom/object.c
index bfb4413..bc444d3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -658,6 +658,11 @@ static Object *object_new_with_type(Type type)
     return obj;
 }
 
+Object *object_new_with_class(ObjectClass *klass)
+{
+    return object_new_with_type(klass->type);
+}
+
 Object *object_new(const char *typename)
 {
     TypeImpl *ti = type_get_by_name(typename);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69f518a..a044078 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4640,7 +4640,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         return;
     }
 
-    xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
+    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
 
     x86_cpu_expand_features(xc, &err);
     if (err) {
@@ -4711,7 +4711,7 @@ static GSList *get_sorted_cpu_model_list(void)
 
 static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
 {
-    Object *obj = object_new(object_class_get_name(OBJECT_CLASS(xc)));
+    Object *obj = object_new_with_class(OBJECT_CLASS(xc));
     char *r = object_property_get_str(obj, "model-id", &error_abort);
     object_unref(obj);
     return r;
@@ -5092,7 +5092,7 @@ static X86CPU *x86_cpu_from_model(const char *model, QDict *props, Error **errp)
         goto out;
     }
 
-    xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
+    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
     if (props) {
         object_apply_props(OBJECT(xc), props, &err);
         if (err) {
@@ -5936,7 +5936,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
     APICCommonState *apic;
     ObjectClass *apic_class = OBJECT_CLASS(apic_get_class());
 
-    cpu->apic_state = DEVICE(object_new(object_class_get_name(apic_class)));
+    cpu->apic_state = DEVICE(object_new_with_class(apic_class));
 
     object_property_add_child(OBJECT(cpu), "lapic",
                               OBJECT(cpu->apic_state), &error_abort);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7e92fb2..72cf48b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -440,7 +440,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     if (cpu_list_data->model) {
         Object *obj;
         S390CPU *sc;
-        obj = object_new(object_class_get_name(klass));
+        obj = object_new_with_class(klass);
         sc = S390_CPU(obj);
         if (sc->model) {
             info->has_unavailable_features = true;
@@ -501,7 +501,7 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
         error_setg(errp, "The CPU definition '%s' requires KVM", info->name);
         return;
     }
-    obj = object_new(object_class_get_name(oc));
+    obj = object_new_with_class(oc);
     cpu = S390_CPU(obj);
 
     if (!cpu->model) {
diff --git a/vl.c b/vl.c
index d6c77bc..f18b26b 100644
--- a/vl.c
+++ b/vl.c
@@ -3989,8 +3989,7 @@ int main(int argc, char **argv, char **envp)
                       cleanup_add_fd, NULL, &error_fatal);
 #endif
 
-    current_machine = MACHINE(object_new(object_class_get_name(
-                          OBJECT_CLASS(machine_class))));
+    current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
     if (machine_help_func(qemu_get_machine_opts(), current_machine)) {
         exit(0);
     }
-- 
1.8.3.1



