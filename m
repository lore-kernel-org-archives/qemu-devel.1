Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC18C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DD92083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DD92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95Jt-0002Xx-2B
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 06:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j95HT-0007gB-Rj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j95HS-0000RE-4f
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:00:07 -0500
Received: from relay.sw.ru ([185.231.240.75]:44574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j95HR-0000Qd-Tg; Tue, 03 Mar 2020 06:00:06 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j95HJ-000499-7p; Tue, 03 Mar 2020 13:59:57 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4]  qcow2: Implement zstd cluster compression method
Date: Tue,  3 Mar 2020 13:59:46 +0300
Message-Id: <20200303105950.26744-1-dplotnikov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

---
zstd comression method is faster than the only available zlib.
The series adds zstd to the methods available for clusters compression.

The implementation is done with respect to the recently added compression
type additional header to the qcow2 specification.

Denis Plotnikov (4):
  qcow2: introduce compression type feature
  qcow2: rework the cluster compression routine
  qcow2: add zstd cluster compression
  iotests: 287: add qcow2 compression type test

 docs/interop/qcow2.txt           |  20 ++++
 configure                        |   2 +-
 qapi/block-core.json             |  23 +++-
 block/qcow2.h                    |  18 ++-
 include/block/block_int.h        |   1 +
 block/qcow2-threads.c            | 200 ++++++++++++++++++++++++++++---
 block/qcow2.c                    | 108 +++++++++++++++++
 tests/qemu-iotests/031.out       |  14 +--
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++++++++--------
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  34 +++---
 tests/qemu-iotests/065           |  28 +++--
 tests/qemu-iotests/080           |   2 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/287           | 127 ++++++++++++++++++++
 tests/qemu-iotests/287.out       |  43 +++++++
 tests/qemu-iotests/common.filter |   3 +-
 tests/qemu-iotests/group         |   1 +
 22 files changed, 639 insertions(+), 111 deletions(-)
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out

-- 
2.17.0


