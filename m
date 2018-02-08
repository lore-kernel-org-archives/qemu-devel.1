Received: from eggs.gnu.org ([2001:4830:134:3::10]:59197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejvOn-0002zg-Fs
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejvOm-0007VP-FX
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:14:37 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <089a3c4e-7fdc-e93d-5b37-ac4d45b5d4e0@redhat.com>
Date: Thu, 8 Feb 2018 17:14:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/27] block/qapi: Add qcow2 create options
 to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b59b1430bb..aade602a04 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3338,6 +3338,49 @@
>   { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
>   
>   ##
> +# @BlockdevQcow2Version:
> +#
> +# @v2:  The original QCOW2 format as introduced in qemu 0.10 (version 2)
> +# @v3:  The extended QCOW2 format as introduced in qemu 1.1 (version 3)
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'BlockdevQcow2Version',
> +  'data': [ 'v2', 'v3' ] }

Yes, I think that turns out nicer.

> +
> +
> +##
> +# @BlockdevCreateOptionsQcow2:
> +#
> +# Driver specific image creation options for qcow2.
> +#
> +# @file             Node to create the image format on
> +# @size             Size of the virtual disk in bytes
> +# @version          Compatibility level (default: v3)
> +# @backing-file     File name of the backing file if a backing file
> +#                   should be used

Do we need an explicit comment that the QMP command does NOT open this 
file (so much as this being the string recorded in the metadata header), 
but that the caller is expected to later connect a node visiting the 
backing file to this node after the create has completed?  Or is that 
more for adding later in the QMP command that uses the overall union 
type (as the same rule will apply to multiple formats, not just qcow2 - 
the create operation is NOT creating the backing chain, but just 
formatting one element that will later be hooked into the chain).

> +# @backing-fmt      Name of the block driver to use for the backing file
> +# @encrypt          Encryption options if the image should be encrypted
> +# @cluster-size     qcow2 cluster size in bytes (default: 65536)
> +# @preallocation    Preallocation mode for the new image (default: off)
> +# @lazy-refcounts   True if refcounts may be updated lazily (default: off)
> +# @refcount-bits    Width of reference counts in bits (default: 16)
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsQcow2',
> +  'data': { 'file':             'BlockdevRef',
> +            'size':             'size',
> +            '*version':         'BlockdevQcow2Version',
> +            '*backing-file':    'str',
> +            '*backing-fmt':     'BlockdevDriver',
> +            '*encrypt':         'QCryptoBlockCreateOptions',
> +            '*cluster-size':    'size',
> +            '*preallocation':   'PreallocMode',
> +            '*lazy-refcounts':  'bool',
> +            '*refcount-bits':   'int' } }

Looks reasonable, and matches what qemu-img create -f qcow2 can do (the 
obvious differences of '-' in QMP instead of '_' in qemu-img -o spelling 
is fine).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
