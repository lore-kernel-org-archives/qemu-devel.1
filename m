Received: from eggs.gnu.org ([2001:4830:134:3::10]:42867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjoP-0001zc-GD
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjoM-0007PN-C7
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emjoM-0007Or-70
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:28:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58E6983F45
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:28:37 +0000 (UTC)
References: <20180216165015.30715-1-stefanha@redhat.com>
	<20180216165015.30715-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13bfdd5e-9b08-7e67-afdb-9746fea40dfd@redhat.com>
Date: Fri, 16 Feb 2018 11:28:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180216165015.30715-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] block: extract AIO_WAIT_WHILE()
 from BlockDriverState
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

On 02/16/2018 10:50 AM, Stefan Hajnoczi wrote:
> BlockDriverState has the BDRV_POLL_WHILE() macro to wait on event loop
> activity while a condition evaluates to true.  This is used to implement
> synchronous operations where it acts as a condvar between the IOThread
> running the operation and the main loop waiting for the operation.  It
> can also be called from the thread that owns the AioContext and in that
> case it's just a nested event loop.
> 
> BlockBackend needs this behavior but doesn't always have a
> BlockDriverState it can use.  This patch extracts BDRV_POLL_WHILE() into
> the AioWait abstraction, which can be used with AioContext and isn't
> tied to BlockDriverState anymore.
> 
> This feature could be built directly into AioContext but then all users
> would kick the event loop even if they signal different conditions.
> Imagine an AioContext with many BlockDriverStates, each time a request
> completes any waiter would wake up and re-check their condition.  It's
> nicer to keep a separate AioWait object for each condition instead.
> 
> Please see "block/aio-wait.h" for details on the API.
> 
> The name AIO_WAIT_WHILE() avoids the confusion between AIO_POLL_WHILE()
> and AioContext polling.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
