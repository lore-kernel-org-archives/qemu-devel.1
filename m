Received: from eggs.gnu.org ([209.51.188.92]:57793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ghqRy-0002X5-Lm
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ghqRx-0007SD-PL
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:37:50 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:36995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ghqRx-0007RU-JR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:37:49 -0500
Received: by mail-pg1-x52d.google.com with SMTP id c25so5909811pgb.4
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 22:37:49 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Fri, 11 Jan 2019 14:37:29 +0800
Message-Id: <20190111063732.10484-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 0/3] optimize waiting for free thread to do
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Changelog in v2:
squash 'compress-wait-thread-adaptive' into 'compress-wait-thread' based
on peter's suggestion


Currently we have two behaviors if all threads are busy to do compression,
the main thread mush wait one of them becoming free if @compress-wait-thread
set to on or the main thread can directly return without wait and post
the page out as normal one

Both of them have its profits and short-comes, however, if the bandwidth is
not limited extremely so that compression can not use out all of it bandwidth,
at the same time, the migration process is easily throttled if we posted too
may pages as normal pages. None of them can work properly under this case

In order to use the bandwidth more effectively, we introduce the third
behavior, adaptive, which make the main thread wait
if there is no bandwidth left or let the page go out as normal page if there
has enough bandwidth to make sure the migration process will not be
throttled

Another patch introduces a new statistic, pages-per-second, as bandwidth
or mbps is not enough to measure the performance of posting pages out as
we have compression, xbzrle, which can significantly reduce the amount of
the data size, instead, pages-per-second is the one we want

Performance data
================
We have limited the bandwidth to 300

                                Used Bandwidth     Pages-per-Second
compress-wait-thread = on         951.66 mbps         131784

compress-wait-thread = off        2491.74 mbps        93495
compress-wait-thread-adaptive     1982.94 mbps        162529
   = on


Xiao Guangrong (3):
  migration: introduce pages-per-second
  migration: fix memory leak when updating tls-creds and tls-hostname
  migration: introduce adaptive model for waiting thread

 hmp.c                 |   8 ++-
 migration/migration.c | 137 +++++++++++++++++++++++++++++++++++++++++---------
 migration/migration.h |  21 ++++++++
 migration/ram.c       | 122 ++++++++++++++++++++++++++++++++++++++++----
 qapi/migration.json   |  44 +++++++++++-----
 5 files changed, 281 insertions(+), 51 deletions(-)

-- 
2.14.5
