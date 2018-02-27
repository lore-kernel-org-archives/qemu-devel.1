Received: from eggs.gnu.org ([2001:4830:134:3::10]:41592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlVq-0003uB-AD
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlVp-0003SD-Ci
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:06:10 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-18-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ceca0a2-788d-9a1a-985f-a6916a5f2bcc@redhat.com>
Date: Tue, 27 Feb 2018 14:05:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-18-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 17/21] blockjobs: add PENDING status and
 event
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
> For jobs utilizing the new manual workflow, we intend to prohibit
> them from modifying the block graph until the management layer provides
> an explicit ACK via block-job-finalize to move the process forward.
> 
> To distinguish this runstate from "ready" or "waiting," we add a new
> "pending" event.
> 
> For now, the transition from PENDING to CONCLUDED/ABORTING is automatic,
> but a future commit will add the explicit block-job-finalize step.
> 
> Transitions:
> Waiting -> Pending:   Normal transition.
> Pending -> Concluded: Normal transition.
> Pending -> Aborting:  Late transactional failures and cancellations.
> 
> Removed Transitions:
> Waiting -> Concluded: Jobs must go to PENDING first.
> 
> Verbs:
> Cancel: Can be applied to a pending job.
> 

> +##
> +# @BLOCK_JOB_PENDING:
> +#
> +# Emitted when a block job is awaiting explicit authorization to finalize graph
> +# changes via @block-job-finalize. If this job is part of a transaction, it will
> +# not emit this event until the transaction has converged first.

Same question of whether this new event is always emitted (and older 
clients presumably ignore it), or only emitted for clients that 
requested new-style state management.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
