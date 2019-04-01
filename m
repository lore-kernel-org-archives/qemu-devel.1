Received: from eggs.gnu.org ([209.51.188.92]:38011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAqNq-0006zH-SZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAqNp-0004Uj-0P
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:25:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hAqNn-0004Sv-1y
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:25:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190327150347.8974-1-armbru@redhat.com>
	<20190327150347.8974-2-armbru@redhat.com>
	<20190329142706.4bfb524e@redhat.com>
	<87o95thhpo.fsf@dusky.pond.sub.org>
	<20190329162526.3b531e4d@redhat.com>
	<87wokhd0q7.fsf@dusky.pond.sub.org>
Date: Mon, 01 Apr 2019 08:25:15 +0200
In-Reply-To: <87wokhd0q7.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 29 Mar 2019 18:55:28 +0100")
Message-ID: <871s2m44z8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Fix to create accel compat props
 before migration object again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: anthony.perard@citrix.com, qemu-devel@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Igor Mammedov <imammedo@redhat.com> writes:
>
>> On Fri, 29 Mar 2019 15:34:59 +0100
>> Markus Armbruster <armbru@redhat.com> wrote:
>>
>>> Igor Mammedov <imammedo@redhat.com> writes:
>>> 
>>> > On Wed, 27 Mar 2019 16:03:46 +0100
>>> > Markus Armbruster <armbru@redhat.com> wrote:
>>> >  
>>> >> Recent commit cda4aa9a5a0 moved block backend creation before machine
>>> >> property evaluation.  This broke block backends registering migration
>>> >> blockers.  Commit e60483f2f84 fixed it by moving migration object
>>> >> creation before block backend creation.  This broke migration with
>>> >> Xen.  Turns out we need to configure the accelerator before we create
>>> >> the migration object so that Xen's accelerator compat properties get
>>> >> applied.  Fix by calling configure_accelerator() earlier, right before
>>> >> migration_object_init().
>>> >> 
>>> >> Fixes: e60483f2f8498ae08ae79ca4c6fb03a3317f5e1e
>>> >> Reported-by: Anthony PERARD <anthony.perard@citrix.com>
>>> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> >> ---
>>> >>  vl.c | 8 ++++++--
>>> >>  1 file changed, 6 insertions(+), 2 deletions(-)
>>> >> 
>>> >> diff --git a/vl.c b/vl.c
>>> >> index d61d5604e5..28b9e9a170 100644
>>> >> --- a/vl.c
>>> >> +++ b/vl.c
>>> >> @@ -4276,6 +4276,12 @@ int main(int argc, char **argv, char **envp)
>>> >>          exit(0);
>>> >>      }
>>> >>  
>>> >> +    /*
>>> >> +     * Must run before migration_object_init() to make Xen's
>>> >> +     * accelerator compat properties stick
>>> >> +     */
>>> >> +    configure_accelerator(current_machine, argv[0]);
>>> >> +  
>>> > Setting machine properties with this change happens after
>>> > accelerator was initialized.
>>> >
>>> > It probably will break initialization of accelerator features
>>> > (to name a couple kernel-irqchip, memory-encryption) that depend
>>> > on machine properties being set before accelerator is initialized.  
>>> 
>>> I'm blind.  Can you suggest a potential reproducer for me to try?
>> sure (it' difficult to move things around in vl.c and spot implicit
>> dependency or not to break something while at it)
>>
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 241db49..9b0d89a 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -1724,6 +1724,7 @@ static int kvm_init(MachineState *ms)
>>      }
>>  
>>      if (machine_kernel_irqchip_allowed(ms)) {
>> +fprintf(stderr, "kvm_irqchip_create\n");
>>          kvm_irqchip_create(ms, s);
>>      }
>>
>> with:
>>
>> qemu-system-x86_64 -machine accel=kvm,kernel-irqchip=off
>>
>> prints "kvm_irqchip_create" after patch and doesn't with current master
>
> Now I see.  Thank you!
>
> machine_kernel_irqchip_allowed(m) returns m->kernel_irqchip_allowed.
> machine_initfn() sets the default value, true.  -machine
> kernel-irqchip=off sets it to false.
>
> To make the latter stick, kvm_init() must run after
> machine_set_property().
>
> kvm_init() is AccelClass method init_machine(), called by
> configure_accelerator() via accel_init_machine().
>
> We have a depencency cycle:
>
>     configure_accelerator()
>     before migration_object_init()
>         to make Xen's accel compat props stick
>     before configure_blockdev()
>         so we can create migration blockers
>     before machine_set_property()
>         so machine props can refer to blockdevs
>     before configure_accelerator()
>         to make -machine kvm-irqchip=off and similar stick
>
> To break it, we need to split one of them.
>
> I've long had a queasy feeling about configure_accelerator().  It needs
> to run early so accelerator properties work, and it needs to run late so
> it can use machine properties.
>
> Can we split it into
>
>     part 1: runs early, can fail, can't use machine properties
>     part 2: runs late, can't fail, can use machine properties
>
> ?

Too risky for 4.0.

> If we can't, or can't for 4.0, then I guess we need to split
> migration_object_init() along similar lines:
>
>     part 1: runs early, makes migration blockers usable,
>             can't use migration properties
>     part 2: runs late, can use migration properties

No dice: what we need to make migration blockers usable is the exactly
what may only run after configure_accelerator(): object_new().

We need to decouple migration blockers from the migration object.  I'll
post patches later today.
