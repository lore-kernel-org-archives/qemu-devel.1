Received: from eggs.gnu.org ([2001:4830:134:3::10]:51978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebrrS-0000ZV-V9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebrrS-0003AW-3g
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:50:55 -0500
Date: Wed, 17 Jan 2018 18:50:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180117175029.GD3860@localhost.localdomain>
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111195225.4226-11-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 10/10] block: x-blockdev-create QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, jsnow@redhat.com

Am 11.01.2018 um 20:52 hat Kevin Wolf geschrieben:
> This adds a synchronous x-blockdev-create QMP command that can create
> qcow2 images on a given node name.
> 
> We don't want to block while creating an image, so this is not the final
> interface in all aspects, but BlockdevCreateOptionsQcow2 and
> .bdrv_co_create() are what they actually might look like in the end. In
> any case, this should be good enough to test whether we interpret
> BlockdevCreateOptions as we should.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json      | 12 ++++++++++++
>  include/block/block_int.h |  2 ++
>  block.c                   | 48 +++++++++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c             |  3 ++-
>  4 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 9341f6708d..93357a4d5d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3415,6 +3415,18 @@
>    } }
>  
>  ##
> +# @x-blockdev-create:
> +#
> +# Create an image format on a given node.
> +# TODO Replace with something asynchronous (block job?)

I just realised that this won't be a block job. It will be a job without
block, because there isn't necessarily any BlockDriverState involved
(when you create the protocol layer).

So it looks like my first job there is to make block jobs work with
bs == NULL... Or actually, we should probably try and do the proper
thing with the whole new job API that we were planning anyway?

Kevin
