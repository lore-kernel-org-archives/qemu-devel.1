Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3363C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8687F206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8687F206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWdv-0004a9-Nm
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPA-0001LV-IP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP8-0005CD-VH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:52 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP7-00050y-8s
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:50 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 3B5A430747CA
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 2B8C1305B7A3;
 Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 12/26] kvm: vmi: add 'key' property
Date: Wed, 15 Apr 2020 03:59:24 +0300
Message-Id: <20200415005938.23895-13-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The introspection tool can be authenticated if the 'key' parameter is
set with the ID of a secret object holding a shared secret between the
introspection tool and QEMU of the introspected VM.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 5659663caa..f456ca56ef 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -14,6 +14,8 @@
 #include "qom/object_interfaces.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "crypto/secret.h"
+#include "crypto/hash.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
=20
@@ -31,6 +33,11 @@ typedef struct VMIntrospection {
     CharBackend sock;
     int sock_fd;
=20
+    char *keyid;
+    Object *key;
+    uint8_t cookie_hash[QEMU_VMI_COOKIE_HASH_SIZE];
+    bool key_with_cookie;
+
     qemu_vmi_from_introspector hsk_in;
     uint64_t hsk_in_read_pos;
     uint64_t hsk_in_read_size;
@@ -109,6 +116,14 @@ static void prop_set_chardev(Object *obj, const char=
 *value, Error **errp)
     i->chardevid =3D g_strdup(value);
 }
=20
+static void prop_set_key(Object *obj, const char *value, Error **errp)
+{
+    VMIntrospection *i =3D VM_INTROSPECTION(obj);
+
+    g_free(i->keyid);
+    i->keyid =3D g_strdup(value);
+}
+
 static void prop_get_uint32(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -153,6 +168,7 @@ static void instance_init(Object *obj)
     update_vm_start_time(i);
=20
     object_property_add_str(obj, "chardev", NULL, prop_set_chardev, NULL=
);
+    object_property_add_str(obj, "key", NULL, prop_set_key, NULL);
=20
     i->handshake_timeout =3D HANDSHAKE_TIMEOUT_SEC;
     object_property_add(obj, "handshake_timeout", "uint32",
@@ -213,6 +229,7 @@ static void instance_finalize(Object *obj)
     VMIntrospection *i =3D VM_INTROSPECTION(obj);
=20
     g_free(i->chardevid);
+    g_free(i->keyid);
=20
     cancel_handshake_timer(i);
=20
@@ -276,6 +293,16 @@ static bool send_handshake_info(VMIntrospection *i, =
Error **errp)
     return true;
 }
=20
+static bool validate_handshake_cookie(VMIntrospection *i)
+{
+    if (!i->key_with_cookie) {
+        return true;
+    }
+
+    return 0 =3D=3D memcmp(&i->cookie_hash, &i->hsk_in.cookie_hash,
+                       sizeof(i->cookie_hash));
+}
+
 static bool validate_handshake(VMIntrospection *i, Error **errp)
 {
     uint32_t min_accepted_size;
@@ -288,6 +315,11 @@ static bool validate_handshake(VMIntrospection *i, E=
rror **errp)
         return false;
     }
=20
+    if (!validate_handshake_cookie(i)) {
+        error_setg(errp, "VMI: received cookie doesn't match");
+        return false;
+    }
+
     /*
      * Check hsk_in.struct_size and sizeof(hsk_in) before accessing any
      * other fields. We might get fewer bytes from applications using
@@ -468,6 +500,31 @@ static void chr_event(void *opaque, QEMUChrEvent eve=
nt)
     }
 }
=20
+static bool make_cookie_hash(const char *key_id, uint8_t *cookie_hash,
+                             Error **errp)
+{
+    uint8_t *cookie =3D NULL, *hash =3D NULL;
+    size_t cookie_size, hash_size =3D 0;
+    bool done =3D false;
+
+    if (qcrypto_secret_lookup(key_id, &cookie, &cookie_size, errp) =3D=3D=
 0
+            && qcrypto_hash_bytes(QCRYPTO_HASH_ALG_SHA1,
+                                  (const char *)cookie, cookie_size,
+                                  &hash, &hash_size, errp) =3D=3D 0) {
+        if (hash_size =3D=3D QEMU_VMI_COOKIE_HASH_SIZE) {
+            memcpy(cookie_hash, hash, QEMU_VMI_COOKIE_HASH_SIZE);
+            done =3D true;
+        } else {
+            error_setg(errp, "VMI: hash algorithm size mismatch");
+        }
+    }
+
+    g_free(cookie);
+    g_free(hash);
+
+    return done;
+}
+
 static Error *vm_introspection_init(VMIntrospection *i)
 {
     Error *err =3D NULL;
@@ -486,6 +543,15 @@ static Error *vm_introspection_init(VMIntrospection =
*i)
         return err;
     }
=20
+    if (i->keyid) {
+        if (!make_cookie_hash(i->keyid, i->cookie_hash, &err)) {
+            return err;
+        }
+        i->key_with_cookie =3D true;
+    } else {
+        warn_report("VMI: the introspection tool won't be 'authenticated=
'");
+    }
+
     chr =3D qemu_chr_find(i->chardevid);
     if (!chr) {
         error_setg(&err, "VMI: device '%s' not found", i->chardevid);

