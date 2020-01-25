Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 17:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D50C2070A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVfBKVWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D50C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivPE3-0000li-FK
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 12:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ivPBC-000640-CR
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ivPBA-00086d-G3
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:25:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ivPBA-0007xT-Au
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579973102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CYRkzMGr0qa4lzTOn1tCfqrIUWVP++89tVcGXamSgg0=;
 b=hVfBKVWgMcPh5CIeuoEfru2gSSbgUgQgQ8J4umFzyHMr7sBNrL1TnwzWC+Uq4l+zfH/2lU
 WNaJ5j8YRkS0Bb7aBEwACy3dANW6YhXzdCS+jADlyhbdZdad6Bmn33xKuHDRwEKDqtvJxz
 xvWgUduJ6TQbx/n8blFE4l4jIObW3Vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-1r9HeJ-YNZGI1g2H6C76tw-1; Sat, 25 Jan 2020 12:25:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E528B18543A4;
 Sat, 25 Jan 2020 17:24:59 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AB2E8E5E2;
 Sat, 25 Jan 2020 17:24:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH] migration: Simplify get_qlist
Date: Sat, 25 Jan 2020 18:24:49 +0100
Message-Id: <20200125172449.13175-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1r9HeJ-YNZGI1g2H6C76tw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of inserting read elements at the head and
then reversing the list, it is simpler to add
each element after the previous one. Introduce
QLIST_RAW_INSERT_AFTER helper and use it in
get_qlist().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Juan Quintela <quintela@redhat.com>

---
---
 include/qemu/queue.h      | 19 ++++++-------------
 migration/vmstate-types.c | 10 +++++++---
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 4d4554a7ce..19425f973f 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -515,6 +515,12 @@ union {                                               =
                  \
              (elm);                                                       =
     \
              (elm) =3D *QLIST_RAW_NEXT(elm, entry))
=20
+#define QLIST_RAW_INSERT_AFTER(head, prev, elem, entry) do {              =
     \
+        *QLIST_RAW_NEXT(prev, entry) =3D elem;                            =
       \
+        *QLIST_RAW_PREVIOUS(elem, entry) =3D QLIST_RAW_NEXT(prev, entry); =
       \
+        *QLIST_RAW_NEXT(elem, entry) =3D NULL;                            =
       \
+} while (0)
+
 #define QLIST_RAW_INSERT_HEAD(head, elm, entry) do {                      =
     \
         void *first =3D *QLIST_RAW_FIRST(head);                           =
       \
         *QLIST_RAW_FIRST(head) =3D elm;                                   =
       \
@@ -527,17 +533,4 @@ union {                                               =
                  \
         }                                                                 =
     \
 } while (0)
=20
-#define QLIST_RAW_REVERSE(head, elm, entry) do {                          =
     \
-        void *iter =3D *QLIST_RAW_FIRST(head), *prev =3D NULL, *next;     =
         \
-        while (iter) {                                                    =
     \
-            next =3D *QLIST_RAW_NEXT(iter, entry);                        =
       \
-            *QLIST_RAW_PREVIOUS(iter, entry) =3D QLIST_RAW_NEXT(next, entr=
y);    \
-            *QLIST_RAW_NEXT(iter, entry) =3D prev;                        =
       \
-            prev =3D iter;                                                =
       \
-            iter =3D next;                                                =
       \
-        }                                                                 =
     \
-        *QLIST_RAW_FIRST(head) =3D prev;                                  =
       \
-        *QLIST_RAW_PREVIOUS(prev, entry) =3D QLIST_RAW_FIRST(head);       =
       \
-} while (0)
-
 #endif /* QEMU_SYS_QUEUE_H */
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 1eee36773a..35e784c9d9 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -879,7 +879,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unus=
ed_size,
     /* offset of the QLIST entry in a QLIST element */
     size_t entry_offset =3D field->start;
     int version_id =3D field->version_id;
-    void *elm;
+    void *elm, *prev =3D NULL;
=20
     trace_get_qlist(field->name, vmsd->name, vmsd->version_id);
     if (version_id > vmsd->version_id) {
@@ -900,9 +900,13 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unu=
sed_size,
             g_free(elm);
             return ret;
         }
-        QLIST_RAW_INSERT_HEAD(pv, elm, entry_offset);
+        if (!prev) {
+            QLIST_RAW_INSERT_HEAD(pv, elm, entry_offset);
+        } else {
+            QLIST_RAW_INSERT_AFTER(pv, prev, elm, entry_offset);
+        }
+        prev =3D elm;
     }
-    QLIST_RAW_REVERSE(pv, elm, entry_offset);
     trace_get_qlist_end(field->name, vmsd->name);
=20
     return ret;
--=20
2.20.1


