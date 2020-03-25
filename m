Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B5C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A0320722
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh3mpQrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4H2-0004T5-HD
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jH4GE-0003zH-BB
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jH4GC-0008WR-E2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:31:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jH4GA-0008Ue-NG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585135906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ADhyqoaLt6DcqJ8sM3Qvfm4Xy8hvMvhIt5oKXH6LCHg=;
 b=Oh3mpQrZtdv3q5EDqLaVO19TlCzU/97S3DV0HAtpcj6El5O/RrEHQb9h0yWjzoP8HQSfmK
 XZZ8O57LBLcFs+436zcqxNTMTinNV92kx6jo8Hm38NVlJPswsnbkDuqMbSKhe0Tv+PPCSV
 diSqp4Ko52XJY3htyS2AK9W+qllrQ/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-kJ1mu_gSO82aOs1NllnguA-1; Wed, 25 Mar 2020 07:31:44 -0400
X-MC-Unique: kJ1mu_gSO82aOs1NllnguA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E01F107ACCD
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:31:43 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-112-233.ams2.redhat.com [10.36.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A42719C70;
 Wed, 25 Mar 2020 11:31:39 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Acceptance test: Fix to EXEC migration
Date: Wed, 25 Mar 2020 13:31:37 +0200
Message-Id: <20200325113138.20337-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The exec migration test isn't run a whole test scenario.
This patch fixes it

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a8367ca023..0365289cda 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -70,8 +70,8 @@ class Migration(Test):
=20
     @skipUnless(find_command('nc', default=3DFalse), "'nc' command not fou=
nd")
     def test_migration_with_exec(self):
-        """
-        The test works for both netcat-traditional and netcat-openbsd pack=
ages
-        """
+        """The test works for both netcat-traditional and netcat-openbsd p=
ackages."""
         free_port =3D self._get_free_port()
         dest_uri =3D 'exec:nc -l localhost %u' % free_port
+        src_uri =3D 'exec:nc localhost %u' % free_port
+        self.do_migrate(dest_uri, src_uri)
--=20
2.21.1


