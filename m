Received: from eggs.gnu.org ([2001:4830:134:3::10]:56378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPros-0003Nq-Cb
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gProq-0007lW-Jg
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:27:10 -0500
Date: Thu, 22 Nov 2018 17:26:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181122172652.6b02aef6@redhat.com>
In-Reply-To: <20181121144211.GE4426@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-6-sameo@linux.intel.com>
	<20181108151623.4de26ecb@redhat.com>
	<20181121144211.GE4426@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/24] hw: acpi: Implement XSDT support
 for RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 21 Nov 2018 15:42:11 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> Hi Igor,
> 
> On Thu, Nov 08, 2018 at 03:16:23PM +0100, Igor Mammedov wrote:
> > On Mon,  5 Nov 2018 02:40:28 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >   
> > > XSDT is the 64-bit version of the legacy ACPI RSDT (Root System
> > > Description Table). RSDT only allow for 32-bit addressses and have thus
> > > been deprecated. Since ACPI version 2.0, RSDPs should point at XSDTs and
> > > no longer RSDTs, although RSDTs are still supported for backward
> > > compatibility.
> > > 
> > > Since version 2.0, RSDPs should add an extended checksum, a complete table
> > > length and a version field to the table.  
> > 
> > This patch re-implements what arm/virt board already does
> > and fixes checksum bug in the later and at the same time
> > without a user (within the patch).
> > 
> > I'd suggest redo it a way similar to FADT refactoring
> >   patch 1: fix checksum bug in virt/arm
> >   patch 2: update reference tables in test
> >   patch 3: introduce AcpiRsdpData similar to commit 937d1b587
> >              (both arm and x86) wich stores all data in hos byte order
> >   patch 4: convert arm's impl. to build_append_int_noprefix() API (commit 5d7a334f7)
> >
> >            ... move out to aml-build.c
> >   patch 5: reuse generalized arm's build_rsdp() for x86, dropping x86 specific one
> >       amending it to generate rev1 variant defined by revision in AcpiRsdpData
> >       (commit dd1b2037a)  
> I agree patches #1, #2 and #5 make sense. 3 and 4 as well, but here
> you're asking about something that's out of scope of the current serie.
/me guilty of that, but I have excuses for doing so:
  * that's the only way to get rid of legacy approach given limited resources.
    So task goes to whomever touches old code. /others and me included/
    I'd be glad if someone would volunteer and do clean ups but in absence
    of such, the victim is interested party.
  * contributor to ACPI part learns how to use preferred approach,
    makes code more robust and clear as it's not possible to make
    endianness mistakes, very simple to review and notice mistakes
    as end result practically matches row by row a table described in spec.
  * there could be exceptions, like acpi/nvdimm.c also contributed by Intel
    whole file written in legacy style (it probably started before I started
    enforcing conversions, anyways it's late now and should be done as whole),
    or odd fixes to existing tables, or too complex case.
    (depending on case I might still ask for conversion)

My ranting aside, conversions I've asked for here are trivial and for
everyone's benefit /QEMU gets more maintainable code, users less bugs,
contributor knows requirements hence his patches go through less iterations,
hopefully if contributor stays around and does contributions/reviews to
acpi code, QEMU could get another co-maintainer for acpi part/

> I'll move those patches from this serie and build a 6 patches new serie
> as suggested.

Thanks!

> 
> Cheers,
> Samuel.
> 
