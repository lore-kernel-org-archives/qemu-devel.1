Received: from eggs.gnu.org ([2001:4830:134:3::10]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dEDET-0002es-2g
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dEDEP-0003TU-U1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dEDEP-0003TI-OG
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:16:33 -0400
Date: Fri, 26 May 2017 13:16:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170526111630.GG7211@noname.str.redhat.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
	<20170526081147.GC7211@noname.str.redhat.com>
	<2f0f5f9a-23b3-5f67-7675-ecdfe15cc187@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f0f5f9a-23b3-5f67-7675-ecdfe15cc187@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/13] qcow2: alloc space for COW in one
 chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, mreitz@redhat.com, "Denis V. Lunev" <den@openvz.org>

Am 26.05.2017 um 10:57 hat Denis V. Lunev geschrieben:
> On 05/26/2017 11:11 AM, Kevin Wolf wrote:
> > It seems much clearer to me that simply unifying the three write
> > requests into a single one is an improvement. And it's easy to do, I
> > even had a patch once to do this. The reason that I didn't send it was
> > that it seemed to conflict with the data cache approach
> These changes help a lot on 2 patterns:
> - writing 4Kb into the middle of the block. The bigger the block size,
>   more we gain
> - sequential write, which is not sector aligned and comes in 2 requests:
>   we perform allocation, which should be significantly faster than actual
>   write and after that both parts of the write can be executed in parallel.
> At my opinion both cases are frequent and important.

Both cases are helped somewhat by reducing the number of I/O requests.
So as a first step, I really think we need to get Berto's patches ready
to be merged.

As for this series, there is one important restriction that you don't
mention: Both cases only benefit from the changes when there is no
backing file (or the backing file is sparse at the given cluster). The
main reason why people use qcow2 is for snapshots, so qcow2 without or
with an empty backing file is actually not my primary concern.

To be honest, I am concerned a bit by the additional complexity brought
in by this series (which also seemed to be more tacked on rather than
fully integrated at the first sight), but I'll have to study it in more
detail.


Maybe another thing to keep in mind is that the sequential write case
can completely avoid COW in theory. I wonder whether we should make
another attempt at this. Previously, it was the complexity of my own
prototypes that stopped me from actually merging them.

Kevin
