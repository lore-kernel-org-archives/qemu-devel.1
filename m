Received: from eggs.gnu.org ([209.51.188.92]:54605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.mielke@gmail.com>) id 1gm50I-0005LO-Nd
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.mielke@gmail.com>) id 1gm50G-00082n-VV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:58:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mark.mielke@gmail.com>)
	id 1gm50G-0007pH-Mo
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:58:44 -0500
Received: by mail-wm1-x333.google.com with SMTP id m1so215921wml.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:58:36 -0800 (PST)
MIME-Version: 1.0
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
	<20190118101633.GC2146@work-vm> <20190118102102.GH20660@redhat.com>
	<328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
	<CALm7yL0nFGC1hYfvASrOL2FzO88oZURiLs-a6pR7Cjp3XS0U_g@mail.gmail.com>
	<19ec0017-bd05-a847-b211-ebbdb141ebf6@redhat.com>
In-Reply-To: <19ec0017-bd05-a847-b211-ebbdb141ebf6@redhat.com>
From: Mark Mielke <mark.mielke@gmail.com>
Date: Tue, 22 Jan 2019 17:58:23 -0500
Message-ID: <CALm7yL0bzm=P0Ruwu0ABRXL2UAtDN_o1Cyrp6WpdtWnm+ToR7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

On Fri, Jan 18, 2019 at 10:25 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 18/01/19 14:41, Mark Mielke wrote:
> > It is useful to understand the risk. However, this is the same risk we
> > have been successfully living with for several years now, and it seems
> > abrupt to declare 3.1 and 3.2 as the Qemu version beyond which migration
> > requires a whole cluster restart whether or not a L2 guest had been, or
> > will ever be started on any of the guests.
> Only if nested was enabled for the kvm_intel module.  If you didn't
> enable it, you didn't see any change with 3.1.
>

We enable it, because a number of the machines require it, and we want to
use the same cluster for both use cases.


> Nested was enabled for kvm_amd years ago.  It was a mistake, but that's
> why we didn't add such a blocker for AMD.
>

I can see how there are users out there that might have it enabled by
mistake. But, in our case we explicitly enabled it because one of the key
use cases we are addressing is a move from physical workstations to virtual
workstations, where product teams have libvirt/qemu/kvm based simulation
targets that they are required to run to develop, debug, and test.

Before this was resolved - I knew live migration with nested KVM was flaky.
I didn't know exactly why or how (although I did suspect), but it works
very well for our use cases, and we only rarely use live migration except
to upgrade hypervisors. I can also usually detect if KVM is/was/will be
used or not, and treat these machines specially (by shutting them down,
migrating them, and starting them back up, although in the past before I
recognized the severity of this problem I have done live migration and then
recommended a restart on their schedule). With the new information from
this thread and the release notes that lead me to starting this thread, I
will definitely ensure that these machines are properly shut down before
they are migrated and started back up.

But, I still need to deal with the issue of hundreds of machines which are
on the same cluster, which happen to be having the VMX bit passed through,
but will never use nested KVM. These machines can't be restarted, but
because they are shared by multiple tenants (all internal to our company -
different product teams, different owners), it will be incredibly difficult
to get buy-in for a system wide restart. It will be much easier for me to
live migrate a majority of the machines with the same level of safety as I
have today with Qemu 2.12, and then deal with the exceptions one at a time
in co-ordination with the owners. For example, if a physical machine has 20
guests on it, and 2 of those guests are using the nested KVM feature (or
will use it in future or past), then I would like to live migrate the 18 to
new machines and then contact the owners of the two machines to schedule
down time to safely move them to fully evacuate the machine and upgrade it.

We know Qemu 2.12 is broken with this configuration. That's what I am on
today. I think it verges on "ivory tower" / "purist" to say that I
absolutely should not expect to be able to live migrate to from Qemu 2.12
to Qemu 4.0 and inherit the same risk that I already have with Qemu 2.12 to
Qemu 2.12, and that a system wide restart is the only correct option.

However, I can accept that you don't want to accept responsibility for
people in this scenario, and you want them to face the problem head-on, and
not allow for blame to come back to the Qemu team, where they say "but Qemu
4.0 fixed this, right? why is it still broken after i live migrated from
Qemu 2.12?" I think this is where you are coming from? I can appreciate
that.

If so, I'd like to know whether I can locally patch Qemu 4.0 to remove the
live migration check, and whether in theory, and with my own testing, and
with me taking responsibility for my own systems and not blaming you for
anything that goes wrong, if you think with your best educated guess, that
it should probably work as well as it did with a Qemu 2.12 live migration
with the same VMX bit set, and the guests in the same state. I think I saw
somebody on this thread is already doing this for Ubuntu with Qemu 3.2?

Thanks for any insight you can provide! :-) I do appreciate it greatly!

P.S. I will ensure that every system is restarted properly. The problem is
that I need to stagger this, and not require the entire environment, or
entire hypervisors worth of hosts with multiple tenants to go down
simultaneously. I'd rather track the machines left to do, and tackle them
in groups over several months and as opportunity is available. It is more
work for me, but when it comes to choosing between interrupting product
release cycles and me spending a little more time, and us accepting
approximately the same risk we already have today - the correct business
decision needs to be made.

-- 
Mark Mielke <mark.mielke@gmail.com>
