Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6171C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9177720702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXEj7nTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9177720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwutF-0004iL-NE
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwupG-0005cv-7w
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupE-0000nn-SF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupE-0000nA-Oo
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9/BUqYrXR/AdhcGhJKpMEvgaqrclFXB8RiepMBdAM8=;
 b=MXEj7nTSSHrh9eKA68X32E6RL0wqyYBFnwZe/Lm7+c7vmLfuaDfcw9JbGQsDUO/4MJ6TYE
 +6s7gLi0VcgkDytWZHLrWzVtwrtzP+ttx0zrY6u6O9nIOMaUcYTN/zjILhF8AIl3dA2fD3
 9WjN7oMfcRHwX8SEsqR3B0cxWKluvfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-IUsB0qhzNAGt-i8YKmqrkQ-1; Wed, 29 Jan 2020 16:24:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7E1B18A6EC3;
 Wed, 29 Jan 2020 21:24:34 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13F5360C05;
 Wed, 29 Jan 2020 21:24:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/29] python/qemu: Add binutils::binary_get_accels()
Date: Wed, 29 Jan 2020 22:23:27 +0100
Message-Id: <20200129212345.20547-12-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IUsB0qhzNAGt-i8YKmqrkQ-1
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

Add a helper to query the list of accelerators built into a
QEMU binary.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/binutils.py          | 10 ++++++++++
 tests/acceptance/core_scripts.py | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
index 76f256f5d2..bba203bc8d 100644
--- a/python/qemu/binutils.py
+++ b/python/qemu/binutils.py
@@ -86,3 +86,13 @@ def binary_get_qom_implementations(qemu_bin, type_name, =
include_abstract=3DFalse):
         LOG.info(res)
         vm.shutdown()
         return [m['name'] for m in res]
+
+def binary_get_accels(qemu_bin):
+    '''
+    Get list of accelerators supported by a QEMU binary
+
+    @param qemu_bin (str): path to the QEMU binary
+    @return list of accelerators supported by the binary
+    '''
+    accel_types =3D binary_get_qom_implementations(qemu_bin, "accel", Fals=
e)
+    return [a.strip("-accel") for a in accel_types]
diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_scrip=
ts.py
index c2fe4acf1d..7380f2f49b 100644
--- a/tests/acceptance/core_scripts.py
+++ b/tests/acceptance/core_scripts.py
@@ -16,6 +16,7 @@ import logging
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from avocado_qemu import Test
+from qemu.binutils import binary_get_accels
 from qemu.binutils import binary_get_arch
 from qemu.binutils import binary_get_machines
 from qemu.binutils import binary_get_qom_implementations
@@ -59,3 +60,12 @@ class PythonQemuCoreScripts(Test):
         for t in type_impl:
             logger.debug('type: {}'.format(t))
         self.assertIn(type_name, type_impl)
+
+    def test_get_accels(self):
+        logger =3D logging.getLogger('core')
+        accels =3D binary_get_accels(self.qemu_bin)
+        for a in accels:
+            logger.debug('accel: {}'.format(a))
+        self.assertNotIn("accel", accels)
+        # qtest is always available
+        self.assertIn("qtest", accels)
--=20
2.21.1


