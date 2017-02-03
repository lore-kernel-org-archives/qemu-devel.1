Received: from eggs.gnu.org ([2001:4830:134:3::10]:41261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZcA9-0004ls-5f
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZcA5-0004Qs-6g
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:36:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZcA4-0004Px-Ty
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:36:17 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB3CAC04B92B
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 11:36:16 +0000 (UTC)
Date: Fri, 3 Feb 2017 11:36:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170203113611.GG3208@work-vm>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-16-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485207141-1941-16-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/17] migration: Test new fd infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We just send the address through the alternate channels and test that it
> is ok.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 4e530ea..95af694 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -432,8 +432,22 @@ static void *multifd_send_thread(void *opaque)
>      qemu_mutex_lock(&params->mutex);
>      while (!params->quit){
>          if (params->pages.num) {
> +            int i;
> +            int num;
> +
> +            num = params->pages.num;
>              params->pages.num = 0;
>              qemu_mutex_unlock(&params->mutex);
> +
> +            for(i=0; i < num; i++) {
> +                if (qio_channel_write(params->c,
> +                                      (const char *)&params->pages.address[i],
> +                                      sizeof(uint8_t *), &error_abort)
> +                    != sizeof(uint8_t*)) {
> +                    /* Shuoudn't ever happen */
> +                    exit(-1);
> +                }

Nope, need to find a way to cleanly find the migration; that
might actually be tricky from one of these threads?

> +            }
>              qemu_mutex_lock(&multifd_send_mutex);
>              params->done = true;
>              qemu_cond_signal(&multifd_send_cond);
> @@ -594,6 +608,7 @@ QemuCond  multifd_recv_cond;
>  static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *params = opaque;
> +    uint8_t *recv_address;
>      char start;
> 
>      qio_channel_read(params->c, &start, 1, &error_abort);
> @@ -605,8 +620,29 @@ static void *multifd_recv_thread(void *opaque)
>      qemu_mutex_lock(&params->mutex);
>      while (!params->quit){
>          if (params->pages.num) {
> +            int i;
> +            int num;
> +
> +            num = params->pages.num;
>              params->pages.num = 0;
>              qemu_mutex_unlock(&params->mutex);
> +
> +            for(i = 0; i < num; i++) {
> +                if (qio_channel_read(params->c,
> +                                     (char *)&recv_address,
> +                                     sizeof(uint8_t*), &error_abort)
> +                    != sizeof(uint8_t *)) {
> +                    /* shouldn't ever happen */
> +                    exit(-1);
> +                }
> +                if (recv_address != params->pages.address[i]) {
> +                    printf("We received %p what we were expecting %p (%d)\n",
> +                           recv_address,
> +                           params->pages.address[i], i);
> +                    exit(-1);
> +                }
> +            }
> +
>              qemu_mutex_lock(&multifd_recv_mutex);
>              params->done = true;
>              qemu_cond_signal(&multifd_recv_cond);
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
