Received: from eggs.gnu.org ([2001:4830:134:3::10]:42747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cydOI-00047z-Oa
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 07:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cydOE-00056k-SL
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 07:58:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
Date: Thu, 13 Apr 2017 13:58:12 +0200
Message-ID: <w51shlcv7sb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 12 Apr 2017 06:54:50 PM CEST, Denis V. Lunev wrote:
> My opinion about this approach is very negative as the problem could
> be (partially) solved in a much better way.

Hmm... it seems to me that (some of) the problems you are describing are
different from the ones this proposal tries to address. Not that I
disagree with them! I think you are giving useful feedback :)

> 1) current L2 cache management seems very wrong to me. Each cache
>     miss means that we have to read entire L2 cache block. This means
>     that in the worst case (when dataset of the test does not fit L2
>     cache size we read 64kb of L2 table for each 4 kb read).
>
>     The situation is MUCH worse once we are starting to increase
>     cluster size. For 1 Mb blocks we have to read 1 Mb on each cache
>     miss.
>
>     The situation can be cured immediately once we will start reading
>     L2 cache with 4 or 8kb chunks. We have patchset for this for our
>     downstream and preparing it for upstream.

Correct, although the impact of this depends on whether you are using
SDD or HDD.

With an SSD what you want is to minimize is the number of unnecessary
reads, so reading small chunks will likely increase the performance when
there's a cache miss.

With an HDD what you want is to minimize the number of seeks. Once you
have moved the disk head to the location where the cluster is, reading
the whole cluster is relatively inexpensive, so (leaving the memory
requirements aside) you generally want to read as much as possible.

> 2) yet another terrible thing in cluster allocation is its allocation
>     strategy.
>     Current QCOW2 codebase implies that we need 5 (five) IOPSes to
>     complete COW operation. We are reading head, writing head, reading
>     tail, writing tail, writing actual data to be written. This could
>     be easily reduced to 3 IOPSes.

That sounds right, but I'm not sure if this is really incompatible with
my proposal :)

>     Another problem is the amount of data written. We are writing
>     entire cluster in write operation and this is also insane. It is
>     possible to perform fallocate() and actual data write on normal
>     modern filesystem.

But that only works when filling the cluster with zeroes, doesn't it? If
there's a backing image you need to bring all the contents from there.

Berto
