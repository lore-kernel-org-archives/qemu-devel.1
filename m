Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C35C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE1B22CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE1B22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5XKX-0002Xe-ON
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 11:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5XDr-0005sf-1x
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5XDp-00030w-HU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:29:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:60746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i5XDp-0002zr-9x; Wed, 04 Sep 2019 11:29:25 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i5XDm-0000Me-Kg; Wed, 04 Sep 2019 18:29:22 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: armbru@redhat.com,
	qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 18:29:12 +0300
Message-Id: <20190904152915.30755-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v5 0/3] qcow2: add zstd cluster compression
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5:
* type changed for compression_type at BDRVQcow2State [Kevin]
* fixed typos, grammar [Kevin]
* fixed default config zstd setting [Kevin]

v4:
* remove not feasible switch case [Vladimir]
* add sanity checks to zstd decompresssion [Vladimir]
* store zstd compressed length in big endian [Max, Kevin]

v3:
* relax the compression type setting requirement when
  the compression type is not zlib [Eric, Kevin]
* add compression type values to the spec [Eric]
* fix wording in the spec and descriptions [Eric]
* fix functions descriptions [Max]
* fix zstd (de)compression functions flaws [Max]
* fix zstd related parts of configure file [Max]
* rebased to v4.1.0-rc5 and chenged the series version aiming to 4.2

v2:
* relax the compression type setting restriction in the spec
* fix qcow2 header size checking
* fix error processing and messaging
* fix qcow2 image specific info reporting
* set Qcow2CompressionType zstd config dependant
* add zstd compressed cluster format description to the spec

v1:
* extend qcow2 header instead of adding a new incompatible extension header
specification re-written accordingly
* enable zstd compression via config
* fix zstd (de)compression functions
* fix comments/description
* fix function naming

---
The goal of the patch-set is to enable qcow2 to use zstd compression for
clusters. ZSTD provides better (de)compression performance than currently
used ZLIB. Using it will improve perforamnce (reduce compression time)
when the compressed clusters is used, e.g backup scenarios.

Also, the patch-set extends qcow2 specification by adding compression_type
feature. The feature enables adding ZSTD and another compression algorithms
in the future.

Here is some measurements ZSTD vs ZLIB:

The test:
Test compresses and decompresses qemu qcow2 image with just
installed rhel-7.6 guest.
Image cluster size: 64K. Image on disk size: 2.2G

The test was conducted with brd disk to reduce the influence
of disk subsystem to the test results.
The results is given in seconds.

compress cmd:
time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
src.img [zlib|zstd]_compressed.img
decompress cmd
time ./qemu-img convert -O qcow2
[zlib|zstd]_compressed.img uncompressed.img


The results:
compression decompression
zlib zstd zlib zstd
------------------------------------------------------------
real 65.5 16.3 (-75 %) 1.9 1.6 (-16 %)
user 65.0 15.8 5.3 2.5
sys 3.3 0.2 2.0 2.0

Both ZLIB and ZSTD gave the same compression ratio: ~1.5
compressed image size in both cases: ~1.4G


Denis Plotnikov (3):
  qcow2: introduce compression type feature
  qcow2: rework the cluster compression routine
  qcow2: add zstd cluster compression

 block/qcow2-threads.c     | 184 +++++++++++++++++++++++++++++++++++---
 block/qcow2.c             |  98 ++++++++++++++++++++
 block/qcow2.h             |  26 ++++--
 configure                 |  29 ++++++
 docs/interop/qcow2.txt    |  39 +++++++-
 include/block/block_int.h |   1 +
 qapi/block-core.json      |  23 ++++-
 7 files changed, 376 insertions(+), 24 deletions(-)

-- 
2.17.0


