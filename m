Received: from eggs.gnu.org ([2001:4830:134:3::10]:46785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ek93r-0000is-Pw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ek93o-0003QE-NX
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:49:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1ek93o-0003Pi-II
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:49:52 -0500
Date: Fri, 9 Feb 2018 08:49:49 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180209084949.569007d7@redhat.com>
In-Reply-To: <f8157f02-4c16-6811-7857-e1ec4d55d49c@linux.vnet.ibm.com>
References: <20180208111732.09869f84@redhat.com>
	<20180208203342.GE13981@localhost.localdomain>
	<f8157f02-4c16-6811-7857-e1ec4d55d49c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com

On Fri, 9 Feb 2018 08:56:19 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> On 08.02.2018 21:33, Eduardo Habkost wrote:
> > On Thu, Feb 08, 2018 at 11:17:32AM -0500, Luiz Capitulino wrote:
> > [...]  
> >> The "halted" field is somewhat controversial. On the one hand,
> >> it offers a convenient way to know if a guest CPU is idle or
> >> running. On the other hand, it's a field that can change many
> >> times a second. In fact, the halted state can change even
> >> before query-cpus-fast has returned. This makes one wonder if
> >> this field should be dropped all together. Having the "halted"
> >> field as optional gives a better option for dropping it in
> >> the future, since we can just stop returning it.  
> > 
> > I'd just drop it, unless we find a use case where it's really
> > useful.

I don't think there's any, unless for debugging purposes.

I'm keeping it mainly for s390. Viktor, libvirt is still using
this field in s390, no?

Dropping halted and having management software still using query-cpus
because of halted would be a total failure of query-cpus-fast.

> > Also, the code that sets/clears cpu->halted is target-specific,
> > so I wouldn't be so sure that simply checking for
> > !kvm_irqchip_in_kernel() is enough on all targets.

I checked the code and had the impression it was enough, but
I don't have experience with other archs. So, would be nice
if other archs maintainers could review this. I'll try to ping them.

> Right, the present patch effectively disables halted anyway (including
> s390). 

No, it doesn't. It only disables halted for archs that require going
to the kernel to get it.

> So it may be cleaner to just drop it right now.
> Assuming the presence of architecure-specific data, libvirt can derive a
> halted state (or an equivalent thereof) from query-cpus-fast returned
> information.

This is a different proposal. You're proposing moving the halted state
to a CPU-specific field. This is doable if that's what we want.
