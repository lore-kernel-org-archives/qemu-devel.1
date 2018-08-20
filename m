Received: from eggs.gnu.org ([2001:4830:134:3::10]:54271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frrXm-0003JU-3N
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 17:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frrXl-0008Pn-5W
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 17:16:57 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c15509f5-c47e-8a35-2a08-792322f4ea49@redhat.com>
Date: Mon, 20 Aug 2018 16:16:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>

On 08/17/2018 02:04 PM, John Snow wrote:
> All jobs do the same thing when they leave their running loop:
> - Store the return code in a structure
> - wait to receive this structure in the main thread
> - signal job completion via job_completed
> 
> Few jobs do anything beyond exactly this. Consolidate this exit
> logic for a net reduction in SLOC.
> 
> More seriously, when we utilize job_defer_to_main_loop_bh to call
> a function that calls job_completed, job_finalize_single will run
> in a context where it has recursively taken the aio_context lock,
> which can cause hangs if it puts down a reference that causes a flush.
> 
> You can observe this in practice by looking at mirror_exit's careful
> placement of job_completed and bdrv_unref calls.
> 
> If we centralize job exiting, we can signal job completion from outside
> of the aio_context, which should allow for job cleanup code to run with
> only one lock, which makes cleanup callbacks less tricky to write.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   include/qemu/job.h |  7 +++++++
>   job.c              | 19 +++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
