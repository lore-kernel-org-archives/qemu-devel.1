Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C92C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 04:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B319420869
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 04:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B319420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iE47W-0000Mm-P3
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 00:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iE46c-0008Gc-HI
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 00:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iE46b-0000XJ-H3
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 00:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iE46X-0000VX-O3; Sat, 28 Sep 2019 00:13:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59D10A44AD1;
 Sat, 28 Sep 2019 04:13:08 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE8405D6B0;
 Sat, 28 Sep 2019 04:13:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] nbd: Don't let client send oversize strings
Date: Fri, 27 Sep 2019 23:13:01 -0500
Message-Id: <20190928041301.16296-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Sat, 28 Sep 2019 04:13:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Qemu as server currently won't accept export names larger than 256
bytes, so most uses of qemu as client have no reason to get anywhere
near the NBD spec maximum of a 4k limit per string.  However, we
didn't actually have any code that prevented the client from violating
the protocol, which, while useful for testing corner-case server
reactions, is probably not ideal.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 1 +
 nbd/client.c        | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 316fd705a9e4..fcabdf0f37c3 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -232,6 +232,7 @@ enum {
  * going larger would require an audit of more code to make sure we
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256
+#define NBD_MAX_STRING_SIZE 4096

 /* Two types of reply structures */
 #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
diff --git a/nbd/client.c b/nbd/client.c
index f6733962b49b..3f21722dd914 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -648,6 +648,10 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint=
32_t opt,
     if (query) {
         query_len =3D strlen(query);
         data_len +=3D sizeof(query_len) + query_len;
+        if (query_len > NBD_MAX_STRING_SIZE) {
+            error_setg(errp, "x_dirty_bitmap query too long to send to s=
erver");
+            return -1;
+        }
     } else {
         assert(opt =3D=3D NBD_OPT_LIST_META_CONTEXT);
     }
@@ -1010,6 +1014,10 @@ int nbd_receive_negotiate(AioContext *aio_context,=
 QIOChannel *ioc,
     bool base_allocation =3D info->base_allocation;

     assert(info->name);
+    if (strlen(info->name) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "name too long to send to server");
+        return -EINVAL;
+    }
     trace_nbd_receive_negotiate_name(info->name);

     result =3D nbd_start_negotiate(aio_context, ioc, tlscreds, hostname,=
 outioc,
--=20
2.21.0


