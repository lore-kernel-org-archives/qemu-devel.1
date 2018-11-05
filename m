Received: from eggs.gnu.org ([2001:4830:134:3::10]:55531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJUMG-0003vZ-AH
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 21:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJUMD-00006H-3M
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 21:11:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:65309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gJUMC-0008WK-Pm
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 21:11:13 -0500
Date: Mon, 5 Nov 2018 03:10:28 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181105021028.GA6380@caravaggio>
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181102132925.365e1881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102132925.365e1881@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/23] ACPI reorganization for
 hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Igor,

On Fri, Nov 02, 2018 at 01:29:25PM +0100, Igor Mammedov wrote:
> On Thu,  1 Nov 2018 11:22:40 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> Thanks for looking at ACPI mess we have in QEMU and trying to make it better,
Thanks for the initial review and feedback.

> this series look a bit hackish probably because it was written to suit new
> virt board, so it needs some more clean up to be done.
>
> > This patch set provides an ACPI code reorganization in preparation for
> > adding hardware-reduced support to QEMU.
> QEMU already has hw reduced implementation, specifically in arm/virt board
Back in May, I tried booting a virt machine type with "acpi=force" with
no success, and today's HEAD still fails. With "acpi=on":

[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: Failed to init ACPI tables

So this code has been broken for several months and I suspect it's not
really run by anyone.
Moreover, even though the virt-acpi-build.c code aims at building a
hardware-reduced ACPI compliant set of tables, the implementation is
largely specific to the arm/virt board. We did take the generic parts
from it in order to build a shareable API across architectures.

So by "adding hardware-reduced support to QEMU", we meant providing a
architecture and machine type agnostic hardware-reduced ACPI
implementation that all QEMU machine types could use.
I'll make sure to change the cover letter wording and rephrase it to
reflect our intention.

> > The changes are coming from the NEMU [1] project where we're defining
> > a new x86 machine type: i386/virt. This is an EFI only, ACPI
> > hardware-reduced platform and as such we had to implement support
> > for the latter.
> > 
> > As a preliminary for adding hardware-reduced support to QEMU, we did
> s:support to QEMU:support for new i386/virt machine:
Most of this serie moves non x86 specific stuff out of i386 into the
(theoretically) architecture agnostic hw/acpi folder in order to a) reuse
and share as much as possible of the non x86 specific ACPI code that
currently lives under hw/i386 and b) improve and extend the current
hw/acpi APIs.
So on one hand I agree this cover letter needs massaging, but on the
other hand I feel it's unfair to say there's anything specific to
i386/virt on this serie. At least we tried really hard to avoid falling
into that trap.

> > some ACPI code reorganization with the following goals:
> > 
> > * Share as much as possible of the current ACPI build APIs between
> >   legacy and hardware-reduced ACPI.
> > * Share the ACPI build code across machine types and architectures and
> >   remove the typical PC machine type dependency.
> >   Eventually we hope to see arm/virt also re-use much of that code.
> it probably should be other way around, generalize and reuse as much of
> arm/virt acpi code,
Our hardware-reduced implementation does that indeed, and the next
patchset following this one will add the actual hardware-reduced ACPI
API implementation together with the arm/virt switch to it (which will
mostly be code removal from virt-acpi-build.c).

> instead of adding new duplicated code without
> an actual user and then swapping/dropping old arm version in favor of the
> new one.
This patch set is not adding any code duplication, I hope.
It's really preparing the current ACPI code in order to precisely NOT add
code duplication when building a machine type agnostic hardware reduced
ACPI API.
I initally added our hardware-reduced ACPI API to that patch serie but
decided to remove it. Here is what it looks like:
https://github.com/intel/nemu/blob/topic/virt-x86/hw/acpi/reduced.c

It's consuming the factorization work that this serie provides, and the
arm/virt machine type will use a fairly large part of that API.

> It's hard to review when it done in this order and easy to miss
> issues that would be easier to spot if you reused arm versions (where
> applicable) as starting point for generalization.
> 
> Here are some generic suggestions/nits that apply to whole series:
>   * s/Factorize/Factor out/
>   * try to restructure series in following way
>      1. put bug fixes at the beginning of series.
I'll try to do that, yes.


>         'make V=1 check' should produce tables diffs to account for
>         changes made in the tables.
I'll run the make check tests, thanks for the reminder.


>         After error fixing, add an extra patch to update reference
>         ACPI tables to simplify testing for reviewing and so for
>         self-check when you'll be doing refactoring to make sure
>         there aren't any changes during generalization/refactoring
>         later.
>
>      2. instead of adding 'new' implementations try to generalize
>         existing ones so that a user for new code will always exist.
>         It's also makes patches easier to review/test.
The PC machine type is consuming all the exported API and e.g. the
new ACPI builder interface as well.


>      3. Since you are touching/moving around existing fixed tables
>         that are using legacy 'struct' based approach to construct
>         them, it's a good as opportunity to switch to a newer approach
>         and use build_append_int_noprefix() API to construct tables.
>         Use build_amd_iommu() as example. And it's doubly true if/when
>         you are adding new fixed tables (i.e. only build_append_int_noprefix()
>         based ones are acceptable).
I'd be happy to do that, but I'd appreciate if that could be done as a
follow up patch set, in order to decouple the code movement/export from
the actual reimplementation.


>      4. for patches during #2 and #3 stages, 'make V=1 check'
>         should pass without any warnings, that will speed up review
>         process.
> 
>      5. add i386/virt board and related hardware reduced ACPI code
>         that's specific to it.
That is definitely going to be our last steps, but I think this would
make a very large patch set to review at once.


> I'll try to review series during next week and will do per patch
> suggestions how to structure it or do other way.
Thanks in advance. FWIW I just sent v5, addressing Philippe's comments.
I'll wait for your feedback before sending v6.

> Hopefully after doing refactoring we would end up with
> simpler/smaller and cleaner ACPI code to the benefit of everyone.
> 
> PS:
> if you need a quick advice wrt APCI parts, feel free to ping me on IRC
> (Paris timezone).
Nice, same timezone for me :)
I'll get in touch next week.

Cheers,
Samuel.
