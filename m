Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF9FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EB621734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLqbYJqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EB621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufH4-00080z-Sg
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrd-0005NH-Tf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrc-00049C-Nj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:41 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrc-000487-Hk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:40 -0500
Received: by mail-wr1-x42e.google.com with SMTP id c14so3133361wrn.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hUG/7q5hSf5ymYtbRPJKidNIIUCm54xUUBFlpg5zKq0=;
 b=tLqbYJqQtBfyse6rQp3S6/Ma/yd4bd+4qTqBWqo0D81u826aElxbkeXHi6vh7hrw01
 0hvLqzNVqE2BR14Y0D2OvLTrFrnY/jlt3BZq251MwiyJMfTll/aFBryoaTN7TAH8yFN/
 eft7v8yfhwRZdlqkTETTB4/Ay3msdDucLl8yaGefup37DSTYQmeA+UWaklfQYZR01nas
 8qqmRzO60rzaBWMtdcVRpEVipZCWJpMk8iFxeBuBhOKtpOuXY9xscuEYtHEvUGHONFch
 PlucL6q/mh7XZiH15DQb0xNBy+JkPR73oLqvUBTbfVrrHeV4z6JwJ5TkrN5ttphWI4Lz
 G61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hUG/7q5hSf5ymYtbRPJKidNIIUCm54xUUBFlpg5zKq0=;
 b=R/oSMGWGTs7AJ6dZhgY1kBXiAAdDiTaKia2Sms1d44i6NkgqW6VVUl83Q4gtU5Jaim
 e6/GYehDNK9WcDhZgjjjDlInHZkJ5WsQ/PAs6Fts2dudcK9H7PB252BKa2coBOc+gV6/
 /16VvBgMX0XsgMVw/qF9fRI6XWvCkig40iRF0jyC2uBb2yHLlkeOGECVlOz8SSsvubKB
 iYB5Yh54QqG82b7J6Nfeb75WKxE+GwCddeWVFkHbJi64bXsN/rTb0pjErivSSJXxJ80K
 VGtKKOPTrf+1pCh7vF0Kb8AmAn8fDIoDYv+2lPsKbdekoAgfYQTeYx9NsGWE39rA0jHJ
 laHQ==
X-Gm-Message-State: APjAAAUTOF4943Sdw0B9pRVHPEAAzcaVjTSU4fkg57fzDMs5+NqvBGoi
 +I3xHTaYvUuXq5WjwCd3hb3HmAdh
X-Google-Smtp-Source: APXvYqzLfOi2acp6yMec3AsL88IYDnNi7F7etX7r7FHDZeWzaZHC1thqmyrP08UAtkwpvDKyxNCiEw==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr17453068wrn.283.1579787379310; 
 Thu, 23 Jan 2020 05:49:39 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/59] object: add object_property_get_defaut()
Date: Thu, 23 Jan 2020 14:48:40 +0100
Message-Id: <1579787342-27146-38-git-send-email-pbonzini@redhat.com>
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

The new callback will be used in following "object: add
object_property_set_defaut_{bool,str,int,uint}()" and "vl: print
default value in object help" patches.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-8-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 17 +++++++++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 29f47d3..ca47308 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -367,6 +367,13 @@ typedef void (ObjectPropertyRelease)(Object *obj,
  */
 typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
 
+/**
+ * ObjectPropertyGetDefault:
+ *
+ * Get an allocated string representation of the default value.
+ */
+typedef char *(ObjectPropertyGetDefault)(ObjectProperty *prop);
+
 struct ObjectProperty
 {
     gchar *name;
@@ -377,6 +384,7 @@ struct ObjectProperty
     ObjectPropertyResolve *resolve;
     ObjectPropertyRelease *release;
     ObjectPropertyInit *init;
+    ObjectPropertyGetDefault *get_default;
     void *opaque;
 };
 
@@ -1234,6 +1242,15 @@ void object_property_set_int(Object *obj, int64_t value,
                              const char *name, Error **errp);
 
 /**
+ * object_property_get_defaut:
+ * @prop: the property to get default value
+ *
+ * Return an allocated string that represents the default property
+ * value or NULL.
+ */
+char *object_property_get_default(ObjectProperty *prop);
+
+/**
  * object_property_get_int:
  * @obj: the object
  * @name: the name of the property
diff --git a/qom/object.c b/qom/object.c
index cd7ce81..49c2429 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1438,6 +1438,15 @@ int64_t object_property_get_int(Object *obj, const char *name,
     return retval;
 }
 
+char *object_property_get_default(ObjectProperty *prop)
+{
+    if (!prop->get_default) {
+        return NULL;
+    }
+
+    return prop->get_default(prop);
+}
+
 void object_property_set_uint(Object *obj, uint64_t value,
                               const char *name, Error **errp)
 {
-- 
1.8.3.1



