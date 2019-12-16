Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1594C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F18920717
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccMNlWBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F18920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igvr8-0007cK-62
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1igvpX-0006Mo-BS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1igvpV-0007yz-2Y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:14:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1igvpU-0007yh-Ut
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576523691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zEvvvBV15wVt6qArBB6bLu+ys8CuhP7RZ9pg3Psqr1k=;
 b=ccMNlWBwNJdpxQQ9T5YP/0eUwv/YteZ+loZImKXKwKy0jMzUNfekAKmrdx8xz+hKAL2Mq1
 T2zX6HzDmSoH6KULxYRE/YlwlOK9GN0EtOaUUoI1u2+/VpcWhHErbEmG4vIAbMjalARkRv
 nLxdPEpq4yqZ2TsyC+x5kgN3+JswGLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-VGtpO0T7NX-Oea9RlRr14g-1; Mon, 16 Dec 2019 14:14:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97B09190D347;
 Mon, 16 Dec 2019 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-67.gru2.redhat.com
 [10.97.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D77255C1B5;
 Mon, 16 Dec 2019 19:14:39 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] python/qemu: New accel module and improvements
Date: Mon, 16 Dec 2019 16:14:33 -0300
Message-Id: <20191216191438.93418-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: VGtpO0T7NX-Oea9RlRr14g-1
X-Mimecast-Spam-Score: 0
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
Cc: fam@euphon.net, ehabkost@redhat.com, philmd@redhat.com, jsnow@redhat.com,
 crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On commit abf0bf998dcb John Snow moved some code out of __init__.py
to machine.py. kvm_available() remained in though. So on patch 01
I continue his work by creating a home for that method (the new
'accel' module). Honestly I was unsure about whether move the code
to any existing module or make a new, but since I am adding more
methods related with accelerators then I thought they would deserve a
module.

The patches 02-04 introduce new helpers and make improvements. Later
I intend to use those methods on the acceptance tests such as
to automatically set the accelerator in QEMUMachine VM via Avocado
tags, and skip the test if the accelerator is not available.

Patch 05 just remove unneeded imports in __init__.py

Changes v3 -> v4:
- Cleaned up Review-by statements (patch 02) [crosa]
- Let LOG.debug() format the log message (patch 02) [crosa]

Changes v2 -> v3:
- Refactor subprocess.check_output() call (patch 02) [crosa]
Not using shell=3DTrue
Pass universal_newlines=3DTrue so don't need to decode() the output
Do not check if returned accelerator's name is empty string
- New patch 05 [crosa]
On patch 01 Cleber suggested to remove unneeded imports in
python/qemu/__init__.py

Changes v1 -> v2:
- Removed 'Based on qmp.py' from python/qemu/accel.py
(patch 01) [alex.bennee]
- logging added only when used on python/qemu/accel.py
(patch 02) [alex.bennee]

Git:
- Tree: https://github.com/wainersm/qemu
- Branch: python_accel_v4

CI:
- Travis (RUNNING): https://travis-ci.org/wainersm/qemu/builds/625827750


Wainer dos Santos Moschetta (5):
  python/qemu: Move kvm_available() to its own module
  python/qemu: accel: Add list_accel() method
  python/qemu: accel: Strengthen kvm_available() checks
  python/qemu: accel: Add tcg_available() method
  python/qemu: Remove unneeded imports in __init__

 python/qemu/__init__.py | 24 -------------
 python/qemu/accel.py    | 77 +++++++++++++++++++++++++++++++++++++++++
 tests/vm/basevm.py      |  2 +-
 3 files changed, 78 insertions(+), 25 deletions(-)
 create mode 100644 python/qemu/accel.py

--=20
2.23.0


