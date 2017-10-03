Received: from eggs.gnu.org ([2001:4830:134:3::10]:54597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzTsX-0000J1-CZ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzTsS-0007MF-Ev
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzTsS-0007JK-6P
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:33:16 -0400
Date: Tue, 3 Oct 2017 17:33:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003203309.GC4760@localhost.localdomain>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<b8474e9d2e0a219d9bac901342f983b13d009301.1507059418.git.alistair.francis@xilinx.com>
	<20171003202345.GA4760@localhost.localdomain>
	<CAKmqyKMXqtXBx+Kp8a5nfHoaPBy29VOka3wzSfLG18jVLegGwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKMXqtXBx+Kp8a5nfHoaPBy29VOka3wzSfLG18jVLegGwQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/5] machine: Add a valid_cpu_types
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, Oct 03, 2017 at 01:26:53PM -0700, Alistair Francis wrote:
> On Tue, Oct 3, 2017 at 1:23 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, Oct 03, 2017 at 01:05:09PM -0700, Alistair Francis wrote:
> >> This patch add a MachineClass element that can be set in the machine C
> >> code to specify a list of supported CPU types. If the supported CPU
> >> types are specified the user enter CPU (by -cpu at runtime) is checked
> >> against the supported types and QEMU exits if they aren't supported.
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> >> ---
> >
> > Thanks!
> >
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >
> > However, I will squash the following changes before queueing,
> > because:
> >
> > * object_class_dynamic_cast() is safe even if class is NULL,
> >   so there's no need to validate cpu_type here.
> > * "must not be valid" sounds like the CPU is not allowed to be a
> >   valid CPU, so I rewrote the comment.
> >
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 3afc6a7b5b..36c2fb069c 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -766,9 +766,6 @@ void machine_run_board_init(MachineState *machine)
> >          ObjectClass *class = object_class_by_name(machine->cpu_type);
> >          int i;
> >
> > -        /* machine->cpu_type is supposed to be always a valid QOM type */
> > -        assert(class);
> > -
> >          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> >              if (object_class_dynamic_cast(class,
> >                                            machine_class->valid_cpu_types[i])) {
> > @@ -780,7 +777,7 @@ void machine_run_board_init(MachineState *machine)
> >          }
> >
> >          if (!machine_class->valid_cpu_types[i]) {
> > -            /* The user specified CPU must not be a valid CPU */
> > +            /* The user specified CPU is not valid */
> >              error_report("Invalid CPU type: %s", machine->cpu_type);
> >              error_printf("The valid types are: %s",
> >                           machine_class->valid_cpu_types[0]);
> 
> Looks good to me.
> 
> Does that mean you are taking the whole series now?

I was planning to tacke only patch 1/5, but I can take the whole
series if I get an Acked-by from the corresponding maintainers.

-- 
Eduardo
