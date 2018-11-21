Received: from eggs.gnu.org ([2001:4830:134:3::10]:41034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPcO0-0000MF-7S
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPcNw-0000Zb-79
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:58:24 -0500
Date: Thu, 22 Nov 2018 00:57:21 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181121235721.GE4450@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-21-sameo@linux.intel.com>
	<20181116170226.35385388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116170226.35385388@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 20/24] hw: acpi: Define ACPI tables
 builder interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Nov 16, 2018 at 05:02:26PM +0100, Igor Mammedov wrote:
> On Mon,  5 Nov 2018 02:40:43 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > In order to decouple ACPI APIs from specific machine types, we are
> > creating an ACPI builder interface that each ACPI platform can choose to
> > implement.
> > This way, a new machine type can re-use the high level ACPI APIs and
> > define some custom table build methods, without having to duplicate most
> > of the existing implementation only to add small variations to it.
> I'm not sure about motivation behind so high APIs,
> what obvious here is an extra level of indirection for not clear gain.
> 
> Yep using table callbacks, one can attempt to generalize
> acpi_setup() and help boards to decide which tables do not build
> (MCFG comes to the mind). But I'm not convinced that acpi_setup()
> could be cleanly generalized as a whole (probably some parts but
> not everything)
It's more about generalizing acpi_build(), and then having one
acpi_setup for non hardware-reduced ACPI and a acpi_reduced_setup() for
hardware-reduced.

Right now there's no generalization at all but with this patch we could
already use the same acpi_reduced_setup() implementation for both arm
and i386/virt.

> so it's minor benefit for extra headache of
> figuring out what callback will be actually called when reading code.
This is the same complexity that already exists for essentially all
current interfaces.

> However if board needs a slightly different table, it will have to
> duplicate an exiting one and then modify to suit its needs.
> 
> to me it pretty much looks the same as calling build_foo()
> we use now but with an extra indirection level and then
> duplicating the later for usage in another board in slightly
> different manner.
I believe what you're trying to say is that this abstraction may be
useful but you're arguing the granularity is not properly defined? Am I
getting this right?

Cheers,
Samuel.
