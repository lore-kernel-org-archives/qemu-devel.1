Received: from eggs.gnu.org ([2001:4830:134:3::10]:38057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dECwY-0000H2-Bm
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dECwV-00048D-6r
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:58:06 -0400
Received: from mail-eopbgr00127.outbound.protection.outlook.com
	([40.107.0.127]:65146
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dECwU-00045o-LH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:58:03 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
	<20170526081147.GC7211@noname.str.redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <ca0a0ede-013d-7281-40e0-5592d0d56ae6@virtuozzo.com>
Date: Fri, 26 May 2017 13:57:54 +0300
MIME-Version: 1.0
In-Reply-To: <20170526081147.GC7211@noname.str.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, "Denis V. Lunev" <den@openvz.org>

On 05/26/2017 11:11 AM, Kevin Wolf wrote:
>
> No. This is what you bypass:
some analysis for the record.

> * All sanity checks that the block layer does
>
> * bdrv_inc/dec_in_flight(), which is required for drain to work
>   correctly. Not doing this will cause crashes.
Should not be  a problem. We are in the request, which
is accounted for the parent. Drain waits parent first and after that
switched to child.

> * tracked_request_begin/end(), mark_request_serialising() and
>   wait_serialising_requests(), which are required for serialising
>   requests to work correctly
should not cause a problem as we are protected by meta
and this area is not exposed to read operation until
fully complete. But yes, not that good.
 
> * Ensuring correct request alignment for file. This means that e.g.
>   qcow2 with cluster size 512 on a host with a 4k native disk will
>   break.
we have already checked that clusters are aligned.

> * blkdebug events
yes
> * before_write_notifiers. Not calling these will cause corrupted backups
>   if someone backups file.
no as there is no user visible data here, we are
writing zeroes where there are zeroes from guest
point of view

> * Dirty bitmap updates
same. The data from the guest point of view is not changed.
This is even good that we do not mark this areas as dirty.

> * Updating write_gen, wr_highest_offset and total_sectors
write_gen is not a problem. It will be set on actual write.
total_sectors is changed manually. Agree that this is not
really elegant.

> * Ensuring that bl.max_pwrite_zeroes and bl.pwrite_zeroes_alignment are
>   respected
yes
> And these are just the obvious things. I'm sure I missed some.
anyway, this is a good list of things to take into account
within bdrv_allocate. But it is important, that from the
guest point of view the content of COW areas is not
changed and thus we can have some important shortcuts.

Den
