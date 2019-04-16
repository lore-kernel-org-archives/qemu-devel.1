Received: from eggs.gnu.org ([209.51.188.92]:52921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hGN43-0004Dn-21
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hGN41-00034E-S9
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:19:51 -0400
Date: Tue, 16 Apr 2019 14:19:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190416141942.02df6399@redhat.com>
In-Reply-To: <CAKmqyKOYif-SVvz3btkx+D9RDCFOmEaQSOR+0y4k18WLtrk3rQ@mail.gmail.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
	<20190411141848.119ee969@redhat.com>
	<CAKmqyKOQ9a5Q8c83ufCgQgsa_RdQv01dDFCLFGmiSC8mkTw0LQ@mail.gmail.com>
	<20190412103558.7be8383d@redhat.com>
	<CAKmqyKOFs8Pv4np+BXyVYGRFwLKn9N-H7q=7JN+nBprAjHBYCQ@mail.gmail.com>
	<20190415103815.35f45e99@Igors-MacBook-Pro.local>
	<CAKmqyKOYif-SVvz3btkx+D9RDCFOmEaQSOR+0y4k18WLtrk3rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 2/6] target/riscv: Fall back to
 generating a RISC-V CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@sifive.com" <palmer@sifive.com>, "ijc@hellion.org.uk" <ijc@hellion.org.uk>

On Mon, 15 Apr 2019 16:56:08 -0700
Alistair Francis <alistair23@gmail.com> wrote:

> On Mon, Apr 15, 2019 at 1:38 AM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Fri, 12 Apr 2019 14:19:16 -0700
> > Alistair Francis <alistair23@gmail.com> wrote:
> >  
> 
> ...
> 
> > > >
> > > > if it's programming error it should be assert
> > > > but in general instance_init()  should never fail.  
> > >
> > > We are checking for a user specified CPU string, not a programming
> > > error so an assert() isn't correct here.
> > >
> > > If *init() can't fail how should this be handled?  
> > typical flow for device object is
> >
> >  object_new(foo) -> foo_init_fn()
> >  set properties on foo
> >  set 'realize' property to 'true' -> foo_realize_fn()
> >
> > all checks should be performed in realize() or during property setting.  
> 
> I thought there was a reason realise didn't work, but now I can't see
> what it is. I can move it to realise.
> 
> >  
> > > > the same applies to errors or warnings within this function.
> > > >  
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    if (riscv_cpu[0] == 'r' && riscv_cpu[1] == 'v') {
> > > > > > > +        /* Starts with "rv" */
> > > > > > > +        if (riscv_cpu[2] == '3' && riscv_cpu[3] == '2') {
> > > > > > > +            valid = true;
> > > > > > > +            rvxlen = RV32;
> > > > > > > +        }
> > > > > > > +        if (riscv_cpu[2] == '6' && riscv_cpu[3] == '4') {
> > > > > > > +            valid = true;
> > > > > > > +            rvxlen = RV64;
> > > > > > > +        }
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    if (!valid) {
> > > > > > > +        error_report("'%s' does not appear to be a valid RISC-V CPU",
> > > > > > > +                     riscv_cpu);
> > > > > > > +        exit(1);
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    for (i = 4; i < strlen(riscv_cpu); i++) {
> > > > > > > +        switch (riscv_cpu[i]) {
> > > > > > > +        case 'i':
> > > > > > > +            if (target_misa & RVE) {
> > > > > > > +                error_report("I and E extensions are incompatible");
> > > > > > > +                exit(1);
> > > > > > > +            }
> > > > > > > +            target_misa |= RVI;
> > > > > > > +            continue;
> > > > > > > +        case 'e':
> > > > > > > +            if (target_misa & RVI) {
> > > > > > > +                error_report("I and E extensions are incompatible");
> > > > > > > +                exit(1);
> > > > > > > +            }
> > > > > > > +            target_misa |= RVE;
> > > > > > > +            continue;
> > > > > > > +        case 'g':
> > > > > > > +            target_misa |= RVI | RVM | RVA | RVF | RVD;
> > > > > > > +            continue;
> > > > > > > +        case 'm':
> > > > > > > +            target_misa |= RVM;
> > > > > > > +            continue;
> > > > > > > +        case 'a':
> > > > > > > +            target_misa |= RVA;
> > > > > > > +            continue;
> > > > > > > +        case 'f':
> > > > > > > +            target_misa |= RVF;
> > > > > > > +            continue;
> > > > > > > +        case 'd':
> > > > > > > +            target_misa |= RVD;
> > > > > > > +            continue;
> > > > > > > +        case 'c':
> > > > > > > +            target_misa |= RVC;
> > > > > > > +            continue;
> > > > > > > +        case 's':
> > > > > > > +            target_misa |= RVS;
> > > > > > > +            continue;
> > > > > > > +        case 'u':
> > > > > > > +            target_misa |= RVU;
> > > > > > > +            continue;
> > > > > > > +        default:
> > > > > > > +            warn_report("QEMU does not support the %c extension",
> > > > > > > +                        riscv_cpu[i]);  
> > > > that's what looks to me like fallback, and what makes
> > > > CPU features for this CPU type non deterministic.  
> > >
> > > What do you mean? QEMU will always parse the specified CPU string and
> > > create a CPU based on the features specified by the user. For each
> > > version of QEMU it will always result in the same outcome for the same
> > > user supplied command line argument.  
> >
> > I've meant that here you would print warning and happily continue parsing
> > user input ignoring input error. One should error out instead and make
> > user fix error.  
> 
> Ah, ok. I can change this one to an error.
> 
> >  
> > >
> > > Newer QEMU versions will support more features though, so they will
> > > accept different options.
> > >  
> > > > I'm not sure what you are trying to achieve here, but it look like
> > > > you are trying to verify MachineClass field in object constructor
> > > > along with other things.  
> > >
> > > I'm just trying to parse the -cpu string option.
> > >  
> > > >
> > > > I'd put all MachineClass checks in class_init and abort on error
> > > > since invalid mcc->isa_str is codding error.  
> > >
> > > No, it's a user error.  
> >
> > Parsing -cpu by assigning to class members user input looks unusual.
> >
> > We had a custom parsing for x86 & sparc cpus, but that was factored out
> > into compat utilities and we shouldn't do it anywhere else without very
> > compelling reason.  
> 
> I did see that, but it didn't seem to work the same way as this.
> 
> >
> > Currently it's preferred to use canonical form for cpu properties, like:
> >
> >   -cpu foo,prop1=x,prop2=y,...  
> 
> Yeah, but I don't see how that would work nicely.
> 
> Instead of:
>     -cpu rv64gcsu
> we would have:
>     -cpu rvgen,xlen=64,g=true,c=true,s=true,u=true
> which seems more complex for users
yes, it's clunky and verbose but it's uniform for all cpus,
which is doubly important for machine users and other interface QEMU
has to communicate with users.

secondly, adding set of symbols to cpu name (ideally it should be cpu's typename)
complicates parsing and adds one more user to the old compat hooks, which
prevents us from deprecating those.
We've put a lot of of effort in consolidating these parts across QEMU,
so adding yet another custom way to parse -cpu looks like regression to me.


> > and let the generic parser to do the job. For it to work you would need
> > to create a property per a cpu feature.
> >
> > This way it will work fine with -cpu and -device/device_add without any
> > custom parsing involved.  
> 
> Although I think it's messy for users, it is the cleanest
> implementation in terms of QOM. Maybe that will be the only solution.
I'd go for this one as it's less controversial and follows common patterns.
Human users can write a wrapper script if necessary.

> 
> Alistair
> ...
