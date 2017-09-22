Received: from eggs.gnu.org ([2001:4830:134:3::10]:50918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvOKg-0002OI-4I
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvOKd-00032p-2B
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dvOKc-00032K-Sv
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:49:26 -0400
Date: Fri, 22 Sep 2017 15:49:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170922154920.10fd08ee.cohuck@redhat.com>
In-Reply-To: <ccb6e3eb-320e-b5dd-f728-09d8cab440c4@de.ibm.com>
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-3-borntraeger@de.ibm.com>
	<5e7ba7d5-82d4-f1e6-532a-37c2c445c227@linux.vnet.ibm.com>
	<ccb6e3eb-320e-b5dd-f728-09d8cab440c4@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On Fri, 22 Sep 2017 14:40:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/22/2017 02:13 PM, Pierre Morel wrote:
> > On 22/09/2017 10:38, Christian Borntraeger wrote:  
> >> Instead of unconditionally enabling the KVM AIS capability
> >> in the kvm arch init function, do this in the flic realize function
> >> when we know if migration is available. This requires to initialize
> >> flic before the CPUs.  
> > 
> > I am not sure to agree.
> > 
> > AIS facility is used for PCI (currently only PCI)
> > We want to support PCI emulation and PCI VFIO
> > 
> > 
> > Not having AIS support in the host kernel or not supporting AISM in the host kernel does not affect the emulation.
> > Neither virtio-pci nor TCG.
> > The only devices, (currently), which can not work without AIS and is not migratable without AISM are PCI VFIO devices.  
> 
> This patch enable the conditional enablement facility for the KVM host mask. The cpu model enablement is done
> differently for KVM and TCG anyway.
> Right now AIS is only enabled for KVM. For TCG AIS is not implemented at all and disabled. So for whenever this
> is fixed in TCG it can be handled then. 

Yes, that will probably still need quite a bit of work before we are
there.

> 
> And for emulated devices under KVM you still need the kernel support - otherwise migration is really broken for
> the nimm/dimm values.

Agreed, you need this for any pci device.

I have not yet reviewed this (or tested under tcg). I'd like to hear
David's opinion, though.
