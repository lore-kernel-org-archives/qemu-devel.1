Received: from eggs.gnu.org ([2001:4830:134:3::10]:49722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gKl34-0004Mf-GD
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gKl30-0007Xi-TQ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:12:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gKl30-0007VG-Hm
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:12:38 -0500
Date: Thu, 8 Nov 2018 15:12:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181108151234.48f37815@redhat.com>
In-Reply-To: <20181105021028.GA6380@caravaggio>
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181102132925.365e1881@redhat.com>
	<20181105021028.GA6380@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org

On Mon, 5 Nov 2018 03:10:28 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> Hi Igor,
> 
> On Fri, Nov 02, 2018 at 01:29:25PM +0100, Igor Mammedov wrote:
> > On Thu,  1 Nov 2018 11:22:40 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
[...]
> > > some ACPI code reorganization with the following goals:
> > > 
> > > * Share as much as possible of the current ACPI build APIs between
> > >   legacy and hardware-reduced ACPI.
> > > * Share the ACPI build code across machine types and architectures and
> > >   remove the typical PC machine type dependency.
> > >   Eventually we hope to see arm/virt also re-use much of that code.  
> > it probably should be other way around, generalize and reuse as much of
> > arm/virt acpi code,  
> Our hardware-reduced implementation does that indeed, and the next
> patchset following this one will add the actual hardware-reduced ACPI
> API implementation together with the arm/virt switch to it (which will
> mostly be code removal from virt-acpi-build.c).
That's where I disagree with patch ordering, i.e. you are adding impl. without
user and than do sudden switch from old API (dropping old one in the process)
to the new one some time in the future.

For example 04/23 add new impl. of build_rsdp() with xsdt support without
actual user, which is duplicate of arm/virt code modulo checksum fix
and than later in 05/23 drops old arm impl. in favor of the new one.

As you saw it causes confusion during review even within one series
and it's much worse in cases where similar changes happen across
several series. In addition bisection would point into wrong patch
05/23 (where code started to be used but not where it was introduced).


> > instead of adding new duplicated code without
> > an actual user and then swapping/dropping old arm version in favor of the
> > new one.  
> This patch set is not adding any code duplication, I hope.
> It's really preparing the current ACPI code in order to precisely NOT add
> code duplication when building a machine type agnostic hardware reduced
> ACPI API.
> I initally added our hardware-reduced ACPI API to that patch serie but
> decided to remove it. Here is what it looks like:
> https://github.com/intel/nemu/blob/topic/virt-x86/hw/acpi/reduced.c
> 
> It's consuming the factorization work that this serie provides, and the
> arm/virt machine type will use a fairly large part of that API.
the point is existing arm/virt machine or any other machine should use
new API right away if applicable instead of some point in the future,
otherwise we are doing something wrong, change might not belong to series.

It's hard to find reasoning for merging new API/verify correctness
without immediate user.


> > It's hard to review when it done in this order and easy to miss
> > issues that would be easier to spot if you reused arm versions (where
> > applicable) as starting point for generalization.

[...]

> >      3. Since you are touching/moving around existing fixed tables
> >         that are using legacy 'struct' based approach to construct
> >         them, it's a good as opportunity to switch to a newer approach
> >         and use build_append_int_noprefix() API to construct tables.
> >         Use build_amd_iommu() as example. And it's doubly true if/when
> >         you are adding new fixed tables (i.e. only build_append_int_noprefix()
> >         based ones are acceptable).  
> I'd be happy to do that, but I'd appreciate if that could be done as a
> follow up patch set, in order to decouple the code movement/export from
> the actual reimplementation.
Well, it fine to keep old style if one fixes code but in all other cases
it's good opportunity to replace legacy approach with the preferred one.
So unless it's a fix, the new code (including generalization) should
use preferred approach (there are exceptions but this series is not the case).
Considering this series is re-factoring to make ACPI code more reusable,
we should do it properly instead of cutting corners.

I apply this rule myself 'ex: build_fadt()' and others if re-factoring
is related the series topic.
 
 
> >      4. for patches during #2 and #3 stages, 'make V=1 check'
> >         should pass without any warnings, that will speed up review
> >         process.
> > 
> >      5. add i386/virt board and related hardware reduced ACPI code
> >         that's specific to it.  
> That is definitely going to be our last steps, but I think this would
> make a very large patch set to review at once.
Agreed, as far as new API is used by already existing code. If API isn't
used then it should be moved out of this series to the one that would
actually use it.

[...]
