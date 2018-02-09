Received: from eggs.gnu.org ([2001:4830:134:3::10]:55476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ek9eV-0000Mx-IJ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ek9eR-0000Io-Jq
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:27:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ek9eR-0000Ht-BY
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:27:43 -0500
Date: Fri, 9 Feb 2018 12:27:35 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180209142735.GK13981@localhost.localdomain>
References: <20180208111732.09869f84@redhat.com>
	<20180208203342.GE13981@localhost.localdomain>
	<f8157f02-4c16-6811-7857-e1ec4d55d49c@linux.vnet.ibm.com>
	<20180209084949.569007d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209084949.569007d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com

On Fri, Feb 09, 2018 at 08:49:49AM -0500, Luiz Capitulino wrote:
> On Fri, 9 Feb 2018 08:56:19 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
> > On 08.02.2018 21:33, Eduardo Habkost wrote:
> > > On Thu, Feb 08, 2018 at 11:17:32AM -0500, Luiz Capitulino wrote:
> > > [...]  
> > >> The "halted" field is somewhat controversial. On the one hand,
> > >> it offers a convenient way to know if a guest CPU is idle or
> > >> running. On the other hand, it's a field that can change many
> > >> times a second. In fact, the halted state can change even
> > >> before query-cpus-fast has returned. This makes one wonder if
> > >> this field should be dropped all together. Having the "halted"
> > >> field as optional gives a better option for dropping it in
> > >> the future, since we can just stop returning it.  
> > > 
> > > I'd just drop it, unless we find a use case where it's really
> > > useful.
> 
> I don't think there's any, unless for debugging purposes.
> 
> I'm keeping it mainly for s390. Viktor, libvirt is still using
> this field in s390, no?
> 
> Dropping halted and having management software still using query-cpus
> because of halted would be a total failure of query-cpus-fast.

If I understood correctly, the CpuInfoS390::cpu_state field added
by Viktor in another patch[1] would replace "halted" for the s390
case.

I'm assuming QEMU will be able to return that field without
interrupting the VCPUs.  Viktor, is that correct?

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02032.html

> 
> > > Also, the code that sets/clears cpu->halted is target-specific,
> > > so I wouldn't be so sure that simply checking for
> > > !kvm_irqchip_in_kernel() is enough on all targets.
> 
> I checked the code and had the impression it was enough, but
> I don't have experience with other archs. So, would be nice
> if other archs maintainers could review this. I'll try to ping them.

I think we need to take a step back and rethink:

1) What the field is supposed to mean?  The semantics of "halted"
   are completely unclear.  What exactly we want to communicate
   to libvirt/management?
2) On which cases the information (whatever it means) is really
   useful/important?  If you are excluding cases with in-kernel
   irqchip, you are already excluding most users.


> 
> > Right, the present patch effectively disables halted anyway (including
> > s390). 
> 
> No, it doesn't. It only disables halted for archs that require going
> to the kernel to get it.

It disables it for all architectures that implement in-kernel
irqchip: x86, arm, s390.

The only existing user of "halted" is s390-specific code in
libvirt, and your patch won't return it on s390, so nobody seems
to benefit from it.


> 
> > So it may be cleaner to just drop it right now.
> > Assuming the presence of architecure-specific data, libvirt can derive a
> > halted state (or an equivalent thereof) from query-cpus-fast returned
> > information.
> 
> This is a different proposal. You're proposing moving the halted state
> to a CPU-specific field. This is doable if that's what we want.

I think it's a valid approach to return a target-specific field
first, and later try to come up with a generic (and clearly
defined) abstraction to represent the same information (either
inside QEMU or inside libvirt).

-- 
Eduardo
