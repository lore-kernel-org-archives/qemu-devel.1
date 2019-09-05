Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E625DC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FDE2070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FDE2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5wUX-00064G-Pd
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 14:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5wOG-0006lZ-So
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5wOF-0006NX-Ds
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5wOC-0006CY-2N; Thu, 05 Sep 2019 14:21:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5747710F23F8;
 Thu,  5 Sep 2019 18:21:47 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB4895D6A3;
 Thu,  5 Sep 2019 18:21:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 13:21:30 -0500
Message-Id: <20190905182132.3563-8-eblake@redhat.com>
In-Reply-To: <20190905182132.3563-1-eblake@redhat.com>
References: <20190905182132.3563-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 05 Sep 2019 18:21:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/9] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit fe0480d6 and friends added BDRV_REQ_NO_FALLBACK as a way to
avoid wasting time on a preliminary write-zero request that will later
be rewritten by actual data, if it is known that the write-zero
request will use a slow fallback; but in doing so, could not optimize
for NBD.  The NBD specification is now considering an extension that
will allow passing on those semantics; this patch updates the new
protocol bits and 'qemu-nbd --list' output to recognize the bit, as
well as the new errno value possible when using the new flag; while
upcoming patches will improve the client to use the feature when
present, and the server to advertise support for it.

The NBD spec recommends (but not requires) that ENOTSUP be avoided for
all but failures of a fast zero (the only time it is mandatory to
avoid an ENOTSUP failure is when fast zero is supported but not
requested during write zeroes; the questionable use is for ENOTSUP to
other actions like a normal write request).  However, clients that get
an unexpected ENOTSUP will either already be treating it the same as
EINVAL, or may appreciate the extra bit of information.  We were
equally loose for returning EOVERFLOW in more situations than
recommended by the spec, so if it turns out to be a problem in
practice, a later patch can tighten handling for both error codes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190823143726.27062-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: tweak commit message, also handle EOPNOTSUPP]
---
 docs/interop/nbd.txt | 3 ++-
 include/block/nbd.h  | 4 ++++
 nbd/common.c         | 5 +++++
 nbd/server.c         | 5 +++++
 qemu-nbd.c           | 1 +
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index 6dfec7f47647..45118809618e 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -53,4 +53,5 @@ the operation of that feature.
 * 2.12: NBD_CMD_BLOCK_STATUS for "base:allocation"
 * 3.0: NBD_OPT_STARTTLS with TLS Pre-Shared Keys (PSK),
 NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
-* 4.2: NBD_FLAG_CAN_MULTI_CONN for sharable read-only exports
+* 4.2: NBD_FLAG_CAN_MULTI_CONN for sharable read-only exports,
+NBD_CMD_FLAG_FAST_ZERO
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 2c87b42dfd48..21550747cf35 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -140,6 +140,7 @@ enum {
     NBD_FLAG_CAN_MULTI_CONN_BIT     =3D  8, /* Multi-client cache consis=
tent */
     NBD_FLAG_SEND_RESIZE_BIT        =3D  9, /* Send resize */
     NBD_FLAG_SEND_CACHE_BIT         =3D 10, /* Send CACHE (prefetch) */
+    NBD_FLAG_SEND_FAST_ZERO_BIT     =3D 11, /* FAST_ZERO flag for WRITE_=
ZEROES */
 };

 #define NBD_FLAG_HAS_FLAGS         (1 << NBD_FLAG_HAS_FLAGS_BIT)
@@ -153,6 +154,7 @@ enum {
 #define NBD_FLAG_CAN_MULTI_CONN    (1 << NBD_FLAG_CAN_MULTI_CONN_BIT)
 #define NBD_FLAG_SEND_RESIZE       (1 << NBD_FLAG_SEND_RESIZE_BIT)
 #define NBD_FLAG_SEND_CACHE        (1 << NBD_FLAG_SEND_CACHE_BIT)
+#define NBD_FLAG_SEND_FAST_ZERO    (1 << NBD_FLAG_SEND_FAST_ZERO_BIT)

 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
@@ -205,6 +207,7 @@ enum {
 #define NBD_CMD_FLAG_DF         (1 << 2) /* don't fragment structured re=
ad */
 #define NBD_CMD_FLAG_REQ_ONE    (1 << 3) /* only one extent in BLOCK_STA=
TUS
                                           * reply chunk */
+#define NBD_CMD_FLAG_FAST_ZERO  (1 << 4) /* fail if WRITE_ZEROES is not =
fast */

 /* Supported request types */
 enum {
@@ -270,6 +273,7 @@ static inline bool nbd_reply_type_is_error(int type)
 #define NBD_EINVAL     22
 #define NBD_ENOSPC     28
 #define NBD_EOVERFLOW  75
+#define NBD_ENOTSUP    95
 #define NBD_ESHUTDOWN  108

 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
diff --git a/nbd/common.c b/nbd/common.c
index cc8b278e541d..ddfe7d118371 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -201,6 +201,8 @@ const char *nbd_err_lookup(int err)
         return "ENOSPC";
     case NBD_EOVERFLOW:
         return "EOVERFLOW";
+    case NBD_ENOTSUP:
+        return "ENOTSUP";
     case NBD_ESHUTDOWN:
         return "ESHUTDOWN";
     default:
@@ -231,6 +233,9 @@ int nbd_errno_to_system_errno(int err)
     case NBD_EOVERFLOW:
         ret =3D EOVERFLOW;
         break;
+    case NBD_ENOTSUP:
+        ret =3D ENOTSUP;
+        break;
     case NBD_ESHUTDOWN:
         ret =3D ESHUTDOWN;
         break;
diff --git a/nbd/server.c b/nbd/server.c
index d5078f7468af..4992148de1c4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -55,6 +55,11 @@ static int system_errno_to_nbd_errno(int err)
         return NBD_ENOSPC;
     case EOVERFLOW:
         return NBD_EOVERFLOW;
+    case ENOTSUP:
+#if ENOTSUP !=3D EOPNOTSUPP
+    case EOPNOTSUPP:
+#endif
+        return NBD_ENOTSUP;
     case ESHUTDOWN:
         return NBD_ESHUTDOWN;
     case EINVAL:
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ae841150760e..9032b6de2ace 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -294,6 +294,7 @@ static int qemu_nbd_client_list(SocketAddress *saddr,=
 QCryptoTLSCreds *tls,
                 [NBD_FLAG_CAN_MULTI_CONN_BIT]       =3D "multi",
                 [NBD_FLAG_SEND_RESIZE_BIT]          =3D "resize",
                 [NBD_FLAG_SEND_CACHE_BIT]           =3D "cache",
+                [NBD_FLAG_SEND_FAST_ZERO_BIT]       =3D "fast-zero",
             };

             printf("  size:  %" PRIu64 "\n", list[i].size);
--=20
2.21.0


