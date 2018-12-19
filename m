Received: from eggs.gnu.org ([2001:4830:134:3::10]:40513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZd8r-0001Kv-JO
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZd8q-0001oI-KT
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:48:09 -0500
References: <20181219065020.81256-1-mahaocong_work@163.com>
	<20181219065020.81256-2-mahaocong_work@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea116c05-43c3-cb11-e492-b32a8f918bec@redhat.com>
Date: Wed, 19 Dec 2018 08:47:50 -0600
MIME-Version: 1.0
In-Reply-To: <20181219065020.81256-2-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] migration: add incremental mode on
 drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, mahaocong <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com

On 12/19/18 12:50 AM, mahaocong wrote:
> From: mahaocong <mahaocong@didichuxing.com>
> 
> Signed-off-by: mahaocong <mahaocong@didichuxing.com>

The subject line tells "what", but you are missing a commit message body 
that gives the "why".  Details about the new feature, and how it is 
useful, go a long way to making the code easier to review.  How much of 
your cover letter should be here as well?

At a first glance, I'm just going to focus on the interface:

> ---
>   block/dirty-bitmap.c         | 14 ++++++++++
>   block/mirror.c               | 63 +++++++++++++++++++++++++++++++++++---------
>   blockdev.c                   | 36 +++++++++++++++++++++++--
>   include/block/block_int.h    |  3 ++-
>   include/block/dirty-bitmap.h |  3 +++
>   include/qemu/hbitmap.h       |  2 ++
>   qapi/block-core.json         |  4 ++-
>   util/hbitmap.c               | 28 ++++++++++++++++++++
>   8 files changed, 136 insertions(+), 17 deletions(-)
> 

> +++ b/qapi/block-core.json
> @@ -1727,6 +1727,8 @@
>   #        (all the disk, only the sectors allocated in the topmost image, or
>   #        only new I/O).
>   #
> +# @bitmap-name: the bitmap to be used in incremental mode.

Missing a '(since 4.0)' tag.  And doesn't really explain what 
incremental mode in a mirroring operation actually means.

> +#
>   # @granularity: granularity of the dirty bitmap, default is 64K
>   #               if the image format doesn't have clusters, 4K if the clusters
>   #               are smaller than that, else the cluster size.  Must be a
> @@ -1768,7 +1770,7 @@
>   { 'struct': 'DriveMirror',
>     'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>               '*format': 'str', '*node-name': 'str', '*replaces': 'str',
> -            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
> +            'sync': 'MirrorSyncMode', '*bitmap-name': 'str', '*mode': 'NewImageMode',

Can this be named just 'bitmap', instead of the longer 'bitmap-name'?

>               '*speed': 'int', '*granularity': 'uint32',
>               '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
>               '*on-target-error': 'BlockdevOnError',
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 8d402c5..7ae2fc2 100644
> --- a/util/hbitmap.c


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
