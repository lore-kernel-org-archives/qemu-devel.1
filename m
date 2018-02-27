Received: from eggs.gnu.org ([2001:4830:134:3::10]:40809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlQO-0002NL-Pe
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlQO-0001KY-4U
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:00:32 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-17-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f475702e-fd2b-c1f2-ae32-4d34791f67ce@redhat.com>
Date: Tue, 27 Feb 2018 14:00:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-17-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 16/21] blockjobs: add waiting status
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
> For jobs that are stuck waiting on others in a transaction, it would
> be nice to know that they are no longer "running" in that sense, but
> instead are waiting on other jobs in the transaction.
> 
> Jobs that are "waiting" in this sense cannot be meaningfully altered
> any longer as they have left their running loop. The only meaningful
> user verb for jobs in this state is "cancel," which will cancel the
> whole transaction, too.
> 
> Transitions:
> Running -> Waiting:   Normal transition.
> Ready   -> Waiting:   Normal transition.
> Waiting -> Aborting:  Transactional cancellation.
> Waiting -> Concluded: Normal transition.
> 
> Removed Transitions:
> Running -> Concluded: Jobs must go to WAITING first.
> Ready   -> Concluded: Jobs must go to WAITING fisrt.

s/fisrt/first/

> +++ b/blockjob.c

> @@ -3934,6 +3938,29 @@
>               'offset': 'int',
>               'speed' : 'int' } }
>   
> +##
> +# @BLOCK_JOB_WAITING:
> +#
> +# Emitted when a block job that is part of a transction has stopped work and is

s/transction/transaction/

> +# waiting for other jobs in the transaction to reach the same state.

Is this event emitted only for 'new-style' transactions (old drivers 
will never see it, because they don't request new style), or always (old 
drivers will see, but presumably ignore, it)?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
