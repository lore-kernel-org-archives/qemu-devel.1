Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2890AC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DE320708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9fHxYaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DE320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwk8R-0006hn-5N
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1iwk7t-00069b-Oc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1iwk7r-0000wj-Kd
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:59:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1iwk7r-0000ra-Ao
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580291950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PDVxPjuC7jT4w6utz8WE10HyfB7pyQRiFWwGFWpseg0=;
 b=h9fHxYaQ+pGuRrdQSIZDXHNnne7TbJ7/G7ZrEneFG+n/fM9vQi05zwRzjQKSavX7zzGlQl
 IMps//cef6DnZ2Z+1r4M5pdOBerMC45LAhXqZx/Cq9so2if944jCbHQT9dh/+bfjMF2iOv
 AI2r7bV1/r+fKFhqiNMm/A2XhmcqgjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-cBRXG5-dOH2-2ZkG4LIknQ-1; Wed, 29 Jan 2020 04:59:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD962DB21
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 09:59:07 +0000 (UTC)
Received: from kh066.redhat.com (unknown [10.36.118.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9312A8578F;
 Wed, 29 Jan 2020 09:59:04 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org,
	wainersm@redhat.com
Subject: [PATCH v2] Acceptance test: provides to use different transport for
 migration
Date: Wed, 29 Jan 2020 11:59:03 +0200
Message-Id: <20200129095903.31088-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: cBRXG5-dOH2-2ZkG4LIknQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: ovoshcha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Along with VM migration via TCP, we can use migration through EXEC
and UNIX transport protocol
---
 tests/acceptance/migration.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 8bbe28d52d..1f6a674843 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -12,11 +12,11 @@
=20
 import tempfile
 from avocado_qemu import Test
-from avocado import skipUnless\
+from avocado import skipUnless
=20
 from avocado.utils import network
 from avocado.utils import wait
-from avocado.utils.path import find_command, CmdNotFoundError
+from avocado.utils.path import find_command
=20
=20
 class Migration(Test):
@@ -62,6 +62,7 @@ class Migration(Test):
         with tempfile.TemporaryDirectory(prefix=3D'socket_') as socket_pat=
h:
             dest_uri =3D 'unix:%s/qemu-test.sock' % socket_path
             self.do_migrate(dest_uri)
+
     @skipUnless(find_command('nc', default=3DFalse), "nc command not found=
 on the system")
     def test_migration_with_exec(self):
         free_port =3D self._get_free_port()
--=20
2.21.1


