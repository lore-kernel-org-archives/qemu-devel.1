Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698DEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3222C21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnDBefIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3222C21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUsA-0003Id-9o
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWZ-00065y-C0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWW-0002Yl-Jr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWU-0002VT-L8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WIgv+99fVQZsaEz7YPvw8reoHX0PjBuDeUHEDbQX4o=;
 b=hnDBefIQt6GXVsM643PMDaWveVZL46qdzrCAPPfpbOea8XtQmCtw5ZFn+UeyrdL5lAlM3H
 +Bf3F5yKou7VhUgEqoThECZy3mzhTQyui5UzWbI6qL7ryJt31lhgApMEOMsh6RrYdCoHCQ
 zTm1dgZmwyT+uDqzQ+UxyV/LTIrS5t0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-U3Y3aGt1MUK62gKRYmYCfg-1; Wed, 18 Dec 2019 03:17:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B809DB2B;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A1A468888;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E03591136433; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 35/35] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Date: Wed, 18 Dec 2019 09:17:21 +0100
Message-Id: <20191218081721.23520-36-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: U3Y3aGt1MUK62gKRYmYCfg-1
X-Mimecast-Spam-Score: 0
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

All callers of nbd_iter_channel_error() pass the address of a
local_err variable, and only call this function if an error has
already occurred, using this function to propagate that error.
This is already implied by its name (local_err instead of the classic
errp), but it is worth additionally stressing this by adding an
assertion to make it part of the function contract.

The local_err parameter is not here to return information about
nbd_iter_channel_error failure. Instead it's assumed to be filled when
passed to the function. This is already stressed by its name
(local_err, instead of classic errp). Stress it additionally by
assertion.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20191205174635.18758-22-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index 5f18f78a94..d085554f21 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -866,6 +866,7 @@ typedef struct NBDReplyChunkIter {
 static void nbd_iter_channel_error(NBDReplyChunkIter *iter,
                                    int ret, Error **local_err)
 {
+    assert(local_err && *local_err);
     assert(ret < 0);
=20
     if (!iter->ret) {
--=20
2.21.0


