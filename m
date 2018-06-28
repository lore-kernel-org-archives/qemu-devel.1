Received: from eggs.gnu.org ([2001:4830:134:3::10]:36020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYevz-0004p9-9U
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYevy-0003X5-DY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:58:35 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <823163f4-aaec-e550-a7fd-4f2c510c80de@redhat.com>
Date: Thu, 28 Jun 2018 16:58:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180628000745.4477-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 05/31] block: Respect backing bs in
 bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 07:07 PM, Max Reitz wrote:
> Basically, bdrv_refresh_filename() should respect all children of a
> BlockDriverState. However, generally those children are driver-specific,
> so this function cannot handle the general case. On the other hand,
> there are only few drivers which use other children than @file and
> @backing (that being vmdk, quorum, and blkverify).
> 
> Most block drivers only use @file and/or @backing (if they use any
> children at all). Both can be implemented directly in
> bdrv_refresh_filename.
> 
> The user overriding the file's filename is already handled, however, the
> user overriding the backing file is not. If this is done, opening the
> BDS with the plain filename of its file will not be correct, so we may
> not set bs->exact_filename in that case.
> 
> iotest 051 contains test cases for overriding the backing file, and so
> its output changes with this patch applied.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c                       | 30 +++++++++++++++++++++++++++++-
>   tests/qemu-iotests/051.out    |  8 ++++----
>   tests/qemu-iotests/051.pc.out |  8 ++++----
>   3 files changed, 37 insertions(+), 9 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
