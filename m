Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ACCC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59AD2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cW7hUOFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59AD2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQRxM-0005cR-32
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56484 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrC-0002tj-EO
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:46 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrA-0006wX-Kl
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54063
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQRrA-0006ue-7R
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587371563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IwJuUhdu7xVAnYSveDtWGbyVZ74+1IB1yT93ItMesU=;
 b=cW7hUOFznlHN6rY7Znw/lNlR+Z2iSCpsYBrE4o90YNa+6JaWIJngfqzABycHfduJI7ea6c
 gW3pqXDlf4Ie2fBGT31T8iZQybC/3H9Li0PcYmukIoRnM0+eGRhVzlEI/COz8q4sMbcagg
 8FyRAqxCbuIJavVHET9l4blNaXhmv2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-DwqgQ15fM1WjDn9fWgMn0Q-1; Mon, 20 Apr 2020 04:32:41 -0400
X-MC-Unique: DwqgQ15fM1WjDn9fWgMn0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02FA0DB21
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:32:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 424995D9CD;
 Mon, 20 Apr 2020 08:32:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A29ED11358BE; Mon, 20 Apr 2020 10:32:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] block/file-posix: Fix check_cache_dropped() error
 handling
Date: Mon, 20 Apr 2020 10:32:27 +0200
Message-Id: <20200420083236.19309-3-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-1-armbru@redhat.com>
References: <20200420083236.19309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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


