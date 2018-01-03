Received: from eggs.gnu.org ([2001:4830:134:3::10]:44507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWghu-0000LD-L4
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWght-0001T8-RT
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:55:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWght-0001Se-KL
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:55:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB4915F7AC
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 10:55:36 +0000 (UTC)
Date: Wed, 3 Jan 2018 18:55:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180103105529.GM2557@xz-mi>
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-10-peterx@redhat.com>
	<87608j2r0u.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87608j2r0u.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH 09/11] migration: cleanup stats update into
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jan 03, 2018 at 11:08:49AM +0100, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > We have quite a few lines in migration_thread() that calculates some
> > statistics for the migration interations.  Isolate it into a single
> > function to improve readability.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> 
> 
> > +static void migration_update_statistics(MigrationState *s,
> 
> 
> migration_update_counters()?

Sure, or...

> 
> statistics for me mean that they are only used for informative
> purposes.  Here we *act* on that values.
> 
> 
> >  
> > -            qemu_file_reset_rate_limit(s->to_dst_file);
> > -            initial_time = current_time;
> > -            initial_bytes = qemu_ftell(s->to_dst_file);
> > -        }
> > +        /* Conditionally update statistics */
> 
> No need for the comment.  If we think it is needed just rename the
> function to:
>    conditionally_update_statistics()?
> 
> I still preffer the:
>    migration_update_counters.

... migration_update_counters_conditionally()?

> 
> 
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 3ab5506233..248f7d9a5c 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -90,6 +90,19 @@ struct MigrationState
> >      QEMUBH *cleanup_bh;
> >      QEMUFile *to_dst_file;
> >  
> > +    /*
> > +     * Migration thread statistic variables, mostly used in
> > +     * migration_thread() iterations only.
> > +     */
> > +    uint64_t initial_bytes;
> 
>        /* bytes already send at the beggining of current interation */
>        uint64_t iteration_initial_bytes;
> 
> > +    int64_t initial_time;
>        /* time at the start of current iteration */
>        int64_t iteration_start_time;
> 
> What do you think?

Will change both.

Thanks,

-- 
Peter Xu
