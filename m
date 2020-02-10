Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34ADC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A6F20838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrTpEYWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A6F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1FD0-0004Os-LL
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 14:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1FBj-0003VA-Ti
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1FBh-0004R8-4H
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:57:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1FBf-0004L1-OB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581364662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YDxbMOL8278v2eAuhQNrtyvDRNk1lYQ1Aa++SPQMVRY=;
 b=WrTpEYWRuDneW22WmDP96l3065Q1+fi3hf6DlF016CGH7Lor3Fs1f4qlwj0FBLufCGS4VM
 zU7B6fAqBcsXtYef5mLn5bDwRUf5dOL49ldx3oPkRfYcR4z3M/SIO0EOhfed+r1aeSuq7u
 keSB+hTT1RSKu7y4g82xKyJi5i2bo0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-bsJezthePEm4fsuIbING-g-1; Mon, 10 Feb 2020 14:57:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F02E38052E8
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 19:57:39 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-112.ams2.redhat.com
 [10.36.117.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D67D8859BF;
 Mon, 10 Feb 2020 19:57:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
Subject: [PATCH] tests/migration: Add some slack to auto converge
Date: Mon, 10 Feb 2020 19:57:31 +0000
Message-Id: <20200210195731.177595-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bsJezthePEm4fsuIbING-g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: philmd@redhat.com
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


