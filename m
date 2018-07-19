Received: from eggs.gnu.org ([2001:4830:134:3::10]:34913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qT-00020L-8b
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qQ-0005Ke-1s
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fg7qP-0005KN-Sq
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:41 -0400
Received: by mail-pg1-x542.google.com with SMTP id n7-v6so3589057pgq.4
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 05:15:41 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu, 19 Jul 2018 20:15:12 +0800
Message-Id: <20180719121520.30026-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 0/8] migration: compression optimization
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

Thanks to Peter's suggestion, i split the long series (1) and this is the
first part.

I am not sure if Dave is happy to @reduced-size, will change immediately
if it's objected. :)

Changelog in v2:
1) introduce a parameter to make the main thread wait for free thread
   thread to compress the data as current behavior based on the comments
   from Dave and Peter
2) description improvement for compression statistics, thanks for Eric's
   improvement
3) move the handle of zero page to the threads
4) fix the issue that the new dirtied page would be overwritten at the
   destination when we drop flush_compressed_data at the end of iteration
   which is pointed out by Dave

(1) https://www.spinics.net/lists/kvm/msg169774.html
   
Xiao Guangrong (8):
  migration: do not wait for free thread
  migration: fix counting normal page for compression
  migration: show the statistics of compression
  migration: introduce save_zero_page_to_file
  migration: drop the return value of do_compress_ram_page
  migration: move handle of zero page to the thread
  migration: hold the lock only if it is really needed
  migration: do not flush_compressed_data at the end of each iteration

 hmp.c                 |  21 +++++
 include/qemu/queue.h  |   1 +
 migration/migration.c |  32 +++++++
 migration/migration.h |   1 +
 migration/ram.c       | 244 +++++++++++++++++++++++++++++++++++++-------------
 migration/ram.h       |   1 +
 qapi/migration.json   |  49 ++++++++--
 7 files changed, 281 insertions(+), 68 deletions(-)

-- 
2.14.4
