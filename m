Received: from eggs.gnu.org ([2001:4830:134:3::10]:37221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoWET-00051y-RH
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 10:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoWEP-0003Gf-PT
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 10:22:57 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <37fa8b17-116b-ea53-6f65-68412fdb813c@redhat.com>
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
	<w51tvuak6b0.fsf@maestria.local.igalia.com>
	<37fa8b17-116b-ea53-6f65-68412fdb813c@redhat.com>
Date: Wed, 21 Feb 2018 16:22:49 +0100
Message-ID: <w51lgfmjrjq.fsf@maestria.local.igalia.com>
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

On Wed 21 Feb 2018 04:00:54 PM CET, Eric Blake wrote:

>> - Solution b: the width of the 'compressed cluster size' field is
>>    (cluster_bits - 8), that's (cluster_size / 256) sectors.
>
> Not true.  It is (cluster_bits - 9) or (cluster_size / 512).

It's not, it's (cluster_bits - 8), the documentation is wrong, see the
patch that I sent earlier.

Here's qcow2_do_open():

    s->csize_mask = (1 << (s->cluster_bits - 8)) - 1;

For a 64k cluster (16 bits) the width is 16 - 8 = 8 bits.

That's 2^8 = 256 sectors, and 256 * 512 = 128k, exactly two clusters.

Coming back to your patch, since we know where the compressed data
starts and we know that it's not going to be larger than cluster_size,
we can read [coffset, coffset + cluster_size) and skip the final bytes
of the last sector because we know that we don't need that data.

Or we can read as much as the size field indicates (up to twice the
cluster size) and let the decompression code handle the rest.

Berto
