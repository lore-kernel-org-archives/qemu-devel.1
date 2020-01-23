Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B41E21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY5gi3b+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B41E21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufPH-00029l-9c
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrl-0005YP-9Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrk-0004Qo-40
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrj-0004Pt-U6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:48 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p17so2627021wmb.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cd+8u3Y9MnihrkwTGy/lli6q5rm4tiEDd8ttjlcyi+Y=;
 b=fY5gi3b+R/Q7Y5xcOLoFItIkBhJhfFs34vhQXuPdWE9iPIKzleSFiM0PCOBAiObV0L
 xWJaW2u6zEuI8yNJ6wx0zlg+OVEs7gaI1NMiVqWSWIvWdYELS6zgHTB9jJPt23rge7vJ
 M7eCOG0knkh3rFmACPVORZdCtc41DABpbK8DG4Wr0fhEJInjqG2XRpdsy2WrSxM+T+Xm
 V7XMbDbZJSOMzZOI64wEwMPCGYeN5trSMZynZVTySfHZ7a0ZnIqLxnTWa4Y6HhR1xwVD
 Ss0wdQm2g+bOeLIbXLb8w9TKUWr99L7d+rw1S6bYuFmffo316/mfBumFWAlNr4xExNue
 Fy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cd+8u3Y9MnihrkwTGy/lli6q5rm4tiEDd8ttjlcyi+Y=;
 b=mXP1ksujRHc+kEmiLxCweVRn3ym+R6TyrUWsIFog/HeHwIRvE0iQAJxZVWWT4sR+3j
 pPa11AkvL79Xz2J8RnN0bKwekh0ZwDajJyijeSCphjeCst7jjgRA74i166Fv3zYnweMB
 KQ20RAldFavwkR0tdyqd6c9pU6NbJ82UUQRwLMdfp9Kgyu86G0tI74FjyvQUHdAtsHCi
 z/kHUqCQwhHlx8rjsR6thwn0KG8FfNPxN3O5g6HdcX/4HZvQZXOjqlkkN92O8W56bo6x
 2GqDtV7caCSGLblpaMe4/H5udLLWqaYwIZ8GMG7AjwlgNRYkrMp+fN90ylqncHBOnnRa
 okcQ==
X-Gm-Message-State: APjAAAUtfvOnjcp27QW7zraRks7oyuhTn+ETvZAiyzztyCCM+5ft4+PP
 GMHbcXV5GJtUzpFk674Lh8ncO1Z7
X-Google-Smtp-Source: APXvYqx2PDnXFhMA/Tsr13uvWIGvpsVKECzYy3SETcNwBjVH2Rqf/nfbpj5nKAZ8pVDwpJtQwwT7wQ==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr4281454wml.186.1579787386872; 
 Thu, 23 Jan 2020 05:49:46 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/59] object: add object_class_property_add_link()
Date: Thu, 23 Jan 2020 14:48:49 +0100
Message-Id: <1579787342-27146-47-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-17-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h |  9 +++++++++
 qom/object.c         | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 5b02be6..ead9129 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1531,6 +1531,7 @@ typedef enum {
 
     /* private */
     OBJ_PROP_LINK_DIRECT = 0x2,
+    OBJ_PROP_LINK_CLASS = 0x4,
 } ObjectPropertyLinkFlags;
 
 /**
@@ -1579,6 +1580,14 @@ void object_property_add_link(Object *obj, const char *name,
                               ObjectPropertyLinkFlags flags,
                               Error **errp);
 
+ObjectProperty *object_class_property_add_link(ObjectClass *oc,
+                              const char *name,
+                              const char *type, ptrdiff_t offset,
+                              void (*check)(const Object *obj, const char *name,
+                                            Object *val, Error **errp),
+                              ObjectPropertyLinkFlags flags,
+                              Error **errp);
+
 /**
  * object_property_add_str:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index e6617c2..202d576 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1732,6 +1732,7 @@ typedef struct {
     union {
         Object **targetp;
         Object *target; /* if OBJ_PROP_LINK_DIRECT, when holding the pointer  */
+        ptrdiff_t offset; /* if OBJ_PROP_LINK_CLASS */
     };
     void (*check)(const Object *, const char *, Object *, Error **);
     ObjectPropertyLinkFlags flags;
@@ -1742,6 +1743,8 @@ object_link_get_targetp(Object *obj, LinkProperty *lprop)
 {
     if (lprop->flags & OBJ_PROP_LINK_DIRECT) {
         return &lprop->target;
+    } else if (lprop->flags & OBJ_PROP_LINK_CLASS) {
+        return (void *)obj + lprop->offset;
     } else {
         return lprop->targetp;
     }
@@ -1857,7 +1860,9 @@ static void object_release_link_property(Object *obj, const char *name,
     if ((prop->flags & OBJ_PROP_LINK_STRONG) && *targetp) {
         object_unref(*targetp);
     }
-    g_free(prop);
+    if (!(prop->flags & OBJ_PROP_LINK_CLASS)) {
+        g_free(prop);
+    }
 }
 
 static void object_add_link_prop(Object *obj, const char *name,
@@ -1910,6 +1915,45 @@ void object_property_add_link(Object *obj, const char *name,
     object_add_link_prop(obj, name, type, targetp, check, flags, errp);
 }
 
+ObjectProperty *
+object_class_property_add_link(ObjectClass *oc,
+    const char *name,
+    const char *type, ptrdiff_t offset,
+    void (*check)(const Object *obj, const char *name,
+                  Object *val, Error **errp),
+    ObjectPropertyLinkFlags flags,
+    Error **errp)
+{
+    Error *local_err = NULL;
+    LinkProperty *prop = g_new0(LinkProperty, 1);
+    gchar *full_type;
+    ObjectProperty *op;
+
+    prop->offset = offset;
+    prop->check = check;
+    prop->flags = flags | OBJ_PROP_LINK_CLASS;
+
+    full_type = g_strdup_printf("link<%s>", type);
+
+    op = object_class_property_add(oc, name, full_type,
+                                   object_get_link_property,
+                                   check ? object_set_link_property : NULL,
+                                   object_release_link_property,
+                                   prop,
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        g_free(prop);
+        goto out;
+    }
+
+    op->resolve = object_resolve_link_property;
+
+out:
+    g_free(full_type);
+    return op;
+}
+
 void object_property_add_const_link(Object *obj, const char *name,
                                     Object *target, Error **errp)
 {
-- 
1.8.3.1



