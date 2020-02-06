Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C6C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5EC21775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQSqnncO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5EC21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izopI-0004Ty-1a
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoaT-0000Fy-2z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoaR-0005JX-Na
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoaR-0005Ez-76
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vK//yiINyqR1YwlnKmG+x4AMYqXU3HV6llVll0Dg1U=;
 b=iQSqnncOfhBQ6JARk/PzvW4VM5ndfofhSzqRU1xcPJbU2sZxv1p+7kKRDPA6UiB/zkTaYT
 TwOqqInaJguzrhAeXjUtXHM4xpZ3l4od+aGo72s5ZUurY1zqoMlMB+uG0xLWKwoPzDghj4
 YJzxN+KeGBF0oMolpcztONVxfk2Ted8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-D_Tu2-5sMAaK63yTWypb7g-1; Thu, 06 Feb 2020 16:21:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B66FDBE8
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:21:20 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B21AF60BEC;
 Thu,  6 Feb 2020 21:21:15 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/46] tests/acceptance/migration: Factor out assert_migration()
Date: Thu,  6 Feb 2020 22:19:15 +0100
Message-Id: <20200206211936.17098-26-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: D_Tu2-5sMAaK63yTWypb7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Oksana Vohchana <ovoshcha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Oksana Vohchana <ovoshcha@redhat.com>

We are going to reuse this code when testing different transport
methods, so factor it out first

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200203111631.18796-2-ovoshcha@redhat.com>
[PMD: Split patch in 2, reworded subject and description]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/migration.py | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a44c1ae58f..3db733b1ce 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -24,6 +24,16 @@ class Migration(Test):
     def migration_finished(vm):
         return vm.command('query-migrate')['status'] in ('completed', 'fai=
led')
=20
+    def assert_migration(self, src_vm, dst_vm):
+        wait.wait_for(self.migration_finished,
+                      timeout=3Dself.timeout,
+                      step=3D0.1,
+                      args=3D(src_vm,))
+        self.assertEqual(src_vm.command('query-migrate')['status'], 'compl=
eted')
+        self.assertEqual(dst_vm.command('query-migrate')['status'], 'compl=
eted')
+        self.assertEqual(dst_vm.command('query-status')['status'], 'runnin=
g')
+        self.assertEqual(src_vm.command('query-status')['status'],'postmig=
rate')
+
     def _get_free_port(self):
         port =3D network.find_free_port()
         if port is None:
@@ -38,13 +48,4 @@ class Migration(Test):
         dest_vm.launch()
         source_vm.launch()
         source_vm.qmp('migrate', uri=3Ddest_uri)
-        wait.wait_for(
-            self.migration_finished,
-            timeout=3Dself.timeout,
-            step=3D0.1,
-            args=3D(source_vm,)
-        )
-        self.assertEqual(dest_vm.command('query-migrate')['status'], 'comp=
leted')
-        self.assertEqual(source_vm.command('query-migrate')['status'], 'co=
mpleted')
-        self.assertEqual(dest_vm.command('query-status')['status'], 'runni=
ng')
-        self.assertEqual(source_vm.command('query-status')['status'], 'pos=
tmigrate')
+        self.assert_migration(source_vm, dest_vm)
--=20
2.21.1


