Received: from eggs.gnu.org ([2001:4830:134:3::10]:33077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dxri9-0000Ft-Ti
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dxri6-0005pi-Of
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dxri6-0005pF-Ec
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:35:54 -0400
Date: Fri, 29 Sep 2017 11:35:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170929093547.GC3812@localhost.localdomain>
References: <9AA25E8890139848BAC96ED2495626F439A2EA23@DGGEML501-MBX.china.huawei.com>
	<20170928170114.GF2130@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928170114.GF2130@work-vm>
Subject: Re: [Qemu-devel] ping RE: question: I found a qemu crash about
 migration
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "wangjie (P)" <wangjie88@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, mreitz@redhat.com, quintela@redhat.com, "pbonzini@redhat.com" <pbonzini@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, "eblake@redhat.com" <eblake@redhat.com>, "berrange@redhat.com kchamart@redhat.com" <kchamart@redhat.com>, "famz@redhat.com" <famz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Am 28.09.2017 um 19:01 hat Dr. David Alan Gilbert geschrieben:
> Hi,
>   This is a 'fun' bug;  I had a good chat to kwolf about it earlier.
> A proper fix really needs to be done together with libvirt so that we
> can sequence:
>    a) The stopping of the CPU on the source
>    b) The termination of the mirroring block job
>    c) The inactivation of the block devices on the source
>        (bdrv_inactivate_all)
>    d) The activation of the block devices on the destination
>        (bdrv_invalidate_cache_all)
>    e) The start of the CPU on the destination
> 
> It looks like you're hitting a race between b/c;  we've had races
> between c/d in the past and moved the bdrv_inactivate_all.
> 
> During the discussion we ended up with two proposed solutions;
> both of them require one extra command and one extra migration
> capability.
> 
> The block way
> -------------
>    1) Add a new migration capability pause-at-complete
>    2) Add a new migration state almost-complete
>    3) After saving devices, if pause-at-complete is set,
>       transition to almost-complete
>    4) Add a new command (migration-continue) that 
>       causes the migration to inactivate the devices (c)
>       and send the final EOF to the destination.
> 
> You set pause-at-complete, wait until migrate hits almost-complete;
> cleanup the mirror job, and then do migration-continue.  When it
> completes do 'cont' on the destination.

Especially since you're concerned about the exact position of the pause,
the following would be a little safer (using the opportunity to suggest
slightly different names,too):

1) Add a new migration capability pause-at-complete
2) Add a new migration state ready
3) After migration has converged (i.e. the background phase of the
   migration has completed) and we are ready to actually switch to the
   destination, stop the VM, transition to 'ready' and emit a QMP event
4) Continue processing QMP commands in the 'ready' phase. This is where
   libvirt is supposed to tear down any running non-VM activities like
   block jobs, NBD servers, etc.
5) Add a new command (migration-complete) that does the final part of
   migration, including sending the remaining dirty memory, device state
   and the final EOF that signals the destination to resume the VM if -S
   isn't given.

The main reason why I advocate this "block way" is that it looks a lot
less hacky, but more future-proof to me. Instead of adding a one-off
hack for the problem at hand, it introduces a phase where libvirt can
cleanly tear down any activity it has still running on the source qemu.


We got away without doing this because we never did a clean handover of
resources from the source to the destination. From the perspective of a
management tool, we had these distinct phases during migration:

a) 'migrate' command:
   Source VM is still running and in control of all resources (like disk
   images), migrating some state in the background

b) Migration converges:
   Both VMs are stopped (assuming -S is given on the destination,
   otherwise this phase is skipped), the destination is in control of
   the resources

c) 'cont' command:
   Destination VM is running and in control of the resources

There is an asymmetry here because there is no phase where the VMs are
stopped, but the source is in control of the resources (this is the
additional state that my proposal introduces).

As long as we didn't really manage control of the resources with locks,
we could abuse b) for things where the source still accessed the
resources if we knew that the destination wouldn't use them yet (it's
not an assumption that I'm willing to trust too much) and it would still
kind of work in the common cases. But it's not really the correct thing
to do, it has probably always caused bugs in corner cases, and the
locking mechanisms are pointing that out now.

We're now noticing this with block device because we're using locking,
but I wouldn't be surprised if we found sooner or later that there are
more resources that should really be handed over in a cleanly designed
way and that work only by accident as long as you don't do that. So I
don't think a local hack for mirroring (or even all block jobs) is
sufficient to be future-proof.

> The migration way
> -----------------
>    1) Stop doing (d) when the destination is started with -S
>       since it happens anyway when 'cont' is issued
>    2) Add a new migration capability ext-manage-storage
>    3) When 'ext-manage-storage' is set, we don't bother doing (c)
>    4) Add a new command 'block-inactivate' on the source
> 
> You set ext-manage-storage, do the migrate and when it's finished
> clean up the block job, block-inactivate on the source, and
> then cont on the destination.

You would have to inactivate every single block node, which is not
a thing libvirt can currently do (they don't even really manage
individual nodes yet). Apart from that I believe it is much too
low-level and users shouldn't have to worry about what implications
migration has to block devices. A clean migration phase model should be
much easier to understand.

Kevin
