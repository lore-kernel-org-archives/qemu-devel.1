Received: from eggs.gnu.org ([2001:4830:134:3::10]:60100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoUN1-00014S-OK
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoUMy-0003z0-Jp
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:23:39 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <2d9713f2-87c1-12ba-3f46-a9a476279cda@redhat.com>
References: <20180220170135.5299-1-berto@igalia.com>
	<2d9713f2-87c1-12ba-3f46-a9a476279cda@redhat.com>
Date: Wed, 21 Feb 2018 14:23:32 +0100
Message-ID: <w51r2pejx2j.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Tue 20 Feb 2018 08:40:43 PM CET, Eric Blake wrote:
>>   Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>
> I'm looking at how this works for different cluster sizes.  If we have
> 512-byte clusters, x is 61, and we DON'T have the 'number sectors'
> field at all!

Well, you can definitely have compressed images with 512-byte clusters.

So I think he have just found one more mistake in the documentation :)

         (x = 62 - (cluster_bits - 8)):

    Bit  0 -  x:    Host cluster offset.
       x+1 - 61:    Number of 512-byte sectors

That's not how it works, it's rather [0, x-1], [x, 61]. For 512-byte
clusters x is 61 and we have 1 bit for the number of sectors, allowing
one or two sectors.

If you have a compressed image with 512-byte clusters you can also see
that since the compressed data is not aligned, some compressed clusters
span two different sectors (as expected).

That means that nb_csectors in the L2 entry is two (1+1), which is the
maximum allowed in this case, so that makes sense. And since the size of
our clusters is also 512 bytes, nb_csectors is twice the cluster size,
so we need s->cluster_data to be (cluster_size * 2) bytes (minus one,
strictly speaking).

> If we ever allowed a compressed cluster to spill across two host
> clusters, it would cause mayhem in trying to track refcounts and other
> things.

I haven't checked how this works in practice but it seems to work fine.
Note that those clusters are read-only so that surely makes things
easier.

Berto
