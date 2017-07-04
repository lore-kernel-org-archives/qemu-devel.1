Received: from eggs.gnu.org ([2001:4830:134:3::10]:56250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dSQ2O-0006Dy-Bn
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dSQ2M-00073a-P5
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:46:52 -0400
Date: Tue, 4 Jul 2017 17:46:40 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170704154640.pb7ldjvnh32nmdai@eukaryote>
References: <1498661881-9605-1-git-send-email-kchamart@redhat.com>
	<1498661881-9605-2-git-send-email-kchamart@redhat.com>
	<w51fuejq36o.fsf@maestria.local.igalia.com>
	<f55056ef-6da8-09d3-a11a-0c97c3fc21ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55056ef-6da8-09d3-a11a-0c97c3fc21ca@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, kwolf@redhat.com, stephen@that.guru, armbru@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Wed, Jun 28, 2017 at 03:33:49PM -0500, Eric Blake wrote:
> On 06/28/2017 03:15 PM, Alberto Garcia wrote:
> > On Wed 28 Jun 2017 04:58:00 PM CEST, Kashyap Chamarthy wrote:
> >> This patch documents (including their QMP invocations) all the four
> >> major kinds of live block operations:
> >>
> >>   - `block-stream`
> >>   - `block-commit`
> >>   - `drive-mirror` (& `blockdev-mirror`)
> >>   - `drive-backup` (& `blockdev-backup`)
> > 
> > This is excellent work, thanks for doing this!

Thanks!

> > I haven't had the time to review the complete document yet, but here are
> > my comments from the first half:

[I'm responding out of order -- as I first replied to your other email,
which gave feedback about the sceond half.]

> >> +Disk image backing chain notation
> >> +---------------------------------
> >   [...]
> >> +.. important::
> >> +    The base disk image can be raw format; however, all the overlay
> >> +    files must be of QCOW2 format.
> > 
> > This is not quite like that: overlay files must be in a format that
> > supports backing files. QCOW2 is the most common one, but there are
> > others (qed). Grep for 'supports_backing' in the source code.
> 
> At the same time, other image formats are not as frequently tested, or
> may be read-only.  Maybe a compromise of "The overlay files can
> generally be any format that supports a backing file, although qcow2 is
> the preferred format and the one used in this document".

Yes, I'll use Eric's wording [thanks] here, that makes the intent
clearer.

> >> +(1) ``block-stream``: Live copy of data from backing files into overlay
> >> +    files (with the optional goal of removing the backing file from the
> >> +    chain).
> > 
> > optional? The backing file is removed from the chain as soon as the
> > operation finishes, although the image file is not removed from the
> > disk. Maybe you meant that?
>
> Hmm, you're right. In this case, qemu ALWAYS rewrites the backing chain
> to get rid of the (now-streamed) backing image.

Correct.  I will clarify the wording here.

> >> +(2) ``block-commit``: Live merge of data from overlay files into backing
> >> +    files (with the optional goal of removing the overlay file from the
> >> +    chain).  Since QEMU 2.0, this includes "active ``block-commit``"
> >> +    (i.e.  merge the current active layer into the base image).
> > 
> > Same question about the 'optional' here.
> 
> Here, optional is a bit more correct. With non-active (intermediate)
> commit, qemu ALWAYS rewrites the backing chain to be shorter; but with
> live commit, you can chose whether to pivot to the now-shorter chain
> (job-complete) or whether to keep the active image intact (starting to
> collect a new delta from the point-in-time of the just-completed commit,
> by job-cancel).

Right.  I'll workout a way to mention this, too.  [Me will not wonder
whether it will confuse the reader about mentioning it so early -- as
the said reader will be using these primitives to make higher level
tools, and they can easily figure out the semantics.]
 
> >> +writing to it.  (The rule of thumb is: live QEMU will always be pointing
> >> +to the right-most image in a disk image chain.)
> > 
> > I think it's 'rightmost', without the hyphen.
> 
> Sadly, I think this is one case where both spellings work to a native
> reader, and where I don't know of a specific style-guide preference.  I
> probably would have written with the hyphen.

Heh, indeed.  Peter Maydell has said Oxford English Dictionary has
mentions for both variants.  But Alberto is correct that the non-hyphen
variant, "rightmost", is much more widely used.

> >> +(3) Intermediate streaming (available since QEMU 2.8): Starting afresh
> >> +    with the original example disk image chain, with a total of four
> >> +    images, it is possible to copy contents from image [B] into image
> >> +    [C].  Once the copy is finished, image [B] can now be (optionally)
> >> +    discarded; and the backing file pointer of image [C] will be
> >> +    adjusted to point to [A].
> > 
> > The 'optional' usage again. [B] will be removed from the chain and can
> > be (optionally) removed from the disk, but that you have to do yourself,
> > QEMU won't do that.
> 
> Indeed, we may need to be specifically clear of the cases where qemu
> shortens the chain, but where disk images that are no longer used by the
> chain (whether they are still viable [as in stream], or invalidated [as
> in commit crossing more than one element of the chain]) are still left
> on the disk for the user to discard separately from qemu.

Yes, I'll keep this in mind for v5.

> >> +The ``block-commit`` command lets you to live merge data from overlay
> >> +images into backing file(s).
> > 
> > I don't think "lets you to live merge data" is correct English.
> 
> Probably better as "lets you merge live data from overlay..."

Yes.  Will fix.

[...]

> >> +(1) Commit content from only image [B] into image [A].  The resulting
> >> +    chain is the following, where image [C] is adjusted to point at [A]
> >> +    as its new backing file::
> >> +
> >> +        [A] <-- [C] <-- [D]
> >> +
> >> +(2) Commit content from images [B] and [C] into image [A].  The
> >> +    resulting chain, where image [D] is adjusted to point to image [A]
> >> +    as its new backing file::
> >> +
> >> +        [A] <-- [D]
> > 
> > Aren't these two just different variants of the same case?
> 
> Almost. But in case 1, image [B] is still viable (from a guest point of
> view, the contents of [B] have not changed); in case 2, image [B] is
> most likely corrupted (any changes propagated from [C] into [A] that
> were not already overridden in [B] now read differently, making image
> [B] no longer match anything the guest ever saw at any point in past time).

Indeed.  Good explanation.  (I now wonder if I should workout a way to
mention some comments from the guest POV)

> >> +.. _`block-commit_Case-3`:
> >> +
> >> +(3) Commit content from images [B], [C], and the active layer [D] into
> >> +    image [A].  The resulting chain (in this case, a consolidated single
> >> +    image)::
> >> +
> >> +        [A]
> >> +
> >> +(4) Commit content from image only image [C] into image [B].  The
> >> +    resulting chain::
> >> +
> >> +	[A] <-- [B] <-- [D]
> >> +
> >> +(5) Commit content from image [C] and the active layer [D] into image
> >> +    [B].  The resulting chain::
> >> +
> >> +	[A] <-- [B]
> > 
> > Same here.
> 
> 4 and 5 indeed are variants of 1 and 2.
> 
> > 
> > I mean, it's fine to have several different examples, but I think
> > there's really two main cases here (as you correctly explain later).

True; I just spelled out all possible cases for one primitive.  for the
rest, I didn't -- as mentioned in a note.

> > 
> >> +    (QEMU) block-commit device=node-D base=a.qcow2 top=d.qcow2 job-id=job0
> >> +    {
> >> +        "execute": "block-commit",
> >> +        "arguments": {
> >> +            "device": "node-D",
> >> +            "job-id": "job0",
> >> +            "top": "d.qcow2",
> >> +            "base": "a.qcow2"
> >> +        }
> >> +    }
> > 
> > This is correct, but I don't know if it's worth mentioning that if you
> > omit the 'top' parameter it defaults to the active layer (node-D in this
> > example).
> 
> I think it's better to be explicit in the examples (always provide all
> parameters, even if what you provide would also be the default when
> omitted), and then maybe the prose can mention which parameters have
> defaults.

Yeah, precisely -- I didn't wanted to skip mentioning something just
because it's the default, for clarity's sake.
> > 
> > Same with 'base'.
> > 
> > Else this part looks good! I'll check the rest of the document tomorrow
> > and give you my feedback.

Thanks, Alberto and Eric.  I'll spin a v5 from this, and feedback from
the other email.

[...]

-- 
/kashyap
