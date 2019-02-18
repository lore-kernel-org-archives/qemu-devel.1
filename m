Received: from eggs.gnu.org ([209.51.188.92]:44007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvppq-0001jW-IX
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvppp-0008MN-V4
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:48:18 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01c9a17c-6930-ca11-7c6e-a29d7f8296f2@redhat.com>
Date: Mon, 18 Feb 2019 14:48:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/12] nbd: Use low-level QIOChannel API in
 nbd_read_eof()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On 2/18/19 10:18 AM, Kevin Wolf wrote:
> Instead of using the convenience wrapper qio_channel_read_all_eof(), use
> the lower level QIOChannel API. This means duplicating some code, but
> we'll need this because this coroutine yield is special: We want it to
> be interruptible so that nbd_client_attach_aio_context() can correctly
> reenter the coroutine.
> 
> This moves the bdrv_dec/inc_in_flight() pair into nbd_read_eof(), so
> that connection_co will always sit in this exact qio_channel_yield()
> call when bdrv_drain() returns.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/nbd.h |  4 ++--
>  block/nbd-client.c  |  8 +-------
>  nbd/client.c        | 46 ++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 40 insertions(+), 18 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
