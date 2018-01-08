Received: from eggs.gnu.org ([2001:4830:134:3::10]:48770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYbg6-0002cR-FX
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYbg5-0007RD-FO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:57:42 -0500
Date: Mon, 8 Jan 2018 18:57:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180108175729.GI8052@localhost.localdomain>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qemu-img: Let "info" warn
 and go ahead without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ala Hino <ahino@redhat.com>

Am 08.01.2018 um 18:07 hat Nir Soffer geschrieben:
> On Mon, Jan 8, 2018 at 4:48 PM Kevin Wolf <kwolf@redhat.com> wrote:
> 
> > Am 05.01.2018 um 07:55 hat Fam Zheng geschrieben:
> > > Management and users are accustomed to "qemu-img info" to query status of
> > > images even when they are used by guests. Since image locking was added,
> > the -U
> > > (--force-share) option is needed for that to work. The reason has been
> > that due
> > > to possible race with image header update, the output can be misleading.
> > >
> > > But what are likely to happen after we emit the error are that, for
> > interactive
> > > users, '-U' will be used and the command retried; for management (nova,
> > RHV,
> > > etc.), the operation is broken with no knob to workaround this.
> > >
> > > This series changes that error to a warning so that it doesn't get in
> > the way.
> >
> > Are management tools actually doing this? There is no good reason to
> > call 'qemu-img info' for an image that is in use by a VM.
> >
> 
> Yes, ovirt/RHV is using this to get the qcow2 compat of an image since 4.1.
> 
> We asked about this here and in private mail, and there was an
> agreement that using qemu-img info on an image is safe for this
> purpose. We know that accessing image header when a guest is using is
> may be racy, but we control both the guest and the image. Nobody is
> modifying the image properties behind our back.

Yes, it's probably safe enough, though it's clearly a case for -U rather
than allowing it unconditionally.

> In 4.2 we will use the new flags[1], but  we cannot fix released code.
> Introducing this locking in qemu-img info will break existing
> installations.

We should have the proper deprecation process and printed a warning for
two releases. Anyway, it's too late for this and now we've already had
two releases where this was a hard error.

I'm not sure if going back to the old behaviour for a while now would be
helpful, you'd just end up with an even more confusing set of qemu
versions, for example:

    <= 2.9          - works without a warning
    2.10 and 2.11   - errors out
    2.12            - prints a warning, but works
    >= 2.13         - errors out again

Is it expected that you use old oVirt versions with newer qemu versions?
If so, why didn't we already notice this with the 2.10 release?
Basically I think it's reasonable to expect that new qemu versions may
require new management versions, too. We try to stay compatible, but
sometimes that just doesn't quite work out as we'd like.

> > If no, NACK. Automatically disabling locking because it can be
> > inconvenient defeats the purpose of locking.
> >
> > If yes, clearly indicate that this usage is deprecated and we'll turn
> > this into an error again with 2.13. Then management tools can be fixed
> > in time.
> 
> 
> This will work for us in general, but I'm not sure that when 2.13 will
> be released, no user will run code assuming the previous behavior. It
> will be best to wait with incompatible changes like this to next major
> version.

qemu doesn't currently use a versioning schema that works like that. Our
deprecation policy is to print a warning for two releases before the
feature is removed or changed incompatibly.

We messed this up this time, but the two releases after the change are
already over, so chances are that nobody would have noticed the problem
in time even if we hadn't messed up.

Kevin
