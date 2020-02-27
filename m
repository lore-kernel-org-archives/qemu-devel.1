Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50FEC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B63E24656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B63E24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Dh9-0005LQ-Nt
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 02:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7DcY-0000G0-KA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7DcV-000097-0D
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:30:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:33966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7DcU-00005b-1V; Thu, 27 Feb 2020 02:30:06 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7DcO-0003Tx-5M; Thu, 27 Feb 2020 10:30:00 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/8] qcow2: Implement zstd cluster compression method
Date: Thu, 27 Feb 2020 10:29:45 +0300
Message-Id: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
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
 den@vrtuozzo.com, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

zstd comression method is faster than the only available zlib.
The series adds zstd to the methods available for clusters compression.

The implementation is done with respect to the recently added compression
type additional header to the qcow2 specification.

Denis Plotnikov (8):
  qcow2: introduce compression type feature
  qcow2: rework the cluster compression routine
  qcow2: add zstd cluster compression
  iotests: filter out compression_type
  iotests: fix header size, feature table size and backing file offset
  iotests: add "compression type" for test output matching
  iotests: 080: update header size value because of adding compression
    type
  iotests: 287: add qcow2 compression type test

 block/qcow2-threads.c            | 199 ++++++++++++++++++++++++++++---
 block/qcow2.c                    | 112 +++++++++++++++++
 block/qcow2.h                    |  31 +++--
 configure                        |  29 +++++
 docs/interop/qcow2.txt           |  18 +++
 include/block/block_int.h        |   1 +
 qapi/block-core.json             |  23 +++-
 tests/qemu-iotests/031.out       |  14 +--
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++++++++--------
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  34 +++---
 tests/qemu-iotests/065           |  20 ++--
 tests/qemu-iotests/080           |   2 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/287           | 123 +++++++++++++++++++
 tests/qemu-iotests/287.out       |  41 +++++++
 tests/qemu-iotests/common.filter |   3 +-
 tests/qemu-iotests/group         |   1 +
 22 files changed, 663 insertions(+), 114 deletions(-)
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out

-- 
2.17.0


