Received: from eggs.gnu.org ([2001:4830:134:3::10]:60347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxAqA-0005Vo-Kx
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxAq5-0008Ai-OQ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxAq5-0008AJ-Hy
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:49:17 -0400
Date: Wed, 27 Sep 2017 13:49:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170927134910.0ffccb7e.cohuck@redhat.com>
In-Reply-To: <20170926183318.12995-1-david@redhat.com>
References: <20170926183318.12995-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/6] s390x/tcg: fix some accesses using
 low address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Tue, 26 Sep 2017 20:33:12 +0200
David Hildenbrand <david@redhat.com> wrote:

> Conny reported that a guest Linux currently spits out:
>   "The s390-virtio transport is deprecated. Please switch to a modern host
>   providing virtio-ccw."
> 
> This is strange, because we have no legacy virtio transport in QEMU :)
> 
> Main problem is, that a page is tested for acccess, and the test does not
> fail. All memory access variants like stb_phys() will never fail. On
> invalid memory, they simply do nothing.
> 
> Linux uses lura for this check. Let's introduce a _real MMU that handles
> prefixing and can later be used for things like low address protection.
> 
> The other BUG is that a check for invalid memory is wrong. Therefore,
> Patch 1 alone makes the guest crash when trying to initialize the
> virtio transport. Crazy stuff.

Indeed, thanks for hunting this down! No strange messages for me any
more :)

Fixed up the empty line in lura and applied to s390-next.
