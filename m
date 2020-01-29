Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8361620702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdbZpYFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8361620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwuxX-00035C-N4
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwupd-0006bR-41
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupc-0001bC-1S
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupb-0001aD-U8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQlns0iVbbE346Xpw09C6qDKAS7IAyqhFylqT1EkNFE=;
 b=SdbZpYFz9gFzTlQy8C6uGXHkCyJg036hyofWXSOFx3eGniQoAtvNuwGgW6Iax5nlcktLTC
 12anmsXBivk53WZDAqMaEW8cCp7mGDq+fzdrVHKobQrr9jeta+xUl/apHGCsf49/71MUDu
 vh0WA9Ev4VYegpa3pou1SH1DRSeMczM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-jQmGLpX4NzqDgeAuvaMPxg-1; Wed, 29 Jan 2020 16:24:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E08B28017CC;
 Wed, 29 Jan 2020 21:24:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F7460BF3;
 Wed, 29 Jan 2020 21:24:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 19/29] tests/acceptance/virtio_check_params: Only test Xen
 as superuser
Date: Wed, 29 Jan 2020 22:23:35 +0100
Message-Id: <20200129212345.20547-20-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jQmGLpX4NzqDgeAuvaMPxg-1
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

When running the test unprivileged, we get:

  $ avocado --show=3Dapp,machine run tests/acceptance/virtio_check_params.p=
y
  JOB ID     : b631d5d692e49b791b211d33b80730315d561d45
  JOB LOG    : job-results/job-2020-01-22T17.56-b631d5d/job.log
   (1/1) tests/acceptance/virtio_check_params.py:VirtioMaxSegSettingsCheck.=
test_machine_types:
  machine: {'name': 'pc-i440fx-2.12', 'seg_max_adjust': 'false', 'device': =
'virtio-scsi-pci'}
  machine: {'name': 'pc-i440fx-2.0', 'seg_max_adjust': 'false', 'device': '=
virtio-scsi-pci'}
  machine: {'name': 'xenpv', 'seg_max_adjust': 'false', 'device': 'virtio-s=
csi-pci'}
  FAIL: machine type xenpv: <class 'qemu.qmp.QMPConnectError'> (0.40 s)

Looking at the job.log file we find:

  xencall: error: Could not obtain handle on privileged command interface: =
No such file or directory
  xen be core: xen be core: can't open xen interface

Do not run this test on Xen machines if not superuser.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index f679b0eec7..ad736bcda3 100755
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -118,6 +118,8 @@ class VirtioMaxSegSettingsCheck(Test):
=20
     def test_machine_types(self):
         EXCLUDED_MACHINES =3D ['none', 'isapc', 'microvm']
+        if os.geteuid() !=3D 0:
+            EXCLUDED_MACHINES +=3D ['xenfv', 'xenpv']
         # collect all machine types except the ones in EXCLUDED_MACHINES
         with QEMUMachine(self.qemu_bin) as vm:
             vm.launch()
--=20
2.21.1


