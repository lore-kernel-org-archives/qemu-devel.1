Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371FCC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CD720842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTXf827x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CD720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1SCe-0008DP-75
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 04:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j1SAO-0004XL-VK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j1SAN-0000k6-Vz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:49:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60023
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j1SAN-0000jt-TA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581414555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T5lkbv7VOEBH6UyHXpdFHxi64kb48QdEc1Ba7+bYC+s=;
 b=PTXf827xf6MSjRugNPXAwLRRf8Kee5vH/Fc1VhWcfcWgAaFw7CvEL/SWAF1728BoVcaRKy
 BQ9KBhJHlRm9RmVMoQw/3uo1J6QTc4zAfQ/FartjedlaUTz8Ri42YUpTkWjYtgOYUHt2HR
 oqR31HFiOuCk7XuROfnZlr9LSOqyKN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-v1K-TQ7kOZuXmgYs5J8PHg-1; Tue, 11 Feb 2020 04:49:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C78B21005502;
 Tue, 11 Feb 2020 09:49:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-79.ams2.redhat.com [10.36.117.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E26F165D3;
 Tue, 11 Feb 2020 09:49:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] qcow2: update_refcount(): Reset old_table_index after
 qcow2_cache_put()
Date: Tue, 11 Feb 2020 10:48:58 +0100
Message-Id: <20200211094900.17315-2-kwolf@redhat.com>
In-Reply-To: <20200211094900.17315-1-kwolf@redhat.com>
References: <20200211094900.17315-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: v1K-TQ7kOZuXmgYs5J8PHg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, pbutsykin@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the case that update_refcount() frees a refcount block, it evicts it
from the metadata cache. Before doing so, however, it returns the
currently used refcount block to the cache because it might be the same.
Returning the refcount block early means that we need to reset
old_table_index so that we reload the refcount block in the next
iteration if it is actually still in use.

Fixes: f71c08ea8e60f035485a512fd2af8908567592f0
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-refcount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f67ac6b2d8..b06a9fa9ce 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -889,6 +889,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(Bloc=
kDriverState *bs,
                                                 offset);
             if (table !=3D NULL) {
                 qcow2_cache_put(s->refcount_block_cache, &refcount_block);
+                old_table_index =3D -1;
                 qcow2_cache_discard(s->refcount_block_cache, table);
             }
=20
--=20
2.20.1


