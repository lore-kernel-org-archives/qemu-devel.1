Received: from eggs.gnu.org ([2001:4830:134:3::10]:32864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlAOr-0003JC-5C
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlAOo-0006aw-4Y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dlAOn-0006ZM-Us
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:55:30 -0400
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <432db396-ab52-61d2-6537-d3d2d47760d3@redhat.com>
Date: Fri, 25 Aug 2017 10:55:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170825083123.47432-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 25/08/2017 10:31, Alexey Kardashevskiy wrote:
> 
> Interestingly, mem_add() from exec.c is called twice:
> as as->dispatch_listener.region_add() and
> as as->dispatch_listener.region_nop() - I did not understand
> the trick but it does not work if I remove the .region_nop() hook.
> How does it work? :)

Didn't note this.

The hooks are:

- region_add: a new MemoryRegionSection appeared compared to the
previous FlatView

- region_nop: a region that was in the previous FlatView stayed there

- region_del: a MemoryRegionSection disappeared compared to the previous
FlatView

Because the AddressSpaceDispatch is rebuilt from scratch, it cares about
both new (region_add) and existing (region_nop) regions.

Paolo
