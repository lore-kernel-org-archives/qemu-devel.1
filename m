Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D84C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BAE21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ee5zCcJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BAE21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOmJ-0003s5-Tz
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOek-0002zz-5Q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOeb-0005eJ-T0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24478
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOea-0005bc-Ep
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pe09oFj+dplfSAmWzK13nOJ+j8pDv/xrYGnj1YjPya4=;
 b=Ee5zCcJFqU2kOWHFzOzw6f6zYrWsQWNLn4r8jUJ/T5Yzv9+cqpe+TMsqR7vQK0QmCcUh+J
 t1DD8oWTlqc+WccRoHTxS2XPv2PsecZfPcf6nPt0Q6OSswPP4zDbaaQvK9mR1g6vBWLDoP
 48E2L00CKDrkCISLAg1cYcsH/8p19x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-4QlvFONpMYqfMy2ZRD_CXg-1; Tue, 17 Dec 2019 21:01:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A303800053
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:01:25 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA6419C58;
 Wed, 18 Dec 2019 02:01:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/10] migration: Increase default number of multifd
 channels to 16
Date: Wed, 18 Dec 2019 03:01:10 +0100
Message-Id: <20191218020119.3776-2-quintela@redhat.com>
In-Reply-To: <20191218020119.3776-1-quintela@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4QlvFONpMYqfMy2ZRD_CXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can scale much better with 16, so we can scale to higher numbers.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..e7f707e033 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -86,7 +86,7 @@
=20
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
-#define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
+#define DEFAULT_MIGRATE_MULTIFD_CHANNELS 16
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
--=20
2.23.0


