Received: from eggs.gnu.org ([2001:4830:134:3::10]:53124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCpIB-0001Aq-GR
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCpI7-0001gi-IM
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:02:59 -0500
Date: Thu, 9 Nov 2017 16:02:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171109160222.GK18164@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171102120223.GI32533@redhat.com>
	<50b7935f-c02f-7d7d-4e8e-fc8967e85d2e@redhat.com>
	<87h8u3ftgk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h8u3ftgk.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Thu, Nov 09, 2017 at 02:54:35PM +0100, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
> 
> > On 2017-11-02 13:02, Daniel P. Berrange wrote:
> > [...]
> >> One alternative approach to doing this would be to suggest that we should
> >> instead just spawn qemu-system-x86_64 with '--machine none' and use that
> >> as a replacement for qemu-nbd, since it already has a built-in NBD server
> >> which can do many exports at once and arbitrary block jobs.
> >
> > As far as I know, we had wanted to add QMP support to qemu-nbd maybe one
> > or two years ago, but nobody ever did it.
> >
> > I've had some discussions about this with Markus and Kevin at KVM Forum.
> >  They appeared to strongly prefer this approach.  I agree with them that
> > design-wise, a qemu with no machine at all (and not even -M none) and
> > early QMP is the way we want to go anyway, and then this would be the
> > correct tool to use.
> 
> "Strongly" is perhaps a bit strong, at least as far as I'm concerned.  I
> just believe that we want the capability to run QEMU without a machine
> anyway, and if that's good enough, then why bother duplicating so much
> of qemu-system-FOO in qemu-nbd & friends?  Besides, once you start to
> duplicate, you'll likely find it hard to stop.
> 
> >> I'm concerned that this could end up being a be a game of whack-a-mole
> >> though, constantly trying to cut out/down all the bits of system emulation
> >> in the machine emulators to get its resource overhead to match the low
> >> overhead of standalone qemu-nbd.
> >
> > However, I personally share your concern.  Especially, I think that
> > getting to a point where we can have no machine at all and early QMP
> > will take much longer than just adding QMP to qemu-nbd -- or adding a
> > qmp command to qemu-img (because you can add NBD exports through QMP, so
> > qemu-nbd's hardcoded focus on NBD exports seems kind of weird then)[1].
> >
> > I'm very much torn here.  There are two approaches: Stripping fat qemu
> > down, or fattening lean qemu-img (?) up.  The latter is very simple.
> 
> "Very simple" is perhaps debatable, but I think we can agree on
> "temptingly simple".

My other concern with using QEMU system emulator binary is that even
if you make it possible to run it with no guest machine instantiated,
it is still a massive binary containing all the stuff you get with a
QEMU system emulator. To be able to lock down the security of this
QEMU to the same level that we could do with qemu-nbd will take even
more work than we would already have todo to make "no machine" be
possible. Even then getting the right security level would require
the invoker to enable the right magic combo of options. And then we
would also need full QEMU backend modularization to be done so that
we could have a binary for serving NBD which didn't pull in irrelevant
stuff like SPICE, GTK & Xorg libraries. This just all sounds like we
are queuing up unfeasibly large amounts of work, alot of which we've
talked about for 10 years and still not been any to make a step forward
on impl.

It feels like the key important factor is to avoid re-inventing the
wheel in multiple places. I don't think this implies that we need to
have a single binary for doing two completely separate tasks. On the
qemu-nbd side it should basically involve assembling building blocks
that we already have available through the QEMU code base. The block
layer is already well isolated & reusable, as evidenced by fact that
it is used across many programs already with little code duplication.
In theory the QMP monitor is fairly well isolated, since we already
reuse the infra for the QEMU guest agent too. For qemu-nbd we could
reuse even more than with the guest agent, since we can pull in some
of the actual command impls for sharing. There's doubtless still
some refactoring to QMP to make it possible, but its no where near
the kind of scope we'd be looking at to take the QEMU system emulator
and enable a "no machine" startup, make it secure by default and
modularize all its dependancies.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
