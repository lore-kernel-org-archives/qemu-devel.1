Received: from eggs.gnu.org ([209.51.188.92]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmfFK-0005Nz-7W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmfDT-0004ES-35
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:47 -0500
Date: Thu, 24 Jan 2019 13:38:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190124133837.GD2101@work-vm>
References: <20190124122525.145968-1-vsementsov@virtuozzo.com>
	<20190124122525.145968-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124122525.145968-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: forbid qmp_cont in
 RUN_STATE_FINISH_MIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, lcapitulino@redhat.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> qmp_cont in RUN_STATE_FINISH_MIGRATE may lead to moving vm to
> RUN_STATE_RUNNING, before actual migration finish. So, when migration
> thread will try to go to RUN_STATE_POSTMIGRATE, assuming transition
> RUN_STATE_FINISH_MIGRATE->RUN_STATE_POSTMIGRATE, it will crash, as
> current state is RUN_STATE_RUNNING, and transition
> RUN_STATE_RUNNING->RUN_STATE_POSTMIGRATE is forbidden.
> 
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/qmp.c b/qmp.c
> index 4c819dd8cf..c2ecf1d804 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -156,6 +156,9 @@ void qmp_cont(Error **errp)
>          return;
>      } else if (runstate_check(RUN_STATE_SUSPENDED)) {
>          return;
> +    } else if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +        error_setg(errp, "Migration is not finalized yet");
> +        return;
>      }

Yeh, a bit of a hack, but I think that's as best as we can do for now;
we can't ban all cont's during migration.

Note, it's still racy since you could call this partway through the
completion before it's set to finish.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


>      for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
> -- 
> 2.18.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
