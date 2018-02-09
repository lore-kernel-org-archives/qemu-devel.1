Received: from eggs.gnu.org ([2001:4830:134:3::10]:40220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ekDWC-0007kT-Rm
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ekDW8-00046j-8A
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:35:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1ekDW8-00046S-2y
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:35:24 -0500
Date: Fri, 9 Feb 2018 13:35:06 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180209133506.3f5dcc1a@redhat.com>
In-Reply-To: <48b8aa8e-36f8-1d2c-ee53-d8006cde77bc@linux.vnet.ibm.com>
References: <20180208111732.09869f84@redhat.com>
	<20180208203342.GE13981@localhost.localdomain>
	<f8157f02-4c16-6811-7857-e1ec4d55d49c@linux.vnet.ibm.com>
	<20180209084949.569007d7@redhat.com>
	<20180209142735.GK13981@localhost.localdomain>
	<48b8aa8e-36f8-1d2c-ee53-d8006cde77bc@linux.vnet.ibm.com>
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

On Fri, 9 Feb 2018 15:50:00 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> On 09.02.2018 15:27, Eduardo Habkost wrote:
> [...]
> >> I'm keeping it mainly for s390. Viktor, libvirt is still using
> >> this field in s390, no?
> >>
> >> Dropping halted and having management software still using query-cpus
> >> because of halted would be a total failure of query-cpus-fast.  
> > 
> > If I understood correctly, the CpuInfoS390::cpu_state field added
> > by Viktor in another patch[1] would replace "halted" for the s390
> > case.  
> Right, CPUState.halted is derived from CPUS390XState.cpu_state on s390:
> A cpu_state of CPU_STATE_STOPPED or CPU_STATE_CHECK_STOPPED results in
> halted = true. This derivation can be done by libvirt for s390.
> > 
> > I'm assuming QEMU will be able to return that field without
> > interrupting the VCPUs.  Viktor, is that correct?
> > 
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02032.html
> >   
> That's correct.
> >>  
> >>>> Also, the code that sets/clears cpu->halted is target-specific,
> >>>> so I wouldn't be so sure that simply checking for
> >>>> !kvm_irqchip_in_kernel() is enough on all targets.  
> >>
> >> I checked the code and had the impression it was enough, but
> >> I don't have experience with other archs. So, would be nice
> >> if other archs maintainers could review this. I'll try to ping them.  
> > 
> > I think we need to take a step back and rethink:
> > 
> > 1) What the field is supposed to mean?  The semantics of "halted"
> >    are completely unclear.  What exactly we want to communicate
> >    to libvirt/management?
> > 2) On which cases the information (whatever it means) is really
> >    useful/important?  If you are excluding cases with in-kernel
> >    irqchip, you are already excluding most users.
> > 
> >   
> Given that nobody (including myself) sees a need for halted we can
> remove it for the fast version of query-cpus without surprising anyone.
> [...]

My conclusion too, I'll drop it.
