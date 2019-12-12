Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EFCC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F80C21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaYZBVIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F80C21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifP5d-0007yP-S7
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ifO3I-0001ce-HY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ifO3H-0005I4-46
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ifO3G-0005HA-Vi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576155522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oSO7A+dXdJZ8ryN9WaQGS8dKl0GZ1r6/F/p0+CEDDsw=;
 b=XaYZBVIgXFaX3Kr4LYXZFHRVWzRiMqLRrmaAYLS6Kzk1GgbLDf52kG9FJ00+hJsUX+Mlib
 uCwrwOvi+421S6RY9tF0rLpJFFCqwmZ6jFblehAEGxapJFqiw1iOt7jGPpbt0bK3h+5erU
 Cf7LIsJFiBwvy6IKIG9LsXAUzm9aAYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-QqoJDWgpMMi5nIAyg6BUlg-1; Thu, 12 Dec 2019 07:58:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D057F801E66;
 Thu, 12 Dec 2019 12:58:37 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31E4610013A1;
 Thu, 12 Dec 2019 12:58:32 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] python/qemu: New accel module and improvements
Date: Thu, 12 Dec 2019 07:58:26 -0500
Message-Id: <20191212125831.2654-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QqoJDWgpMMi5nIAyg6BUlg-1
X-Mimecast-Spam-Score: 0
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 alex.bennee@linaro.org, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On commit abf0bf998dcb John Snow moved some code out of __init__.py
to machine.py. kvm_available() remained in though. So on patch 01
I continue his work by creating a home for that method (the new
'accel' module). Honestly I was unsure about whether move the code
to any existing module or make a new, but since I am adding more
methods related with accelerators then I thought they would deserve a modul=
e.

The patches 02-04 introduce new helpers and make improvements. Later
I intend to use those methods on the acceptance tests such as
to automatically set the accelerator in QEMUMachine VM via Avocado
tags, and skip the test if the accelerator is not available.

Patch 05 just remove unneeded imports in __init__.py

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
- Branch: python_accel_v3

CI:
- Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/623800273
  Failure is not related with this change

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
2.21.0


