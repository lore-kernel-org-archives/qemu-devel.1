Received: from eggs.gnu.org ([2001:4830:134:3::10]:34875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eql20-0004mA-0o
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eql1w-0005fM-7C
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:35:20 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-9-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46034cb1-d31e-ba4b-2474-f90c08bdfbfc@redhat.com>
Date: Tue, 27 Feb 2018 13:34:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-9-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 08/21] blockjobs: add ABORTING state
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
> Add a new state ABORTING.
> 
> This makes transitions from normative states to error states explicit
> in the STM, and serves as a disambiguation for which states may complete
> normally when normal end-states (CONCLUDED) are added in future commits.
> 
> Notably, Paused/Standby jobs do not transition directly to aborting,
> as they must wake up first and cooperate in their cancellation.
> 
> Transitions:
> Running -> Aborting: can be cancelled or encounter an error
> Ready   -> Aborting: can be cancelled or encounter an error
> 
> Verbs:
> None. The job must finish cleaning itself up and report its final status.
> 
>               +---------+
>               |UNDEFINED|
>               +--+------+
>                  |
>               +--v----+
>               |CREATED|
>               +--+----+
>                  |
>               +--v----+     +------+
>     +---------+RUNNING<----->PAUSED|
>     |         +--+----+     +------+
>     |            |
>     |         +--v--+       +-------+
>     +---------+READY<------->STANDBY|
>     |         +-----+       +-------+
>     |
> +--v-----+
> |ABORTING|
> +--------+
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockjob.c           | 31 ++++++++++++++++++-------------
>   qapi/block-core.json |  7 ++++++-
>   2 files changed, 24 insertions(+), 14 deletions(-)
> 

> +++ b/qapi/block-core.json
> @@ -996,10 +996,15 @@
>   # @standby: The job is ready, but paused. This is nearly identical to @paused.
>   #           The job may return to @ready or otherwise be canceled.
>   #
> +# @aborting: The job is in the process of being aborted, and will finish with
> +#            an error. The job will afterwards report that it is @concluded.

@concluded isn't defined yet, but I'm okay with the minor future 
reference, as it's less churn to get to the description that works at 
the end of the series.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
