Received: from eggs.gnu.org ([2001:4830:134:3::10]:51579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drMwO-0002RL-KG
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drMwN-0001NA-Jq
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drMwN-0001Md-Dp
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:31:47 -0400
Date: Mon, 11 Sep 2017 13:31:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170911133139.518caf34@nial.brq.redhat.com>
In-Reply-To: <20170909201657.GF7570@localhost.localdomain>
References: <cover.1504656490.git.alistair.francis@xilinx.com>
	<b2bfe1ee20bd9764572015df0d167d3015036ef0.1504656490.git.alistair.francis@xilinx.com>
	<20170909201657.GF7570@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 1/2] machine: Add a valid_cpu_types
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, marcel@redhat.com, alistair23@gmail.com, qemu-devel@nongnu.org

On Sat, 9 Sep 2017 17:16:57 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Sep 05, 2017 at 05:12:01PM -0700, Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > ---
> > 
> >  hw/core/machine.c   | 27 +++++++++++++++++++++++++++
> >  include/hw/boards.h |  1 +
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 41b53a17ad..de0f127d27 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -758,6 +758,33 @@ void machine_run_board_init(MachineState *machine)
> >          machine_numa_finish_init(machine);
> >      }
> >      machine_class->init(machine);
> > +
> > +    if (machine_class->valid_cpu_types && machine->cpu_model) {
> > +        const char *temp;
> > +        int i, len = machine_class->valid_cpu_types->len;  
> 
> I suggest doing this after Igor's series that replaces the
> cpu_model field (full -cpu string) with cpu_type (only the CPU
> type name).

in addition check should run before
  machine_class->init(machine);
it should be possible after cpu_model -> cpu_type refactoring is complete

[...]

> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 3363dd19fd..78678f84a9 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -172,6 +172,7 @@ struct MachineClass {
> >      int minimum_page_bits;
> >      bool has_hotpluggable_cpus;
> >      int numa_mem_align_shift;
> > +    GArray *valid_cpu_types;  
> 
> The list of CPU types for a machine are very likely to be
> statically defined at build time.  Any specific reason to not
> make it a simple char** pointer?
wile working on cpu_model, I've seen only static checks
used in some machines. So +1 to static null terminated array
[
  TYPE_FOO1,
  TYPE_FOO2,
  NULL
]

> 
> >      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
> >                                   int nb_nodes, ram_addr_t size);
> >  
> > -- 
> > 2.11.0
> >   
> 
