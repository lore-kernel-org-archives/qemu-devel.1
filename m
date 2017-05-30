Received: from eggs.gnu.org ([2001:4830:134:3::10]:46409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dFnh6-00048q-5s
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dFnh4-000379-6Q
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:24:44 -0400
Date: Tue, 30 May 2017 22:24:28 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170530202428.vtz3f6jopr74huzb@eukaryote>
References: <1496158724-2809-1-git-send-email-kchamart@redhat.com>
	<df3d406e-d9e2-73e0-4943-23fac349c1b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3d406e-d9e2-73e0-4943-23fac349c1b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] live-block-ops.txt: Rewrite and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

First, thanks for the quick feedback!

On Tue, May 30, 2017 at 02:24:40PM -0500, Eric Blake wrote:
> On 05/30/2017 10:38 AM, Kashyap Chamarthy wrote:
> > This edition documents all four operations:

[...]

> s/occurance/occurrence/
> 
> >     use raw JSON; for subsequent occurances, use 'qmp-shell', with an
> 
> s/occurances/occurrences/

Will address, both.  Sigh, I first ran it through GNU `aspell`, but
forgot to have to save the typo corrections.

> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---
> > * An HTML rendered version is here:
> >   https://kashyapc.fedorapeople.org/virt/qemu/live-block-operations.html
> 
> Helpful; thanks!
> 
> > diff --git a/docs/live-block-operations.rst b/docs/live-block-operations.rst
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..19107776cd1edd20fac17ddda192d677199190d9
> > --- /dev/null
> > +++ b/docs/live-block-operations.rst
> > @@ -0,0 +1,757 @@
> > +============================
> > +Live Block Device Operations
> > +============================
> 
> Is it worth mentioning a copyright/license in this prologue?  It's not
> mandatory (you get the default of GPLv2+ based on the top-level if you
> don't do it), but being explicit never hurts.

Good point, I add the boilerplate copyright / license text.
 
> > +
> > +Table of Contents
> > +=================
> > +
> > +(1) `Disk image backing chain notation`_
> > +(2) `Brief overview of live block QMP primitives`_
> > +(3) `Interacting with a QEMU instance`_
> > +(4) `Example disk image chain`_
> > +(5) `A note on points-in-time vs file names`_
> > +(6) `Live block streaming -- `block-stream``_
> > +(7) `QMP invocation for `block-stream``_
> > +(8) `Live block commit -- `block-commit``_
> > +(9) `QMP invocation for `block-commit``_
> > +(10) `Live disk synchronization -- `drive-mirror`&`blockdev-mirror``_
> > +(11) `QMP invocation for `drive-mirror``_
> > +(12) `Notes on `blockdev-mirror``_
> > +(13) `Live disk backup -- `drive-backup`&`blockdev-backup``_
> > +(14) `QMP invocation for `drive-backup``_
> > +(15) `Notes on `blockdev-backup``_
> > +
> 
> Does .rst have any mechanisms for ensuring the ToC doesn't get out of
> sync if we later change sections around?

Hmm, good question, I don't know such a mechanism exists yet, I think it
will get out of sync; will check.  But if we _do_ rearrange, it's
trivial to fix it.  But I see where you're coming from.

> > +
> > +.. _`Disk image backing chain notation`:
> > +
> 
> > +
> > +Arrow to be read as: Image [A] is the backing file of disk image [B].
> 
> Maybe: "The arrow can be read as:"

Yes, will fix.

> > +And live QEMU is currently writing to image [B], consequently, it is
> > +also referred to as the "active layer".
> > +
> > +There are two kinds of terminology that is common when referring to
> 
> s/that is common/that are common/

Likewise.

[...]

> > +- `block-stream`: Live copy data from overlay files into backing images.
> 
> Backwards.  This is a live copy of data from backing images into
> overlays (with the optional goal of removing the backing image from the
> chain).

Err, indeed.  Will fix.

> > +
> > +- `block-commit`: Live merge data from backing files into overlay
> > +  images.  Since QEMU 2.0, this includes "active `block-commit`" (i.e.
> > +  merge the current active layer into the base image).
> 
> Backwards.  This is live merge of data from overlay images into backing
> images (with the optional goal of removing the overlay image from the
> chain).

Yes, again, will fix.

[...]

> > +Interacting with a QEMU instance
> > +--------------------------------
> > +
> > +To show some example invocations of command-line, we shall use the
> 
> 'shall' is okay, but sounds rather formal; using 'will' sounds more typical.

Funny you mention, I actually _began_ with "will", but think my
subconscious self 'overwrote' it with "shall", as I was reading a book
("The Blind Watchmaker") which was using "shall" throughout.  Probably
that had an influence. :-)

> > +following invocation of QEMU, with a QMP server running over UNIX
> > +socket:
> > +
> > +.. code-block::
> > +
> > +    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \
> > +        -M q35 -nodefaults -m 512 \
> > +        -blockdev node-name=node-A,driver=qcow2,file.driver=file,file.filename=./a.qcow2 \
> > +        -device virtio-blk,drive=node-A,id=virtio0 \
> > +        -monitor stdio -qmp unix:/tmp/qmp-sock,server,nowait
> 
> Nice use of -blockdev! 

I was conscious to use the latest upstream preferences, regardless
whether they're used by higher layers.

> Is it worth also giving file.node-name for a
> non-generated node name on the protocol layer?

Hmm, if I had to guess, you say the above for completeness' sake.
Because, IIRC, the 'node-name; at the protocol layer will come in handy
when doing things like IOPS throttling (for which

Do you have a preferred `-blockdev` invocation?

> > +
> > +The `-blockdev` command-line option, used above, is available from QEMU
> > +2.9 onwards.  In the above invocation, notice the 'node-name' parameter
> > +that is used to refer to the disk image a.qcow2 ('node-A') -- this is a
> > +cleaner way to refer to a disk image (as opposed to referring to it by
> > +spelling out file paths).  So, we shall continue to designate a
> > +'node-name' to each further disk image created (either via
> > +`blockdev-snapshot-sync`, or `blockdev-add`) as part of the disk image
> > +chain, and continue to refer to the disks using their 'node-name' (where
> > +possible, because `block-stream`, and `block-commit` do not yet, as of
> > +QEMU 2.9, take 'node-name' parameters) when performing various block
> > +operations.
> > +
> > +To interact with the QEMU instance launched above, we shall use the
> 
> Again, shall vs. will.  Probably a recurring comment.

Yeah, I tried to remain consistent.  I shall replace it with "will". :-)

[...]

> > +Live block commit (`block-commit`)
> > +----------------------------------
> > +
> > +The `block-commit` command lets you to live merge data from overlay
> 
> s/to live/do a live/
> 
> > +images into backing file(s).  Since QEMU 2.0, this includes "live active
> > +commit" (i.e. it is possible to merge the "active layer", the right-most
> > +image in a disk image chain where live QEMU will be writing to, into the
> > +base image).  This is analogous to `block-stream`, but in opposite
> > +direction.
> > +
> > +Continuing with our example disk image chain, where live QEMU is writing
> 
> Is it really continuing with the example, or re-starting from the
> original setup? (Continuing sort of implies that you run the previous
> section first, then this section on the result of the previous section -
> but then you no longer have the 4-image chain that you get by re-starting).

Good catch.  I actually meant: "Starting afresh, with our example disk
image chain".  I will reword it accordingly.  (Should also have to
correct it later.)

> > +to the right-most image in the chain, [D]:
> > +
> > +.. code-block::
> > +
> > +    [A] <-- [B] <-- [C] <-- [D]
> > +
> > +The disk image chain can be shortened in one of the following ways:
> > +
> > +(1) Commit content from only image [B] into image [A].  The resulting
> > +    chain is the following, where the backing file for [D] is adjusted
> > +    to point at [C]:
> 
> Image [D] had no adjustment. Rather, image [C] now points at [A] as its
> new backing.

Yes, correct.  I will fix it.

> > +
> > +    .. code-block::
> > +
> > +        [A] <-- [C] <-- [D]
> > +
> > +(2) Commit content from images [B] and [C] into image [A].  The
> > +    resulting chain:
> > +
> > +    .. code-block::
> > +
> > +        [A] <-- [D]
> 
> Now image [D] is updated to point to [A].

Yes, I will spell that out.

> 
> > +QMP invocation for `block-commit`
> > +---------------------------------
> > +
> > +For case (1), from the previous section -- merge contents only from
> > +image [B] into image [A], the invocation is as following:
> > +
> > +.. code-block::
> > +
> > +    (QEMU) block-commit device=node-D base=a.qcow2 top=b.qcow2 job-id=job0
> > +    {
> > +        "execute": "block-commit",
> > +        "arguments": {
> > +            "device": "node-D",
> > +            "job-id": "job0",
> > +            "top": "b.qcow2",
> > +            "base": "a.qcow2"
> > +        }
> > +    }
> > +
> > +Once the above `block-commit` operation has completed, a
> > +`BLOCK_JOB_COMPLETED` event will be issued, and no further action is
> > +required.  The end result being, the backing file of image [D] is
> > +adjusted to point to image [B], and the original disk image chain will
> > +end up being transformed to:
> > +
> > +.. code-block::
> > +
> > +    [A] <-- [B] <-- [D]
> 
> Doesn't match your description of bullet 1) above.  You are committing B
> into A, which means the overlay of B (in this case C) gets rewritten to
> point to the new base, and your end chain is [A] <-- [C] <-- [D]

Oops, indeed.  I will fix it.  I inadvertently mixed them up.

> > +
> > +NB: The intermdiate image [C] is invalid (as in: no more further
> > +overlays based on it can be created) and, therefore, should be dropped.
> 
> You are correct that the image dropped in this manner no longer
> corresponds to actual guest contents - but it should be [B] that is
> invalidated.

Yes, will fix.

[...]

> 
> > +However, case (3), the "active `block-commit`", is a *two-phase*
> > +operation: in the first phase, the content from the active overlay,
> > +along with the intermediate overlays, is copied into the backing file
> > +(also called, the base image); in the second phase, adjust the said
> > +backing file as the current active image -- possible via issuing the
> > +command `block-job-complete`.  [Optionally, the operation can be
> > +cancelled, by issuing the command `block-job-cancel`, but be careful
> > +when doing this.]
> > +
> 
> Stupid US vs. UK spelling of canceled/cancelled.  I honestly don't care
> which variant you pick.

I will stick with the UK-variant, as I grew up learning the UK English
:-)

> > +
> > +    (QEMU) block-commit device=node-D base=a.qcow2 top=d.qcow2 job-id=job0
> > +    {
> 
> > +
> > +Once the synchronization has completed, the event `BLOCK_JOB_READY` will
> > +be emitted
> 
> Trailing '.'?

Yes.

> 
> > +Finally, once the above job is completed, an event `BLOCK_JOB_COMPLETED`
> > +will be emitted.
> > +
> > +[The invocation for rest of all the cases, discussed in the previous
> > +setion, is omitted for brevity.]
> 
> s/setion/section/
> 
> > +
> > +
> > +.. _`Live disk synchronization -- `drive-mirror`&`blockdev-mirror``:
> > +
> 
> You show the sync=full version, but not a shallow mirror (only the
> active layer is mirrored; the destination must already have the contents
> of the backing chain visible via other means, whether by 'cp' or by some
> storage-array-specific command).  Since libvirt storage migration uses
> NBD disks on the destination with shallow drive-mirror on the source,
> that is a common enough setup that it is worth documenting.

Yeah, I considered it, but felt: "Hmm, am I making it too long?"

But you're very correct in pointing it out.  What's the use of
documenting it, if I'm not mentioning one of the most common scenarios.

I will work something out.

> 
> > +.. _`Live disk backup -- `drive-backup`&`blockdev-backup``:
> > +
> > +Live disk backup (`drive-backup` & `blockdev-backup`)
> > +-----------------------------------------------------
> > +
> 
> It may be worth documenting incremental backup policies here (I'm not
> sure if we have it documented elsewhere in the tree).  John may have
> better pointers to material on that.

I thought about it briefly, but realized John is more qualified for it,
and he has written the following document (which probably needs
updating, and also probably rework it to use reStructuredText -- not
because, it's my preference, but upstream QEMU seems to want to
consolidate on it, as I noted in my commit message).

https://github.com/qemu/qemu/blob/master/docs/bitmaps.md

I will make it a TODO item.  Meanwhile, maybe John might chime in to
comment here.

> Several things to fix, but it looks nice overall.  Looking forward to v2.

Sure.

Thanks for the quick feedback!  I appreciate the grammar (and, of
course the core content) corrections.

---

Eric, do you have an opinion:  Now that I _do_ have the notes
available[*], do you think it is worth spelling out the invocation for
QMP `blockdev-{backup, mirror}`?  Or wait for later?

Thanks.

[*]
https://kashyapc.fedorapeople.org/virt/qemu/blockdev-backup-and-mirror.html#qmp-invocation-for-blockdev-backup


[...]

-- 
/kashyap
