Received: from eggs.gnu.org ([2001:4830:134:3::10]:37607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOjEo-0000Rw-UZ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOjEo-0000DS-00
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:32:58 -0400
References: <20180601091835.21620-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d3be270-d50a-fb9d-a194-be1b7f48f3d4@redhat.com>
Date: Fri, 1 Jun 2018 07:32:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180601091835.21620-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: Consolidate the locking error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 06/01/2018 04:18 AM, Fam Zheng wrote:
> When hot-plugging a block device fails due to image locking errors,
> users won't see the helpful 'Is another process using the image?'
> message in QMP because currently the error hint is not carried over
> there.
> 
> Even though extending QMP to include hint is a conceivably easy task,
> Libvirt will need some change to consume that data.
> 
> Before that is fully sorted out, let's just do the easy fix by joining
> the two lines.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   block/file-posix.c         | 10 ++--
>   tests/qemu-iotests/153.out | 99 +++++++++++++-------------------------
>   tests/qemu-iotests/182.out |  3 +-
>   3 files changed, 38 insertions(+), 74 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 5a602cfe37..03776e13b1 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -699,11 +699,10 @@ static int raw_check_lock_bytes(BDRVRawState *s,
>               if (ret) {
>                   char *perm_name = bdrv_perm_names(p);
>                   error_setg(errp,
> -                           "Failed to get \"%s\" lock",
> +                           "Failed to get \"%s\" lock. "
> +                           "Is another process using the image?",

Except that this goes against the error message recommendations that 
Markus has tried to remind people of (in general, using a full-stop in 
error_setg() is frowned on).  Markus, do you have any suggestions?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
