Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1224AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66F720702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgcDTJlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66F720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwuw9-0000qA-VK
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwupg-0006go-98
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupf-0001eQ-56
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38296
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupf-0001e6-0H
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXede9xAnvU2QNlS5XPZDgQCoVntfQIvKdG9jNiQE5g=;
 b=NgcDTJljQrnNGNu0e77ZSgIZyWzYC/4kzkNuJDEqdbS4SeQ7x56wR5mD6sFWpYOH1zD7iA
 NzEese+bbgjaY5uRPjlim6b8/6AyB33IrqWdL5o9MGC3v0USETWs4TKEHy3MWuho1c9hKv
 KMhJa4r8q3h7T+lTfKZknAomu9/SLJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-uJ0lkRmAM4qQdb0E1jhoAw-1; Wed, 29 Jan 2020 16:24:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78AB718A6EC0;
 Wed, 29 Jan 2020 21:24:56 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CD4660BF3;
 Wed, 29 Jan 2020 21:24:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 18/29] tests/acceptance/virtio_check_params: List machine
 being tested
Date: Wed, 29 Jan 2020 22:23:34 +0100
Message-Id: <20200129212345.20547-19-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uJ0lkRmAM4qQdb0E1jhoAw-1
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

Add logging for easier debugging of failures:

  $ avocado --show=3Dmachine run tests/acceptance/virtio_check_params.py
   (1/1) tests/acceptance/virtio_check_params.py:VirtioMaxSegSettingsCheck.=
test_machine_types:
  machine: {'name': 'pc-i440fx-2.12', 'seg_max_adjust': 'false', 'device': =
'virtio-scsi-pci'}
  machine: {'name': 'pc-i440fx-2.0', 'seg_max_adjust': 'false', 'device': '=
virtio-scsi-pci'}
  machine: {'name': 'pc-q35-4.2', 'seg_max_adjust': 'false', 'device': 'vir=
tio-scsi-pci'}
  machine: {'name': 'pc-i440fx-2.5', 'seg_max_adjust': 'false', 'device': '=
virtio-scsi-pci'}
  machine: {'name': 'pc-i440fx-4.2', 'seg_max_adjust': 'false', 'device': '=
virtio-scsi-pci'}
  ...

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index 51a2dd76e8..f679b0eec7 100755
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -21,6 +21,7 @@
 import sys
 import os
 import re
+import logging
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from qemu.machine import QEMUMachine
@@ -73,6 +74,9 @@ class VirtioMaxSegSettingsCheck(Test):
         return query_ok, props, error
=20
     def check_mt(self, mt, dev_type_name):
+        mt['device'] =3D dev_type_name # Only for the debug() call.
+        logger =3D logging.getLogger('machine')
+        logger.debug(mt)
         with QEMUMachine(self.qemu_bin) as vm:
             vm.set_machine(mt["name"])
             for s in VM_DEV_PARAMS[dev_type_name]:
--=20
2.21.1


