Received: from eggs.gnu.org ([2001:4830:134:3::10]:51126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cg9nw-00084y-BK
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cg9nu-0002mp-H6
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:44:28 -0500
Date: Tue, 21 Feb 2017 13:44:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170221134416.5803b3e5@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA-VAY8LM+8jE4B-L=0QdcY5FLvwmwGVbUhcXjnC9-AW+w@mail.gmail.com>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA9JWzUEmGa2Wxd5xPE4dVknOKBkt=wMda7CAgxzrgOc+w@mail.gmail.com>
	<20170220195500.332a4844@nial.brq.redhat.com>
	<CAFEAcA-VAY8LM+8jE4B-L=0QdcY5FLvwmwGVbUhcXjnC9-AW+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Stefan Hajnoczi <stefanha@gmail.com>

On Mon, 20 Feb 2017 19:11:00 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 20 February 2017 at 18:55, Igor Mammedov <imammedo@redhat.com> wrote:
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
[...]
> 
> > its sole user netduino2 board has cpu_model hardcodded
> > at board level which could be left alone or converted
> > to this API.  
> 
> I think this may be for the benefit of the not-yet-in-tree
> netduinoplus2 board, which is a very similar SoC but
> with a cortex-m4. There are likely other ways we could
> model that, though.
> 
> > Using API would make code more consistent
> > at the cost of more code for default/valid callbacks.  
> 
> Mmm, we could have the board code just forward the
> default/valid callbacks through to the SoC (which
> would then either implement them or forward them again).
> But I think we should definitely see if we can make
> the code for handling "the CPU is actually inside some
> other object" as clean as we can, because I think
> that's by far the most common case. Machines like
> the x86 pc and the ARM virt board where the CPU is
> instantiated directly in the board code are the
> non-standard cases I think. We have a lot of boards
> where we do instantiate the CPU in the board code
> just for legacy reasons where we don't properly
> model the SoC the CPU is inside. But hardware that
> really has the CPU as a top level pluggable object
> is rare.

If we are to ditch legacy approach,
It would be cleaner for SoC to have fixed/unconfigurable
CPU type and each SoC being modeled as a separate
QOM object/type that would instantiate CPU directly
with QOM style, using type name, like:

    cpu = object_new(TYPE_FOO_CPU)
    set props if necessary               
    object_property_set_bool(cpu, true, "realized", &err)
    object_unref(cpu)

or similar with extra check/logic on top of plain object_new()

    prepare cpu_opts for cpu type TYPE_FOO_CPU
    cpu = qdev_device_add(cpu_opts)
    object_unref(cpu)

instead of using cpu_init/cpu_foo_init/cpu_generic_init()
with cpu_model parsing logic which is not really needed
there as concrete SoC model knows exact CPU type.

It should work for CPUs that are converted to QOM types,
i.e. a cpu_model maps to a distinct QOM type but we
still have legacy cpu_model handling where we have
not completely QOMifed single base CPU types, ex.

  cpu_mips_init(const char *cpu_model) 
      cpudef = get_feature_set_by_name(cpu+model)
      cpu = object_new(TYPE_MIPS_CPU)
      cpu->cpudef = cdef

which rely on cpu_model parsing like x86 used to be
before conversion from a single CPU type to a set
of concrete classes. QOMification of remaining
CPUs that rely on legacy cpu_model could be idea
for gsoc/outreachy project so students could learn
about QEMU internals (CCing Stefan). 

> 
> thanks
> -- PMM
> 
