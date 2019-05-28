Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9FBC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAD120679
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAD120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVdIm-0004Vg-CH
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 10:42:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVdGF-0002pj-F0
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVdG9-0008KC-7k
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:39:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:46360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVdFs-0006u8-3L; Tue, 28 May 2019 10:39:11 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVdEL-0004ye-Pg; Tue, 28 May 2019 17:37:33 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com,
	qemu-block@nongnu.org
Date: Tue, 28 May 2019 17:37:24 +0300
Message-Id: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v0 0/3] add zstd cluster compression
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
  qcow2: add compression type processing
  qcow2: add zstd cluster compression

 block/qcow2.c             | 240 ++++++++++++++++++++++++++++++++++++--
 block/qcow2.h             |  29 +++--
 configure                 |  26 +++++
 docs/interop/qcow2.txt    |  37 +++++-
 include/block/block_int.h |   1 +
 qapi/block-core.json      |  34 +++++-
 6 files changed, 348 insertions(+), 19 deletions(-)

-- 
2.17.0


