Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDAC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2FD2465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWCiQ2g4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2FD2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuOau-0003r6-3k
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 17:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuOZ6-00026M-Uy
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuOZ5-0001tN-Cl
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26555
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuOZ5-0001sj-8S
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579732414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77vF3k15FTYFomIOoon+XSCFO0pcEnC1dHzATvCNB/0=;
 b=SWCiQ2g42dVBeDcoGGnIhQsiYF62OdtIWvUzS5Pzv1EC/KfXLypQ9ctxxOF18CWYtkRlxt
 Q1DbY+jRv6UQYoy3vVTUyAGOmbZqisAqec8pVVLsaKJ0CD+BjFCAxKGSv6NmLDAfmP6I2O
 4GCnF8B8tr1FEzZq91ajDx/dk1y6OJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-54ohBjJeNeaOjHLqiW4vAw-1; Wed, 22 Jan 2020 17:33:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C289B10054E3;
 Wed, 22 Jan 2020 22:33:31 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-78.brq.redhat.com [10.40.204.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8752B845A5;
 Wed, 22 Jan 2020 22:33:28 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: [PATCH 6/6] tests/acceptance/virtio_seg_max_adjust: Restrict to Linux
 host
Date: Wed, 22 Jan 2020 23:32:47 +0100
Message-Id: <20200122223247.30419-7-philmd@redhat.com>
In-Reply-To: <20200122223247.30419-1-philmd@redhat.com>
References: <20200122223247.30419-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 54ohBjJeNeaOjHLqiW4vAw-1
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
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test is failing on OSX:

  TestFail: machine type pc-i440fx-2.0: <class 'TypeError'>

Looking at the job.log:

  Unexpected error in object_property_find() at qom/object.c:1201:
  qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0: can=
't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not found

Which makes sense looking at hw/block/virtio-blk.c:

  1261 static Property virtio_blk_properties[] =3D {
  1262     DEFINE_BLOCK_PROPERTIES(VirtIOBlock, conf.conf),
  ...
  1268 #ifdef __linux__
  1269     DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
  1270                       VIRTIO_BLK_F_SCSI, false),
  1271 #endif

Fix by only running this test on a Linux host:

 (38/55) tests/acceptance/virtio_seg_max_adjust.py:VirtioMaxSegSettingsChec=
k.test_machine_types:  SKIP: Host OS is not Linux

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_seg_max_adjust.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance/v=
irtio_seg_max_adjust.py
index 2fc6bfcbd8..f8fd03e3b6 100755
--- a/tests/acceptance/virtio_seg_max_adjust.py
+++ b/tests/acceptance/virtio_seg_max_adjust.py
@@ -27,6 +27,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__), '=
..', '..', 'python'))
 from qemu.machine import QEMUMachine
 from avocado_qemu import Test
 from avocado.core.exceptions import TestSkipError
+from avocado import skipUnless
=20
 #list of machine types and virtqueue properties to test
 VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
@@ -117,6 +118,8 @@ class VirtioMaxSegSettingsCheck(Test):
             return True
         return False
=20
+
+    @skipUnless(sys.platform.startswith('linux'), 'Host OS is not Linux')
     def test_machine_types(self):
         """
         :avocado: tags=3Darch:i386
--=20
2.21.1


