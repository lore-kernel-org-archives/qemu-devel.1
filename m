Received: from eggs.gnu.org ([2001:4830:134:3::10]:33779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPTir-00012j-Ul
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPTir-0001MN-5C
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:43:21 -0500
Date: Wed, 21 Nov 2018 15:42:37 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181121144237.GF4426@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-2-sameo@linux.intel.com>
	<20181109152316.43b79217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109152316.43b79217@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/24] hw: i386: Decouple the ACPI build
 from the PC machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

Hi Igor,

On Fri, Nov 09, 2018 at 03:23:16PM +0100, Igor Mammedov wrote:
> On Mon,  5 Nov 2018 02:40:24 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > ACPI tables are platform and machine type and even architecture
> > agnostic, and as such we want to provide an internal ACPI API that
> > only depends on platform agnostic information.
> > 
> > For the x86 architecture, in order to build ACPI tables independently
> > from the PC or Q35 machine types, we are moving a few MachineState
> > structure fields into a machine type agnostic structure called
> > AcpiConfiguration. The structure fields we move are:
> 
> It's not obvious why new structure is needed, especially at
> the beginning of series. We probably should place this patch
> much later in the series (if we need it at all) and try
> generalize a much as possible without using it.
Patches order set aside, this new structure is needed to make the
existing API not completely bound to the pc machine type anymore and
"Decouple the ACPI build from the PC machine type".

It was either creating a structure to build ACPI tables in a machine
type independent fashion, or pass custom structures (or potentially long
list of arguments) to the existing APIs. See below.


> And try to come up with an API that doesn't need centralized collection
> of data somehow related to ACPI (most of the fields here are not generic
> and applicable to a specific board/target).
> 
> For generic API, I'd prefer a separate building blocks
> like build_fadt()/... that take as an input only parameters
> necessary to compose a table/aml part with occasional board
> interface hooks instead of all encompassing AcpiConfiguration
> and board specific 'acpi_build' that would use them when/if needed.
Let's take build_madt as an example. With my patch we define:

void build_madt(GArray *table_data, BIOSLinker *linker,
                MachineState *ms, AcpiConfiguration *conf);

And you're suggesting we'd define:

void build_madt(GArray *table_data, BIOSLinker *linker,
                MachineState *ms, HotplugHandler *acpi_dev,
                bool apic_xrupt_override);

instead. Is that correct?

Pros for the latter is the fact that, as you said, we would not need to
define a centralized structure holding all possibly needed ACPI related
fields.
Pros for the former is about defining a pointer to all needed ACPI
fields once and for all and hiding the details of the API in the AML
building implementation.


> We probably should split series into several smaller
> (if possible independent) ones, so people won't be scared of
> its sheer size and run away from reviewing it.
I will try to split it in smaller chunks if that helps.

Cheers,
Samuel.
