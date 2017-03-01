Received: from eggs.gnu.org ([2001:4830:134:3::10]:54745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cj5za-000771-00
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cj5zY-0000eC-Lq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:16:37 -0500
Date: Wed, 1 Mar 2017 16:16:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170301151626.GB4799@noname.redhat.com>
References: <20170301081504.23595-1-famz@redhat.com>
	<20170301094917.GA4799@noname.redhat.com>
	<20170301123913.GA26744@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301123913.GA26744@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH RFC] block: Tolerate existing writers on
 read only BdrvChild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 01.03.2017 um 13:39 hat Fam Zheng geschrieben:
> On Wed, 03/01 10:49, Kevin Wolf wrote:
> > Am 01.03.2017 um 09:15 hat Fam Zheng geschrieben:
> > > In an ideal world, read-write access to an image is inherently
> > > exclusive, because we cannot guarantee other readers and writers a
> > > consistency view of the whole image at all point. That's what the
> > > current permission system does, and it is okay as long as it is entirely
> > > internal. But that would change with the coming image locking. In
> > > practice, both end users and our test cases use tools like qemu-img and
> > > qemu-io to peek at images while guest is running.
> > > 
> > > Relax a bit and accept other writers in this case.
> > > 
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > 
> > Hm. On the one hand I think you're right that people are using things
> > like this, on other hand it's also true that the result might not be
> > consistent and therefore image locking is right about forbidding these
> > actions.
> > 
> > I think your patch is too permissive, it allows even launching a second
> > long-running VM on the image, which will definitely see corrupted data
> > sooner or later.
> > 
> > Maybe what we can do is allow shared writers for read-only images if
> > CONSISTENT_READ isn't requested. It's still not 100% correct because we
> > can get inconsistent metadata and cause unexpected failure, but this is
> > probably tolerable. We would then have to change the allowed actions to
> > not request this permission.
> > 
> > In qemu-img, we have these read-only users:
> > [...]
> > 
> > So the list of subcommands where we want to support it is rather short.
> > We can change blk_new_open() to clear CONSISTENT_READ for BDRV_O_NOIO,
> > which could cover 'info' and 'snapshot -l'.
> > 
> > That leaves us with qemu-io, 'convert -s' and 'map', all of which can be
> > imagined to be useful even with a running VM, but all of which can also
> > easily produce wrong results in this case. An explicit command line
> > option to disable CONSISTENT_READ might be the right tool here.
> 
> I'm not sure about this because: 1) this is intrusive from a user PoV, many
> scripts and upper layer tools will stop working;

Are you sure? I don't expect user scripts or even proper management
tools to use qemu-io on running VMs. I do expect that some users are
using 'convert -s' with running VMs despite our recommendation against
it.

If they are aware that they're doing something that works only in the
right circumstances, then breaking it isn't nice. But my gut feeling is
that most of them don't know about the implications of accessing a live
image. In this case breaking their use case and making them think about
whether they want to add something like a --force option sounds like a
good thing because they aren't caught by surprise when things go wrong
eventually.

> 2) CONSISTENT_READ is enforced by qcow2 in its .bdrv_child_perm
> implementation even if blk_new_open() doesn't ask for it, therefore
> such an option has to impact the whole graph;

Yes, the perm |= CONSISTENT_READ statement would become conditional as
well so that it isn't set if all parents are read-only and don't need
CONSISTENT_READ themselves.

This is strictly speaking wrong, but after all the whole point of the
change would be to allow things that are strictly speaking wrong.

> 3) this isn't only about asking for "persistent read" perm, but more
> about granting "write" in shared_perm, so it feels messy.

Yes, exceptions make everything messy.

> A perhaps more contained way is to add a BDRV_O_RELAXED_LOCK flag and
> use it in those subcommands, then in the image locking code, the "no
> other writer" byte is not locked if it's set. This has a simpler
> semantic and a more manageable scope.

No new flags, please (at least none that are used in places deeper than
blk_new_open()).

I'm also not sure whether applying different rules within qemu and
externally is a really good idea. If an external process can open an
image read-only, why wouldn't it be possible internally?

Kevin
