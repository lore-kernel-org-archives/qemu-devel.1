Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C624206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/xes4cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C624206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwv3s-0006OJ-M0
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuq1-0007OP-Bz
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuq0-0002t3-E6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuq0-0002qI-9r
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RgfhbTdW/N69ju8x61MEPmXC48AqPEUH+WU3+4iKWA=;
 b=R/xes4cT2J99tbAFb4FSjdqw1bpKnq833If/bRvshTh4wDv7b5jHccdLLEQwk8j1j6XoXG
 pCx1YxNHgo2hNbggHu1lU49reyp9s1TpHkGqQpGKFWF/W/KX4jhqhXCripYGUKke03not1
 iks3f3SdDF4gH8TcYWw5c/GmO7w0L3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-ifms6K_HNY6hM2bHC8FTSQ-1; Wed, 29 Jan 2020 16:25:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EE678017CC;
 Wed, 29 Jan 2020 21:25:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39D9D60BF3;
 Wed, 29 Jan 2020 21:25:23 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 27/29] tests/acceptance/migration: Default to -nodefaults
Date: Wed, 29 Jan 2020 22:23:43 +0100
Message-Id: <20200129212345.20547-28-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ifms6K_HNY6hM2bHC8FTSQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need the default options to run this test.

This fixes errors when running a binary built with
--without-default-devices such:

  ERROR: qemu-system-arm: Unsupported NIC model: virtio-net-pci

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/migration.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a44c1ae58f..d09e5d3fe7 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -32,10 +32,12 @@ class Migration(Test):
=20
=20
     def test_migration_with_tcp_localhost(self):
-        source_vm =3D self.get_vm()
         dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
         dest_vm =3D self.get_vm('-incoming', dest_uri)
+        dest_vm.add_args('-nodefaults')
         dest_vm.launch()
+        source_vm =3D self.get_vm()
+        source_vm.add_args('-nodefaults')
         source_vm.launch()
         source_vm.qmp('migrate', uri=3Ddest_uri)
         wait.wait_for(
--=20
2.21.1


