Received: from eggs.gnu.org ([209.51.188.92]:57841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2Kl7-0003FG-Oo
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2Kl6-0004Em-1n
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:02:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2Kl5-0004Dt-O2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:02:15 -0500
Date: Fri, 8 Mar 2019 19:02:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190308190209.GK2834@work-vm>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-7-chen.zhang@intel.com>
	<20190308174108.GG2834@work-vm>
	<9CFF81C0F6B98A43A459C9EDAD400D7806070A6F@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D7806070A6F@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH V3 6/7] Migration/colo.c: Add the necessary
 checks for colo_do_failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Chen" <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

* Zhang, Chen (chen.zhang@intel.com) wrote:
> 
> 
> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com] 
> Sent: Saturday, March 9, 2019 1:41 AM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Zhang Chen <zhangckid@gmail.com>; Juan Quintela <quintela@redhat.com>; zhanghailiang <zhang.zhanghailiang@huawei.com>; Markus Armbruster <armbru@redhat.com>; Eric Blake <eblake@redhat.com>; qemu-dev <qemu-devel@nongnu.org>
> Subject: Re: [PATCH V3 6/7] Migration/colo.c: Add the necessary checks for colo_do_failover
> 
> * Zhang Chen (chen.zhang@intel.com) wrote:
> > From: Zhang Chen <chen.zhang@intel.com>
> > 
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> 
>>  OK, we should make that properly return an error.
>>  (Actually we should make the failover command be one of the new OOB commands; so that it can work even if the main loop is blocked- that would make COLO robust properly against network failures)
> 
> Good idea~ which OOB command can be the demo in current Qemu?
>  Maybe I can do this job in the future.

The 'migration-pause' command I think is the only real one so far.
Remember the important thing is the code that runs as part of it must
not take any lock that could be blocked by the main loop or any
part of the replication that could block based on the other host
having died.

Dave

> 
> Thanks
> Zhang Chen
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> > ---
> >  migration/colo.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/colo.c b/migration/colo.c index 
> > dbe2b88807..d1ae2e6d11 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -197,10 +197,16 @@ void colo_do_failover(MigrationState *s)
> >          vm_stop_force_state(RUN_STATE_COLO);
> >      }
> >  
> > -    if (get_colo_mode() == COLO_MODE_PRIMARY) {
> > +    switch (get_colo_mode()) {
> > +    case COLO_MODE_PRIMARY:
> >          primary_vm_do_failover();
> > -    } else {
> > +        break;
> > +    case COLO_MODE_SECONDARY:
> >          secondary_vm_do_failover();
> > +        break;
> > +    default:
> > +        error_report("colo_do_failover failed because the colo mode"
> > +                     " could not be obtained");
> >      }
> >  }
> >  
> > --
> > 2.17.GIT
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
