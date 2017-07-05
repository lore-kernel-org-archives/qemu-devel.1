Received: from eggs.gnu.org ([2001:4830:134:3::10]:50526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSsIi-00008H-DI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSsIf-0006AC-Qn
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:57:36 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSsIf-00069v-KR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:57:33 -0400
Received: by mail-wr0-f174.google.com with SMTP id k67so2926029wrc.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 14:57:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20170629132749.997-1-pbonzini@redhat.com>
Message-ID: <c4d2c1cc-b6ae-c001-904c-bc7282e00465@redhat.com>
Date: Wed, 5 Jul 2017 23:57:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/11] Block layer
 thread-safety, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On 29/06/2017 15:27, Paolo Bonzini wrote:
> This part takes care of drivers and devices, making sure that they can
> accept concurrent I/O from multiple AioContext.
> 
> The following drivers are thread-safe without using any QemuMutex/CoMutex:
> crypto, gluster, null, rbd, win32-aio.  NBD has already been fixed,
> because the patch fixed an unrelated testcase.
> 
> The following drivers already use mutexes for everything except possibly
> snapshots, which do not (yet?) need protection: bochs, cloop, dmg, qcow,
> parallels, vhdx, vmdk, curl, iscsi, nfs.
> 
> The following drivers already use mutexes for _almost_ everything: vpc
> (missing get_block_status), vdi (missing bitmap access), vvfat (missing
> commit), not protected), qcow2 (must call CoQueue APIs under CoMutex).
> They are fixed by patches 1-5.
> 
> The following drivers must be changed to use CoMutex to protect internal
> data: qed (patches 6-9), sheepdog (patch 10).
> 
> The following driver must be changed to support I/O from any AioContext:
> ssh.  It is fixed by patch 11.
> 
> Paolo
> 
> v1->v2: new patch 8 + adjustments to patch 9 to fix qemu-iotests testcase
>         183 (bdrv_invalidate_cache from block migration)
> 
> Paolo Bonzini (11):
>   qcow2: call CoQueue APIs under CoMutex
>   coroutine-lock: add qemu_co_rwlock_downgrade and
>     qemu_co_rwlock_upgrade
>   vdi: make it thread-safe
>   vpc: make it thread-safe
>   vvfat: make it thread-safe
>   qed: move tail of qed_aio_write_main to qed_aio_write_{cow,alloc}
>   block: invoke .bdrv_drain callback in coroutine context and from
>     AioContext
>   qed: introduce bdrv_qed_init_state
>   qed: protect table cache with CoMutex
>   sheepdog: add queue_lock
>   ssh: support I/O from any AioContext
> 
>  block/io.c                 |  42 +++++++--
>  block/qcow2.c              |   4 +-
>  block/qed-cluster.c        |   4 +-
>  block/qed-l2-cache.c       |   6 ++
>  block/qed-table.c          |  24 +++--
>  block/qed.c                | 214 ++++++++++++++++++++++++++++-----------------
>  block/qed.h                |  11 ++-
>  block/sheepdog.c           |  21 ++++-
>  block/ssh.c                |  24 +++--
>  block/vdi.c                |  48 +++++-----
>  block/vpc.c                |  20 ++---
>  block/vvfat.c              |   8 +-
>  include/block/block_int.h  |   2 +-
>  include/qemu/coroutine.h   |  18 ++++
>  util/qemu-coroutine-lock.c |  35 ++++++++
>  15 files changed, 331 insertions(+), 150 deletions(-)
> 


ping?

Paolo
