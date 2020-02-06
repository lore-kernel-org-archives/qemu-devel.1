Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14ABC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF6C214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JagYwE+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF6C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgsz-00021J-RH
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izge6-00051A-SS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izge4-00042R-EP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izge4-00040z-Au
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7wux+wTHX0FdahFdVQMvw9ct0piSALKAkVkc8PnqIc=;
 b=JagYwE+5nhxtQ2+VDyhdQ/RE+AO4+sdkbDktXwpRmoBJsZoBKHLArw7TWja66o7wixvTPt
 B1Ut9X78dZPCtAlq0VF6qB8jnkDvt7H0WdxsYJGZNC7LpZ6yY/qtL8Vax+FfH+kmiJOtjd
 6NvDBcW9CSVcJJaMWiaZFDHov8crNlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-UcY89iJVPkG_gFi0wDm6yg-1; Thu, 06 Feb 2020 07:52:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6216800D54;
 Thu,  6 Feb 2020 12:52:29 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 026EA5DA7C;
 Thu,  6 Feb 2020 12:52:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] nbd: Allow description when creating NBD blockdev
Date: Thu,  6 Feb 2020 06:52:22 -0600
Message-Id: <20200206125224.3819972-2-eblake@redhat.com>
In-Reply-To: <20200206125224.3819972-1-eblake@redhat.com>
References: <20200206125224.3819972-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: UcY89iJVPkG_gFi0wDm6yg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow blockdevs to match the feature already present in qemu-nbd -D.
Enhance iotest 223 to cover it.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20191114024635.11363-5-eblake@redhat.com>
---
 blockdev-nbd.c             | 9 ++++++++-
 monitor/hmp-cmds.c         | 4 ++--
 qapi/block.json            | 9 ++++++---
 tests/qemu-iotests/223     | 2 +-
 tests/qemu-iotests/223.out | 6 ++++--
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 8c20baa4a4b9..de2f2ff71320 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -144,6 +144,7 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
 }

 void qmp_nbd_server_add(const char *device, bool has_name, const char *nam=
e,
+                        bool has_description, const char *description,
                         bool has_writable, bool writable,
                         bool has_bitmap, const char *bitmap, Error **errp)
 {
@@ -167,6 +168,11 @@ void qmp_nbd_server_add(const char *device, bool has_n=
ame, const char *name,
         return;
     }

+    if (has_description && strlen(description) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "description '%s' too long", description);
+        return;
+    }
+
     if (nbd_export_find(name)) {
         error_setg(errp, "NBD server already has export named '%s'", name)=
;
         return;
@@ -195,7 +201,8 @@ void qmp_nbd_server_add(const char *device, bool has_na=
me, const char *name,
         writable =3D false;
     }

-    exp =3D nbd_export_new(bs, 0, len, name, NULL, bitmap, !writable, !wri=
table,
+    exp =3D nbd_export_new(bs, 0, len, name, description, bitmap,
+                         !writable, !writable,
                          NULL, false, on_eject_blk, errp);
     if (!exp) {
         goto out;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index d0e0af893a66..558fe06b8f7c 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2351,7 +2351,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *=
qdict)
             continue;
         }

-        qmp_nbd_server_add(info->value->device, false, NULL,
+        qmp_nbd_server_add(info->value->device, false, NULL, false, NULL,
                            true, writable, false, NULL, &local_err);

         if (local_err !=3D NULL) {
@@ -2373,7 +2373,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qd=
ict)
     bool writable =3D qdict_get_try_bool(qdict, "writable", false);
     Error *local_err =3D NULL;

-    qmp_nbd_server_add(device, !!name, name, true, writable,
+    qmp_nbd_server_add(device, !!name, name, false, NULL, true, writable,
                        false, NULL, &local_err);
     hmp_handle_error(mon, local_err);
 }
diff --git a/qapi/block.json b/qapi/block.json
index 145c268bb646..7898104dae42 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -250,9 +250,12 @@
 # @name: Export name. If unspecified, the @device parameter is used as the
 #        export name. (Since 2.12)
 #
+# @description: Free-form description of the export, up to 4096 bytes.
+#               (Since 5.0)
+#
 # @writable: Whether clients should be able to write to the device via the
 #     NBD connection (default false).
-
+#
 # @bitmap: Also export the dirty bitmap reachable from @device, so the
 #          NBD client can use NBD_OPT_SET_META_CONTEXT with
 #          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
@@ -263,8 +266,8 @@
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-add',
-  'data': {'device': 'str', '*name': 'str', '*writable': 'bool',
-           '*bitmap': 'str' } }
+  'data': {'device': 'str', '*name': 'str', '*description': 'str',
+           '*writable': 'bool', '*bitmap': 'str' } }

 ##
 # @NbdServerRemoveMode:
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index ea69cd4b8b5e..56fbc5fb09a0 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -153,7 +153,7 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add=
",
   "bitmap":"b3"}}' "error" # Missing bitmap
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2", "writable":true,
-  "bitmap":"b2"}}' "return"
+  "description":"some text", "bitmap":"b2"}}' "return"
 $QEMU_NBD_PROG -L -k "$SOCK_DIR/nbd"

 echo
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index f17559880268..80c0cf65095b 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -50,7 +50,7 @@ exports available: 0
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompati=
ble with readonly export"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b3"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'b3' is not found"}}
-{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "writ=
able":true, "bitmap":"b2"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "writ=
able":true, "description":"some text", "bitmap":"b2"}}
 {"return": {}}
 exports available: 2
  export: 'n'
@@ -63,6 +63,7 @@ exports available: 2
    base:allocation
    qemu:dirty-bitmap:b
  export: 'n2'
+  description: some text
   size:  4194304
   flags: 0xced ( flush fua trim zeroes df cache fast-zero )
   min block: 1
@@ -130,7 +131,7 @@ exports available: 0
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompati=
ble with readonly export"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b3"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'b3' is not found"}}
-{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "writ=
able":true, "bitmap":"b2"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "writ=
able":true, "description":"some text", "bitmap":"b2"}}
 {"return": {}}
 exports available: 2
  export: 'n'
@@ -143,6 +144,7 @@ exports available: 2
    base:allocation
    qemu:dirty-bitmap:b
  export: 'n2'
+  description: some text
   size:  4194304
   flags: 0xced ( flush fua trim zeroes df cache fast-zero )
   min block: 1
--=20
2.24.1


