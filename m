Received: from eggs.gnu.org ([209.51.188.92]:49079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hAxoq-0007eA-94
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hAxop-0002Vm-FU
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:21:48 -0400
Date: Mon, 1 Apr 2019 16:21:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190401142135.GE4935@localhost.localdomain>
References: <20190330150702.11687-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330150702.11687-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Saner printing of large file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 30.03.2019 um 16:07 hat Eric Blake geschrieben:
> Disk sizes close to INT64_MAX cause overflow, for some pretty
> ridiculous output:
> 
>   $ ./nbdkit -U - memory size=$((2**63 - 512)) --run 'qemu-img info $nbd'
>   image: nbd+unix://?socket=/tmp/nbdkitHSAzNz/socket
>   file format: raw
>   virtual size: -8388607T (9223372036854775296 bytes)
>   disk size: unavailable
> 
> But there's no reason to have two separate implementations of integer
> to human-readable abbreviation, where one has overflow and stops at
> 'T', while the other avoids overflow and goes all the way to 'E'. With
> this patch, the output now claims 8EiB instead of -8388607T, which
> really is the correct rounding of largest file size supported by qemu
> (we could go 511 bytes larger if we used byte-accurate sizing instead
> of rounding up to the next sector boundary, but that wouldn't change
> the human-readable result).
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block-next branch for 4.1.

Kevin
