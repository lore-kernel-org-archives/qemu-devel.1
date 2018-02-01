Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehGA3-0005ST-PE
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehGA0-0005Yq-Cp
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:48:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehGA0-0005YS-5Z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:48:20 -0500
Received: by mail-wm0-f68.google.com with SMTP id f71so6422564wmf.0
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 06:48:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
Message-ID: <ecdb2235-24ee-8280-a988-c3d56d02f393@redhat.com>
Date: Thu, 1 Feb 2018 09:48:17 -0500
MIME-Version: 1.0
In-Reply-To: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Call check and invalidate_cache
 from coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 18/01/2018 07:43, Paolo Bonzini wrote:
> Check and invalidate_cache share some parts of the implementation
> with the regular I/O path.  This is sometimes complicated because the
> I/O path wants to use a CoMutex but that is not possible outside coroutine
> context.  By moving things to coroutine context, we can remove special
> cases.  In fact, invalidate_cache is already called from coroutine context
> because incoming migration is placed in a coroutine.
> 
> While at it, I'm including two patches from Stefan to rename the
> bdrv_create callback to bdrv_co_create, because it is already called
> from coroutine context.  The name is now bdrv_co_create_opts, with
> bdrv_co_create reserved for the QAPI-based version that Kevin is
> working on.
> 
> qcow2 still has cache flushing in non-coroutine context, coming from
> qcow2_reopen_prepare->qcow2_update_options_prepare and
> qcow2_close->qcow2_inactivate.
> 
> Paolo

Ping?

Thanks,

Paolo

> v1->v2: fix file-win32
> 
> Paolo Bonzini (5):
>   qcow2: make qcow2_do_open a coroutine_fn
>   qed: make bdrv_qed_do_open a coroutine_fn
>   block: convert bdrv_invalidate_cache callback to coroutine_fn
>   qcow2: introduce qcow2_write_caches and qcow2_flush_caches
>   block: convert bdrv_check callback to coroutine_fn
> 
> Stefan Hajnoczi (2):
>   block: rename .bdrv_create() to .bdrv_co_create_opts()
>   qcow2: make qcow2_co_create2() a coroutine_fn
> 
>  block.c                   |  88 ++++++++++++++++++++++++++++++----
>  block/crypto.c            |   8 ++--
>  block/file-posix.c        |  15 +++---
>  block/file-win32.c        |   5 +-
>  block/gluster.c           |  12 ++---
>  block/iscsi.c             |  13 ++---
>  block/nfs.c               |  11 +++--
>  block/parallels.c         |  23 +++++----
>  block/qcow.c              |   5 +-
>  block/qcow2-refcount.c    |  28 +++++++++++
>  block/qcow2.c             | 118 +++++++++++++++++++++++++++++++---------------
>  block/qcow2.h             |   2 +
>  block/qed-check.c         |   1 +
>  block/qed-table.c         |  26 ++++------
>  block/qed.c               |  72 +++++++++++++++++++++-------
>  block/raw-format.c        |   5 +-
>  block/rbd.c               |  12 +++--
>  block/sheepdog.c          |  10 ++--
>  block/ssh.c               |   5 +-
>  block/vdi.c               |  11 +++--
>  block/vhdx.c              |  12 +++--
>  block/vmdk.c              |  12 +++--
>  block/vpc.c               |   5 +-
>  include/block/block_int.h |  11 +++--
>  24 files changed, 355 insertions(+), 155 deletions(-)
> 
