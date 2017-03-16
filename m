Received: from eggs.gnu.org ([2001:4830:134:3::10]:32932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coZKD-0004S3-3Z
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coZKC-0006Bf-6L
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:36:33 -0400
Date: Thu, 16 Mar 2017 18:36:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170316173608.GJ4995@noname.redhat.com>
References: <20170316004603.20609-1-jsnow@redhat.com>
	<20170316004603.20609-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316004603.20609-4-jsnow@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org

Am 16.03.2017 um 01:46 hat John Snow geschrieben:
> This lets us hook into drained_begin and drained_end requests from the
> backend level, which is particularly useful for making sure that all
> jobs associated with a particular node (whether the source or the target)
> receive a drain request.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> --
> 
> RFC topics:
> 
> - BlkDevOps is traditionally only for Qdev devices, and a BlockJob is not
>   currently a 'device'... Do we want to loosen this restriction, find another
>   way to deliver callbacks to BlockJobs attached to BlkBackends, or do something
>   crazy like make a BlockJob device object?
> 
>   struct JobDevice {
>     DeviceState parent_obj;
>     BlockJob *job;
>   } ...??

We should probably rename BlkDevOps to something that works not only for
devices, but for any user of a BlockBackend. I don't think the
implementation has to be changed, it's just a struct of callbacks and an
opaque pointer that is actually properly treated as opaque.

BlockBackend also has a dev field, which is indeed supposed to be a
DeviceState and is sometimes casted to one (if we can assert
!blk->legacy_dev), but it's a concept completely separate from
BlkDevOps. So we just need to be sure not to call blk_attach_dev() or
blk_attach_dev_legacy().

Kevin
