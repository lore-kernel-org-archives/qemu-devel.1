Received: from eggs.gnu.org ([209.51.188.92]:50089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hAvrS-0004Lk-B5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hAvrR-0004fJ-8t
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:16:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hAvrQ-0004eG-VD
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:16:21 -0400
Date: Mon, 1 Apr 2019 14:16:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190401141614.45d31d9e@redhat.com>
In-Reply-To: <f9dd683b32136bd4f5d5705b1ce6b7e3b421eccb.camel@intel.com>
References: <f9dd683b32136bd4f5d5705b1ce6b7e3b421eccb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Thoughts about introducing virtio-cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Ortiz, Samuel" <samuel.ortiz@intel.com>, "Castelino, Manohar R" <manohar.r.castelino@intel.com>

On Wed, 27 Mar 2019 14:45:09 +0000
"Boeuf, Sebastien" <sebastien.boeuf@intel.com> wrote:

> Hi everyone,
> 
> I have recently learned about the on-going work from David Hildenbrand
> about virtio-mem, with a strong focus on proposing a unified solution
> for every architecture, which is the point of using paravirtualization
> here.
> This proposes a standardized way across different hypervisors to manage
> the guest RAM available, which at the same time will allow for a clean
> memory hot(un)plug support.
It was born mainly as the result of inability to deliver fine granularity
memory hotplug for guests that support memory hotplug with current kernel-mm
subsystem implementation. Ability to use virtio-mem on architectures that
do not have platform specific means to do hotplug is very useful but was
a nice side-effect.

It's still remains to see how much it will be able to deliver.
(I'm more interested in lessons it it will teach us in process).

> Based on this, I was thinking that once this will be ready, and
> assuming you manage your devices through a PCI bus, the last bit to get
> rid of ACPI dependency would be about CPU. We could standardize the way
> vCPUs are created and managed by each hypervisors by introducing
> virtio-cpu. And the same way I mentioned architecture agnostic and
> clean hotplug for virtio-mem, I would expect this new virtio device to
> target the same goals.
> 
> The end goal is to propose an approach where hypervisors could be
> unified across architectures, which would be convenient to support CPU
> hotplug features, without being forced to use ACPI only for this
> purpose.
Current cpu hotplug (ACPI one) in QEMU is combination of both static
part describing what CPUs are possible on given instance and dynamic
that notifies when and which CPUs are present. Hardware impl. is
hidden behind ACPI so guest OS doesn't know about details and QEMU
is free to change interface when it's necessary without need for
matching guest OS update.

So what is the purpose of getting rid of ACPI and what you'd
gain from it?
What alternatives do you have in mind to describe hardware?

> I am really looking for community's feedback here, as I would like to
> understand if there are some technical reasons why this approach would
> not be feasible/acceptable. Also, please let me know if there is
> already some on-going work, I'd be happy to participate!
>
> Thanks,
> Sebastien
