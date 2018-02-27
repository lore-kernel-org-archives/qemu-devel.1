Received: from eggs.gnu.org ([2001:4830:134:3::10]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqkst-00083m-Oz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqkss-0000K0-Ms
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:25:55 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-8-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14553f87-de62-8da5-752b-febc0e815dab@redhat.com>
Date: Tue, 27 Feb 2018 13:25:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> Which commands ("verbs") are appropriate for jobs in which state is
> also somewhat burdensome to keep track of.
> 
> As of this commit, it looks rather useless, but begins to look more
> interesting the more states we add to the STM table.
> 
> A recurring theme is that no verb will apply to an 'undefined' job.

Back to the argument of whether we even want that state.

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

Seems reasonable.  Hopefully shouldn't trip up libvirt too badly (if 
libvirt attempted a redundant job transition that used to silently 
succeed and now fails, the failure message should be pretty obvious that 
it was a no-op attempt).

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
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
