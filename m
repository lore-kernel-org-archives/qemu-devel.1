Received: from eggs.gnu.org ([2001:4830:134:3::10]:40859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT7Su-0005tM-C9
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT7Sr-0002tw-4i
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:36:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT7Sq-0002tm-V5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:36:49 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 119BDC03BD55
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 13:36:49 +0000 (UTC)
Date: Mon, 16 Jan 2017 21:36:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116133643.GH14226@lemon.Home>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-12-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/16] block: explicitly acquire aiocontext
 in callbacks that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Fri, 01/13 14:17, Paolo Bonzini wrote:
> diff --git a/nbd/server.c b/nbd/server.c
> index efe5cb8..08fb720 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1366,6 +1366,10 @@ static void nbd_restart_write(void *opaque)
>  static void nbd_set_handlers(NBDClient *client)
>  {
>      if (client->exp && client->exp->ctx) {
> +        /* Note that the handlers do not expect any concurrency; qemu-nbd
> +         * does not instantiate multiple AioContexts yet, nor does it call
> +         * aio_poll/aio_dispatch from multiple threads.
> +         */
>          aio_set_fd_handler(client->exp->ctx, client->sioc->fd, true,
>                             client->can_read ? nbd_read : NULL,
>                             client->send_coroutine ? nbd_restart_write : NULL,

What about the built-in server (QMP nbd_server_start)?

> -- 
> 2.9.3
> 
> 
