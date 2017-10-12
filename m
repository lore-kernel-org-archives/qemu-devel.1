Received: from eggs.gnu.org ([2001:4830:134:3::10]:38856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2d2O-0005MF-HQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2d2J-0005zR-Mv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e2d2J-0005z9-GX
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:56:27 -0400
Date: Thu, 12 Oct 2017 13:56:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171012125620.GG5957@stefanha-x1.localdomain>
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-16-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929033844.26935-16-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 15/22] monitor: send event when request
 queue full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 29, 2017 at 11:38:37AM +0800, Peter Xu wrote:
> Set maximum QMP request queue length to 8.  If queue full, instead of
> queue the command, we directly return a "request-dropped" event, telling
> client that specific command is dropped.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index 1e9a6cb6a5..d9bed31248 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3971,6 +3971,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      }
>  }
>  
> +#define  QMP_ASYNC_QUEUE_LEN_MAX  (8)

Why 8?

My understanding is that this patch series is not about asynchronous QMP
commands.  Instead it's about executing certain commands immediately in
the parser thread.

Therefore, I suggest hardcoding length 1 for now and not calling it
"async".  You may also be able to simplify the code since a queue isn't
actually needed.
