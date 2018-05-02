Received: from eggs.gnu.org ([2001:4830:134:3::10]:49371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDu4z-00035v-FV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDu4w-0004T4-2k
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDu4v-0004Sg-RV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:54:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3BCE81A88A2
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 15:53:56 +0000 (UTC)
Date: Wed, 2 May 2018 16:53:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180502155346.GG2679@work-vm>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425112723.1111-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 01/21] migration: Set error state in
 case of error
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 0e90efa092..2ae560ea80 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -415,10 +415,20 @@ struct {
>      int count;
>  } *multifd_send_state;
>  
> -static void terminate_multifd_send_threads(Error *errp)
> +static void terminate_multifd_send_threads(Error *err)
>  {
>      int i;
>  
> +    if (err) {
> +        MigrationState *s = migrate_get_current();
> +        migrate_set_error(s, err);
> +        if (s->state == MIGRATION_STATUS_SETUP ||
> +            s->state == MIGRATION_STATUS_ACTIVE) {

Can you explain/add comment why these only set it in some states?
For example what about PRE_SWITCHOVER, DEVICE or postcopy?

Dave

> +            migrate_set_state(&s->state, s->state,
> +                              MIGRATION_STATUS_FAILED);
> +        }
> +    }
> +
>      for (i = 0; i < multifd_send_state->count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> @@ -515,10 +525,20 @@ struct {
>      int count;
>  } *multifd_recv_state;
>  
> -static void terminate_multifd_recv_threads(Error *errp)
> +static void terminate_multifd_recv_threads(Error *err)
>  {
>      int i;
>  
> +    if (err) {
> +        MigrationState *s = migrate_get_current();
> +        migrate_set_error(s, err);
> +        if (s->state == MIGRATION_STATUS_SETUP ||
> +            s->state == MIGRATION_STATUS_ACTIVE) {
> +            migrate_set_state(&s->state, s->state,
> +                              MIGRATION_STATUS_FAILED);
> +        }
> +    }
> +
>      for (i = 0; i < multifd_recv_state->count; i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
