Received: from eggs.gnu.org ([2001:4830:134:3::10]:36344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN7tj-0004LX-SM
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN7tb-00077W-6x
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:00:49 -0500
References: <20181005234023.8104-1-mreitz@redhat.com>
	<20181005234023.8104-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03a28fa3-8509-9d91-f852-baabd526bc30@redhat.com>
Date: Wed, 14 Nov 2018 21:00:21 -0600
MIME-Version: 1.0
In-Reply-To: <20181005234023.8104-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 01/31] block: Use
 bdrv_refresh_filename() to pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On 10/5/18 6:39 PM, Max Reitz wrote:
> Before this patch, bdrv_refresh_filename() is used in a pushing manner:
> Whenever the BDS graph is modified, the parents of the modified edges
> are supposed to be updated (recursively upwards).  However, that is
> nonviable, considering that we want child changes not to concern
> parents.
> 

>   include/block/block.h |  1 -
>   block.c               | 31 +++++++++++++++----------------
>   block/qapi.c          |  4 ++++
>   block/raw-format.c    |  1 +
>   block/replication.c   |  2 --
>   block/vhdx-log.c      |  1 +
>   block/vmdk.c          |  6 ++++++
>   block/vpc.c           |  4 +++-
>   blockdev.c            |  8 ++++++++
>   9 files changed, 38 insertions(+), 20 deletions(-)
> 

> +++ b/block/vpc.c
> @@ -284,9 +284,11 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>   
>       checksum = be32_to_cpu(footer->checksum);
>       footer->checksum = 0;
> -    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum)
> +    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum) {
> +        bdrv_refresh_filename(bs);
>           fprintf(stderr, "block-vpc: The header checksum of '%s' is "
>               "incorrect.\n", bs->filename);
> +    }

In the intervening month, this now conflicts. I'm guessing we'll see a 
v12 targeted for 4.0, since your other series on "block: Deal with 
filters" depends on this one?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
