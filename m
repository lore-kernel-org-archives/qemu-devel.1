Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A35C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8FF20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4fqGUDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8FF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDeX-0000TC-Gc
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdE-00079E-In
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdD-0006QE-Bu
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixDdD-0006Ne-8o
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580405370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ECPqTyZsswZw3GBB/5nUX+uXnP0IbYfrQgGu81ljF9E=;
 b=P4fqGUDdXrXGSi/epOXjaKhggjKGDp9QijfOLec1muuUxA5hO86v9xAfX9MjFpsYFk04AU
 AwY6A9GsqwnJ1QzC5jx8t9BXr8MiisWOHEyBMwIx3bbBWpsN21XOj3IhZchJHQHgmhpyPI
 SCbZOXVSOy+HE6TbKa53XvSUDEfTyrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-FYj41myBPpqzeJSB8M7bvQ-1; Thu, 30 Jan 2020 12:29:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1751618FE868;
 Thu, 30 Jan 2020 17:29:26 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 947005D9E5;
 Thu, 30 Jan 2020 17:29:21 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/14] LUKS: encryption slot management using amend
 interface
Date: Thu, 30 Jan 2020 19:29:05 +0200
Message-Id: <20200130172919.13424-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FYj41myBPpqzeJSB8M7bvQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here is the updated series of my patches, incorporating all the feedback I =
received.

Patches are strictly divided by topic to 3 groups, and each group depends o=
n former groups.

* Patches 1,2 implement qcrypto generic amend interface, including definiti=
on
  of structs used in crypto.json and implement this in luks crypto driver
  Nothing is exposed to the user at this stage

* Patches 3-9 use the code from patches 1,2 to implement qemu-img amend bas=
ed encryption slot management
  for luks and for qcow2, and add a bunch of iotests to cover that.

* Patches 10-13 add x-blockdev-amend (I'll drop the -x prefix if you like),=
 and wire it
  to luks and qcow2 driver to implement qmp based encryption slot managemen=
t also using
  the code from patches 1,2, and also add a bunch of iotests to cover this.

V2:
=09* Still the same API interface.
=09* Added new patch to refactor qcow2 amend options
=09* Reworked main code implementation to be hopefully cleaner.
=09* Fixed iotests hopefully.

Best regards,
        Maxim Levitsky

Maxim Levitsky (14):
  qcrypto/core: add generic infrastructure for crypto options amendment
  qcrypto/luks: implement encryption key management
  block/amend: add 'force' option
  block/amend: separate amend and create options for qemu-img
  block/amend: refactor qcow2 amend options
  block/crypto: rename two functions
  block/crypto: implement the encryption key management
  block/qcow2: extend qemu-img amend interface with crypto options
  iotests: filter few more luks specific create options
  iotests: qemu-img tests for luks key management
  block/core: add generic infrastructure for x-blockdev-amend qmp
    command
  block/crypto: implement blockdev-amend
  block/qcow2: implement blockdev-amend
  iotests: add tests for blockdev-amend

 block.c                          |   4 +-
 block/Makefile.objs              |   2 +-
 block/amend.c                    | 108 ++++++++
 block/crypto.c                   | 204 +++++++++++++--
 block/crypto.h                   |  45 +++-
 block/qcow2.c                    | 319 +++++++++++++---------
 crypto/block-luks.c              | 391 ++++++++++++++++++++++++++-
 crypto/block.c                   |  31 +++
 crypto/blockpriv.h               |   8 +
 include/block/block.h            |   1 +
 include/block/block_int.h        |  24 +-
 include/crypto/block.h           |  22 ++
 qapi/block-core.json             |  68 +++++
 qapi/crypto.json                 |  64 +++++
 qapi/job.json                    |   4 +-
 qemu-img-cmds.hx                 |   4 +-
 qemu-img.c                       |  44 +++-
 qemu-img.texi                    |   6 +-
 tests/qemu-iotests/049.out       | 102 ++++----
 tests/qemu-iotests/061.out       |  12 +-
 tests/qemu-iotests/079.out       |  18 +-
 tests/qemu-iotests/082.out       | 437 +++++++++++++++++++++----------
 tests/qemu-iotests/085.out       |  38 +--
 tests/qemu-iotests/087.out       |   6 +-
 tests/qemu-iotests/115.out       |   2 +-
 tests/qemu-iotests/121.out       |   4 +-
 tests/qemu-iotests/125.out       | 192 +++++++-------
 tests/qemu-iotests/134.out       |   2 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/158.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/188.out       |   2 +-
 tests/qemu-iotests/189.out       |   4 +-
 tests/qemu-iotests/198.out       |   4 +-
 tests/qemu-iotests/243.out       |  16 +-
 tests/qemu-iotests/250.out       |   2 +-
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/263.out       |   4 +-
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/300           | 207 +++++++++++++++
 tests/qemu-iotests/300.out       |  99 +++++++
 tests/qemu-iotests/301           |  90 +++++++
 tests/qemu-iotests/301.out       |  30 +++
 tests/qemu-iotests/302           | 284 ++++++++++++++++++++
 tests/qemu-iotests/302.out       |  40 +++
 tests/qemu-iotests/303           | 235 +++++++++++++++++
 tests/qemu-iotests/303.out       |  33 +++
 tests/qemu-iotests/common.filter |   6 +-
 tests/qemu-iotests/group         |   6 +
 50 files changed, 2730 insertions(+), 522 deletions(-)
 create mode 100644 block/amend.c
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out
 create mode 100755 tests/qemu-iotests/301
 create mode 100644 tests/qemu-iotests/301.out
 create mode 100644 tests/qemu-iotests/302
 create mode 100644 tests/qemu-iotests/302.out
 create mode 100644 tests/qemu-iotests/303
 create mode 100644 tests/qemu-iotests/303.out

--=20
2.17.2


