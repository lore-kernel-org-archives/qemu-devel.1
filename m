Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FC1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8134D206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJVtwhT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8134D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwv1R-0002SC-Kt
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwupw-0007FE-RK
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupv-0002S5-NM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupv-0002R9-IB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1YPxrH/NEwLU/qG9sunz38BY6jEll2Q5sPq0M4BS4g=;
 b=UJVtwhT9T4U4HerIPsbu2A6iSLe0zU6C09jinFzt1s8cvbtcyll/Ot/PEXniqfvfts7sCY
 tSdgTxTETmOu+RoQUQgYB33oHIxf+w8Ji7BAp/3K2iH97bVHcuNXJGVM2C5TFCAV0bNdwi
 YOgv6gktngwu1Z6AvvXTh/k5fMpvVwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-f23z-rCONniScigDas1fbQ-1; Wed, 29 Jan 2020 16:25:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C4EA477;
 Wed, 29 Jan 2020 21:25:20 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60B7E60BF3;
 Wed, 29 Jan 2020 21:25:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 25/29] tests/acceptance/virtio_check_params: Require a
 virtio-scsi-pci device
Date: Wed, 29 Jan 2020 22:23:41 +0100
Message-Id: <20200129212345.20547-26-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: f23z-rCONniScigDas1fbQ-1
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

When running this test with QEMU configured using
--without-default-devices, we get:

  ERROR: qemu-system-s390x: -device virtio-scsi-pci,id=3Dscsi0: 'virtio-scs=
i-pci' is not a valid device model name

To be able to run the acceptance tests with a binary built using
--without-default-devices, add a 'device' tag. The Test::setUp()
method will verify the device is available, else cancel (skip)
the test.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index 3466aa5b32..95a9048786 100755
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -44,6 +44,9 @@ VM_DEV_PARAMS =3D {'virtio-scsi-pci': ['-device', 'virtio=
-scsi-pci,id=3Dscsi0'],
=20
=20
 class VirtioMaxSegSettingsCheck(Test):
+    """
+    :avocado: tags=3Ddevice:virtio-scsi-pci
+    """
     @staticmethod
     def make_pattern(props):
         pattern_items =3D ['{0} =3D \w+'.format(prop) for prop in props]
--=20
2.21.1


