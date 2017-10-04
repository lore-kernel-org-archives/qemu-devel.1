Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzmd8-0005nC-QF
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzmd6-0002y6-5y
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzmd5-0002xj-UH
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:34:40 -0400
Date: Wed, 4 Oct 2017 13:34:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171004163434.GN4760@localhost.localdomain>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<2a93b997d0acd369f35d68981a23ba491443daf6.1507059418.git.alistair.francis@xilinx.com>
	<20171003203654.GD4760@localhost.localdomain>
	<CAKmqyKN+QnBAS6c4mAb2EiTVQv3Km6EdmGXCFC3hVogL96QK1Q@mail.gmail.com>
	<20171004131232.32f5caae@nial.brq.redhat.com>
	<20171004122851.GJ4760@localhost.localdomain>
	<20171004150816.41ffc161@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004150816.41ffc161@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Marcel Apfelbaum <marcel@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Oct 04, 2017 at 03:08:16PM +0200, Igor Mammedov wrote:
> On Wed, 4 Oct 2017 09:28:51 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Oct 04, 2017 at 01:12:32PM +0200, Igor Mammedov wrote:
> > > On Tue, 3 Oct 2017 14:41:17 -0700
> > > Alistair Francis <alistair.francis@xilinx.com> wrote:
> > >   
> > > > On Tue, Oct 3, 2017 at 1:36 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:  
> > > > > On Tue, Oct 03, 2017 at 01:05:13PM -0700, Alistair Francis wrote:    
> > > > >> List all possible valid CPU options.
> > > > >>
> > > > >> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > > > >> ---
> > > > >>
> > > > >>  hw/arm/xlnx-zcu102.c         | 10 ++++++++++
> > > > >>  hw/arm/xlnx-zynqmp.c         | 16 +++++++++-------
> > > > >>  include/hw/arm/xlnx-zynqmp.h |  1 +
> > > > >>  3 files changed, 20 insertions(+), 7 deletions(-)
> > > > >>
> > > > >> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> > > > >> index 519a16ed98..039649e522 100644
> > > > >> --- a/hw/arm/xlnx-zcu102.c
> > > > >> +++ b/hw/arm/xlnx-zcu102.c
> > > > >> @@ -98,6 +98,8 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
> > > > >>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> > > > >>                                &error_abort);
> > > > >>
> > > > >> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> > > > >> +                            &error_fatal);    
> > > > >
> > > > > Do you have plans to support other CPU types to xlnx_zynqmp in
> > > > > the future?  If not, I wouldn't bother adding the cpu-type
> > > > > property and the extra boilerplate code if it's always going to
> > > > > be set to cortex-a53.    
> > > > 
> > > > No, it'll always be A53.
> > > > 
> > > > I did think of that, but I also wanted to use the new option! I also
> > > > think there is an advantage in sanely handling users '-cpu' option,
> > > > before now we just ignored it, so I think it still does give a
> > > > benefit. That'll be especially important on the Xilinx tree (sometimes
> > > > people use our machines with a different CPU to 'benchmark' or test
> > > > other CPUs with our CoSimulation setup). So I think it does make sense
> > > > to keep in.  
> > > if cpu isn't user settable, one could just outright die if cpu_type
> > > is not NULL and say that user's CLI is wrong.
> > > (i.e. don't give users illusion that they allowed to use '-cpu')  
> > 
> > Isn't it exactly what this patch does, by setting:
> >     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
> >     mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
> > ?
> > 
> > Except that "-cpu cortex-a53" won't die, which is a good thing.
> allowing "-cpu cortex-a53" here, would allow to use feature parsing
> which weren't allowed or were ignored before if user supplied '-cpu'.
> so I'd more strict and refuse any -cpu and break CLI that tries to use it
> if board has non configurable cpu type. It would be easier to relax
> restriction later if necessary.
> 
> using validate_cpus here just to have users for the new code,
> doesn't seem like valid justification and at that it makes board
> code more complex where it's not necessary and build in cpu type
> works just fine.

It's up to the board maintainer to decide what's the best option.
Both features are independent from each other and can be
implemented by machine core.

In either case, the valid_cpu_types feature will be still very
useful for boards like pxa270 and sa1110, which support -cpu but
only with specific families of CPU types (grep for
"strncmp(cpu_type").

> 
> wrt centralized way to refuse -cpu if board doesn't support it,
> (which is not really related to this series) following could be done:
> 
> when cpu_model removal is completely done I plan to replace
>   vl.c
>      cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
> with
>      cpu_parse_cpu_model(DEFAULT_TARGET_CPU_TYPE, cpu_model)
> 
> so that we could drop temporary guard
> 
>      if (machine_class->default_cpu_type) {

This sounds good to me, even if we don't reject -cpu on any
board.


> 
> with that it would be possible to tell from machine_run_board_init()
> that board doesn't provide cpu but user provided '-cpu'
> so we would be able to:
>   if ((machine_class->default_cpu_type == NULL) &&
>       (machine->cpu_type != NULL))
>           error_fatal("machine doesn't support -cpu option");

I won't complain too much if a board maintainer really wants to
make the board reject -cpu completely, but it's up to them.

Personally, I'd prefer to have all boards setting
default_cpu_type even if they support only one CPU model, so
clients don't need a special case for boards that don't support
-cpu.

-- 
Eduardo
