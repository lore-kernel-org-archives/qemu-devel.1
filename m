Received: from eggs.gnu.org ([2001:4830:134:3::10]:45941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frOn6-00061O-Nq
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 10:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frOn5-0005wH-TD
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 10:34:52 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <403a606c-3fc8-7fa6-bad0-fd4c52a24db2@redhat.com>
Date: Wed, 15 Aug 2018 21:04:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180815025614.53588-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Improve qemu-img dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, mreitz@redhat.com

On 08/14/2018 09:56 PM, Eric Blake wrote:
> I was trying to test NBD fleecing by copying subsets of one
> file to another, and had the idea to use:
> 
> $ export NBD drive to be fleeced on port 10809
> $ qemu-img create -f qcow2 copy $size
> $ qemu-nbd -f qcow2 -p 10810 copy
> $ qemu-img dd -f raw -O raw if=nbd://localhost:10809 of=nbd://localhost:10810 \
>      skip=$offset seek=$offset count=$((len/cluster)) bs=$cluster
> 
> except that seek= wasn't implemented. And in implementing that,
> I learned that skip= is broken when combined with count=.
> 
> [In the meantime, I had to use:
> 
> $ export NBD drive to be fleeced on port 10809
> $ modprobe nbd
> $ qemu-nbd -c /dev/nbd0 -f raw nbd://localhost:10809
> $ qemu-nbd -c /dev/nbd1 -f qcow2 copy
> $ dd if=/dev/nbd0 of/dev/nbd1 \

Oops, left out one = on that line.

>      skip=$offset seek=$offset count=$((len/cluster)) bs=$cluster

And this needs to be Rather, skip=$((offset/cluster)) 
seek=$((offset/cluster)), unless iflag=skip_bytes oflag=seek_bytes is 
also in use.

What's more, it's essential to use conf=fdatasync when scripting this, 
otherwise, the dd process can end while the data is still in buffers, 
and if 'qemu-nbd -d /dev/nbd1' follows too closely, those buffers are 
lost instead of flushed.  (I lost the better part of a day figuring out 
why things worked when I did it by hand but not when I scripted it, 
until finally figuring out that the final flush is mandatory to avoid 
data loss).

> 
> to get the behavior I needed (basically, create an empty qcow2
> destination file, then plug in the guest-visible data based on
> the subsets of the disk of my choosing, by reading the block
> status/dirty bitmap over NBD).  But bouncing through three
> NBD client/server pairs just so I can use plain 'dd' instead
> of just two pairs with 'qemu-img dd' feels dirty.
> ]
> 
> Eric Blake (2):
>    qemu-img: Fix dd with skip= and count=
>    qemu-img: Add dd seek= option
> 
>   qemu-img.c                 |  76 ++++++----
>   tests/qemu-iotests/160     |  15 +-
>   tests/qemu-iotests/160.out | 344 ++++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 397 insertions(+), 38 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
