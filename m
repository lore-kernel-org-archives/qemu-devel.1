Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67111C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 20:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3554523429
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 20:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3554523429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3nzr-00057a-7Y
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 16:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwV-0002yC-CC
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwU-0001J3-1U
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i3nwQ-0001EA-2X; Fri, 30 Aug 2019 16:56:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 34B8FA36EE3;
 Fri, 30 Aug 2019 20:56:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 774985DD6C;
 Fri, 30 Aug 2019 20:56:11 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 23:55:58 +0300
Message-Id: <20190830205608.18192-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 30 Aug 2019 20:56:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/10] RFC crypto/luks: encryption key
 managment using amend interface
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

This patch series is continuation of my work to add encryption
key managment to luks/qcow2 with luks.

This patch series is based on patch series I sent earlier
called 'RFC crypto/luks: preparation for encryption key managment'

Let me hear what you think. This is still an RFC, so please
don't kill if I did something obviously wrong.

I did run the iotests - all luks and qcow2 tests, including
3 that I added.

Only test 162 seems pretty much always to fail,regardless of my changes
I suspect something nbd related / or an enviroment issue

Best regards,
	Maxim Levitsky

Maxim Levitsky (10):
  qcrypto: add suport for amend options
  qcrypto-luks: extend the create options for upcoming encryption key
    management
  qcrypto-luks: implement the encryption key management
  block: amend: add 'force' option
  block/crypto: implement the encryption key management
  qcow2: implement crypto amend options
  block: add x-blockdev-amend qmp command
  block/crypto: implement blockdev-amend
  block/qcow2: implement blockdev-amend
  iotests : add tests for encryption key management

 block.c                          |   4 +-
 block/Makefile.objs              |   2 +-
 block/amend.c                    | 116 +++++++++
 block/crypto.c                   | 154 +++++++++++-
 block/crypto.h                   |  16 ++
 block/qcow2.c                    | 153 ++++++++++--
 crypto/block-luks.c              | 392 ++++++++++++++++++++++++++++++-
 crypto/block.c                   |  31 +++
 crypto/blockpriv.h               |   8 +
 include/block/block.h            |   1 +
 include/block/block_int.h        |  22 +-
 include/crypto/block.h           |  22 ++
 qapi/block-core.json             |  34 ++-
 qapi/crypto.json                 |  19 ++
 qapi/job.json                    |   4 +-
 qemu-img-cmds.hx                 |   4 +-
 qemu-img.c                       |   8 +-
 qemu-img.texi                    |   6 +-
 tests/qemu-iotests/082.out       |  54 +++++
 tests/qemu-iotests/087.out       |   6 +-
 tests/qemu-iotests/134.out       |   2 +-
 tests/qemu-iotests/158.out       |   4 +-
 tests/qemu-iotests/188.out       |   2 +-
 tests/qemu-iotests/189.out       |   4 +-
 tests/qemu-iotests/198.out       |   4 +-
 tests/qemu-iotests/300           | 202 ++++++++++++++++
 tests/qemu-iotests/300.out       |  98 ++++++++
 tests/qemu-iotests/301           |  90 +++++++
 tests/qemu-iotests/301.out       |  30 +++
 tests/qemu-iotests/302           | 247 +++++++++++++++++++
 tests/qemu-iotests/302.out       |  18 ++
 tests/qemu-iotests/common.filter |   6 +-
 tests/qemu-iotests/group         |   8 +
 33 files changed, 1717 insertions(+), 54 deletions(-)
 create mode 100644 block/amend.c
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out
 create mode 100755 tests/qemu-iotests/301
 create mode 100644 tests/qemu-iotests/301.out
 create mode 100644 tests/qemu-iotests/302
 create mode 100644 tests/qemu-iotests/302.out

-- 
2.17.2


