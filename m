Received: from eggs.gnu.org ([2001:4830:134:3::10]:34593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcMWV-0003lj-Uf
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcMWS-0000Yp-RK
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:03:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40958
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dcMWS-0000YD-Lv
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:03:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v711xVCW120683
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 22:02:59 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c2a86qcf0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 22:02:58 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 31 Jul 2017 22:02:58 -0400
Date: Tue, 1 Aug 2017 10:02:53 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<20170731035137.GB21572@bjsdjshi@linux.vnet.ibm.com>
	<20170731131302.5bb2198c@gondolin>
	<bcb1d8d2-b620-fc47-4a2f-c89bbb744d0b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb1d8d2-b620-fc47-4a2f-c89bbb744d0b@linux.vnet.ibm.com>
Message-Id: <20170801020253.GD12259@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pmorel@linux.vnet.ibm.com

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-07-31 14:30:32 +0200]:

> 
> 
> On 07/31/2017 01:13 PM, Cornelia Huck wrote:
> > On Mon, 31 Jul 2017 11:51:37 +0800
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > 
> >> * Cornelia Huck <cohuck@redhat.com> [2017-07-27 13:59:10 +0200]:
> >>
> >>> On Thu, 27 Jul 2017 03:54:18 +0200
> >>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> [..]
> >>
> >> After thinking quite a while, if we do want to add a real device object
> >> for a channel path, the most intractable problem (but not the only one)
> >> for me is to find a good way to map the real path with the virtual one.
> 
> Yeah, channel path virtualisation... IMHO our current solution is not
> not really solving the problem.
If we choose to go with Conny's idea, then yes, my prototype is totally
in the wrong direction.

> Say, do we  care about a design which could work with live migration
> (@Dong Jia)?
Channel I/O pass through and live migration don't go together.

I'm afraid, we did not considerate live migration yet. If we can
migrate, that would be great! But we are still struggling in finding a
way out the current swamp...

> 
> >> How would we retrieve the information from the real one? We'd need the
> >> host kernel to provide totally new interfaces for channel path
> >> information synchronization and notification machenism. I don't think in
> >> this case sysfs is the choice. Ioctls, vfio MMIO regions and eventfd
> >> could be a better choice. I think, this is like we are trying to
> >> passthru a channel path. So we'd need to have a new vfio device physical
> >> driver (e.g. vfio-chp) to handle this...
> > 
> > And that would run into the problem of (1) the chp objects not using a
> > bus on Linux, and (2) implying dedicating the chpids, which we likely
> > do not want.
> > 
> 
> AFAIU this is about "real-virtual" vs "virutal-virtual". I would really like
> to see some design here (@Dong Jia). I'm not sure any more where do we want to go.
If we can find a way to satisfy the requirements that Conny mentioned, I
can prepare a design. Sadly, we are not there yet.

> 
> [..]
> >>
> >>>
> >>> tl;dr: I don't think we want chp crws until after we have a good chp
> >>> model.  
> >> I have to agree.
> > 
> > I'm wondering whether we should just defer this to later. We can live
> > with no chp crw being created (except for rchp), as due to the crw
> > generation being unreliable the guest OS has to handle path changes
> > without crws anyway.
> > 
> > We just need to make sure that pno and friends are appropriately
> > reported to the guest.
> > 
> 
> +1 
Ha! This is very very clever!

I will give it a try. If everything go well, I will agree with this
happyly. ;)

-- 
Dong Jia Shi
