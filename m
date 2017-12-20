Received: from eggs.gnu.org ([2001:4830:134:3::10]:51993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eRmVG-0006MP-8N
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eRmVD-0002yH-0j
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eRmVC-0002xW-Nr
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:06:14 -0500
Date: Wed, 20 Dec 2017 20:06:08 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171220220608.GH24025@localhost.localdomain>
References: <cover.1513729519.git.alistair.francis@xilinx.com>
	<CAFEAcA-dvs-E83ZCEk6VAyyQkpghX9oF-d-D62vOKs7kfjPzaw@mail.gmail.com>
	<CAKmqyKPHHQcQ3HYs4r7f4uUDfdMqSq=-mUJn6becXw8WXNAwNQ@mail.gmail.com>
	<CAKmqyKMKL_BGSbaetubaPv8gkmF9XFFdDwkXAPsUZdV1qkOyqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKMKL_BGSbaetubaPv8gkmF9XFFdDwkXAPsUZdV1qkOyqA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/5] Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Dec 19, 2017 at 05:03:59PM -0800, Alistair Francis wrote:
> On Tue, Dec 19, 2017 at 4:55 PM, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
> > On Tue, Dec 19, 2017 at 4:43 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> On 20 December 2017 at 00:27, Alistair Francis
> >> <alistair.francis@xilinx.com> wrote:
> >>> There are numorous QEMU machines that only have a single or a handful of
> >>> valid CPU options. To simplyfy the management of specificying which CPU
> >>> is/isn't valid let's create a property that can be set in the machine
> >>> init. We can then check to see if the user supplied CPU is in that list
> >>> or not.
> >>>
> >>> I have added the valid_cpu_types for some ARM machines only at the
> >>> moment.
> >>>
> >>> Here is what specifying the CPUs looks like now:
> >>>
> >>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m3" -S
> >>> QEMU 2.10.50 monitor - type 'help' for more information
> >>> (qemu) info cpus
> >>> * CPU #0: thread_id=24175
> >>> (qemu) q
> >>>
> >>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m4" -S
> >>> QEMU 2.10.50 monitor - type 'help' for more information
> >>> (qemu) q
> >>>
> >>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m5" -S
> >>> qemu-system-aarch64: unable to find CPU model 'cortex-m5'
> >>>
> >>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-a9" -S
> >>> qemu-system-aarch64: Invalid CPU type: cortex-a9-arm-cpu
> >>> The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
> >>
> >> Thanks for this; we really should be more strict about
> >> forbidding "won't work" combinations than we have
> >> been in the past.
> >>
> >> In the last of these cases, I think that when we
> >> list the invalid CPU type and the valid types
> >> we should use the same names we want the user to
> >> use on the command line, without the "-arm-cpu"
> >> suffixes.
> >
> > Hmm... That is a good point, it is confusing that they don't line up.

Agreed.

> >
> > The problem is that we are just doing a simple
> > object_class_dynamic_cast() in hw/core/machine.c which I think
> > (untested) requires us to have the full name in the valid cpu array.
[...]
> 
> I think an earlier version of my previous series adding the support to
> machine.c did string comparison, but it was decided to utilise objects
> instead. One option is to make the array 2 wide and have the second
> string be user friendly?

Making the array 2-column will duplicate information that we can
already find out using other methods, and it won't solve the
problem if an entry has a parent class with multiple subclasses
(the original reason I suggested object_class_dynamic_cast()).

The main obstacle to fix this easily is that we do have a common
  ObjectClass *cpu_class_by_name(const char *cpu_model)
function, but not a common method to get the model name from a
CPUClass.  Implementing this is possible, but probably better to
do it after moving the existing arch-specific CPU model
enumeration hooks to common code (currently we duplicate lots of
CPU enumeration/lookup boilerplate code that we shouldn't have
to).

Listing only the human-friendly names in the array like in the
original patch could be a reasonable temporary solution.  It
won't allow us to use a single entry for all subclasses of a
given type by now (e.g. listing only TYPE_X86_CPU on PC), but at
least we can address this issue without waiting for a refactor of
the CPU model enumeration code.

-- 
Eduardo
