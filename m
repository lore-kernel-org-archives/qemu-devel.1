Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3659DC3F2C6
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B1220848
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZgXsl+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B1220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxjK-0001ib-4z
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxi0-0008QX-Kk
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxhy-0001Xb-B6
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxhy-0001XJ-4Z
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+F3lKsDhqPn+ohSvGbcLHWI+ofgcQjRAlodqGgaUuRg=;
 b=gZgXsl+O0otow115UQfflM66OgPRNWfg7otqUumg1XaRy6TN0Inp/BhcGpWWhIoCDK228Y
 Ijln1ng8mwB4LiSUSnUsrB6rdvNSuKq8mP8gvucmOIbdfUN81SwYwxYhVzPkgN/07s45SZ
 PG1ZRpUS8+XmzzKSpzxx9ZFUuwkeQOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-2t9uV0OtNs-xA5H6W-bHGQ-1; Sun, 08 Mar 2020 11:19:11 -0400
X-MC-Unique: 2t9uV0OtNs-xA5H6W-bHGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 532C6184C800;
 Sun,  8 Mar 2020 15:19:10 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D7285C1B0;
 Sun,  8 Mar 2020 15:19:05 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/14] LUKS: encryption slot management using amend
 interface
Date: Sun,  8 Mar 2020 17:18:49 +0200
Message-Id: <20200308151903.25941-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!
Here is the updated series of my patches, incorporating all the feedback I =
received.

This implements the API interface that we agreed upon except that I merged =
the
LUKSKeyslotActive/LUKSKeyslotInactive union into a struct because otherwise
I need nested unions which are not supported currently by QAPI parser.
This didn't change the API and thus once support for nested unions is there=
,
it can always be implemented in backward compatible way.

I hope that this series will finally be considered for merging, since I am =
somewhat running
out of time to finish this task.

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

Tested with -raw,-qcow2 and -luks iotests and 'make check'

Best regards,
        Maxim Levitsky

clone of "luks-keymgmnt-v2"

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
 block/amend.c                    | 108 +++++++++
 block/crypto.c                   | 203 ++++++++++++++--
 block/crypto.h                   |  47 +++-
 block/qcow2.c                    | 314 ++++++++++++++----------
 crypto/block-luks.c              | 398 ++++++++++++++++++++++++++++++-
 crypto/block.c                   |  31 +++
 crypto/blockpriv.h               |   8 +
 docs/tools/qemu-img.rst          |   5 +-
 include/block/block.h            |   1 +
 include/block/block_int.h        |  24 +-
 include/crypto/block.h           |  22 ++
 qapi/block-core.json             |  68 ++++++
 qapi/crypto.json                 |  75 +++++-
 qapi/job.json                    |   4 +-
 qemu-img-cmds.hx                 |   4 +-
 qemu-img.c                       |  44 +++-
 tests/qemu-iotests/049.out       | 102 ++++----
 tests/qemu-iotests/061.out       |  12 +-
 tests/qemu-iotests/079.out       |  18 +-
 tests/qemu-iotests/082.out       | 176 ++++----------
 tests/qemu-iotests/085.out       |  38 +--
 tests/qemu-iotests/087.out       |   6 +-
 tests/qemu-iotests/115.out       |   2 +-
 tests/qemu-iotests/121.out       |   4 +-
 tests/qemu-iotests/125.out       | 192 +++++++--------
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
 tests/qemu-iotests/284.out       |   6 +-
 tests/qemu-iotests/300           | 207 ++++++++++++++++
 tests/qemu-iotests/300.out       |  99 ++++++++
 tests/qemu-iotests/301           |  90 +++++++
 tests/qemu-iotests/301.out       |  30 +++
 tests/qemu-iotests/302           | 278 +++++++++++++++++++++
 tests/qemu-iotests/302.out       |  40 ++++
 tests/qemu-iotests/303           | 233 ++++++++++++++++++
 tests/qemu-iotests/303.out       |  33 +++
 tests/qemu-iotests/common.filter |   6 +-
 tests/qemu-iotests/group         |   6 +
 51 files changed, 2486 insertions(+), 516 deletions(-)
 create mode 100644 block/amend.c
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out
 create mode 100755 tests/qemu-iotests/301
 create mode 100644 tests/qemu-iotests/301.out
 create mode 100755 tests/qemu-iotests/302
 create mode 100644 tests/qemu-iotests/302.out
 create mode 100755 tests/qemu-iotests/303
 create mode 100644 tests/qemu-iotests/303.out

--=20
2.17.2


