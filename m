Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E5C2D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7673F20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7673F20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKyF-000331-L3
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJKws-0001kU-Kw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJKwq-0006Ax-T0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:45:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:57858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJKwq-00067m-Kt; Tue, 31 Mar 2020 13:45:12 -0400
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJKwg-000560-0V; Tue, 31 Mar 2020 20:45:02 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v14 0/4] qcow2: Implement zstd cluster compression method
Date: Tue, 31 Mar 2020 20:44:51 +0300
Message-Id: <20200331174455.31792-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v14:
   * fix bug on compression - looping until compress == 0 [Me]
   * apply reworked Vladimir's suggestions:
      1. not mixing ssize_t with size_t
      2. safe check for ENOMEM in compression part - avoid overflow
      3. tolerate sanity check allow zstd to make progress only
         on one of the buffers
v13:
   * 03: add progress sanity check to decompression loop [Vladimir]
     03: add successful decompression check [Me]

v12:
   * 03: again, rework compression and decompression loops
         to make them more correct [Vladimir]
     03: move assert in compression to more appropriate place
             [Vladimir]
v11:
   * 03: the loops don't need "do{}while" form anymore and
         the they were buggy (missed "do" in the beginning)
         replace them with usual "while(){}" loops [Vladimir]
v10:
   * 03: fix zstd (de)compressed loops for multi-frame
         cases [Vladimir]
v9:
   * 01: fix error checking and reporting in qcow2_amend compression type part [Vladimir]
   * 03: replace asserts with -EIO in qcow2_zstd_decompression [Vladimir, Alberto]
   * 03: reword/amend/add comments, fix typos [Vladimir]

v8:
   * 03: switch zstd API from simple to stream [Eric]
         No need to state a special cluster layout for zstd
         compressed clusters.
v7:
   * use qapi_enum_parse instead of the open-coding [Eric]
   * fix wording, typos and spelling [Eric]

v6:
   * "block/qcow2-threads: fix qcow2_decompress" is removed from the series
      since it has been accepted by Max already
   * add compile time checking for Qcow2Header to be a multiple of 8 [Max, Alberto]
   * report error on qcow2 amending when the compression type is actually chnged [Max]
   * remove the extra space and the extra new line [Max]
   * re-arrange acks and signed-off-s [Vladimir]

v5:
   * replace -ENOTSUP with abort in qcow2_co_decompress [Vladimir]
   * set cluster size for all test cases in the beginning of the 287 test

v4:
   * the series is rebased on top of 01 "block/qcow2-threads: fix qcow2_decompress"
   * 01 is just a no-change resend to avoid extra dependencies. Still, it may be merged in separate

v3:
   * remove redundant max compression type value check [Vladimir, Eric]
     (the switch below checks everything)
   * prevent compression type changing on "qemu-img amend" [Vladimir]
   * remove zstd config setting, since it has been added already by
     "migration" patches [Vladimir]
   * change the compression type error message [Vladimir] 
   * fix alignment and 80-chars exceeding [Vladimir]

v2:
   * rework compression type setting [Vladimir]
   * squash iotest changes to the compression type introduction patch [Vladimir, Eric]
   * fix zstd availability checking in zstd iotest [Vladimir]
   * remove unnecessry casting [Eric]
   * remove rudundant checks [Eric]
   * fix compressed cluster layout in qcow2 spec [Vladimir]
   * fix wording [Eric, Vladimir]
   * fix compression type filtering in iotests [Eric]

v1:
   the initial series


Denis Plotnikov (4):
  qcow2: introduce compression type feature
  qcow2: rework the cluster compression routine
  qcow2: add zstd cluster compression
  iotests: 287: add qcow2 compression type test

 docs/interop/qcow2.txt           |   1 +
 configure                        |   2 +-
 qapi/block-core.json             |  23 ++-
 block/qcow2.h                    |  20 ++-
 include/block/block_int.h        |   1 +
 block/qcow2-threads.c            | 233 +++++++++++++++++++++++++++++--
 block/qcow2.c                    | 120 ++++++++++++++++
 tests/qemu-iotests/031.out       |  14 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 +++++++-------
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  34 +++--
 tests/qemu-iotests/065           |  28 ++--
 tests/qemu-iotests/080           |   2 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/287           | 128 +++++++++++++++++
 tests/qemu-iotests/287.out       |  43 ++++++
 tests/qemu-iotests/common.filter |   3 +-
 tests/qemu-iotests/group         |   1 +
 22 files changed, 671 insertions(+), 108 deletions(-)
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out

-- 
2.17.0


