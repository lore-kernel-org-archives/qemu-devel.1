Received: from eggs.gnu.org ([2001:4830:134:3::10]:40289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1f9BVn-0007uV-HZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1f9BVh-0007hQ-Kh
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:30:15 -0400
Message-ID: <1524151804.3017.9.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 19 Apr 2018 17:30:04 +0200
In-Reply-To: <20180419062917.31486-1-david@gibson.dropbear.id.au>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org

On Thu, 2018-04-19 at 16:29 +1000, David Gibson wrote:
> Currently the "pseries" machine type will (usually) advertise
> different pagesizes to the guest when running under KVM and TCG, which
> is not how things are supposed to work.
> 
> This comes from poor handling of hardware limitations which mean that
> under KVM HV the guest is unable to use pagesizes larger than those
> backing the guest's RAM on the host side.
> 
> The new scheme turns things around by having an explicit machine
> parameter controlling the largest page size that the guest is allowed
> to use.  This limitation applies regardless of accelerator.  When
> we're running on KVM HV we ensure that our backing pages are adequate
> to supply the requested guest page sizes, rather than adjusting the
> guest page sizes based on what KVM can supply.
> 
> This means that in order to use hugepages in a PAPR guest it's
> necessary to add a "cap-hpt-mps=24" machine parameter as well as
> setting the mem-path correctly.  This is a bit more work on the user
> and/or management side, but results in consistent behaviour so I think
> it's worth it.

libvirt guests already need to explicitly opt-in to hugepages, so
adding this new option automagically based on that shouldn't be too
difficult.

A couple of questions:

  * I see the option accepts values 12, 16, 24 and 34, with 16
    being the default. I guess 34 corresponds to 1 GiB hugepages?
    Also, in what scenario would 12 be used?

  * The name of the property suggests this setting is only relevant
    for HPT guests. libvirt doesn't really have the notion of HPT
    and RPT, and I'm not really itching to introduce it. Can we
    safely use this option for all guests, even RPT ones?

Thanks.

-- 
Andrea Bolognani / Red Hat / Virtualization
