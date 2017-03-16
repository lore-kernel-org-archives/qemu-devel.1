Received: from eggs.gnu.org ([2001:4830:134:3::10]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coQmA-0001mv-38
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coQm9-00041g-CK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:28:50 -0400
References: <20170316004603.20609-1-jsnow@redhat.com>
	<20170316004603.20609-4-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89775fe2-498f-d79c-c714-507bd373164e@redhat.com>
Date: Thu, 16 Mar 2017 09:28:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170316004603.20609-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC patch 3/3] blockjob: add devops to blockjob
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org



On 16/03/2017 01:46, John Snow wrote:
> - BlkDevOps is traditionally only for Qdev devices, and a BlockJob is not
>   currently a 'device'... Do we want to loosen this restriction, find another
>   way to deliver callbacks to BlockJobs attached to BlkBackends, or do something
>   crazy like make a BlockJob device object?
> 
>   struct JobDevice {
>     DeviceState parent_obj;
>     BlockJob *job;
>   } ...??

I think we want to loosen it.

> - Not so sure about leaving the initial job refcount at 1, since we are giving
>   away a handle to this job as dev_opaque. By incrementing it to 2, however,
>   it's not clear whose responsibility it is to decrement it again.

It would be another callback, sent at the time the dev_ops are removed.
But devices have been treating dev_opaque as a weak reference, it makes
sense to do the same for jobs.

Paolo
