Received: from eggs.gnu.org ([2001:4830:134:3::10]:42923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eveol-0002r3-LN
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eveoi-0007L2-Ko
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:57:55 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1eveoi-0007K5-EG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:57:52 -0400
Received: by mail-pl0-x241.google.com with SMTP id d9-v6so10875862plo.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 00:57:52 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 13 Mar 2018 15:57:31 +0800
Message-Id: <20180313075739.11194-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 0/8] migration: improve and cleanup compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

This is the first part of our work to improve compression to make it
be more useful in the production.

The first patch resolves the problem that the migration thread spends
too much CPU resource to compression memory if it jumps to a new block
that causes the network is used very deficient.

The second patch fixes the performance issue that too many VM-exits
happen during live migration if compression is being used, it is caused
by huge memory returned to kernel frequently as the memory is allocated
and freed for every signal call to compress2()

The remaining patches clean the code up dramatically  


Xiao Guangrong (8):
  migration: stop compressing page in migration thread
  migration: stop allocating and freeing memory frequently
  migration: support to detect compression and decompression errors
  migration: introduce control_save_page()
  migration: move calling control_save_page to the common place
  migration: move calling save_zero_page to the common place
  migration: introduce save_normal_page()
  migration: remove ram_save_compressed_page()

 migration/qemu-file.c |  38 ++++-
 migration/qemu-file.h |   6 +-
 migration/ram.c       | 430 +++++++++++++++++++++++++++++---------------------
 3 files changed, 290 insertions(+), 184 deletions(-)

-- 
2.14.3
