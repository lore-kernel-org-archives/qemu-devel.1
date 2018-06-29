Received: from eggs.gnu.org ([2001:4830:134:3::10]:51876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYxhg-0006Zl-Er
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYxhc-00014D-F9
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:01:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYxhc-00013k-8O
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:01:00 -0400
References: <1400565880-13409-1-git-send-email-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <57e00977-d315-6be9-de9f-b599021958f2@redhat.com>
Date: Fri, 29 Jun 2018 13:00:57 -0500
MIME-Version: 1.0
In-Reply-To: <1400565880-13409-1-git-send-email-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 00/15] Drop in_use from
 BlockDriverState and enable point-in-time snapshot exporting over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imain@redhat.com, stefanha@redhat.com, hbrock@redhat.com, jcody@redhat.com, armbru@redhat.com, John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 05/20/2014 01:04 AM, Fam Zheng wrote:
> Thanks for Eric's and Markus' reviewing!

Thread necromancy - now that patch 15/15 has had a revival four years 
later (two different threads proposing a test 222 for image fleecing) - 
I want to double check if anything else in this series still needs 
forward porting.

> 
> v20: Rebase to master, with minor improvements as listed below:
> 
>      [02/15] block: Introduce op_blockers to BlockDriverState
>              Better error message in bdrv_op_is_blocked. (Markus)
> 
>      [03/15] block: Replace in_use with operation blocker
>              Accurate commit message: why use bdrv_op_blocker_is_empty in
>              block_job_create. (Markus)
> 
>      [06/15] block: Add backing_blocker in BlockDriverState
>              Drop error_is_set().
>              Call error_free() unconditionally.
>              
> 
>      [08/15] block: Support dropping active in bdrv_drop_intermediate
>              Fix list index in function comment. (Eric)
> 
>      [13/15] block: Add blockdev-backup to transaction
>              Drop error_is_set().
> 
>      [14/15] qemu-iotests: Test blockdev-backup in 055
>              Bump year in file header. (Eric)
>   

> Fam Zheng (15):
>    block: Add BlockOpType enum
>    block: Introduce op_blockers to BlockDriverState
>    block: Replace in_use with operation blocker
>    block: Move op_blocker check from block_job_create to its caller
>    block: Add bdrv_set_backing_hd()
>    block: Add backing_blocker in BlockDriverState

Before this point looks to be in master (in some form or another); after 
this point did not have any review.

>    block: Parse "backing" option to reference existing BDS
>    block: Support dropping active in bdrv_drop_intermediate
>    stream: Use bdrv_drop_intermediate and drop close_unused_images
>    commit: Use bdrv_drop_intermediate
>    qmp: Add command 'blockdev-backup'
>    block: Allow backup on referenced named BlockDriverState
>    block: Add blockdev-backup to transaction
>    qemu-iotests: Test blockdev-backup in 055
>    qemu-iotests: Image fleecing test case 089
> 
>   block-migration.c               |   7 +-
>   block.c                         | 310 +++++++++++++++++++++++++++-------------
>   block/backup.c                  |  26 ++++
>   block/commit.c                  |   2 +-
>   block/mirror.c                  |   9 +-
>   block/stream.c                  |  42 +-----
>   blockdev.c                      | 122 ++++++++++++++--
>   blockjob.c                      |  14 +-
>   hw/block/dataplane/virtio-blk.c |  18 ++-
>   include/block/block.h           |  29 +++-
>   include/block/block_int.h       |   9 +-
>   include/block/blockjob.h        |   3 +
>   qapi-schema.json                |  52 +++++++
>   qmp-commands.hx                 |  44 ++++++
>   tests/qemu-iotests/055          | 277 +++++++++++++++++++++++++++++------
>   tests/qemu-iotests/055.out      |   4 +-
>   tests/qemu-iotests/089          |  99 +++++++++++++
>   tests/qemu-iotests/089.out      |   5 +
>   tests/qemu-iotests/group        |   1 +
>   19 files changed, 856 insertions(+), 217 deletions(-)
>   create mode 100755 tests/qemu-iotests/089
>   create mode 100644 tests/qemu-iotests/089.out
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
