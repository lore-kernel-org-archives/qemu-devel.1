Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4PmK-00030H-0N
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4PmE-0007eK-Tj
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e4PmE-0007cq-Kg
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B705920277
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 11:11:13 +0000 (UTC)
Date: Tue, 17 Oct 2017 12:11:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171017111106.GB2326@work-vm>
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004104636.7963-9-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 08/12] migration: Test new fd
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We just send the address through the alternate channels and test that it
> is ok.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

I remember questions on this patch from last time as well; this is just
test isn't it, and all this gets changed in later patches.  So I'm
not too sure of the point, especially since you could use
qio_channel_writev_all  here and make the changes smaller.

Dave

> --
> 
> Use qio_channel_*all functions
> ---
>  migration/ram.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 745da2971d..4c16d0775b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -492,8 +492,24 @@ static void *multifd_send_thread(void *opaque)
>              break;
>          }
>          if (p->pages.num) {
> +            Error *local_err = NULL;
> +            size_t ret;
> +            int i;
> +            int num;
> +
> +            num = p->pages.num;
>              p->pages.num = 0;
>              qemu_mutex_unlock(&p->mutex);
> +
> +            for (i = 0; i < num; i++) {
> +                ret = qio_channel_write_all(p->c,
> +                         (const char *)&p->pages.iov[i].iov_base,
> +                         sizeof(uint8_t *), &local_err);
> +                if (ret != 0) {
> +                    terminate_multifd_send_threads(local_err);
> +                    return NULL;
> +                }
> +            }
>              qemu_mutex_lock(&multifd_send_state->mutex);
>              p->done = true;
>              qemu_mutex_unlock(&multifd_send_state->mutex);
> @@ -675,6 +691,7 @@ int multifd_load_cleanup(Error **errp)
>  static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *p = opaque;
> +    uint8_t *recv_address;
>  
>      qemu_sem_post(&p->ready);
>      while (true) {
> @@ -684,7 +701,29 @@ static void *multifd_recv_thread(void *opaque)
>              break;
>          }
>          if (p->pages.num) {
> +            Error *local_err = NULL;
> +            size_t ret;
> +            int i;
> +            int num;
> +
> +            num = p->pages.num;
>              p->pages.num = 0;
> +
> +            for (i = 0; i < num; i++) {
> +                ret = qio_channel_read_all(p->c, (char *)&recv_address,
> +                                           sizeof(uint8_t *), &local_err);
> +                if (ret != 0) {
> +                    terminate_multifd_recv_threads(local_err);
> +                    return NULL;
> +                }
> +                if (recv_address != p->pages.iov[i].iov_base) {
> +                    error_setg(&local_err, "received %p and expecting %p (%d)",
> +                               recv_address, p->pages.iov[i].iov_base, i);
> +                    terminate_multifd_recv_threads(local_err);
> +                    return NULL;
> +                }
> +            }
> +
>              p->done = true;
>              qemu_mutex_unlock(&p->mutex);
>              qemu_sem_post(&p->ready);
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
