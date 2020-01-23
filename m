Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018DAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA54921734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sALh1Zsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA54921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueda-0006mT-MU
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrj-0005V9-49
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrh-0004LJ-RY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:46 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrh-0004K3-L8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:45 -0500
Received: by mail-wr1-x42e.google.com with SMTP id c9so3134247wrw.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oY9cSuB59xRHq3LMhdI5P/MTn902Rp70IXIZQ4mig9A=;
 b=sALh1ZsdtUFtAdBPa9FNgNgdrTF76RO7Is9H+D9jkvyZkDfGMR6EORVWSp+MvdFKit
 Cj95nPfkK2MoKbV/JAvwoAZB9g78weMohReEUXzFWjxQW4Wm09fA7FFuCJhyWVnp6Lz2
 sppw7Wy2//HEgXZ7TgRSnocpWRw/PNDBTw5DFakGMC8iHWvsRU/tL84gt+l0zJEFfQ2B
 vx20eUI6p0DhKI43VT7sh0p29wLtUobBfs7lKBJzZaHq51pEcRi2E8m1I+QUvDCvov5y
 fZahS05FgSUKC5MVGvks9aslnox37iZi9RVmlYckgiDF5yuJE8XD3qYZjO6jWRtAViET
 brdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oY9cSuB59xRHq3LMhdI5P/MTn902Rp70IXIZQ4mig9A=;
 b=W4j1SEifLwxz6z+4XGNnz9PVwH3AOjVm+khx5RqcfS08nFdyEptgOr3eCenobDi32c
 /kSjtbw9EZwmZbqTKaim4kAVN6dgvr9IPiWOGaGW31NkiCCVsgJrTmZbz6f9ht1Zi9vy
 APzdBmyPEyXIDZrvuSr+VtSSijeQ+UREMEKkZ1mkQUc8Pkq7uf6Qw8u43+D8qu4xO6LW
 yFOPjyL61trIkg2ADoqBakSL4/H9uClOojmlw30DxDWjChlI/fKace7Yie9MCQyIkxZj
 w/BoKlAXcXlfBRcHK0oaTWlLHAaBuBaT/flUqq9G/l68PFTs5mbiqarSvHOdEEmJawei
 5Qvg==
X-Gm-Message-State: APjAAAVamMCK+qA8Octuja4gJUXDjcKaiydkSaPET17AC8I+z6PQEF18
 1CJXjvVhc9rlzrU1Cf8W2aX8jhK+
X-Google-Smtp-Source: APXvYqzLlpKinutkCKRfNg3KktApGWz+LST7ZjgFeAL1LYe6qKAg+z7UbkRr5KZyBtUWuC/Fc14pYg==
X-Received: by 2002:adf:f885:: with SMTP id u5mr17880815wrp.359.1579787384391; 
 Thu, 23 Jan 2020 05:49:44 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/59] object: rename link "child" to "target"
Date: Thu, 23 Jan 2020 14:48:46 +0100
Message-Id: <1579787342-27146-44-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

A child property is a different kind of property. Let's use "target"
for the link target.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-14-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h |  4 ++--
 qom/object.c         | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index fb133d6..7e66bc7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1545,7 +1545,7 @@ void object_property_allow_set_link(const Object *, const char *,
  * @obj: the object to add a property to
  * @name: the name of the property
  * @type: the qobj type of the link
- * @child: a pointer to where the link object reference is stored
+ * @targetp: a pointer to where the link object reference is stored
  * @check: callback to veto setting or NULL if the property is read-only
  * @flags: additional options for the link
  * @errp: if an error occurs, a pointer to an area to store the error
@@ -1570,7 +1570,7 @@ void object_property_allow_set_link(const Object *, const char *,
  * modified.
  */
 void object_property_add_link(Object *obj, const char *name,
-                              const char *type, Object **child,
+                              const char *type, Object **targetp,
                               void (*check)(const Object *obj, const char *name,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags,
diff --git a/qom/object.c b/qom/object.c
index fb80013..ced5e0b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1729,7 +1729,7 @@ void object_property_allow_set_link(const Object *obj, const char *name,
 }
 
 typedef struct {
-    Object **child;
+    Object **targetp;
     void (*check)(const Object *, const char *, Object *, Error **);
     ObjectPropertyLinkFlags flags;
 } LinkProperty;
@@ -1739,11 +1739,11 @@ static void object_get_link_property(Object *obj, Visitor *v,
                                      Error **errp)
 {
     LinkProperty *lprop = opaque;
-    Object **child = lprop->child;
+    Object **targetp = lprop->targetp;
     gchar *path;
 
-    if (*child) {
-        path = object_get_canonical_path(*child);
+    if (*targetp) {
+        path = object_get_canonical_path(*targetp);
         visit_type_str(v, name, &path, errp);
         g_free(path);
     } else {
@@ -1798,8 +1798,8 @@ static void object_set_link_property(Object *obj, Visitor *v,
 {
     Error *local_err = NULL;
     LinkProperty *prop = opaque;
-    Object **child = prop->child;
-    Object *old_target = *child;
+    Object **targetp = prop->targetp;
+    Object *old_target = *targetp;
     Object *new_target = NULL;
     char *path = NULL;
 
@@ -1821,7 +1821,7 @@ static void object_set_link_property(Object *obj, Visitor *v,
         return;
     }
 
-    *child = new_target;
+    *targetp = new_target;
     if (prop->flags & OBJ_PROP_LINK_STRONG) {
         object_ref(new_target);
         object_unref(old_target);
@@ -1832,7 +1832,7 @@ static Object *object_resolve_link_property(Object *parent, void *opaque, const
 {
     LinkProperty *lprop = opaque;
 
-    return *lprop->child;
+    return *lprop->targetp;
 }
 
 static void object_release_link_property(Object *obj, const char *name,
@@ -1840,14 +1840,14 @@ static void object_release_link_property(Object *obj, const char *name,
 {
     LinkProperty *prop = opaque;
 
-    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *prop->child) {
-        object_unref(*prop->child);
+    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *prop->targetp) {
+        object_unref(*prop->targetp);
     }
     g_free(prop);
 }
 
 void object_property_add_link(Object *obj, const char *name,
-                              const char *type, Object **child,
+                              const char *type, Object **targetp,
                               void (*check)(const Object *, const char *,
                                             Object *, Error **),
                               ObjectPropertyLinkFlags flags,
@@ -1858,7 +1858,7 @@ void object_property_add_link(Object *obj, const char *name,
     gchar *full_type;
     ObjectProperty *op;
 
-    prop->child = child;
+    prop->targetp = targetp;
     prop->check = check;
     prop->flags = flags;
 
-- 
1.8.3.1



