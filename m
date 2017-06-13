Received: from eggs.gnu.org ([2001:4830:134:3::10]:51765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKnPd-0006zq-M9
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKnPY-0004M7-Lc
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:07:21 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dKnPY-0004LQ-8E
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:07:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170613133329.23653-7-stefanha@redhat.com>
References: <20170613133329.23653-1-stefanha@redhat.com>
	<20170613133329.23653-7-stefanha@redhat.com>
Date: Tue, 13 Jun 2017 17:07:13 +0200
Message-ID: <w511sqoncym.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>

On Tue 13 Jun 2017 03:33:26 PM CEST, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Use qcow2_calc_prealloc_size() to get the required file size.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

You kept my R-b here but one of the changes was in this patch:

> +    info = g_new(BlockMeasureInfo, 1);
> +    info->fully_allocated =
> +        qcow2_calc_prealloc_size(virtual_size, cluster_size,
> +                                 ctz32(refcount_bits));
> +    if (DIV_ROUND_UP(info->fully_allocated, cluster_size) > INT_MAX) {
> +        g_free(info);
> +        error_setg(&local_err, "The image size is too large "
> +                               "(try using a larger cluster size)");
> +        goto err;
> +    }

This has the opposite problem than the previous version: valid image
sizes are now rejected by the 'measure' command.

$ qemu-img create -f qcow2 img.qcow2 1P
Formatting 'img.qcow2', fmt=qcow2 size=1125899906842624 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16

$ build/qemu-img measure -O qcow2 --size 1P
qemu-img: The image size is too large (try using a larger cluster size)

The actual limit is:

#define QCOW_MAX_L1_SIZE 0x2000000

That's 4194304 entries, each one can address cluster_size^2 / 8 bytes

So using that formula, here is the maximum virtual size depending on the
cluster size:

|--------------+------------------|
| Cluster size | Max virtual size |
|--------------+------------------|
| 512 bytes    | 128 GB           |
| 1 KB         | 512 GB           |
| 2 KB         | 2 TB             |
| 4 KB         | 8 TB             |
| 8 KB         | 32 TB            |
| 16 KB        | 128 TB           |
| 32 KB        | 512 TB           |
| 64 KB        | 2 PB             |
| 128 KB       | 8 PB             |
| 256 KB       | 32 PB            |
| 512 KB       | 128 PB           |
| 1 MB         | 512 PB           |
| 2 MB         | 2 EB             |
|--------------+------------------|

I just created a 2 EB image and it works fine, Linux can detect it
without problems, I can create a file system, etc.

If you specify a larger size, qcow2_grow_l1_table() fails with -EFIB.

Berto
