Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BCAC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB3821852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB3821852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj1Yq-00007q-0a
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46103)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hj1V8-0004Y3-OX
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hj1V5-0008Me-0x
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:10:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:54568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hj1Uv-0008Gi-W1; Thu, 04 Jul 2019 09:10:02 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hj1Up-000226-Rt; Thu, 04 Jul 2019 16:09:55 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com
Date: Thu,  4 Jul 2019 16:09:46 +0300
Message-Id: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 0/3] add zstd cluster compression
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

change log:

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
               compression               decompression
             zlib       zstd           zlib         zstd
    ------------------------------------------------------------
    real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
    user     65.0       15.8            5.3          2.5
    sys       3.3        0.2            2.0          2.0
    
    Both ZLIB and ZSTD gave the same compression ratio: ~1.5
    compressed image size in both cases: ~1.4G

Denis Plotnikov (3):
  qcow2: introduce compression type feature
  qcow2: rework the cluster compression routine
  qcow2: add zstd cluster compression

 block/qcow2.c             | 287 +++++++++++++++++++++++++++++++++++---
 block/qcow2.h             |  26 +++-
 configure                 |  32 +++++
 docs/interop/qcow2.txt    |  40 +++++-
 include/block/block_int.h |   1 +
 qapi/block-core.json      |  23 ++-
 6 files changed, 379 insertions(+), 30 deletions(-)

-- 
2.17.0


