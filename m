Received: from eggs.gnu.org ([2001:4830:134:3::10]:54115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqium-0001Rm-Jn
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqiul-00039e-Hf
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:19:44 -0500
Date: Tue, 27 Feb 2018 18:19:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180227171934.GI5269@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-8-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-8-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 07/21] blockjobs: add block_job_verb
 permission table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 24.02.2018 um 00:51 hat John Snow geschrieben:
> Which commands ("verbs") are appropriate for jobs in which state is
> also somewhat burdensome to keep track of.
> 
> As of this commit, it looks rather useless, but begins to look more
> interesting the more states we add to the STM table.
> 
> A recurring theme is that no verb will apply to an 'undefined' job.
> 
> Further, it's not presently possible to restrict the "pause" or "resume"
> verbs any more than they are in this commit because of the asynchronous
> nature of how jobs enter the PAUSED state; justifications for some
> seemingly erroneous applications are given below.
> 
> =====
> Verbs
> =====
> 
> Cancel:    Any state except undefined.
> Pause:     Any state except undefined;
>            'created': Requests that the job pauses as it starts.
>            'running': Normal usage. (PAUSED)
>            'paused':  The job may be paused for internal reasons,
>                       but the user may wish to force an indefinite
>                       user-pause, so this is allowed.
>            'ready':   Normal usage. (STANDBY)
>            'standby': Same logic as above.
> Resume:    Any state except undefined;
>            'created': Will lift a user's pause-on-start request.
>            'running': Will lift a pause request before it takes effect.
>            'paused':  Normal usage.
>            'ready':   Will lift a pause request before it takes effect.
>            'standby': Normal usage.
> Set-speed: Any state except undefined, though ready may not be meaningful.
> Complete:  Only a 'ready' job may accept a complete request.
> 
> 
> =======
> Changes
> =======
> 
> (1)
> 
> To facilitate "nice" error checking, all five major block-job verb
> interfaces in blockjob.c now support an errp parameter:
> 
> - block_job_user_cancel is added as a new interface.
> - block_job_user_pause gains an errp paramter
> - block_job_user_resume gains an errp parameter
> - block_job_set_speed already had an errp parameter.
> - block_job_complete already had an errp parameter.
> 
> (2)
> 
> block-job-pause and block-job-resume will no longer no-op when trying
> to pause an already paused job, or trying to resume a job that isn't
> paused. These functions will now report that they did not perform the
> action requested because it was not possible.
> 
> iotests have been adjusted to address this new behavior.
> 
> (3)
> 
> block-job-complete doesn't worry about checking !block_job_started,
> because the permission table guards against this.
> 
> (4)
> 
> test-bdrv-drain's job implementation needs to announce that it is
> 'ready' now, in order to be completed.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
