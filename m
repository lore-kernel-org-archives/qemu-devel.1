Received: from eggs.gnu.org ([2001:4830:134:3::10]:58108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1chJPU-0004qX-Mb
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1chJPR-0007Oj-9x
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:12:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1chJPR-0007OB-3w
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:11:57 -0500
Date: Fri, 24 Feb 2017 14:11:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170224171152.GU2778@thinpad.lan.raisama.net>
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<CAFEAcA8_SsbdXWFbAt+qKXF-XGBjAt=ZbDgzSaeXYFzYPL1KTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8_SsbdXWFbAt+qKXF-XGBjAt=ZbDgzSaeXYFzYPL1KTQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] i386: Add "max" CPU model to TCG
 and KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Feb 24, 2017 at 01:48:46PM +0000, Peter Maydell wrote:
> On 22 February 2017 at 18:39, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Changes v1 -> v2:
> > * Fix build without CONFIG_KVM at lmce_supported()
> > * Rebased on top of my x86-next branch:
> >   https://github.com/ehabkost/qemu x86-next
> >
> > Git branch for testing:
> >   https://github.com/ehabkost/qemu-hacks work/x86-cpu-max-tcg
> >
> > libvirt code to use the new feature already exist, and were
> > submitted to libvir-list, at:
> >   https://www.mail-archive.com/libvir-list@redhat.com/msg142168.html
> >
> > ---
> >
> > This is a replacement for the previous series that enabled the
> > "host" CPU model on TCG. Now a new "max" CPU is being added,
> > while keeping "host" KVM-specific.
> >
> > In addition to simply adding "max" as a copy of the existing
> > "host" CPU model, additional patches change it to not use any
> > host CPUID information when in TCG mode.
> 
> 
> I had a look at implementing this for ARM, and ran into problems
> because of how we've done '-cpu host'. For us the "host" CPU
> type is registered dynamically when kvm_init() is called,
> because (a) it only exists if -enable-kvm and (b) it probes
> the kernel to find out what's available. So I could easily
> add 'max' in the same place; but then where should I add the
> type definition of 'max' for the non-KVM case?

I recommend registering the type unconditionally, moving
KVM-specific initialization to ->instance_init() and/or
->realize() (being careful to make instance_init() not crash if
KVM is disabled), and make ->realize() fail if KVM is disabled.
IIRC, we did exactly that on x86 a while ago.

-- 
Eduardo
