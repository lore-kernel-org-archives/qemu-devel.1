Received: from eggs.gnu.org ([209.51.188.92]:41153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpU7H-0006yu-Uu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 03:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpU7H-0007ad-3V
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 03:24:03 -0500
Date: Fri, 1 Feb 2019 09:23:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190201092356.295925c2.cohuck@redhat.com>
In-Reply-To: <cfe20aba-2f80-f8cb-66df-f9958bdf61f6@redhat.com>
References: <1548956828-10210-1-git-send-email-thuth@redhat.com>
	<20190131185621.28815291.cohuck@redhat.com>
	<538ee62b-293d-f053-4bd2-76bf166388e1@redhat.com>
	<c60dd137-ca05-85cd-78ca-d22c79ccd85e@redhat.com>
	<aee584b8-90f1-3f10-25dd-5b38d1f46142@redhat.com>
	<cfe20aba-2f80-f8cb-66df-f9958bdf61f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Fix the function arguments in
 the pci stub file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org

On Fri, 1 Feb 2019 07:46:40 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 2019-02-01 07:14, Thomas Huth wrote:
> > On 2019-01-31 19:08, Paolo Bonzini wrote:  
> >> On 31/01/19 19:00, Thomas Huth wrote:  
> >>>>> (and the prototypes in the header) anymore, so if you try to compile s390x
> >>>>> without CONFIG_PCI, the build currently fails.
> >>>>>  
> >>>> Fixes: 468a93898a97 ("s390x/pci: pass the retaddr to all PCI instructions")
> >>>>  
> >>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>>> ---
> >>>>>  hw/s390x/s390-pci-stub.c | 16 +++++++++-------
> >>>>>  1 file changed, 9 insertions(+), 7 deletions(-)  
> >>>> This file seems to be in danger of bitrot. Do you think it'll be easier
> >>>> to test rarely used configs like that after we switch to Kconfig?  
> >>> I hope so, yes. There will be a new --without-default-devices options
> >>> for "configure" (which matches "make allnoconfig" from the kernel) - if
> >>> we do it right in the Kconfig file for s390x, it should be possible to
> >>> catch this problem with that option.  
> >>
> >> Yes, it will be in .travis.yml too.
> >>
> >> Right now there is a "select PCI" in the hw/s390x/Kconfig file, but
> >> probably it's best to add a config S390_ZPCI with "default y if
> >> S390_CCW_VIRTIO" and "select PCI" in it.  Not a blocker, but I can
> >> integrate it if you send me a fixup patch.  
> > 
> > Yes, that's what I had in mind, too. I'll send a fixup patch...  
> 
> Actually, disabling the s390-pci code works from a compiling+linking
> point of view, but when you then try to start the machine, it fails:
> 
> $ s390x-softmmu/qemu-system-s390x -nographic
> qemu-system-s390x: Unknown device 's390-pcihost' for default sysbus
> Aborted (core dumped)
> 
> IIRC we originally wanted to make the "s390-pcihost" device really
> optional, but then decided not to do it since it would break migration.
> So the status of the "PCI disablement" got stuck somewhere inbetween,
> where we've created the switch for the Makefile and the stub file, but
> never really got it to a point where it could really really be disabled.

Well you can disable it, but it's not usable ;)

But yes, that annoying pcihost device needed for backwards compat got
into the way.

> 
> So I see two options now:
> 
> 1) Finally really make the device optional, at least for new machine
> types, so we can really disable CONFIG_PCI and get a working executable.
> 
> 2) Scratch the idea completely to make this optional, always link the
> s390-pci-bus.o and s390-pci-inst.o files unconditionally, and remove the
> s390-pci-stub.c file.
> 
> I assume options 2 is preferred, since we likely rather want to move
> into the PCI direction in the long run, instead of ignoring it...

I think both options are viable, but option 1 is of course more work.
The win there is that we could disable an entire subsystem.

I guess that the basic questions are: How important is it that
subsystems can be compiled out, and do we see a use case for a pci-less
s390 machine in the future? We really don't want to spend much time on
something of dubious use...
