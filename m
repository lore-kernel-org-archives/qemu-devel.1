Received: from eggs.gnu.org ([2001:4830:134:3::10]:44630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eigZi-0008OQ-2b
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eigZe-0005Ap-Rl
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:12:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eigZe-0005Ac-Ix
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:12:42 -0500
Date: Mon, 5 Feb 2018 13:12:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180205131231.GB2316@work-vm>
References: <20170922122505.9413-1-quintela@redhat.com>
	<20170922122505.9413-16-quintela@redhat.com>
	<20180205104944.26fac450@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205104944.26fac450@bahia.lan>
Subject: Re: [Qemu-devel] [PULL 15/18] migration: split common postcopy out
 of ram postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, peterx@redhat.com

* Greg Kurz (groug@kaod.org) wrote:
> On Fri, 22 Sep 2017 14:25:02 +0200
> Juan Quintela <quintela@redhat.com> wrote:
> 
> > From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > 

<snip>

> >  /* Sent prior to starting the destination running in postcopy, discard pages
> > @@ -1354,6 +1376,10 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
> >          return -1;
> >      }
> >  
> > +    if (!migrate_postcopy_ram()) {
> > +        return 0;
> > +    }
> > +
> 
> If postcopy-ram was set on the source but not on the destination, the source
> sends an advise with ram_pagesize_summary() and qemu_target_page_size() but
> this return path on the destination doesn't dispose of the two values. This
> results in a corrupted stream and confuses qemu_loadvm_state():
> 
> qemu-system-ppc64: Expected vmdescription section, but got 0
> 
> Migration doesn't happen, and worse, the destination may starts execution,
> ie, we have two running instances...

Thanks for debugging this; I'd noticed it but not got around to digging
down.

> It looks wrong that the parsing of the advise depends on a migration
> capability being set by the user. The destination should process the
> postcopy-ram advise sent by the source in any case.
> 
> Now that you're about to introduce a new postcopy variant, I guess it
> is time to improve the advise format to reflect this, as you already
> suggest in a comment above. The format could be something like:
> - uin8_t: number of enabled postcopy variants
> - for each variant:
>   uint8_t: type of the postcopy variant
>   per variant arguments
> 
> The destination could then process the advise according to what the source
> actually sent.
> 
> In the meantime, I'd suggest to partly revert 58110f0acb1a. At least, the part
> that changes the advise format, since it isn't strictly needed right now.

I guess it's difficult to change now; but it needs to be robust.
As I said in my review of the patch (about a year ago!):

   Libvirt does set it on the destination, and it's already useful for checking
   the destination host has the appropriate kernel userfault support;
   so I'm fine with requiring it.
   However it's good where possible to fail nicely if someone doesn't set it.

So we've missed that last bit;  lets make the advise code check the
length match what it's expecting.

Dave

> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -98,23 +98,6 @@ static struct mig_cmd_args {
>      [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
>  };
>  
> -/* Note for MIG_CMD_POSTCOPY_ADVISE:
> - * The format of arguments is depending on postcopy mode:
> - * - postcopy RAM only
> - *   uint64_t host page size
> - *   uint64_t taget page size
> - *
> - * - postcopy RAM and postcopy dirty bitmaps
> - *   format is the same as for postcopy RAM only
> - *
> - * - postcopy dirty bitmaps only
> - *   Nothing. Command length field is 0.
> - *
> - * Be careful: adding a new postcopy entity with some other parameters should
> - * not break format self-description ability. Good way is to introduce some
> - * generic extendable format with an exception for two old entities.
> - */
> -
>  static int announce_self_create(uint8_t *buf,
>                                  uint8_t *mac_addr)
>  {
> @@ -888,8 +871,6 @@ void qemu_savevm_send_postcopy_advise(QEMUFile *f)
>          trace_qemu_savevm_send_postcopy_advise();
>          qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE,
>                                   16, (uint8_t *)tmp);
> -    } else {
> -        qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE, 0, NULL);
>      }
>  }
>  
> @@ -1387,10 +1368,6 @@ static int loadvm_postcopy_handle_advise(MigrationIncomin
>          return -1;
>      }
>  
> -    if (!migrate_postcopy_ram()) {
> -        return 0;
> -    }
> -
>      if (!postcopy_ram_supported_by_host(mis)) {
>          postcopy_state_set(POSTCOPY_INCOMING_NONE);
>          return -1;
> 
> 
> 
> Cheers,
> 
> --
> Greg
> 
> >      if (!postcopy_ram_supported_by_host()) {
> >          postcopy_state_set(POSTCOPY_INCOMING_NONE);
> >          return -1;
> > @@ -1564,7 +1590,9 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
> >           * A rare case, we entered listen without having to do any discards,
> >           * so do the setup that's normally done at the time of the 1st discard.
> >           */
> > -        postcopy_ram_prepare_discard(mis);
> > +        if (migrate_postcopy_ram()) {
> > +            postcopy_ram_prepare_discard(mis);
> > +        }
> >      }
> >  
> >      /*
> > @@ -1572,8 +1600,10 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
> >       * However, at this point the CPU shouldn't be running, and the IO
> >       * shouldn't be doing anything yet so don't actually expect requests
> >       */
> > -    if (postcopy_ram_enable_notify(mis)) {
> > -        return -1;
> > +    if (migrate_postcopy_ram()) {
> > +        if (postcopy_ram_enable_notify(mis)) {
> > +            return -1;
> > +        }
> >      }
> >  
> >      if (mis->have_listen_thread) {
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
