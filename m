Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D7C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F822253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOmdbkyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F822253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuOdL-0006jo-5R
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 17:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuOZ3-00022K-BG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuOZ1-0001qP-Ez
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuOZ1-0001p6-0s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579732409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFGQ2SP7BDswGuZiV7ppV32pBVt5j4zcY6wW+AuqMTw=;
 b=FOmdbkyuyCTijAl44dyvONSgsB+h297L4Iy7QAn0m2u4XeGG+WGmWxGV0g4t3AHgtRq2Sk
 5bkvrGp0ALk5d/GeggpZPjfaOOvUgyZY/chdl39TxWjYHkur2a8YEjv5Be7MhDwDnVrUp7
 ETInGr9JVMNUfDrsS6NPZKLamsVFyc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-AkDXhuApNEueZLvIu7np6Q-1; Wed, 22 Jan 2020 17:33:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E662107ACC5;
 Wed, 22 Jan 2020 22:33:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-78.brq.redhat.com [10.40.204.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21161845A5;
 Wed, 22 Jan 2020 22:33:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: [PATCH 4/6] tests/acceptance/virtio_seg_max_adjust: Only test Xen as
 superuser
Date: Wed, 22 Jan 2020 23:32:45 +0100
Message-Id: <20200122223247.30419-5-philmd@redhat.com>
In-Reply-To: <20200122223247.30419-1-philmd@redhat.com>
References: <20200122223247.30419-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: AkDXhuApNEueZLvIu7np6Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running the test unprivileged, we get:

  $ avocado --show=3Dapp,machine run tests/acceptance/virtio_seg_max_adjust=
.py
  JOB ID     : b631d5d692e49b791b211d33b80730315d561d45
  JOB LOG    : job-results/job-2020-01-22T17.56-b631d5d/job.log
   (1/1) tests/acceptance/virtio_seg_max_adjust.py:VirtioMaxSegSettingsChec=
k.test_machine_types:
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_seg_max_adjust.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance/v=
irtio_seg_max_adjust.py
index f679b0eec7..ad736bcda3 100755
--- a/tests/acceptance/virtio_seg_max_adjust.py
+++ b/tests/acceptance/virtio_seg_max_adjust.py
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


