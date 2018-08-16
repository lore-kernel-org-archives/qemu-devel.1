Received: from eggs.gnu.org ([2001:4830:134:3::10]:39418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq7ls-0005Wv-MA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq7lq-0006MY-Rh
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:12:20 -0400
From: Eric Blake <eblake@redhat.com>
References: <20180815025614.53588-1-eblake@redhat.com>
Message-ID: <0d25d0fd-ef6d-f1d8-d72f-bd3972375e39@redhat.com>
Date: Wed, 15 Aug 2018 21:12:13 -0500
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

On the bright side, 'qemu-img dd' appears to properly flush images when 
closing them, even though it does not have a conv= parameter.

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

And this needs to be skip=$((offset/cluster)) seek=$((offset/cluster)), 
unless iflag=skip_bytes oflag=seek_bytes is also in use.

What's more, it's essential to use conv=fdatasync when scripting this, 
otherwise, the dd process can end while the data is still in kernel 
buffers, and if 'qemu-nbd -d /dev/nbd1' follows too closely, those 
buffers are lost instead of flushed.

I lost the better part of a day figuring out why things worked when I 
did it by hand but not when I scripted it, until finally figuring out 
that the final flush (or a long sleep before disconnect) is mandatory to 
avoid data loss.  And it did not help that 'qemu-nbd -c' forks parallel 
processes in order to both serve an image over NBD and to connect the 
kernel as client to that private socket, but in such as way that 
--trace=nbd_\* no longer works due to the fd dance performed in setting 
things up, so it's much harder to see what requests the kernel is 
making. Also useful for anyone else trying to debug setups like this: 
'strace -D -o file -f qemu-nbd ...' is essential (without -D, the 
parallel processes don't get set up correctly; and -f is needed to trace 
through the forks).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
