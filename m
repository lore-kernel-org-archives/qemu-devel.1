Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0010ECA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7CB20679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erUmzOWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7CB20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIyD-0003tY-EO
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNIXN-0005ND-BD
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNIXM-0002lX-9J
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:27:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNIXM-0002l9-5t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571844419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qo4k4Dw+pnxV7TbicL18z1fOMWIRfsoSaltyjb9eTJE=;
 b=erUmzOWtDr4Fj6M+m4nm0vJePxVB8PVg4mJ/hfjS74TOt1uhV9EErxtf9KJMRWxOgA0XGr
 jpWQIIySxJvjvwnf8Hz7jD7mwtzv8g8liXOsndiwUCnUuzBxBD6tZv8hABdY2bjhr85exD
 DQD89WSxQHACIPabDddy2pOzvICQmfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-ySeDEXHHOMO2UOw_IhgC1w-1; Wed, 23 Oct 2019 11:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F4F31005500;
 Wed, 23 Oct 2019 15:26:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-192.ams2.redhat.com
 [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B7B4608C1;
 Wed, 23 Oct 2019 15:26:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold s->lock
Date: Wed, 23 Oct 2019 17:26:19 +0200
Message-Id: <20191023152620.13166-3-kwolf@redhat.com>
In-Reply-To: <20191023152620.13166-1-kwolf@redhat.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ySeDEXHHOMO2UOw_IhgC1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, psyhomb@gmail.com, michael@weiser.dinsnail.net,
 vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcow2_cache_do_get() requires that s->lock is locked because it can
yield between picking a cache entry and actually taking ownership of it
by setting offset and increasing the reference count.

Add an assertion to make sure the caller really holds the lock. The
function can be called outside of coroutine context, where bdrv_pread
and flushes become synchronous operations. The lock cannot and need not
be taken in this case.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cache.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d29b038a67..75b13dad99 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -327,6 +327,9 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qco=
w2Cache *c,
     int min_lru_index =3D -1;
=20
     assert(offset !=3D 0);
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_assert_locked(&s->lock);
+    }
=20
     trace_qcow2_cache_get(qemu_coroutine_self(), c =3D=3D s->l2_table_cach=
e,
                           offset, read_from_disk);
@@ -386,6 +389,8 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qco=
w2Cache *c,
         }
     }
=20
+    assert(c->entries[i].ref =3D=3D 0);
+    assert(c->entries[i].offset =3D=3D 0);
     c->entries[i].offset =3D offset;
=20
     /* And return the right table */
--=20
2.20.1


