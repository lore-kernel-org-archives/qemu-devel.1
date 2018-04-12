Received: from eggs.gnu.org ([2001:4830:134:3::10]:36144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6Xt1-00073R-Cb
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6Xt0-0002xO-Hg
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:47:19 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-19-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef8717bb-89e0-7c78-354c-3dce960b24e9@redhat.com>
Date: Thu, 12 Apr 2018 10:47:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180411163940.2523-19-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/19] block: Allow graph changes in
 bdrv_drain_all_begin/end sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 11/04/2018 18:39, Kevin Wolf wrote:
> The much easier and more obviously correct way is to fundamentally
> change the way the functions work: Iterate over all BlockDriverStates,
> no matter who owns them, and drain them individually. Compensation is
> only necessary when a new BDS is created inside a drain_all section.
> Removal of a BDS doesn't require any action because it's gone afterwards
> anyway.

Ok, now I see (I think) why you chose the recursive check for in-flight
requests.  The higher quiesce_count is not a problem, but I am still not
convinced about the recursion.

Paolo

> This change means that some nodes get a higher bs->quiesce_count now
> because each node propagates its individual drain to all of its parents.
> In the old subtree drain, propagation back to the parent that made the
> recursive drain request was avoided. While this isn't perfectly
> beautiful, accepting the higher counts seems preferable to adding drain
> code to multiple other places that modify the graph.
