Received: from eggs.gnu.org ([2001:4830:134:3::10]:58053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dChyW-0006su-6T
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dChyT-0005XP-2n
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:41:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518993198.24289.7946457258780782948.stgit@bahia.lan>
	<20170520064509.GD30246@umbus.fritz.box>
	<20170521190333.49404422@bahia.lan>
Date: Mon, 22 May 2017 09:41:48 +0200
In-Reply-To: <20170521190333.49404422@bahia.lan> (Greg Kurz's message of "Sun,
	21 May 2017 19:03:33 +0200")
Message-ID: <87lgpp2v9f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/4] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Cedric Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

Greg Kurz <groug@kaod.org> writes:

> On Sat, 20 May 2017 16:45:09 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>
>> On Fri, May 19, 2017 at 12:32:12PM +0200, Greg Kurz wrote:
>> > If the user explicitely asked for kernel-irqchip support and "xics-kvm"
>> > initialization fails, we shouldn't fallback to emulated "xics" as we
>> > do now. It is also awkward to print an error message when we have an
>> > errp pointer argument.
>> > 
>> > Let's use the errp argument to report the error and let the caller decide.
>> > This simplifies the code as we don't need a local Error * here.
>> > 
>> > Signed-off-by: Greg Kurz <groug@kaod.org>  
>> 
>> Concept looks good, but..
>> 
>> > ---
>> > v2: - total rewrite
>> > ---
>> >  hw/ppc/spapr.c |   13 ++++++-------
>> >  1 file changed, 6 insertions(+), 7 deletions(-)
>> > 
>> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> > index 91f7434861a8..75e298b4c6be 100644
>> > --- a/hw/ppc/spapr.c
>> > +++ b/hw/ppc/spapr.c
>> > @@ -128,18 +128,14 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
>> >      sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
>> >  
>> >      if (kvm_enabled()) {
>> > -        Error *err = NULL;
>> > -
>> >          if (machine_kernel_irqchip_allowed(machine) &&
>> >              !xics_kvm_init(spapr, errp)) {
>> >              spapr->icp_type = TYPE_KVM_ICP;
>> > -            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs, &err);
>> > +            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs, errp);  
>> 
>> I believe there are reasons you're not supposed to just pass an errp
>> through to a subordinate function.  Instead you're supposed to have a
>> local Error * and use error_propagate().
>> 
>
> You only need to have a local Error * if it is used to check the return status
> of the function (ie, you cannot check *errp because errp could be NULL) as
> described in error.h.

Correct.  Quote:

 * Receive an error and pass it on to the caller:
 *     Error *err = NULL;
 *     foo(arg, &err);
 *     if (err) {
 *         handle the error...
 *         error_propagate(errp, err);
 *     }
 * where Error **errp is a parameter, by convention the last one.
 *
 * Do *not* "optimize" this to
 *     foo(arg, errp);
 *     if (*errp) { // WRONG!
 *         handle the error...
 *     }
 * because errp may be NULL!
 *
 * But when all you do with the error is pass it on, please use
 *     foo(arg, errp);
 * for readability.

>                       This isn't the case here but...
>
>> >          }
>> >          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
>> > -            error_reportf_err(err,
>> > -                              "kernel_irqchip requested but unavailable: ");
>> > -        } else {
>> > -            error_free(err);
>> > +            error_prepend(errp, "kernel_irqchip requested but unavailable: ");
>> > +            return;
>> >          }
>> >      }
>> >  
>> > @@ -147,6 +143,9 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
>> >          xics_spapr_init(spapr);
>> >          spapr->icp_type = TYPE_ICP;
>> >          spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs, errp);
>> > +        if (!spapr->ics) {  
>> 
>> It would also be more standard to check the returned error, rather
>> than the other result.
>> 
>
> ... if you prefer to use a local Error *, I'll gladly do that. :)

Opinions and practice vary on this one.

I prefer checking the return value because it lets me avoid the
error_propagate() boiler-plate more often.

Having both an Error parameter and an error return value begs the
question whether the two agree.

You can assert they do, but it's distracting.  We generally don't.

When there's no success value to transmit, you avoid the problem by
making the function return void.  We used to favor that, but it has
turned out not to be a success, because it leads to cumbersome code.
For what it's worth, GLib wants you to transmit success / failure in the
return value, too:

https://developer.gnome.org/glib/unstable/glib-Error-Reporting.html#gerror-rules

>> > +            return;
>> > +        }
>> >      }
>> >  }
>> >  
>> >   
>> 
