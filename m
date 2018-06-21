Received: from eggs.gnu.org ([2001:4830:134:3::10]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fW7xs-00056H-EH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fW7xo-0008Fo-9Y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:04 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fW7xo-0008EF-2W
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:00 -0400
Received: by mail-pf0-x243.google.com with SMTP id c22-v6so2199987pfi.2
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:22:00 -0700 (PDT)
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Date: Thu, 21 Jun 2018 15:21:41 -0700
Message-Id: <20180621222143.27266-1-naravamudan@digitalocean.com>
Subject: [Qemu-devel] [PATCH v3 0/2] linux-aio: fix two NULL pointer
 dereferences failure paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: naravamudan@digitalocean.com
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

laio_init() can fail for a couple of reasons, which will lead to a NULL
pointer dereference in laio_attach_aio_context(), called from
aio_get_linux_aio().

Test case 1:
    Set /proc/sys/fs/max-aio-nr to 0. Start a guest with an aio=native
    disk.

    Result: laio_init() returns NULL due to not being able to allocate
    any AIO contexts. This NULL is assigned to ctx->linux_aio and
    dereferenced in aio_get_linux_aio.

Test case 2:
    Set /proc/sys/fs/max-aio-nr to 128. Start a guest with an aio=native
    disk and one in-use I/O thread.

    Result: laio_init() returns NULL due to not being able to allocate
    additional AIO contexts for the I/O thread. This NULL is assigned to
    ctx->linux_aio and dereferenced in aio_get_linux_aio.

Thanks to Jon Snow, Eric Blake and Kevin Wolf for review comments on v1
and v2.

Nishanth Aravamudan (2):
  linux-aio: properly bubble up errors from initialization
  file-posix: reconfigure aio on iothread start

 block/file-posix.c      | 33 ++++++++++++++++++++++++++++-----
 block/linux-aio.c       | 15 ++++++++++-----
 include/block/aio.h     |  3 +++
 include/block/raw-aio.h |  2 +-
 stubs/linux-aio.c       |  2 +-
 util/async.c            | 16 +++++++++++++---
 6 files changed, 56 insertions(+), 15 deletions(-)

-- 
2.17.1
