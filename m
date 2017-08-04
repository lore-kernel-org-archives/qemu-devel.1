Received: from eggs.gnu.org ([2001:4830:134:3::10]:40911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddZL3-0004AP-DD
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddZL2-0007xF-GM
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:56:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddZL2-0007wt-9z
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:56:12 -0400
Date: Fri, 4 Aug 2017 11:56:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170804115607.40f8a6d8@gondolin>
In-Reply-To: <20170726102623.1d182c07@gondolin>
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-2-cohuck@redhat.com>
	<f914a2ea-2958-406f-f68f-511027bc30be@redhat.com>
	<20170726102623.1d182c07@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/9] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Wed, 26 Jul 2017 10:26:23 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 26 Jul 2017 08:52:44 +0200
> Thomas Huth <thuth@redhat.com> wrote:

> > Since this missed the 2.10 freeze anyway and we've got some more time to
> > discuss it: I still think it would be much cleaner to move the functions
> > from kvm-all.c that use these PCI functions into a separate file
> > kvm-pci.c instead and compile that only with CONFIG_PCI=y. That way we
> > likely also could prevent that more dependencies on CONFIG_PCI creep
> > into kvm-all.c again at later points in time.
> > 
> > I've now had a closer look, and it seems like the only affected
> > functions are kvm_irqchip_add_msi_route() and
> > kvm_irqchip_update_msi_route() ... and these seems only to be used in
> > code we would not care about on s390x with CONFIG_PCI=n. So could you
> > please have at least a try to move these two functions (and other
> > related msi functions) to a new file kvm-pci.c instead to see whether
> > that would work, too?  
> 
> I can try, as this missed the 2.10 boat anyway.
> 
> The code contains some parts that are not relevant in all cases (msi
> routes if we don't use pci, adapter routes for anything not
> s390x, ...), but I don't think trying to rip this out would be much of
> an improvement. I'll try the minimal (well, not quite as minimal as
> this patch) route instead.

I tried this; but it turned out to be one of those cases where you pull
on a stick and then find half a tree attached to it... Much of the code
is used by all routing variants, and I ended up exposing so many
functions that it was just ugly and unreadable.

The variant I'm now going with is keeping the original approach and
adding a pci_available variable, which I also use in the patch that
exposes the zpci facility patch only when pci is compiled in. I'll try
to post this after lunch.
