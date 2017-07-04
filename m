Received: from eggs.gnu.org ([2001:4830:134:3::10]:46936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dSKlG-0005sH-4G
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dSKlE-0006GT-Mi
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:08:50 -0400
Date: Tue, 4 Jul 2017 12:08:33 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170704100833.cvlzzeacdc4qz367@eukaryote>
References: <1498661881-9605-1-git-send-email-kchamart@redhat.com>
	<1498661881-9605-2-git-send-email-kchamart@redhat.com>
	<w51k23v5660.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51k23v5660.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 1/2] live-block-ops.txt:
 Rename, rewrite, and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stephen@that.guru, armbru@redhat.com, mreitz@redhat.com

On Thu, Jun 29, 2017 at 02:28:55PM +0200, Alberto Garcia wrote:
> On Wed 28 Jun 2017 04:58:00 PM CEST, Kashyap Chamarthy wrote:
> > +Once a 'mirror' job has started, there are two possible actions when a
> > +``drive-mirror`` job is active:
> > +
> > +1. Issuing the command ``block-job-cancel``: will, after completing
> > +   synchronization of the content from the disk image chain to the
> > +   target image, [E] -- create a point-in-time (which is at the time of
> > +   *triggering* the cancel command) copy, contained in image [E], of the
> > +   backing file.
> 
> A point-in-time [...] copy [...] of the backing file ? That would be a
> copy of the whole chain or the topmost image (depending on the sync
> mode).

Yep you're right -- it indeed copies the whole chain.  I'll fix the
wording.

Kevin also made a good point on IRC (#qemu, OFTC): "By the way, are you
sure that block-job-cancel for mirror creates a point-in-time copy when
the cancel command is issued? Shouldn't it really be when the cancel
event is emitted?"

So, I'll spell out the mention of the event.

> > +The ``"sync": "full"``, from the above, means: copy the *entire* chain
> > +to the destination.
> 
> I think it's in general a good idea to describe the different sync modes
> before doing this, because they're not completely obvious when you first
> try to use these commands.
> 
> > +Notes on ``blockdev-mirror``
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   [...]
> > +(1) Create the target image (using ``qemu-img``), say, backup.qcow2
> 
> If we're doing a mirror here, backup.qcow2 is probably not the best
> name :-)

Yeah, I'll use the 'mirror.qcow2' unless someone has a better name :-)
I actually _did_ consider naming, but stuck with "backup" because,
`mirror` is a _kind_ of a backup, too.  And "mirror" itself is a
slightly wrong name, as Stefan Hajnoczi once correcte me elsewhere: it's
synchronizing disk contents to the target, but not "live mirroring"

> > +Live disk backup --- ``drive-backup`` and ``blockdev-backup``
> > +-------------------------------------------------------------
> > +
> > +The ``drive-backup`` (and its newer equivalent ``blockdev-backup``) allows
> > +you to create a point-in-time snapshot.
> > +
> > +In this case, the point-in-time is when you *start* the ``drive-backup``
> > +(or its newer equivalent ``blockdev-backup``) command.
> > +
> > +Currently, there are four different types of synchronization modes:
> > +
> > +(1) ``full`` -- Synchronize the content of entire disk image chain to
> > +    the target
> > +(2) ``top`` -- Synchronize only the contents of the top-most disk image
> > +    in the chain to the target
> > +(3) ``none`` -- Synchronize only the new writes from this point on
> > +(4) ``incremental`` -- Synchronize content that is described by the
> > +    dirty bitmap
> 
> Here's the kind of summary of the different sync modes that I was
> talking about earlier.

I will move it to the top.  I even thought about it, but forgot to act
on it.  It makes logical sense to mention the terms on their first
occurence.

> One note about sync=none, though. If I'm not wrong drive-backup makes a
> point-in-time copy of the data at the moment when the command is issued
> (that's one difference from drive-mirror). Therefore drive-backup never
> synchronizes "new writes from this point on".
> 
> I don't think that drive-backup sync=none copies any data then, can
> anyone clarify?

Kevin clarified on IRC:

[kashyap] kwolf: When you get a moment, can you clarify Alberto's
          question on this thread:
          https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg06670.html

[kwolf] kashyap: The documentation [I think he means QAPI schema
        documentation here] isn't very clear, we should probably improve
        the comment in the schema

[kwolf] But looking at the code it seems it just disables the background
        copy, i.e. it backups only what is overwritten.

[kashyap] kwolf: Let's see if I get it: so it ('drive-backup sync=none')
          backups whatever the overwritten contents in the disk image
          chain to the target?

[kwolf] kashyap: Yes. Normally backup consists of two parts: Anything
        that is overwritten by the guest is first copied out to the
        backup, and in the background the whole image is copied start to
        end. With sync=none, it's only the first part.

> The rest of the document looks good to me, thanks!

Thanks for the review.  Much appreciated.


-- 
/kashyap
