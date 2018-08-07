Received: from eggs.gnu.org ([2001:4830:134:3::10]:48424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fmy2h-00035E-GX
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fmy2e-00052g-6O
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:12:39 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:39729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fmy2d-00052U-VM
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:12:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id j8-v6so8281185pff.6
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 02:12:35 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue,  7 Aug 2018 17:11:59 +0800
Message-Id: <20180807091209.13531-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 00/10] migration: compression optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Changelog in v3:

Thanks to Peter's comments, the changes in this version are:
1) make compress-wait-thread be true on default to keep current behavior
2) save the compressed-size instead of reduced size and fix calculating
   compression ratio
3) fix calculating xbzrle_counters.cache_miss_rate and
   compression_counters.busy_rate


Xiao Guangrong (10):
  migration: do not wait for free thread
  migration: fix counting normal page for compression
  migration: introduce save_zero_page_to_file
  migration: drop the return value of do_compress_ram_page
  migration: move handle of zero page to the thread
  migration: hold the lock only if it is really needed
  migration: do not flush_compressed_data at the end of each iteration
  migration: handle the error condition properly
  migration: fix calculating xbzrle_counters.cache_miss_rate
  migration: show the statistics of compression

 hmp.c                 |  21 ++++
 include/qemu/queue.h  |   1 +
 migration/migration.c |  33 ++++++
 migration/migration.h |   1 +
 migration/ram.c       | 283 +++++++++++++++++++++++++++++++++++++-------------
 migration/ram.h       |   1 +
 qapi/migration.json   |  49 +++++++--
 7 files changed, 308 insertions(+), 81 deletions(-)

-- 
2.14.4
