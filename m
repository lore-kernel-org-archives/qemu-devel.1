Received: from eggs.gnu.org ([2001:4830:134:3::10]:42272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpaZC-0004KT-1k
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpaZ7-0004Yl-FE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpaZ7-0004YX-8S
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:40:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 308A0356F0
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 13:40:24 +0000 (UTC)
Date: Wed, 6 Sep 2017 14:40:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170906134017.GB8457@work-vm>
References: <20170804175011.21944-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804175011.21944-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH f0r 2.11] runstate/migrate: Two more
 transitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, pbonzini@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> There's a race if someone does a 'stop' near the end of migrate;
> the migration process goes through two runstates:
>     'finish migrate'
>     'postmigrate'
> 
> If the user issues a 'stop' between the two we end up with invalid
> state transitions.
> Add the transitions as valid.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> ---
>  vl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/vl.c b/vl.c
> index 99fcfa0442..bacb03f49d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -621,6 +621,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>  
>      { RUN_STATE_PAUSED, RUN_STATE_RUNNING },
>      { RUN_STATE_PAUSED, RUN_STATE_FINISH_MIGRATE },
> +    { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
>  
> @@ -633,6 +634,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
>  
>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
> +    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_POSTMIGRATE },
>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_COLO},
> -- 
> 2.13.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
