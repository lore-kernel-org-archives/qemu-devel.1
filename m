Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7CCC35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5904620716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiAiVUtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5904620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwurk-0001GC-Hu
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuow-0004wv-6m
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuou-0000AN-NF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuou-00009R-Is
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLv31TMeukyEv5VIAlP2E+fPgsFOq8eiqjTaqSQdDfY=;
 b=hiAiVUtnh3zI8IPcMQepeSeS75D016++DM4BVcaS5ONFvrkUc4zSRJAAjPLU2PibJBhM3s
 CC8mN1rjqMDMrOamqs9Fv7gTLaVcUahIRj5dju/ddskSrOBDa8Agv1aSQ3qaL4Ew+4krR9
 of4c9Q0RJf8XO6wv8ElSMHq+nVyPJuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-LHJnkq4fOmmcqYvqPudNMw-1; Wed, 29 Jan 2020 16:24:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89111477;
 Wed, 29 Jan 2020 21:24:15 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C54960BF3;
 Wed, 29 Jan 2020 21:24:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 06/29] python/qemu: Add binutils::binary_get_arch()
Date: Wed, 29 Jan 2020 22:23:22 +0100
Message-Id: <20200129212345.20547-7-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LHJnkq4fOmmcqYvqPudNMw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a helper to query the architecture of a QEMU binary.
We simply send the 'query-target' command over a QMP socket.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/binutils.py          | 15 +++++++++++++++
 tests/acceptance/core_scripts.py | 11 +++++++++++
 2 files changed, 26 insertions(+)

diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
index 96b200eef4..905d393ba5 100644
--- a/python/qemu/binutils.py
+++ b/python/qemu/binutils.py
@@ -36,3 +36,18 @@ def binary_get_version(qemu_bin):
         LOG.info(res)
         vm.shutdown()
         return res['qemu']
+
+def binary_get_arch(qemu_bin):
+    '''
+    Get target architecture for a QEMU binary
+
+    @param qemu_bin (str): path to the QEMU binary
+    @return binary target architecture
+    '''
+    with QEMUMachine(qemu_bin) as vm:
+        vm.set_machine('none')
+        vm.launch()
+        res =3D vm.command('query-target')
+        LOG.info(res)
+        vm.shutdown()
+        return res['arch']
diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_scrip=
ts.py
index 3f253337cd..93dd822368 100644
--- a/tests/acceptance/core_scripts.py
+++ b/tests/acceptance/core_scripts.py
@@ -16,6 +16,7 @@ import logging
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from avocado_qemu import Test
+from qemu.binutils import binary_get_arch
 from qemu.binutils import binary_get_version
=20
=20
@@ -29,3 +30,13 @@ class PythonQemuCoreScripts(Test):
         self.assertGreaterEqual(version['major'], 0)
         if version['major'] =3D=3D 0:
             self.assertGreaterEqual(version['minor'], 14)
+
+    def test_get_arch_x86(self):
+        """
+        :avocado: tags=3Darch:i386
+        :avocado: tags=3Darch:x86_64
+        """
+        logger =3D logging.getLogger('core')
+        a =3D binary_get_arch(self.qemu_bin)
+        logger.debug('arch: {}'.format(a))
+        self.assertIn(a, ['i386', 'x86_64'])
--=20
2.21.1


