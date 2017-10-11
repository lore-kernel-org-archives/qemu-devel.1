Received: from eggs.gnu.org ([2001:4830:134:3::10]:53946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1e2CEf-0006hr-Jq
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1e2CEb-0007HG-K5
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:19:25 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1e2CEa-0007F3-Hh
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:19:21 -0400
From: "wangjie (P)" <wangjie88@huawei.com>
Date: Wed, 11 Oct 2017 08:18:56 +0000
Message-ID: <9AA25E8890139848BAC96ED2495626F439A47577@DGGEML501-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] ping RE: ping RE: question: I found a qemu crash about
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, "eblake@redhat.com" <eblake@redhat.com>, "berrange@redhat.com kchamart@redhat.com" <kchamart@redhat.com>, "famz@redhat.com" <famz@redhat.com>

I found the real culprit, the bug begin to occur since the committed as fol=
lowing:
https://github.com/qemu/qemu/commit/e253f4b89796967d03a455d1df2ae6bda8cc7d0=
1

since the patch committed, the mirror target bs begin to use BlockBackend, =
So the mirror target bs will be inactived in bdrv_inactivate_all

why the mirror target bs not be inactived in qemu-2.6.0, but be inactived i=
n qemu-2.7.0-rc0?

-----Original Message-----
From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]=20
Sent: Monday, October 09, 2017 7:56 PM
To: Kevin Wolf <kwolf@redhat.com>
Cc: wangjie (P) <wangjie88@huawei.com>; qemu-devel@nongnu.org; mreitz@redha=
t.com; quintela@redhat.com; pbonzini@redhat.com; fuweiwei (C) <fuweiwei2@hu=
awei.com>; eblake@redhat.com; berrange@redhat.com kchamart@redhat.com <kcha=
mart@redhat.com>; famz@redhat.com
Subject: Re: ping RE: question: I found a qemu crash about migration

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 29.09.2017 um 21:06 hat Dr. David Alan Gilbert geschrieben:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > Am 28.09.2017 um 19:01 hat Dr. David Alan Gilbert geschrieben:
> > > > Hi,
> > > >   This is a 'fun' bug;  I had a good chat to kwolf about it earlier=
.
> > > > A proper fix really needs to be done together with libvirt so=20
> > > > that we can sequence:
> > > >    a) The stopping of the CPU on the source
> > > >    b) The termination of the mirroring block job
> > > >    c) The inactivation of the block devices on the source
> > > >        (bdrv_inactivate_all)
> > > >    d) The activation of the block devices on the destination
> > > >        (bdrv_invalidate_cache_all)
> > > >    e) The start of the CPU on the destination
> > > >=20
> > > > It looks like you're hitting a race between b/c;  we've had=20
> > > > races between c/d in the past and moved the bdrv_inactivate_all.
> > > >=20
> > > > During the discussion we ended up with two proposed solutions;=20
> > > > both of them require one extra command and one extra migration=20
> > > > capability.
> > > >=20
> > > > The block way
> > > > -------------
> > > >    1) Add a new migration capability pause-at-complete
> > > >    2) Add a new migration state almost-complete
> > > >    3) After saving devices, if pause-at-complete is set,
> > > >       transition to almost-complete
> > > >    4) Add a new command (migration-continue) that=20
> > > >       causes the migration to inactivate the devices (c)
> > > >       and send the final EOF to the destination.
> > > >=20
> > > > You set pause-at-complete, wait until migrate hits=20
> > > > almost-complete; cleanup the mirror job, and then do=20
> > > > migration-continue.  When it completes do 'cont' on the destination=
.
> > >=20
> > > Especially since you're concerned about the exact position of the=20
> > > pause, the following would be a little safer (using the=20
> > > opportunity to suggest slightly different names,too):
> > >=20
> > > 1) Add a new migration capability pause-at-complete
> > > 2) Add a new migration state ready
> > > 3) After migration has converged (i.e. the background phase of the
> > >    migration has completed) and we are ready to actually switch to th=
e
> > >    destination, stop the VM, transition to 'ready' and emit a QMP=20
> > > event
> > > 4) Continue processing QMP commands in the 'ready' phase. This is whe=
re
> > >    libvirt is supposed to tear down any running non-VM activities lik=
e
> > >    block jobs, NBD servers, etc.
> > > 5) Add a new command (migration-complete) that does the final part of
> > >    migration, including sending the remaining dirty memory, device st=
ate
> > >    and the final EOF that signals the destination to resume the VM if=
 -S
> > >    isn't given.
> >=20
> > What worries me here is whether some other subsection is going to=20
> > say that this pause must happen after the device state save, e.g. if=20
> > the device state save causes them to push out the last=20
> > block/packet/etc - and I've got no real way to say whether that=20
> > point is any better or worse than the point I was suggestion.
> > And the position in the cycle when the pause happens is part of the API=
.
>=20
> The important point here is that the VM is stopped. If device=20
> emulation is doing anything by itself while the VM is stopped, that is a =
bug.
> In other words, that last block/packet/etc. must already have been=20
> pushed out when we stopped the VM, so there is nothing left to push=20
> out when we save the state.
>=20
> With correctly written device code, there is no difference whether we=20
> save the device state first or last, without external influence it=20
> will be the same.
>=20
> The obvious external thing that I can see is monitor commands, e.g.=20
> the monitor allows to access I/O ports, which can change the device state=
.
> However, monitor commands are completely under the control of the=20
> user, so they can always choose the order that they need.
>=20
> In any case, saving the device state only immediately before doing the=20
> switch makes sure that we consider any changes that have still been=20
> made.
>=20
> > > The main reason why I advocate this "block way" is that it looks a=20
> > > lot less hacky, but more future-proof to me. Instead of adding a=20
> > > one-off hack for the problem at hand, it introduces a phase where=20
> > > libvirt can cleanly tear down any activity it has still running on th=
e source qemu.
> >=20
> > Yes, if we get that phase right.
> >=20
> > > We got away without doing this because we never did a clean=20
> > > handover of resources from the source to the destination. From the=20
> > > perspective of a management tool, we had these distinct phases during=
 migration:
> > >=20
> > > a) 'migrate' command:
> > >    Source VM is still running and in control of all resources (like d=
isk
> > >    images), migrating some state in the background
> > >=20
> > > b) Migration converges:
> > >    Both VMs are stopped (assuming -S is given on the destination,
> > >    otherwise this phase is skipped), the destination is in control of
> > >    the resources
> > >=20
> > > c) 'cont' command:
> > >    Destination VM is running and in control of the resources
> > >=20
> > > There is an asymmetry here because there is no phase where the VMs=20
> > > are stopped, but the source is in control of the resources (this=20
> > > is the additional state that my proposal introduces).
> > >=20
> > > As long as we didn't really manage control of the resources with=20
> > > locks, we could abuse b) for things where the source still=20
> > > accessed the resources if we knew that the destination wouldn't=20
> > > use them yet (it's not an assumption that I'm willing to trust too=20
> > > much) and it would still kind of work in the common cases. But=20
> > > it's not really the correct thing to do, it has probably always=20
> > > caused bugs in corner cases, and the locking mechanisms are pointing =
that out now.
> > >=20
> > > We're now noticing this with block device because we're using=20
> > > locking, but I wouldn't be surprised if we found sooner or later=20
> > > that there are more resources that should really be handed over in=20
> > > a cleanly designed way and that work only by accident as long as=20
> > > you don't do that. So I don't think a local hack for mirroring (or=20
> > > even all block jobs) is sufficient to be future-proof.
> >=20
> > Without the block-job we were actually pretty safe - up until the=20
> > EOF we knew the destination wouldn't start, and similarly we=20
> > wouldn't start using a device on the destination before the source=20
> > had saved that device.
>=20
> s/Without the block-job/With only the guest device/
>=20
> As long as only a guest device is using a resource, we're pretty safe,=20
> yes. This is because the VM is stopped when we actually migrate, so=20
> the user is already shut down without management tool interaction and=20
> the resource isn't actually in use at this point.
>=20
> Anything that keeps using a resource while the VM is stopped is a=20
> potential problem. Apart from block jobs, this includes at least the=20
> built-in NBD server, which also needs to be shut down before we can=20
> complete migration. And probably other things I'm forgetting right now.
>=20
> > My worry is where the edge of 'source is in control of the device=20
> > is' - is that upto the point at which the end of the device save? Befor=
e that?
> > After that? What?  It seems to be pretty arbitrary.  Unless we can=20
> > understand why it's where it is, then I'm not sure if it's a 'clean=20
> > migration phase model'.
>=20
> I can tell you where in the phase model it is: The source gives up=20
> control of the image during 'migration-complete', i.e. at the=20
> transition between the 'ready' and the 'completed' phase on the source.
>=20
> Within this transition, it's less clear where it has to be, but that's=20
> the same with its current place. I expect all of this code to stay=20
> mostly unchanged, but just called a bit later, so the place where we=20
> inactivate images today sounds like a good candidate. It's important=20
> that it's done before sending the EOF packet that triggers the=20
> destination to try and take control of the images.
>=20
> > > > The migration way
> > > > -----------------
> > > >    1) Stop doing (d) when the destination is started with -S
> > > >       since it happens anyway when 'cont' is issued
> > > >    2) Add a new migration capability ext-manage-storage
> > > >    3) When 'ext-manage-storage' is set, we don't bother doing (c)
> > > >    4) Add a new command 'block-inactivate' on the source
> > > >=20
> > > > You set ext-manage-storage, do the migrate and when it's=20
> > > > finished clean up the block job, block-inactivate on the source,=20
> > > > and then cont on the destination.
> > >=20
> > > You would have to inactivate every single block node, which is not=20
> > > a thing libvirt can currently do (they don't even really manage=20
> > > individual nodes yet). Apart from that I believe it is much too=20
> > > low-level and users shouldn't have to worry about what=20
> > > implications migration has to block devices. A clean migration=20
> > > phase model should be much easier to understand.
> >=20
> > Yep, I see that.
> > (Having said that, this extra round-trip with management is adding=20
> > extra downtime, and we'll have to work out things like what happens=20
> > if you cancel or fail in that time).
>=20
> libvirt can opt in to the additional phase only when it actually needs=20
> it.
>=20
> I'm not sure if the requirement can change while migration is already=20
> running. I don't think so currently, but if yes, we might need a way=20
> for management tools to change the capability setting after the fact.

OK, I'm going to look at doing this in the next few days.

Dave

> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
