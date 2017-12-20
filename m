Received: from eggs.gnu.org ([2001:4830:134:3::10]:53159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eRitz-0005mv-Ip
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eRitw-0000Wz-Dk
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:15:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eRitw-0000WY-0R
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:15:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E0047E426
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:15:31 +0000 (UTC)
Date: Wed, 20 Dec 2017 18:15:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171220181524.GF2349@work-vm>
References: <20171215171655.7818-1-dgilbert@redhat.com>
	<20171219051642.GZ22308@xz-mi> <20171219101407.GB2730@work-vm>
	<20171219112131.GB22308@xz-mi> <20171219113321.GD2730@work-vm>
	<20171220031057.GC22308@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220031057.GC22308@xz-mi>
Subject: Re: [Qemu-devel] [PATCH 0/2] migration/channel errors and cancelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, quintela@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Dec 19, 2017 at 11:33:21AM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Tue, Dec 19, 2017 at 10:14:08AM +0000, Dr. David Alan Gilbert wrote:
> > > > * Peter Xu (peterx@redhat.com) wrote:
> > > > > On Fri, Dec 15, 2017 at 05:16:53PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > > 
> > > > > > Hi,
> > > > > >   Where a channel fails asynchronously during connect, call
> > > > > > back through the migration code so it can clean up.
> > > > > >   In particular this causes the transition of a 'cancelling' state
> > > > > > to 'cancelled' in the case of:
> > > > > > 
> > > > > >     migrate -d tcp:deadhost:port
> > > > > >      <host tries to connect>
> > > > > >     migrate_cancel
> > > > > > 
> > > > > > previously the status would get stuck in cancelling because
> > > > > > the final cleanup didn't happen.
> > > > > > 
> > > > > >   This is the second part of the fix for:
> > > > > > https://bugzilla.redhat.com/show_bug.cgi?id=1525899
> > > > > 
> > > > > IIUC this series tries to deliver the connection error a long way
> > > > > until migrate_fd_connect() to handle it. But, haven't we already have
> > > > > a function migrate_fd_error() to do that (which is faster, and
> > > > > simpler)?
> > > > > 
> > > > > void migrate_fd_error(MigrationState *s, const Error *error)
> > > > > {
> > > > >     trace_migrate_fd_error(error_get_pretty(error));
> > > > >     assert(s->to_dst_file == NULL);
> > > > >     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> > > > >                       MIGRATION_STATUS_FAILED);
> > > > >     migrate_set_error(s, error);
> > > > >     notifier_list_notify(&migration_state_notifiers, s);
> > > > >     block_cleanup_parameters(s);
> > > > > }
> > > > > 
> > > > > I think it's not handling the case when cancelling.  If we let it to
> > > > > handle the cancelling case well, would it be a simpler fix?
> > > > >
> > > > > Moreover, I think this is another good example that migration is not
> > > > > handling the cleanup "cleanly" in general... I really hope we can do
> > > > > this better in 2.12.  I'll see whether I can give it a shot, but in
> > > > > all cases it'll be after the merging of existing patches since there
> > > > > are already quite a lot of dangling patches.
> > > > 
> > > > No, I think migrate_fd_error is the cause of the problem here, not the
> > > > answer.
> > > 
> > > Could I ask why migrate_fd_error() is problematic?  Yeah I agree that
> > > we should have a single point to clean things up, then can we call
> > > migrate_fd_cleanup() somehow inside migrate_fd_error()?
> > > 
> > > The thing I don't really understand is: why we want the error be
> > > delivered via those functions (migration_channel_connect,
> > > migrate_fd_connect, etc.) to finally be cleaned up.
> > 
> > migrate_fd_cleanup has a lot of code for dealing with different cases:
> >    a) Closing the to_dst_file
> >    b) joining the thread if its already running
> >    c) Cleaning up multifd (stub)
> >    d) finishing of cancel
> >    e) notification
> >    f) block cleanup
> > 
> > we seem to have copied some of those into migrate_fd_error - but not all
> > of them.  In this case the one we're missing is (d) got finishing
> > cancel;
> > when you issue a cancel command we move from whatever state we were in
> > to the 'cancelling' state, various things get cleaned up and eventually
> > we move to cancelled; that wasn't happening because we missed the
> > code in migrate_fd_cleanup out.  So we could copy that code (copied code
> > is bad) or we could just make sure migrate_fd_cleanup is called like
> > it normally is.
> 
> I fully agree on above.
> 
> > 
> > The other thinking is that at the moment the migration/socket.c and tls.c
> > etc code has to choose between callbacks into the main migration code,
> > either migration_channel_connet or migrate_fd_error - now it's simpler,
> > once you've asked for an outgoing migration you always get a callback
> > to migration_channel_connect.  Much more predictable.
> 
> This is the point I still don't understand, on why we must go into
> migrate_fd_connect(), even if error happens before that point.

To me it just doesn't feel clean, and is the reason this error happened
in the first place.

Dave

> What I meant is pasted at the end.  Again, I don't know whether it
> works, just want to show what I meant.  I'm fine with current approach
> too.  Thanks,
> 
> ----------------------------------
> 
> diff --git a/migration/migration.c b/migration/migration.c                     
> index 4de3b551fe..fd9b509ab1 100644    
> --- a/migration/migration.c            
> +++ b/migration/migration.c            
> @@ -1074,8 +1074,10 @@ static void migrate_fd_cleanup(void *opaque)            
>  {                                     
>      MigrationState *s = opaque;       
>                                        
> -    qemu_bh_delete(s->cleanup_bh);    
> -    s->cleanup_bh = NULL;             
> +    if (s->cleanup_bh) {              
> +        qemu_bh_delete(s->cleanup_bh);
> +        s->cleanup_bh = NULL;         
> +    }                                 
>                                        
>      if (s->to_dst_file) {             
>          Error *local_err = NULL;      
> @@ -1124,11 +1126,15 @@ void migrate_fd_error(MigrationState *s, const Error *error)                                                                          
>  {                                     
>      trace_migrate_fd_error(error_get_pretty(error));                          
>      assert(s->to_dst_file == NULL);   
> +    /*                                
> +     * If we are still in setup, switch to failure.  It's also                
> +     * possible that the migration has been cancelled, then we do             
> +     * nothing here.                  
> +     */                               
>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,                      
>                        MIGRATION_STATUS_FAILED);                               
>      migrate_set_error(s, error);      
> -    notifier_list_notify(&migration_state_notifiers, s);                      
> -    block_cleanup_parameters(s);      
> +    migrate_fd_cleanup(s);            
>  }                                     
>                                        
>  static void migrate_fd_cancel(MigrationState *s)                              
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
