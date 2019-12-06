Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D00C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 21:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125842173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+wIRlah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125842173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idLI4-0005TF-2A
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 16:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1idLFV-0003ZA-Vf
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1idLFS-0001kL-Gp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1idLFS-0001eq-AV
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575668084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FuNeX3t5615Xq4pcj92I9oIyDzRI1Fgw6YYZ/iwzXxw=;
 b=A+wIRlahhHxdcRpJQMzSAnvvblHTeqob7OJpopSFsGOb2Iwot7m4w3NPYJmw1Qia207EKf
 PHTNLh7Vh76aXJIxRYevEjN9GVO1pNdDMhu8TRFb3u3ZQttYgBjo1zJKFRKKekiEPoJ2mB
 lnoxGhNOBBNKWloSljNvjObYXxZym+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-1sBrSopdMSGT26Yj-pQU1Q-1; Fri, 06 Dec 2019 16:34:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3566183B70C;
 Fri,  6 Dec 2019 21:34:39 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEDF45C1D4;
 Fri,  6 Dec 2019 21:34:33 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] python/qemu: New accel module and improvements
Date: Fri,  6 Dec 2019 16:34:29 -0500
Message-Id: <20191206213433.11305-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1sBrSopdMSGT26Yj-pQU1Q-1
X-Mimecast-Spam-Score: 0
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 philmd@redhat.com, crosa@redhat.com, jsnow@redhat.com
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

Changes v1 -> v2:
- Removed 'Based on qmp.py' from python/qemu/accel.py
  (patch 01) [alex.bennee]
- logging added only when used on python/qemu/accel.py
  (patch 02) [alex.bennee]

Git:
- Tree: https://github.com/wainersm/qemu
- Branch: python_accel_v2

CI:
- Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/621748861


Wainer dos Santos Moschetta (4):
  python/qemu: Move kvm_available() to its own module
  python/qemu: accel: Add list_accel() method
  python/qemu: accel: Strengthen kvm_available() checks
  python/qemu: accel: Add tcg_available() method

 python/qemu/__init__.py | 20 +----------
 python/qemu/accel.py    | 77 +++++++++++++++++++++++++++++++++++++++++
 tests/vm/basevm.py      |  2 +-
 3 files changed, 79 insertions(+), 20 deletions(-)
 create mode 100644 python/qemu/accel.py

--=20
2.21.0


