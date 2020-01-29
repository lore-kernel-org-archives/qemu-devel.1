Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8FDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD0220702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2GsiJa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD0220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwuyw-00064m-JJ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwupS-00069D-FF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupR-0001HA-Cv
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupR-0001GP-9S
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HyYGUWUsJJCNtttCSH0oBPVnAMD7cX3BJej4nyJypFc=;
 b=G2GsiJa3CfP9Xd0PE7/7v2wtA8bDRqqv6hxoQtgQ5vkNeR+E7ARbXPaVgIxPI53Z3AM0Sl
 c7C11NNkKKJu09YwZRlyMxVdXwnIdJVFiCrr8g4JhLYTkjJJapk03pnqouheBJ69r/jLKS
 oz/XZ1VZQdZN3RAFlkjPL84UH2xC6GY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-DH35DtRhOb-n5KzgJApPOQ-1; Wed, 29 Jan 2020 16:24:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAFF6DB60;
 Wed, 29 Jan 2020 21:24:46 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F14C960BF3;
 Wed, 29 Jan 2020 21:24:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 16/29] tests/acceptance/virtio_check_params: Only remove
 listed machines
Date: Wed, 29 Jan 2020 22:23:32 +0100
Message-Id: <20200129212345.20547-17-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DH35DtRhOb-n5KzgJApPOQ-1
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

Do not remove unavailable machines, this fixes:

  VirtioMaxSegSettingsCheck.test_machine_types: ERROR: list.remove(x): x no=
t in list (0.12 s)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
TODO check how to use attribute (Wainer)
---
 tests/acceptance/virtio_check_params.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index 5458573138..4a417b8ef5 100755
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -109,14 +109,15 @@ class VirtioMaxSegSettingsCheck(Test):
         return False
=20
     def test_machine_types(self):
-        # collect all machine types except 'none', 'isapc', 'microvm'
+        EXCLUDED_MACHINES =3D ['none', 'isapc', 'microvm']
+        # collect all machine types except the ones in EXCLUDED_MACHINES
         with QEMUMachine(self.qemu_bin) as vm:
             vm.launch()
             machines =3D [m['name'] for m in vm.command('query-machines')]
             vm.shutdown()
-        machines.remove('none')
-        machines.remove('isapc')
-        machines.remove('microvm')
+        for m in EXCLUDED_MACHINES:
+            if m in machines:
+                machines.remove(m)
=20
         for dev_type in DEV_TYPES:
             # create the list of machine types and their parameters.
--=20
2.21.1


