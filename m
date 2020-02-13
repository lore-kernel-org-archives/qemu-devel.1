Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF97DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B24924670
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RitP0hbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B24924670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ERo-00086u-P4
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2EQZ-0006UU-3I
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2EQY-0007pX-5r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2EQY-0007p8-1t
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581600069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ouxemjEQjJZWO36TxE/ocS3VG6z8bD5gZUW9n4giJ10=;
 b=RitP0hbONUnevO0wmputTcg6FwwXlMbraBgnxOvtxfQFNVzl9Z58FRJg9OXKBGwxpYOdDi
 /SIcy71YdmqFvFQhyPZ5j9WrOSFkzR2GCgrHSnnoAs9bq0Zrua0aY0N2RdVcXWbvqBHR2b
 DEGzL6ipiPxuSxgyI/G7y9W423PsdaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-4XgtjMKGMNiDPzTiRB2F7Q-1; Thu, 13 Feb 2020 08:21:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEEB5802CBC
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 13:21:05 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79D575C54A;
 Thu, 13 Feb 2020 13:20:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] tests/migration: Add some slack to auto converge
Date: Thu, 13 Feb 2020 14:20:28 +0100
Message-Id: <20200213132030.57757-5-quintela@redhat.com>
In-Reply-To: <20200213132030.57757-1-quintela@redhat.com>
References: <20200213132030.57757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4XgtjMKGMNiDPzTiRB2F7Q-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

There's an assert in autoconverge that checks that we quit the
iteration when we go below the expected threshold.  Philippe
saw a case where this assert fired with the measured value
slightly over the threshold. (about 3k out of a few million).

I can think of two reasons:
  a) Rounding errors
  b) That after we make the decision to quit iteration we do one
    more sync and that sees a few more dirty pages.

So add 1% slack to the assertion, that should cover a and
most cases of b, probably all we'll see for the test.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index cf27ebbc9d..a78ac0c7da 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1237,7 +1237,8 @@ static void test_migrate_auto_converge(void)
     g_assert_cmpint(percentage, <=3D, max_pct);
=20
     remaining =3D read_ram_property_int(from, "remaining");
-    g_assert_cmpint(remaining, <, expected_threshold);
+    g_assert_cmpint(remaining, <,
+                    (expected_threshold + expected_threshold / 100));
=20
     migrate_continue(from, "pre-switchover");
=20
--=20
2.24.1


