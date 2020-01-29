Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5345820702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL/KeJbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5345820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwurk-0001FR-Fa
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwup6-0005Mp-5d
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwup4-0000Wh-W7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwup4-0000Vh-SU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFb6Iha5av7utREA4X4Ytd8S+SApAb4/yVnvfLwSwcg=;
 b=YL/KeJbNo+JXzWW7DIoDFWZVQLH21gJMmqf8Fs8gv6qO+L+iG+Wgx/9glamhPIRoFs333X
 vBek7ZjGPh/7oEJvjcmbclOT1PFyYHswdrAGNI19m36Ritq+tkUV1eIs6rNDtQct4rCZq9
 NgshGWD96ndlMhV9gX2Faz3CP3GxDhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-99fCIZSWPn-JySzQbBoXew-1; Wed, 29 Jan 2020 16:24:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 985228010C2;
 Wed, 29 Jan 2020 21:24:27 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BF1060BF3;
 Wed, 29 Jan 2020 21:24:23 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/29] python/qemu: Add
 binutils::binary_get_qom_implementations()
Date: Wed, 29 Jan 2020 22:23:26 +0100
Message-Id: <20200129212345.20547-11-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 99fCIZSWPn-JySzQbBoXew-1
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since QEMU binaries can be built with various configurations,
the list of QOM objects linked can vary.
Add a helper to query the list of all QOM types implementing a
particular interface.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/binutils.py          | 20 ++++++++++++++++++++
 tests/acceptance/core_scripts.py | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
index 7bb57c521b..76f256f5d2 100644
--- a/python/qemu/binutils.py
+++ b/python/qemu/binutils.py
@@ -66,3 +66,23 @@ def binary_get_machines(qemu_bin):
         LOG.info(res)
         vm.shutdown()
         return [m['name'] for m in res]
+
+def binary_get_qom_implementations(qemu_bin, type_name, include_abstract=
=3DFalse):
+    '''
+    Get list of QOM types implementing a particular interface
+
+    @param qemu_bin (str): path to the QEMU binary
+    @param type_name (str): QOM interface name
+    @param include_abstract (bool): if True, abstract interfaces are also
+                                    returned in the list
+    @return list of QOM types implementing the interface @type_name
+    '''
+    with QEMUMachine(qemu_bin) as vm:
+        vm.set_machine('none')
+        vm.launch()
+        res =3D vm.command('qom-list-types',
+                         implements=3Dtype_name,
+                         abstract=3Dinclude_abstract)
+        LOG.info(res)
+        vm.shutdown()
+        return [m['name'] for m in res]
diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_scrip=
ts.py
index a5b112f928..c2fe4acf1d 100644
--- a/tests/acceptance/core_scripts.py
+++ b/tests/acceptance/core_scripts.py
@@ -18,6 +18,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__), '=
..', '..', 'python'))
 from avocado_qemu import Test
 from qemu.binutils import binary_get_arch
 from qemu.binutils import binary_get_machines
+from qemu.binutils import binary_get_qom_implementations
 from qemu.binutils import binary_get_version
=20
=20
@@ -49,3 +50,12 @@ class PythonQemuCoreScripts(Test):
             logger.debug('machine: {}'.format(m))
         # The 'none' machine is always available
         self.assertIn('none', machines)
+
+    def test_get_qom_implementation(self):
+        logger =3D logging.getLogger('core')
+        type_name =3D "accel"
+        type_impl =3D binary_get_qom_implementations(self.qemu_bin,
+                                                   type_name, True)
+        for t in type_impl:
+            logger.debug('type: {}'.format(t))
+        self.assertIn(type_name, type_impl)
--=20
2.21.1


