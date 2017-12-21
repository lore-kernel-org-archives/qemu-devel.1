Received: from eggs.gnu.org ([2001:4830:134:3::10]:56436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSAEW-0000n7-1x
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSAEV-0004ZB-80
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:26:36 -0500
References: <20171220103412.13048-1-kwolf@redhat.com>
	<20171220103412.13048-12-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26dee366-26a3-2000-25c7-a80b189fe785@redhat.com>
Date: Thu, 21 Dec 2017 17:26:26 -0600
MIME-Version: 1.0
In-Reply-To: <20171220103412.13048-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/19] block: Don't notify parents in drain
 call chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On 12/20/2017 04:34 AM, Kevin Wolf wrote:
> This is in preparation for subtree drains, i.e. drained sections that
> affect not only a single node, but recursively all child nodes, too.
> 
> Calling the parent callbacks for drain is pointless when we just came
> from that parent node recursively and leads to multiple increases of
> bs->quiesce_counter in a single drain call. Don't do it.
> 
> In order for this to work correctly, the parent callback must be called
> for every bdrv_drain_begin/end() call, not only for the outermost one:
> 
> If we have a node N with two parents A and B, recursive draining of A
> should cause the quiesce_counter of B to increased because its child N

either 'to be increased' or 'to increase'

> is drained independently of B. If now B is recursively drained, too, A
> must increase its quiesce_counter because N is drained independently of
> A only now, even if N is going from quiesce_counter 1 to 2.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/block.h |  4 ++--
>   block.c               | 13 +++++++++----
>   block/io.c            | 47 ++++++++++++++++++++++++++++++++++-------------
>   3 files changed, 45 insertions(+), 19 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
