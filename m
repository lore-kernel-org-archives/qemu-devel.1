Received: from eggs.gnu.org ([2001:4830:134:3::10]:37822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk5ps-00036z-SZ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk5pr-0005OW-PN
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:55:32 -0400
Date: Mon, 30 Jul 2018 12:55:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180730105522.GC3775@localhost.localdomain>
References: <20180729212744.23709-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729212744.23709-1-lbloch@janustech.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] qcow2: Make the L2 cache cover the
 whole image by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, berto@igalia.com

Am 29.07.2018 um 23:27 hat Leonid Bloch geschrieben:
> This series makes the qcow2 L2 cache cover the entire image by default.
> The importance of this change is in noticeable performance improvement,
> especially with heavy random I/O. The memory overhead is very small:
> only 1 MB of cache for every 8 GB of image size. On systems with very
> limited RAM the maximal cache size can be limited by the existing
> cache-size and l2-cache-size options.
> 
> The L2 cache is also resized accordingly, by default, if the image is
> resized.

I agree with changing the defaults, I would have proposed a change
myself soon. We have been offering cache size options for a long time,
and management tools are still ignoring them. So we need to do something
in QEMU.

Now, what the exact defaults should be, is something to use a bit more
thought on. You say "the memory overhead is very small", without going
into details. Let's check.

This is the formula from your patch (unit is bytes):

    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);

So we get:

    64k clusters, 8G image:   1M (maximum covered by old default)
    64k clusters, 1T image: 128M
    1M clusters, 1T image:    8M
    512b clusters, 1T image: 16G

1T is by far not the maximum size for a qcow2 image, and 16G memory
usage is definitely not "very small" overhead. Even the 128M for the
default cluster size are already a lot. So the simplistic approch of
this series won't work as a default.

Let's refine it a bit:

* Basing it on max_l2_cache sounds fine generally
* Cap it at 32 MB (?) by default
* Enable cache-clean-interval=30 (?) by default to compensate a bit for
  the higher maximum memory usage

Another thing I just noticed while looking at the code is that
cache-clean-interval only considers blocks that aren't dirty, but
doesn't take measures to get dirty blocks written out, so we depend on
the guest flushing the cache before we can get free the memory. Should
we attempt to write unused dirty entries back? Berto?

> The reasons for making this behavior default, unlike in the patches I
> have sent previously, are the following:
> 1) Unelegant complications with making an option to accept either a
>    size or a string, while outputting a proper error message.
> 2) More bulky logic to sort out what to do if the image is being resized
>    but the (defined) overall cache size is too small to contain the
>    new l2-cache-size.
> (Making this behavior default resolves all of these technical issues
> neatly)

The default must always correspond to some explicit setting. We can only
change defaults relatively freely because we can assume that if a user
cared about the setting, they would have specified it explicitly. If
it's not possible to specify a setting explicitly, we can't make this
assumption any more, so we'd be stuck with the default forever.

Now, considering what I wrote above, an alternate wouldn't be the best
way to represent this any more. We do have a cache size again (the 32 MB
cap) even while trying to cover the whole image.

Maybe the right interface with this in mind would be a boolean option
that specifies whether the given cache sizes are exact values (old
semantics) or maximum values, which are limited to what the actual
images size requires. If you do want the "real" full mode, you'd set
l2-cache-size=INT64_MAX and exact-cache-sizes=false (this could use a
better name). The new default would be l2-cache-size=32M,
exact-cache-sizes=false. The old default is cache-size=1M,
exact-cache-sizes=true.

Kevin

> 3) The performance gain (as measured by fio in random read/write tests)
>    can be as high as 50%, or even more, so this would be a reasonable
>    default behavior.
> 4) The memory overhead is really small for the gain, and in cases when
>    memory economy is critical, the maximal cache values can always be
>    set by the appropriate options.
