Received: from eggs.gnu.org ([2001:4830:134:3::10]:49879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoRFx-0000bf-PK
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoRFu-0000rm-HD
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:04:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180220222459.8461-3-eblake@redhat.com>
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
Date: Wed, 21 Feb 2018 11:04:03 +0100
Message-ID: <w51tvuak6b0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: Avoid memory over-allocation on
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

On Tue 20 Feb 2018 11:24:59 PM CET, Eric Blake wrote:

I was also preparing a patch to change this, but you arrived first :-)

> So, it's time to cut back on the waste.  A compressed cluster
> will NEVER occupy more than an uncompressed cluster (okay, gzip
> DOES document that because the compression stream adds metadata,
> and because of the pigeonhole principle, there are worst case
> scenarios where attempts to compress will actually inflate an
> image - but in those cases, we would just write the cluster
> uncompressed instead of inflating it).  And as that is a smaller
> amount of memory, we can get by with the simpler g_malloc.

> -        if (!s->cluster_cache) {
> -            s->cluster_cache = g_malloc(s->cluster_size);
> +            assert(!s->cluster_cache);
> +            s->cluster_data = g_try_malloc(s->cluster_size);
> +            s->cluster_cache = g_try_malloc(s->cluster_size);

There's a few things here:

- QEMU won't write compressed data if the size is >= s->cluster_size
  (there's an explicit check for that in qcow2_co_pwritev_compressed())

- The size field of the compressed cluster descriptor *does* allow
  larger sizes, so you can't simply read csize bytes into
  s->cluster_data becuase you could cause a buffer overflow.

- Solution a: check that csize < s->cluster_size and return an error if
  it's not. However! although QEMU won't produce an image with a
  compressed cluster that is larger than the uncompressed one, the qcow2
  on-disk format in principle allows for that, so arguably we should
  accept it.

- Solution b: the width of the 'compressed cluster size' field is
  (cluster_bits - 8), that's (cluster_size / 256) sectors. Since the
  size of each sector is 512 bytes, the maximum possible size that the
  field can store is (cluster_size * 2) bytes. So allocate that amount
  of space for s->cluster_data, read the data as it is on disk and let
  the decompression code return an error if the data is indeed
  corrupted or it doesn't fit in the output buffer.

Berto
