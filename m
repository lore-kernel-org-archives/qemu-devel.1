Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624AFC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F032073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+7mlO5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F032073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThN8-0001Qs-Cb
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh28-0007uN-R4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1i-0003zp-Sf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1h-0003v5-NG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wH9qFb1vz2F+UQwonoBfny/s8QXIKAguywZ3WwtIZ4Y=;
 b=R+7mlO5pNB5eIc4L8qxat0S6o7S+XHa6FnsM38HM38+KRBG3cz5f4qjBPdEQxJI4e2ISzj
 WFdmcfohUwB6l8yo+SVZzbkpuMf5wlf+gox79LqNMrn6ye1wbrh3DFTU2rOvoAZeSKc0vE
 gXELUAtI8+weZxi1fjhlKjXxLeJyAik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-csiLGFbeOgWZNSc8JbmkmA-1; Wed, 29 Apr 2020 03:20:56 -0400
X-MC-Unique: csiLGFbeOgWZNSc8JbmkmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453AA1009447
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 169E910021B3;
 Wed, 29 Apr 2020 07:20:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1016E11358C8; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/32] block/file-posix: Fix check_cache_dropped() error
 handling
Date: Wed, 29 Apr 2020 09:20:28 +0200
Message-Id: <20200429072048.29963-13-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

check_cache_dropped() calls error_setg() in a loop.  It fails to break
the loop in one instance.  If a subsequent iteration error_setg()s
again, it trips error_setv()'s assertion.

Fix it to break the loop.

Fixes: 31be8a2a97ecba7d31a82932286489cac318e9e9
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200422130719.28225-3-armbru@redhat.com>
---
 block/file-posix.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 7e19bbff5f..094e3b0212 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2691,10 +2691,13 @@ static void check_cache_dropped(BlockDriverState *b=
s, Error **errp)
         vec_end =3D DIV_ROUND_UP(length, page_size);
         for (i =3D 0; i < vec_end; i++) {
             if (vec[i] & 0x1) {
-                error_setg(errp, "page cache still in use!");
                 break;
             }
         }
+        if (i < vec_end) {
+            error_setg(errp, "page cache still in use!");
+            break;
+        }
     }
=20
     if (window) {
--=20
2.21.1


