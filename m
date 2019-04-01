Received: from eggs.gnu.org ([209.51.188.92]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hAynM-0002uy-Nz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hAynL-0002YS-SA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:24:20 -0400
Date: Mon, 1 Apr 2019 17:24:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190401152411.GF4935@localhost.localdomain>
References: <20190401145741.28322-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401145741.28322-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Alberto Garcia <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 01.04.2019 um 16:57 hat Eric Blake geschrieben:
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
> Quite a few iotests need updates to expected output to match.
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> v2 - actually update iotests to match; no change to block/ code so R-b added

Thanks, updated the patch in block-next.

Kevin
