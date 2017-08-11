Received: from eggs.gnu.org ([2001:4830:134:3::10]:55534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBvL-0001Qn-T9
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBvJ-0002OB-RX
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:32:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dgBvJ-0002Ns-I4
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88A072BF06
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 15:32:28 +0000 (UTC)
Date: Fri, 11 Aug 2017 16:32:20 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811153220.GV2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-17-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 16/19] migration: Test new fd
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Tue, Aug 08, 2017 at 06:26:26PM +0200, Juan Quintela wrote:
> We just send the address through the alternate channels and test that it
> is ok.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index eb0015e..42ad126 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -479,8 +479,26 @@ static void *multifd_send_thread(void *opaque)
>              break;
>          }
>          if (p->pages.num) {
> +            int i;
> +            int num;
> +
> +            num = p->pages.num;
>              p->pages.num = 0;
>              qemu_mutex_unlock(&p->mutex);
> +
> +            for (i = 0; i < num; i++) {
> +                if (qio_channel_write(p->c,
> +                                      (const char *)&p->pages.iov[i].iov_base,
> +                                      sizeof(uint8_t *), &error_abort)
> +                    != sizeof(uint8_t *)) {

Must not use error_abort - this kils the entire VM if we hit an I/O error.

Treating short-writes a fatal is also really not desirable.

> +                    MigrationState *s = migrate_get_current();
> +
> +                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                                      MIGRATION_STATUS_FAILED);
> +                    terminate_multifd_send_threads();
> +                    return NULL;
> +                }
> +            }
>              qemu_mutex_lock(&multifd_send_state->mutex);
>              p->done = true;
>              qemu_mutex_unlock(&multifd_send_state->mutex);
> @@ -640,6 +658,7 @@ void multifd_load_cleanup(void)
>  static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *p = opaque;
> +    uint8_t *recv_address;
>  
>      qemu_sem_post(&p->ready);
>      while (true) {
> @@ -649,7 +668,38 @@ static void *multifd_recv_thread(void *opaque)
>              break;
>          }
>          if (p->pages.num) {
> +            int i;
> +            int num;
> +
> +            num = p->pages.num;
>              p->pages.num = 0;
> +
> +            for (i = 0; i < num; i++) {
> +                if (qio_channel_read(p->c,
> +                                     (char *)&recv_address,
> +                                     sizeof(uint8_t *), &error_abort)
> +                    != sizeof(uint8_t *)) {

Again, don't use error_abort, and you should handle short reads.

> +                    MigrationState *s = migrate_get_current();
> +
> +                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                                      MIGRATION_STATUS_FAILED);
> +                    terminate_multifd_recv_threads();
> +                    return NULL;
> +                }
> +                if (recv_address != p->pages.iov[i].iov_base) {
> +                    MigrationState *s = migrate_get_current();
> +
> +                    printf("We received %p what we were expecting %p (%d)\n",
> +                           recv_address,
> +                           p->pages.iov[i].iov_base, i);

Should use a trace event probe for this.

> +
> +                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                                      MIGRATION_STATUS_FAILED);
> +                    terminate_multifd_recv_threads();
> +                    return NULL;
> +                }
> +            }
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
