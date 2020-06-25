Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F4FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23D02063A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dl19NGuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23D02063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRRJ-0004Ff-5u
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQ7-0002VT-Qy
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:55:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQ5-0003Dh-NJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593089756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iOFqRxWN0KN31F9D3kO8ZfeCloNjmxAzaKRjZh229fo=;
 b=Dl19NGuy06JEvbQpsMT9m7jxR2O+J02D7OvkMHyMvaEuGiuGZKLstZMn7Z7Pi5KgzWNvL9
 4FfuCmQHx9YtVu2mwckwT1tmYa9bdRTbu8C32LPlpDVbAQl2VdPuRpwLkj3FOMbeNagBA8
 XIprxB84rzbEsd1oE+pFZvd5HHUqnXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250--emaiJQHPjWpRNORMNm74w-1; Thu, 25 Jun 2020 08:55:51 -0400
X-MC-Unique: -emaiJQHPjWpRNORMNm74w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F4B68064B7;
 Thu, 25 Jun 2020 12:55:50 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDE1E61169;
 Thu, 25 Jun 2020 12:55:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/19] block: LUKS encryption slot management + iotest tweaks
Date: Thu, 25 Jun 2020 14:55:29 +0200
Message-Id: <20200625125548.870061-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series collects all patches from Maxim’s series “LUKS: encryption
slot management using amend interface”, plus iotest patches that seem
useful to have before it.  (And then I modified some of Maxim’s patches
to take advantage of those patches.)

Maxim’s series was here:
https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00330.html

I already posted patches 1 and 2 here:
https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00954.html

Change from the latter series:
- Patch 1:
  - Use $SED instead of plain “sed” in one place I missed
  - Older bash versions do not support readarray’s -d switch, so we have
    to separate the Formatting line by a \n instead of \0.
    Unfortunately, that means we cannot just split by \0 and be done
    with it, but we have to ensure we put everything before the line
    starting by “Formatting” into $filename_part, and we do that with a
    loop that iterates over the split array until it finds the
    “Formatting” line.
  - Use multiple -e for grep instead of '(...|...|...)'
- Patch 2: Rebase fallout du to grep now using multiple -e parameters


git-backport-diff against Maxim’s series:

001/19:[down] 'iotests: Make _filter_img_create more active'
002/19:[0053] [FC] 'iotests: filter few more luks specific create options'
003/19:[down] 'iotests/common.rc: Add _require_working_luks'
004/19:[down] 'iotests.py: Add qemu_img_pipe_and_status()'
005/19:[down] 'iotests.py: Add (verify|has)_working_luks()'
006/19:[down] 'iotests: Check whether luks works'
007/19:[----] [--] 'qcrypto/core: add generic infrastructure for crypto options amendment'
008/19:[----] [--] 'qcrypto/luks: implement encryption key management'
009/19:[----] [--] 'block/amend: add 'force' option'
010/19:[----] [--] 'block/amend: separate amend and create options for qemu-img'
011/19:[0268] [FC] 'block/amend: refactor qcow2 amend options'
012/19:[----] [--] 'block/crypto: rename two functions'
013/19:[----] [--] 'block/crypto: implement the encryption key management'
014/19:[----] [--] 'block/qcow2: extend qemu-img amend interface with crypto options'
015/19:[0007] [FC] 'iotests: qemu-img tests for luks key management'
016/19:[----] [--] 'block/core: add generic infrastructure for x-blockdev-amend qmp command'
017/19:[----] [--] 'block/crypto: implement blockdev-amend'
018/19:[----] [--] 'block/qcow2: implement blockdev-amend'
019/19:[0005] [FC] 'iotests: add tests for blockdev-amend'


git-backport-diff against “iotests: Make _filter_img_create more
active”:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/19:[0035] [FC] 'iotests: Make _filter_img_create more active'
002/19:[0004] [FC] 'iotests: filter few more luks specific create options'
003/19:[down] 'iotests/common.rc: Add _require_working_luks'
004/19:[down] 'iotests.py: Add qemu_img_pipe_and_status()'
005/19:[down] 'iotests.py: Add (verify|has)_working_luks()'
006/19:[down] 'iotests: Check whether luks works'
007/19:[down] 'qcrypto/core: add generic infrastructure for crypto options amendment'
008/19:[down] 'qcrypto/luks: implement encryption key management'
009/19:[down] 'block/amend: add 'force' option'
010/19:[down] 'block/amend: separate amend and create options for qemu-img'
011/19:[down] 'block/amend: refactor qcow2 amend options'
012/19:[down] 'block/crypto: rename two functions'
013/19:[down] 'block/crypto: implement the encryption key management'
014/19:[down] 'block/qcow2: extend qemu-img amend interface with crypto options'
015/19:[down] 'iotests: qemu-img tests for luks key management'
016/19:[down] 'block/core: add generic infrastructure for x-blockdev-amend qmp command'
017/19:[down] 'block/crypto: implement blockdev-amend'
018/19:[down] 'block/qcow2: implement blockdev-amend'
019/19:[down] 'iotests: add tests for blockdev-amend'


Max Reitz (5):
  iotests: Make _filter_img_create more active
  iotests/common.rc: Add _require_working_luks
  iotests.py: Add qemu_img_pipe_and_status()
  iotests.py: Add (verify|has)_working_luks()
  iotests: Check whether luks works

Maxim Levitsky (14):
  iotests: filter few more luks specific create options
  qcrypto/core: add generic infrastructure for crypto options amendment
  qcrypto/luks: implement encryption key management
  block/amend: add 'force' option
  block/amend: separate amend and create options for qemu-img
  block/amend: refactor qcow2 amend options
  block/crypto: rename two functions
  block/crypto: implement the encryption key management
  block/qcow2: extend qemu-img amend interface with crypto options
  iotests: qemu-img tests for luks key management
  block/core: add generic infrastructure for x-blockdev-amend qmp
    command
  block/crypto: implement blockdev-amend
  block/qcow2: implement blockdev-amend
  iotests: add tests for blockdev-amend

 docs/tools/qemu-img.rst          |   5 +-
 qapi/block-core.json             |  68 +++++
 qapi/crypto.json                 |  73 +++++-
 qapi/job.json                    |   4 +-
 block/crypto.h                   |  37 +++
 crypto/blockpriv.h               |   8 +
 include/block/block.h            |   1 +
 include/block/block_int.h        |  24 +-
 include/crypto/block.h           |  22 ++
 block.c                          |   4 +-
 block/amend.c                    | 113 +++++++++
 block/crypto.c                   | 206 +++++++++++++--
 block/qcow2.c                    | 332 +++++++++++++-----------
 crypto/block-luks.c              | 416 ++++++++++++++++++++++++++++++-
 crypto/block.c                   |  29 +++
 qemu-img.c                       |  44 +++-
 block/Makefile.objs              |   2 +-
 qemu-img-cmds.hx                 |   4 +-
 tests/qemu-iotests/049.out       | 102 ++++----
 tests/qemu-iotests/061.out       |  12 +-
 tests/qemu-iotests/082.out       | 185 ++++----------
 tests/qemu-iotests/085.out       |  38 +--
 tests/qemu-iotests/087           |   1 +
 tests/qemu-iotests/087.out       |   6 +-
 tests/qemu-iotests/112.out       |   2 +-
 tests/qemu-iotests/134.out       |   2 +-
 tests/qemu-iotests/141           |   2 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/153           |   9 +-
 tests/qemu-iotests/158.out       |   4 +-
 tests/qemu-iotests/178           |   1 +
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/188           |   1 +
 tests/qemu-iotests/188.out       |   2 +-
 tests/qemu-iotests/189           |   1 +
 tests/qemu-iotests/189.out       |   4 +-
 tests/qemu-iotests/198           |   1 +
 tests/qemu-iotests/198.out       |   4 +-
 tests/qemu-iotests/206           |   1 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/263           |   1 +
 tests/qemu-iotests/263.out       |   4 +-
 tests/qemu-iotests/274.out       |  46 ++--
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/284           |   1 +
 tests/qemu-iotests/284.out       |   6 +-
 tests/qemu-iotests/293           | 208 ++++++++++++++++
 tests/qemu-iotests/293.out       |  99 ++++++++
 tests/qemu-iotests/294           |  90 +++++++
 tests/qemu-iotests/294.out       |  30 +++
 tests/qemu-iotests/295           | 280 +++++++++++++++++++++
 tests/qemu-iotests/295.out       |  40 +++
 tests/qemu-iotests/296           | 234 +++++++++++++++++
 tests/qemu-iotests/296.out       |  33 +++
 tests/qemu-iotests/common.filter | 106 ++++++--
 tests/qemu-iotests/common.rc     |  30 +++
 tests/qemu-iotests/group         |   4 +
 tests/qemu-iotests/iotests.py    |  78 ++++--
 59 files changed, 2591 insertions(+), 493 deletions(-)
 create mode 100644 block/amend.c
 create mode 100755 tests/qemu-iotests/293
 create mode 100644 tests/qemu-iotests/293.out
 create mode 100755 tests/qemu-iotests/294
 create mode 100644 tests/qemu-iotests/294.out
 create mode 100755 tests/qemu-iotests/295
 create mode 100644 tests/qemu-iotests/295.out
 create mode 100755 tests/qemu-iotests/296
 create mode 100644 tests/qemu-iotests/296.out

-- 
2.26.2


