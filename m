Received: from eggs.gnu.org ([2001:4830:134:3::10]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZFr3-0000we-6M
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZFr2-00087e-2F
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:51:41 -0500
Date: Wed, 10 Jan 2018 12:51:25 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110125125.GL3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
	<20180108175729.GI8052@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180108175729.GI8052@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, Ala Hino <ahino@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, Jan 08, 2018 at 06:57:29PM +0100, Kevin Wolf wrote:
> Am 08.01.2018 um 18:07 hat Nir Soffer geschrieben:
> > On Mon, Jan 8, 2018 at 4:48 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > 
> > > Am 05.01.2018 um 07:55 hat Fam Zheng geschrieben:
> > > > Management and users are accustomed to "qemu-img info" to query status of
> > > > images even when they are used by guests. Since image locking was added,
> > > the -U
> > > > (--force-share) option is needed for that to work. The reason has been
> > > that due
> > > > to possible race with image header update, the output can be misleading.
> > > >
> > > > But what are likely to happen after we emit the error are that, for
> > > interactive
> > > > users, '-U' will be used and the command retried; for management (nova,
> > > RHV,
> > > > etc.), the operation is broken with no knob to workaround this.
> > > >
> > > > This series changes that error to a warning so that it doesn't get in
> > > the way.
> > >
> > > Are management tools actually doing this? There is no good reason to
> > > call 'qemu-img info' for an image that is in use by a VM.
> > >
> > 
> > Yes, ovirt/RHV is using this to get the qcow2 compat of an image since 4.1.
> > 
> > We asked about this here and in private mail, and there was an
> > agreement that using qemu-img info on an image is safe for this
> > purpose. We know that accessing image header when a guest is using is
> > may be racy, but we control both the guest and the image. Nobody is
> > modifying the image properties behind our back.
> 
> Yes, it's probably safe enough, though it's clearly a case for -U rather
> than allowing it unconditionally.
> 
> > In 4.2 we will use the new flags[1], but  we cannot fix released code.
> > Introducing this locking in qemu-img info will break existing
> > installations.
> 
> We should have the proper deprecation process and printed a warning for
> two releases. Anyway, it's too late for this and now we've already had
> two releases where this was a hard error.
> 
> I'm not sure if going back to the old behaviour for a while now would be
> helpful, you'd just end up with an even more confusing set of qemu
> versions, for example:
> 
>     <= 2.9          - works without a warning
>     2.10 and 2.11   - errors out
>     2.12            - prints a warning, but works
>     >= 2.13         - errors out again

I think this is really undesirable to have 2.12 suddenly behave diferently
after 2 releases of having this change. Apps are pretty much forced to
take the change to use -U regardless because 2.10 & 2.11 are already in
the wild. Printing a warning would only be useful if we had done it in
2.10.  Now it is too late to be useful and will just confuse life even
more.

So IMHO just drop this patch.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
