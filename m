Received: from eggs.gnu.org ([2001:4830:134:3::10]:56835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dCmHX-0007Cf-QZ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dCmHW-0008Rp-UY
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:17:51 -0400
Date: Mon, 22 May 2017 14:17:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170522121735.GA6350@noname.redhat.com>
References: <20170519103247.4405-1-stefanha@redhat.com>
	<20170519103247.4405-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170519103247.4405-5-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] migration: use
 bdrv_drain_all_begin/end() instead bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

Am 19.05.2017 um 12:32 hat Stefan Hajnoczi geschrieben:
> blk/bdrv_drain_all() only takes effect for a single instant and then
> resumes block jobs, guest devices, and other external clients like the
> NBD server.  This can be handy when performing a synchronous drain
> before terminating the program, for example.
> 
> Monitor commands usually need to quiesce I/O across an entire code
> region so blk/bdrv_drain_all() is not suitable.  They must use
> bdrv_drain_all_begin/end() to mark the region.  This prevents new I/O
> requests from slipping in or worse - block jobs completing and modifying
> the graph.
> 
> I audited other blk/bdrv_drain_all() callers but did not find anything
> that needs a similar fix.  This patch fixes the savevm/loadvm commands.
> Although I haven't encountered a read world issue this makes the code
> safer.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> @@ -2279,7 +2284,7 @@ int load_vmstate(const char *name, Error **errp)
>      }
>  
>      /* Flush all IO requests so they don't interfere with the new state.  */
> -    bdrv_drain_all();
> +    bdrv_drain_all_begin();
>  
>      ret = bdrv_all_goto_snapshot(name, &bs);
>      if (ret < 0) {
> @@ -2303,6 +2308,8 @@ int load_vmstate(const char *name, Error **errp)
>      qemu_fclose(f);
>      aio_context_release(aio_context);
>  
> +    bdrv_drain_all_end();
> +
>      migration_incoming_state_destroy();
>      if (ret < 0) {
>          error_setg(errp, "Error %d while loading VM state", ret);

There are a few error returns between these two places where a
bdrv_drain_all_end() is missing.

Kevin
