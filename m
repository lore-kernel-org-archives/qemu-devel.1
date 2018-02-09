Received: from eggs.gnu.org ([2001:4830:134:3::10]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekAgy-0001vT-8l
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekAgt-0006FV-Kd
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:34:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ekAgt-0006FF-G4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:34:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5480D6F4E3
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 15:34:14 +0000 (UTC)
References: <20180208171807.24267-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0508914a-760f-8a85-6d50-5658fc40d05a@redhat.com>
Date: Fri, 9 Feb 2018 09:34:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180208171807.24267-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] block: fix blk_aio_*() segfault when
 blk->root == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 02/08/2018 11:18 AM, Stefan Hajnoczi wrote:
> Using bdrv_inc_in_flight(blk_bs(blk)) doesn't work since BlockBackend->root may
> be NULL.
> 
> This patch series solves the issue by adding an BlockBackend->in_flight counter
> so requests can be tracked even when there is no BlockDriverState.
> 
> This should fix the IDE and virtio-blk segfaults that have been encountered
> when there is no BlockDriverState.
> 
> The patch is based on work by Kevin Wolf.
> 
> Kevin Wolf (1):
>    block: test blk_aio_flush() with blk->root == NULL
> 
> Stefan Hajnoczi (2):
>    block: add BlockBackend->in_flight counter
>    Revert "IDE: Do not flush empty CDROM drives"

Tested by applying the series out of order (2, 3, 1) - the new test 
fails after 2 (so even our workaround was not robust), fails after 3 
(expected there, because we revert the workaround), then finally passes 
after 1 (the correct fix with no workaround needed).  So for the series, 
you can add:
Tested-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
