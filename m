Received: from eggs.gnu.org ([2001:4830:134:3::10]:38332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e4T3S-0002BL-6J
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e4T3M-0006wW-Lb
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:41:14 -0400
Date: Tue, 17 Oct 2017 16:41:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171017144100.GC7660@dhcp-200-186.str.redhat.com>
References: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: don't add 'driver' to options when
 refering to backing via node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 12.10.2017 um 16:14 hat Peter Krempa geschrieben:
> When refering to a backing file of an image via node name
> bdrv_open_backing_file would add the 'driver' option to the option list
> filling it with the backing format driver. This breaks construction of
> the backing chain via -blockdev, as bdrv_open_inherit reports an error
> if both 'reference' and 'options' are provided.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>

If you don't mind, I'd add a specific example to the commit message:

$ qemu-img create -f raw /tmp/backing.raw 64M
$ qemu-img create -f qcow2 -F raw -b /tmp/backing.raw /tmp/test.qcow2
$ qemu-system-x86_64 \
  -blockdev driver=file,filename=/tmp/backing.raw,node-name=backing \
  -blockdev driver=qcow2,file.driver=file,file.filename=/tmp/test.qcow2,node-name=root,backing=backing
qemu-system-x86_64: -blockdev driver=qcow2,file.driver=file,file.filename=/tmp/test.qcow2,node-name=root,backing=backing: Could not open backing file: Cannot reference an existing block device with additional options or a new filename

> diff --git a/block.c b/block.c
> index 46eb1728da..684cb018da 100644
> --- a/block.c
> +++ b/block.c
> @@ -2245,7 +2245,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>          goto free_exit;
>      }
> 
> -    if (bs->backing_format[0] != '\0' && !qdict_haskey(options, "driver")) {
> +    if (!reference &&
> +        bs->backing_format[0] != '\0' && !qdict_haskey(options, "driver")) {
>          qdict_put_str(options, "driver", bs->backing_format);
>      }

Looks good to me.

Kevin
