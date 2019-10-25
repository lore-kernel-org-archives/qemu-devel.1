Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FC6222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKBeCNaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FC6222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO045-0005Bn-GD
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNzvi-0007Bh-Fp
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNzvh-0000Tq-Cs
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:47:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNzvh-0000Re-9i
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0n/tv09jMUDXbhtmyy4n6WZbW8UGYVKae0qHmyHw8o=;
 b=YKBeCNaqSuZ4XzRrKiwTyHHIH6XSXHWMDeOT5FawZqlw6FSAUPr/KTuNQNisgxfngv07D4
 hAQgz81E44Fq0vjLcbDYuwBSpZ4arBM239z4p+rigeuBVuFSOCtU6uRFuwVMAgkPnLoo73
 POMzXBFWzQMGAqJVF0B9VsDWr0y9CYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-8UIjjYuyO_WEfv7UZMmbUg-1; Fri, 25 Oct 2019 09:46:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97BF8801E5C;
 Fri, 25 Oct 2019 13:46:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90C2D5D70E;
 Fri, 25 Oct 2019 13:46:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 6/7] coroutine: Add qemu_co_mutex_assert_locked()
Date: Fri, 25 Oct 2019 15:46:10 +0200
Message-Id: <20191025134611.25920-7-kwolf@redhat.com>
In-Reply-To: <20191025134611.25920-1-kwolf@redhat.com>
References: <20191025134611.25920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 8UIjjYuyO_WEfv7UZMmbUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some functions require that the caller holds a certain CoMutex for them
to operate correctly. Add a function so that they can assert the lock is
really held.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/coroutine.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 8d55663062..dfd261c5b1 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -167,6 +167,21 @@ void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex);
  */
 void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
=20
+/**
+ * Assert that the current coroutine holds @mutex.
+ */
+static inline coroutine_fn void qemu_co_mutex_assert_locked(CoMutex *mutex=
)
+{
+    /*
+     * mutex->holder doesn't need any synchronisation if the assertion hol=
ds
+     * true because the mutex protects it. If it doesn't hold true, we sti=
ll
+     * don't mind if another thread takes or releases mutex behind our bac=
k,
+     * because the condition will be false no matter whether we read NULL =
or
+     * the pointer for any other coroutine.
+     */
+    assert(atomic_read(&mutex->locked) &&
+           mutex->holder =3D=3D qemu_coroutine_self());
+}
=20
 /**
  * CoQueues are a mechanism to queue coroutines in order to continue execu=
ting
--=20
2.20.1


