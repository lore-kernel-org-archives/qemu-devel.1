Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2271C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6483524125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1MJrCeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6483524125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuagV-0006Su-EJ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuafR-0005Ty-Ug
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuafQ-0006Tg-1r
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:28:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50974
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuafP-0006TK-UP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579778935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTjVUYt4wAd20VubywjRYV1osOiBguqJpqhqZYd0Zlg=;
 b=E1MJrCeP3DC/kA7DRGZ8ULmBPcAJIrsi3E/siUATx8r0zyX3l2NT9oZ2Af6Pwz2YEqHpDt
 haGNqwC+LbE5Vl1jNc4iPk/gueAbLbOa9mfGbScJInZlMH9zQhdyAOWW97GWmi//BhRlfF
 4NLMgQC4js9+k+ggu5rtTocOglbootw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-HeyjdDcYP2ipqOzn_Us7wg-1; Thu, 23 Jan 2020 06:28:53 -0500
Received: by mail-wm1-f69.google.com with SMTP id m21so279926wmg.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 03:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uTjVUYt4wAd20VubywjRYV1osOiBguqJpqhqZYd0Zlg=;
 b=QjHlBb8ZZ/nmx1Cg+GOUvY2eCRaPub7wAlFZsEbrbWueKABdZWECKVmVi/gEDvKpuX
 IL9ng1XVU/qmBzxwJRPtSC86QJjNZLCXDrL1UbG+S9xr4peEYV4sEDJRkgTjXJkduSj5
 3VhnboScT/scFgoumdQAZ6Jj3Kuw25fPECSvW/vLUGdqDDsE+BV5KlsARjPgO9zrWpgS
 sZgdEY34k96CygYe0ozi2cUU/QQfRDkdWOAcLnRqbcHGwa2UA5Aw2bPhpWRSKCWxIaMo
 fkcLISmJsXq7pG13v7h66OjsmzZrSUVLo5f2vGPiLGQ83KvuQo9ZSpRTcuqzqbS5kqAQ
 l02w==
X-Gm-Message-State: APjAAAVOhuTAw+cKmuDZGXwyy1WcySY5R3H0Fz7BwmP3tveUvXlcnovP
 IzaiixgL2mOFXmtOAfpCnenhwF/1OjrL4Imcz6i06lg05mJgPg1dcZAD8HindJ3JDYRM9zc5SQq
 C9sqzSTcJzpBuvZk=
X-Received: by 2002:a05:6000:118e:: with SMTP id
 g14mr18069361wrx.39.1579778932146; 
 Thu, 23 Jan 2020 03:28:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqySJsWPvAkgplHWRYGeVT6996JqJTIQw02ei2yOcuTK/8lymrdDRl9Is2dW2AZ/fvUtpXvosQ==
X-Received: by 2002:a05:6000:118e:: with SMTP id
 g14mr18069341wrx.39.1579778931870; 
 Thu, 23 Jan 2020 03:28:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id r62sm2638124wma.32.2020.01.23.03.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 03:28:51 -0800 (PST)
Subject: Re: [PATCH 10/26] object: add object_property_set_defaut_{bool, str, 
 int, uint}()
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
 <20200110153039.1379601-11-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a3b0024-fb80-c34d-16fd-78f8bc722807@redhat.com>
Date: Thu, 23 Jan 2020 12:28:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200110153039.1379601-11-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: HeyjdDcYP2ipqOzn_Us7wg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

This patch caught my attention because of the typo in the function, but 
I also noticed that get_default is never set to anything but 
object_property_get_defval.

What do you think about removing the method and just relying on defval?
In practice there would be a new patch that squashes 7, 10 and the thing
after my signature.

Paolo

diff --git a/include/qom/object.h b/include/qom/object.h
index 1ea5c8c..035e41c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -367,13 +367,6 @@ typedef void (ObjectPropertyRelease)(Object *obj,
  */
 typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
 
-/**
- * ObjectPropertyGetDefault:
- *
- * Get an allocated string representation of the default value.
- */
-typedef char *(ObjectPropertyGetDefault)(ObjectProperty *prop);
-
 struct ObjectProperty
 {
     gchar *name;
@@ -384,7 +377,6 @@ struct ObjectProperty
     ObjectPropertyResolve *resolve;
     ObjectPropertyRelease *release;
     ObjectPropertyInit *init;
-    ObjectPropertyGetDefault *get_default;
     void *opaque;
     QObject *defval;
 };
diff --git a/qom/object.c b/qom/object.c
index 2464a9f..aa6cf19 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1444,15 +1444,6 @@ int64_t object_property_get_int(Object *obj, const char *name,
     return retval;
 }
 
-char *object_property_get_default(ObjectProperty *prop)
-{
-    if (!prop->get_default) {
-        return NULL;
-    }
-
-    return prop->get_default(prop);
-}
-
 static void object_property_init_defval(Object *obj, ObjectProperty *prop)
 {
     Visitor *v = qobject_input_visitor_new(prop->defval);
@@ -1463,8 +1454,12 @@ static void object_property_init_defval(Object *obj, ObjectProperty *prop)
     visit_free(v);
 }
 
-static char *object_property_get_defval(ObjectProperty *prop)
+char *object_property_get_default(ObjectProperty *prop)
 {
+    if (!prop->defval) {
+        return NULL;
+    }
+
     return qstring_free(qobject_to_json(prop->defval), TRUE);
 }
 
@@ -1472,11 +1467,9 @@ static void object_property_set_default(ObjectProperty *prop, QObject *defval)
 {
     assert(!prop->defval);
     assert(!prop->init);
-    assert(!prop->get_default);
 
     prop->defval = defval;
     prop->init = object_property_init_defval;
-    prop->get_default = object_property_get_defval;
 }
 
 void object_property_set_default_bool(ObjectProperty *prop, bool value)
@@ -2610,8 +2603,7 @@ void object_property_add_alias(Object *obj, const char *name,
         goto out;
     }
     op->resolve = property_resolve_alias;
-    if (target_prop->get_default) {
-        op->get_default = target_prop->get_default;
+    if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
     }
 


