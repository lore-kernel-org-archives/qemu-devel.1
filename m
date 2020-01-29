Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E2220702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ar3/M69T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E2220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwuvi-0008IX-Or
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwupJ-0005oi-UR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupI-0000zh-Nt
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupI-0000yt-Jl
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYtdihKiw1InrMU7Bp2DP9tR44Uayvozpk04F0HZe78=;
 b=Ar3/M69TpQjg7I5vID450kXGkQiXmXnbwx7sh5/moAC9GI7k+ELPDLFAeIOLFf4ZY4DE9u
 wwUR3Y3vm7gicJdTw4ksO86QUPu9UxsHdfIre6vnzUGMt01NngN7D8wl62PwhlIBLZi+2F
 PrEMFp4rYkovtJA5Tj/smjeaQ4RyDnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-DEiXDiHOMgKgoeoTuFFWDw-1; Wed, 29 Jan 2020 16:24:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0D79800D48;
 Wed, 29 Jan 2020 21:24:39 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8C9460BF3;
 Wed, 29 Jan 2020 21:24:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/29] python/qemu: Add binutils::binary_get_devices()
Date: Wed, 29 Jan 2020 22:23:29 +0100
Message-Id: <20200129212345.20547-14-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DEiXDiHOMgKgoeoTuFFWDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
the list of devices linked in can vary.
Add a helper to query the list of devices built into a
QEMU binary.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/binutils.py          | 9 +++++++++
 tests/acceptance/core_scripts.py | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
index bba203bc8d..9633ba8efd 100644
--- a/python/qemu/binutils.py
+++ b/python/qemu/binutils.py
@@ -96,3 +96,12 @@ def binary_get_accels(qemu_bin):
     '''
     accel_types =3D binary_get_qom_implementations(qemu_bin, "accel", Fals=
e)
     return [a.strip("-accel") for a in accel_types]
+
+def binary_get_devices(qemu_bin):
+    '''
+    Get list of devices supported by a QEMU binary
+
+    @param qemu_bin (str): path to the QEMU binary
+    @return list of devices supported by the binary
+    '''
+    return binary_get_qom_implementations(qemu_bin, "device", False)
diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_scrip=
ts.py
index 7380f2f49b..a62eb2e46b 100644
--- a/tests/acceptance/core_scripts.py
+++ b/tests/acceptance/core_scripts.py
@@ -18,6 +18,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__), '=
..', '..', 'python'))
 from avocado_qemu import Test
 from qemu.binutils import binary_get_accels
 from qemu.binutils import binary_get_arch
+from qemu.binutils import binary_get_devices
 from qemu.binutils import binary_get_machines
 from qemu.binutils import binary_get_qom_implementations
 from qemu.binutils import binary_get_version
@@ -69,3 +70,10 @@ class PythonQemuCoreScripts(Test):
         self.assertNotIn("accel", accels)
         # qtest is always available
         self.assertIn("qtest", accels)
+
+    def test_get_devices(self):
+        logger =3D logging.getLogger('core')
+        devices =3D binary_get_devices(self.qemu_bin)
+        for d in devices:
+            logger.debug('device: {}'.format(d))
+        self.assertIn("migration", devices)
--=20
2.21.1


