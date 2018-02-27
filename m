Received: from eggs.gnu.org ([2001:4830:134:3::10]:60849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqiFN-0000A3-Hh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqiFM-0000nc-Oh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:36:57 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a4831e75-76c5-1bfc-7be5-f9ed1eb785dd@redhat.com>
Date: Tue, 27 Feb 2018 10:36:53 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 02/21] blockjobs: model single jobs as
 transactions
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
> model all independent jobs as single job transactions.
> 
> It's one less case we have to worry about when we add more states to the
> transition machine. This way, we can just treat all job lifetimes exactly
> the same. This helps tighten assertions of the STM graph and removes some
> conditionals that would have been needed in the coming commits adding a
> more explicit job lifetime management API.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

> @@ -729,6 +727,17 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>               return NULL;
>           }
>       }
> +
> +    /* Single jobs are modeled as single-job transactions for sake of
> +     * consolidating the job management logic */
> +    if (!txn) {
> +        txn = block_job_txn_new();
> +        block_job_txn_add_job(txn, job);
> +        block_job_txn_unref(txn);
> +    } else {
> +        block_job_txn_add_job(txn, job);
> +    }
> +
>       return job;

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
