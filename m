Received: from eggs.gnu.org ([2001:4830:134:3::10]:35556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnNkv-0004tx-Tf
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnNks-0007Jf-Rl
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:40:01 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180808071051.30628-3-lbloch@janustech.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-3-lbloch@janustech.com>
Date: Wed, 08 Aug 2018 14:39:55 +0200
Message-ID: <w51d0utt4kk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qcow2: Make the default L2 cache
 sufficient to cover the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 08 Aug 2018 09:10:48 AM CEST, Leonid Bloch wrote:
> Sufficient L2 cache can noticeably improve the performance when using
> large images with frequent I/O. The memory overhead is not significant
> in most cases, as the cache size is only 1 MB for each 8 GB of virtual
> image size (with the default cluster size of 64 KB). For cases with very
> large images and/or small cluster sizes, there is an upper limit on the
> default L2 cache: 32 MB.

I find this description a bit confusing.

First of all, because it's not true that the default will cover the
whole image: we're just increasing it, but any image > 256GB is going to
need more than 32MB (with 64KB clusters, that is).

Second, because it's not clear what happens if you increase that
maximum. Do you have to calculate the new value? Can you make it larger
than what you actually need?

The way I see it: there are two simple changes from the user's point of
view (they can even be two separate patches).

1) The default l2-cache-size is now 32MB. DEFAULT_L2_CACHE_CLUSTERS is
   useless now and disappears.

2) QEMU will only use as much memory from l2-cache-size as it can use to
   cover the whole image. Increasing the value of l2-cache-size will not
   use any additional memory, so it's safe to do.

Berto
