Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E71AC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5072920658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqwVjUIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5072920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izokl-0005Tx-Ex
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoaL-0008Vp-LW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoaJ-0004Zk-NE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55520
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoaJ-00044C-EJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyLjO0vPjCIOWKJsbHHkEJ/bq3H5xbIyp6Q/me8Dezk=;
 b=RqwVjUICQswtlowDW0IXe7zmgc0v81mxYgTzQPKcFfddqUuivaeIPXDSgGXIetoLlS/2DG
 FehCTpikzGA4Ji0lMY4A8Bp199Lv1parumm5DWu+N6fDfIilb7hSTrQn/8ZHFFnRZWD9M5
 ku9emlqsVdYUqj1tQShGvVK173FW6jM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-ckGHu6uDPYCKnYHnHVZ1pQ-1; Thu, 06 Feb 2020 16:21:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29005800D5C
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:21:07 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B0AB60BEC;
 Thu,  6 Feb 2020 21:21:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/46] tests/acceptance/virtio_check_params: List machine being
 tested
Date: Thu,  6 Feb 2020 22:19:10 +0100
Message-Id: <20200206211936.17098-21-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ckGHu6uDPYCKnYHnHVZ1pQ-1
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
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200129212345.20547-19-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index 270f69d092..29e91bfa37 100755
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


