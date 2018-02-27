Received: from eggs.gnu.org ([2001:4830:134:3::10]:34931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqiNJ-00061Q-CI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqiNI-0005R1-E7
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:45:09 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-5-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4b49edb-481a-5a44-fde2-dd117621e954@redhat.com>
Date: Tue, 27 Feb 2018 10:44:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 04/21] blockjobs: add status enum
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
> We're about to add several new states, and booleans are becoming
> unwieldly and difficult to reason about. It would help to have a
> more explicit bookkeeping of the state of blockjobs. To this end,
> add a new "status" field and add our existing states in a redundant
> manner alongside the bools they are replacing:
> 

> Some of these states appear somewhat superfluous, but it helps define the
> expected flow of a job; so some of the states wind up being synchronous
> empty transitions. Importantly, jobs can be in only one of these states
> at any given time, which helps code and external users alike reason about
> the current condition of a job unambiguously.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> +++ b/qapi/block-core.json
> @@ -955,6 +955,32 @@
>   { 'enum': 'BlockJobType',
>     'data': ['commit', 'stream', 'mirror', 'backup'] }
>   
> +##
> +# @BlockJobStatus:
> +#
> +# Indicates the present state of a given blockjob in its lifetime.
> +#
> +# @undefined: Erroneous, default state. Should not ever be visible.
> +#
> +# @created: The job has been created, but not yet started.
> +#
> +# @running: The job is currently running.
> +#
> +# @paused: The job is running, but paused. The pause may be requested by
> +#          either the QMP user or by internal processes.
> +#
> +# @ready: The job is running, but is ready for the user to signal completion.
> +#         This is used for long-running jobs like mirror that are designed to
> +#         run indefinitely.
> +#
> +# @standby: The job is ready, but paused. This is nearly identical to @paused.
> +#           The job may return to @ready or otherwise be canceled.
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'BlockJobStatus',
> +  'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby'] }

Do we need 'undefined' in the list if it should never be visible?  I'm 
okay if you keep it because it makes other code easier, but as Kevin 
points out in 5/21, if you aren't even using it, it might be worth 
considering dropping the state altogether.

Otherwise, the patch looks fine to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
