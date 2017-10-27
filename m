Received: from eggs.gnu.org ([2001:4830:134:3::10]:50235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e81h0-0003ZY-So
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e81gx-000468-Mb
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1e81gx-000426-DZ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:16:43 -0400
Date: Fri, 27 Oct 2017 12:16:36 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20171027101636.GF4938@orkuz.home>
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<d028d04a-9c28-af10-3410-f9007867cc05@de.ibm.com>
	<1ac27ce2-091d-e1b7-fc94-ebdf696a35e9@redhat.com>
	<9f4037d8-93a3-be0f-8cb4-4424158e236b@linux.vnet.ibm.com>
	<a7b30204-a854-afde-af01-234520cc6d7b@redhat.com>
	<87wp3jqips.fsf@marc-ibm.boeblingen.de.ibm.com>
	<04fe8f34-6f23-93d4-f388-ad7f03a24ca7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04fe8f34-6f23-93d4-f388-ad7f03a24ca7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Thu, Oct 26, 2017 at 10:09:46 +0200, David Hildenbrand wrote:
> On 25.10.2017 18:45, Marc Hartmayer wrote:
> > On Wed, Oct 25, 2017 at 05:50 PM +0200, David Hildenbrand <david@redhat.com> wrote:
> >> On 25.10.2017 17:09, Boris Fiuczynski wrote:
> >>> David, I disagree if your proposal is to generally tolerate new cpu
> >>> features in old machine types. This *might* work for gs but how do you
> >>> guaranty that guests do not behave differently/wrong when suddenly new
> >>> cpu features are made available to guest when (re-)starting them.
> >>> That is my feedback for the qemu side of this mater.
> >>
> >> Just re-reading this section, so what you mean is:
> >>
> >> a) guest is started, host model is copied and used. guest works.
> >> b) guest is stopped.
> >> c) QEMU/KVM/HW is updated.
> >> d) guest is started, new host model is copied. guest no longer works.
> >>
> >> d) could be because there are now some additional features with e.g.
> >> broken guest implementation or now missing features.
> >>
> >>
> >> What you propose (if I am not wrong) is a to bind features somehow to a
> >> QEMU machine. I think that should never be done. You could not catch now
> >> missing features.
> > 
> > What exactly do you mean by the last sentence?
> 
> In general, up/downgrading QEMU/KVM/HW can lead to the removal of features.
> 
> Another example is the "nested" flag for KVM. toggling that can lead to
> the host feature looking differently (+/- SIE features).
> 
> So if you really want to make sure that a VM XML that once ran perfectly
> fine on a host will still run after any QEMU/KVM/HW changes on that host:
> 
> a) specify an explicit CPU model, not the host model (e.g. "z13")
> b) copy the host model to the XML persistently.
> 
> Linking any of that to the machine types is in my opinion the very wrong
> approach.

I agree, we should do that only if it's really impossible to even create
a machine with a given machine type in combination with some CPU models.
And I believe this is not the case.

The host-model CPU guarantees guest ABI only while a domain is running.
Once it stops and a user starts it again, the ABI seen by the guest OS
may be different and this may sometimes cause the guest OS won't start.
It's pretty similar to what can happen when you change the machine type.
Of course, machine type doesn't change automatically while host-model
CPUs do change. But that's just how host-model is defined. If you don't
want this to happen, you should use a specific CPU model; you can copy
it from domain capabilities XML to make a persistent version of a
host-model CPU.

BTW, using host-model CPU may actually break migration to host with
older QEMU even though an old machine type is used. This is OK since
host-model may bring features which are not supported on the older host
and backward migration is only supported when no new features are used.
However, if a domain with a host-model CPU was started on the old host
and migrated to the new one, migrating it back to the old one is
supported and it will work.

Jirka
