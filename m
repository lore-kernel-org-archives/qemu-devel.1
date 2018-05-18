Received: from eggs.gnu.org ([2001:4830:134:3::10]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJjrq-0004Yf-Jz
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJjrp-0007Fi-Ja
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:12:38 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-37-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <998828bf-31ce-1778-6139-2a47e2b11db4@redhat.com>
Date: Fri, 18 May 2018 13:12:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-37-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 36/40] job: Add lifecycle QMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On 05/18/2018 08:21 AM, Kevin Wolf wrote:
> This adds QMP commands that control the transition between states of the
> job lifecycle.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/job.json |  99 +++++++++++++++++++++++++++++++++++++++++++
>   job-qmp.c     | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS   |   1 +
>   Makefile.objs |   1 +
>   trace-events  |   9 ++++
>   5 files changed, 244 insertions(+)
>   create mode 100644 job-qmp.c
> 
> +##
> +# @job-dismiss:
> +#
> +# Deletes a job that is in the CONCLUDED state. This command only needs to be
> +# run explicitly for jobs that don't have automatic dismiss enabled.

Did we decide whether it is valid to expect a job with automatic dismiss 
enabled (old-style block jobs) to use the new job control commands?  Or 
would it be reasonable to require that 'job-dismiss' is an error on jobs 
with auto-dismiss enabled (as in, if you're going to use new style jobs, 
you are guaranteed to also have auto-dismiss false, because we don't 
expose a way to change that flag in new-style jobs; and if you use old 
style jobs, all management of the job should be done through the old 
interfaces).

> +# This command will refuse to operate on any job that has not yet reached its
> +# terminal state, JOB_STATUS_CONCLUDED. For jobs that make use of JOB_READY
> +# event, job-cancel or job-complete will still need to be used as appropriate.
> +#
> +# @id: The job identifier.
> +#
> +# Since: 2.13
> +##
> +{ 'command': 'job-dismiss', 'data': { 'id': 'str' } }
> +


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
