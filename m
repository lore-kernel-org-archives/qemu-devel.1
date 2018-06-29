Received: from eggs.gnu.org ([2001:4830:134:3::10]:35595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1fYmXr-0003D1-Tv
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1fYmXn-0001e1-Ux
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:06:11 -0400
Received: from 185-219-166-8-static.vivo.cz ([185.219.166.8]:43714
	helo=smtp.vivo.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1fYmXn-0001Yd-Mt
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:06:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.vivo.cz (Postfix) with ESMTP id 91153CF835
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:06:05 +0200 (CEST)
Received: from smtp.vivo.cz ([127.0.0.1])
	by localhost (smtp.vivo.cz [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HeXP2cOvL3dg for <qemu-devel@nongnu.org>;
	Fri, 29 Jun 2018 08:06:04 +0200 (CEST)
Received: from mamuti.net (85-132-149-57-static.vivo.cz [85.132.149.57])
	by smtp.vivo.cz (Postfix) with ESMTPS id A08F8CB84F
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:06:04 +0200 (CEST)
Date: Fri, 29 Jun 2018 08:06:04 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20180629060604.GA5072@orkuz.home>
References: <20180628154502.GO3513@redhat.com> <20180628185938.GC2538@work-vm>
	<20180628192353.GG7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628192353.GG7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [libvirt] CPU model versioning separate from
 machine type versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Thu, Jun 28, 2018 at 16:23:53 -0300, Eduardo Habkost wrote:
> On Thu, Jun 28, 2018 at 07:59:38PM +0100, Dr. David Alan Gilbert wrote:
> [...]
> > > An application like virt-manager which wants a simple UI can forever be
> > > happy simply giving users a list of bare CPU model names, and allowing
> > > libvirt / QEMU to automatically expand to the best versioned model for
> > > their host.
> > > 
> > > An application like oVirt/OpenStack which wants direct control can allow
> > > the admin to choice if a bare name, or explicitly picking a versioned name
> > > if they need to cope with possibility of outdated hosts.
> > 
> > I fear people are going to find this out the hard way, when they add
> > a new system into their cluster, a little bit later it gets a VM started
> > on it, and then they try and migrate it to one of the older machines.
> > 
> > Now if there was something that could take the CPU defintions from all
> > the machines in the cluster and tell it which to use/which problems
> > they had then that might make sense.  It would be best for each
> > higher level not to reinvent that.
> 
> I think QEMU already provides enough info to allow that to be
> implemented.  I'm not sure sure if the libvirt API already
> provides all the info needed for this (I think it does).

Right, libvirt provides virConnectBaselineHypervisorCPU API which
accepts a list of host CPU models from several hosts and returns the
best CPU definition runnable on these hosts. However, OpenStack
clusters are too dynamic for this to be practical so the admin would
need to take care of this by setting an appropriate model statically.

> > Would you restrict the combinations to cut down the test matrix - e.g.
> > not allow Haswell-3.0.0 on anything prior to a 2.12 machine type?
> 
> Not sure if it would be worth the extra complexity: we would need
> an interface to tell libvirt which CPU models are usable on which
> machine-types.

In case we do this, libvirt should already by ready for it on the API
level for both reporting capabilities and CPU comparison/baseline. All
these APIs already accept machine type as an optional parameter so that
different results can be provided depending on machine type.

Jirka
