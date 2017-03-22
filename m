Received: from eggs.gnu.org ([2001:4830:134:3::10]:53597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqgms-0002YN-J7
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqgmr-0001co-Je
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:58:54 -0400
Date: Wed, 22 Mar 2017 09:58:46 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170322135846.GB15423@localhost.localdomain>
References: <1490034784-28177-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490034784-28177-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9?] block/file-posix.c:
 Fix unused variable warning on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, patches@linaro.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, Mar 20, 2017 at 06:33:04PM +0000, Peter Maydell wrote:
> On OpenBSD none of the ioctls probe_logical_blocksize() tries
> exist, so the variable sector_size is unused. Refactor the
> code to avoid this (and reduce the duplicated code).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The alternative would be to move the variable so it was
> local to a code block inside each #ifdef, but this seemed
> a bit nicer anyway.
> 
> Tentatively tagged 'for-2.9' just because this is the only
> warning in the OpenBSD build, but I don't insist on it.
> 
> I've opted to retain the existing behaviour of "try every
> ioctl available and use the last one that works" rather
> than "stop as soon as something worked".
> 
> ---
>  block/file-posix.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 53febd3..b980d23 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -219,28 +219,28 @@ static int probe_logical_blocksize(int fd, unsigned int *sector_size_p)
>  {
>      unsigned int sector_size;
>      bool success = false;
> +    int i;
>  
>      errno = ENOTSUP;
> -
> -    /* Try a few ioctls to get the right size */
> +    unsigned long ioctl_list[] = {
>  #ifdef BLKSSZGET
> -    if (ioctl(fd, BLKSSZGET, &sector_size) >= 0) {
> -        *sector_size_p = sector_size;
> -        success = true;
> -    }
> +        BLKSSZGET,
>  #endif
>  #ifdef DKIOCGETBLOCKSIZE
> -    if (ioctl(fd, DKIOCGETBLOCKSIZE, &sector_size) >= 0) {
> -        *sector_size_p = sector_size;
> -        success = true;
> -    }
> +        DKIOCGETBLOCKSIZE,
>  #endif
>  #ifdef DIOCGSECTORSIZE
> -    if (ioctl(fd, DIOCGSECTORSIZE, &sector_size) >= 0) {
> -        *sector_size_p = sector_size;
> -        success = true;
> -    }
> +        DIOCGSECTORSIZE,
>  #endif
> +    };
> +
> +    /* Try a few ioctls to get the right size */
> +    for (i = 0; i < ARRAY_SIZE(ioctl_list); i++) {
> +        if (ioctl(fd, ioctl_list[i], &sector_size) >= 0) {
> +            *sector_size_p = sector_size;
> +            success = true;
> +        }
> +    }
>  
>      return success ? 0 : -errno;
>  }
> -- 
> 2.7.4
> 
>

Reviewed-by: Jeff Cody <jcody@redhat.com>
