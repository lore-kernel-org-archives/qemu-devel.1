Received: from eggs.gnu.org ([2001:4830:134:3::10]:47092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kg-0003sB-Hi
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kd-0004VJ-3A
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:58 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:33073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fs1kW-0004K3-Uu
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:50 -0400
Received: by mail-pl0-x229.google.com with SMTP id b90-v6so8441016plb.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 01:10:43 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 21 Aug 2018 16:10:19 +0800
Message-Id: <20180821081029.26121-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v4 00/10] migration: compression optimization
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

Changelog in v4:
These changes are based on the suggestion from Peter Eric.
1) improve qapi's grammar
2) move calling flush_compressed_data to migration_bitmap_sync()
3) rename 'handle_pages' to 'target_page_count'

Note: there is still no clear way to fix handling the error condition
returned by ram_find_and_save_block(), i moved the patch to the end of
this series, hope it's good to help to merge this patchset

Xiao Guangrong (10):
  migration: do not wait for free thread
  migration: fix counting normal page for compression
  migration: introduce save_zero_page_to_file
  migration: drop the return value of do_compress_ram_page
  migration: move handle of zero page to the thread
  migration: hold the lock only if it is really needed
  migration: do not flush_compressed_data at the end of each iteration
  migration: fix calculating xbzrle_counters.cache_miss_rate
  migration: show the statistics of compression
  migration: handle the error condition properly

 hmp.c                 |  21 ++++
 include/qemu/queue.h  |   1 +
 migration/migration.c |  33 +++++
 migration/migration.h |   1 +
 migration/ram.c       | 329 +++++++++++++++++++++++++++++++++++---------------
 migration/ram.h       |   1 +
 qapi/migration.json   |  53 +++++++-
 7 files changed, 333 insertions(+), 106 deletions(-)

-- 
2.14.4
