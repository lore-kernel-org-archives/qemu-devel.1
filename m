Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCEFCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04AC121A4C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhFLODuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AC121A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJRI-0000AE-1z
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNIXJ-0005Gh-Gd
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNIXH-0002il-Dz
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:26:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38037
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNIXF-0002gq-De
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571844411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5LhvtZSfFq0VX5A7OuDSQtwwsHYnVMcy/wI7iSilQc=;
 b=NhFLODuWfKE/wCsgupk+uRrCWauDpTZ0FLghGEfBD0hiSVBwvcCs52udny7B2Ept1kU7Q9
 aawhQfcGY4R2VzecKPxkE4vAb49+QeiBAQz8uxtUl6poya+DyVOqGsy4cFYAzQTPVMpbgk
 dSXBIKfZDIZSvsch9PS5M6nZ8USZePQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-T5EIT1y5NdaTF3P0VLOOoA-1; Wed, 23 Oct 2019 11:26:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3326800D4E;
 Wed, 23 Oct 2019 15:26:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-192.ams2.redhat.com
 [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8101960852;
 Wed, 23 Oct 2019 15:26:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] coroutine: Add qemu_co_mutex_assert_locked()
Date: Wed, 23 Oct 2019 17:26:18 +0200
Message-Id: <20191023152620.13166-2-kwolf@redhat.com>
In-Reply-To: <20191023152620.13166-1-kwolf@redhat.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: T5EIT1y5NdaTF3P0VLOOoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, psyhomb@gmail.com, michael@weiser.dinsnail.net,
 vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some functions require that the caller holds a certain CoMutex for them
to operate correctly. Add a function so that they can assert the lock is
really held.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/coroutine.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9801e7f5a4..a36bcfe5c8 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -167,6 +167,13 @@ void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex);
  */
 void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
=20
+/**
+ * Assert that the current coroutine holds @mutex.
+ */
+static inline coroutine_fn void qemu_co_mutex_assert_locked(CoMutex *mutex=
)
+{
+    assert(mutex->locked && mutex->holder =3D=3D qemu_coroutine_self());
+}
=20
 /**
  * CoQueues are a mechanism to queue coroutines in order to continue execu=
ting
--=20
2.20.1


