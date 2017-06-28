Received: from eggs.gnu.org ([2001:4830:134:3::10]:33543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQJN8-0006o4-RB
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQJN5-0005qM-Js
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:15:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1498661881-9605-2-git-send-email-kchamart@redhat.com>
References: <1498661881-9605-1-git-send-email-kchamart@redhat.com>
	<1498661881-9605-2-git-send-email-kchamart@redhat.com>
Date: Wed, 28 Jun 2017 22:15:27 +0200
Message-ID: <w51fuejq36o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stephen@that.guru, armbru@redhat.com, mreitz@redhat.com

On Wed 28 Jun 2017 04:58:00 PM CEST, Kashyap Chamarthy wrote:
> This patch documents (including their QMP invocations) all the four
> major kinds of live block operations:
>
>   - `block-stream`
>   - `block-commit`
>   - `drive-mirror` (& `blockdev-mirror`)
>   - `drive-backup` (& `blockdev-backup`)

This is excellent work, thanks for doing this!

I haven't had the time to review the complete document yet, but here are
my comments from the first half:

> +Disk image backing chain notation
> +---------------------------------
  [...]
> +.. important::
> +    The base disk image can be raw format; however, all the overlay
> +    files must be of QCOW2 format.

This is not quite like that: overlay files must be in a format that
supports backing files. QCOW2 is the most common one, but there are
others (qed). Grep for 'supports_backing' in the source code.

> +(1) ``block-stream``: Live copy of data from backing files into overlay
> +    files (with the optional goal of removing the backing file from the
> +    chain).

optional? The backing file is removed from the chain as soon as the
operation finishes, although the image file is not removed from the
disk. Maybe you meant that?

> +(2) ``block-commit``: Live merge of data from overlay files into backing
> +    files (with the optional goal of removing the overlay file from the
> +    chain).  Since QEMU 2.0, this includes "active ``block-commit``"
> +    (i.e.  merge the current active layer into the base image).

Same question about the 'optional' here.

> +writing to it.  (The rule of thumb is: live QEMU will always be pointing
> +to the right-most image in a disk image chain.)

I think it's 'rightmost', without the hyphen.

> +(3) Intermediate streaming (available since QEMU 2.8): Starting afresh
> +    with the original example disk image chain, with a total of four
> +    images, it is possible to copy contents from image [B] into image
> +    [C].  Once the copy is finished, image [B] can now be (optionally)
> +    discarded; and the backing file pointer of image [C] will be
> +    adjusted to point to [A].

The 'optional' usage again. [B] will be removed from the chain and can
be (optionally) removed from the disk, but that you have to do yourself,
QEMU won't do that.

> +The ``block-commit`` command lets you to live merge data from overlay
> +images into backing file(s).

I don't think "lets you to live merge data" is correct English.

> +The disk image chain can be shortened in one of the following ways:
> +
> +.. _`block-commit_Case-1`:
> +
> +(1) Commit content from only image [B] into image [A].  The resulting
> +    chain is the following, where image [C] is adjusted to point at [A]
> +    as its new backing file::
> +
> +        [A] <-- [C] <-- [D]
> +
> +(2) Commit content from images [B] and [C] into image [A].  The
> +    resulting chain, where image [D] is adjusted to point to image [A]
> +    as its new backing file::
> +
> +        [A] <-- [D]

Aren't these two just different variants of the same case?

> +
> +.. _`block-commit_Case-3`:
> +
> +(3) Commit content from images [B], [C], and the active layer [D] into
> +    image [A].  The resulting chain (in this case, a consolidated single
> +    image)::
> +
> +        [A]
> +
> +(4) Commit content from image only image [C] into image [B].  The
> +    resulting chain::
> +
> +	[A] <-- [B] <-- [D]
> +
> +(5) Commit content from image [C] and the active layer [D] into image
> +    [B].  The resulting chain::
> +
> +	[A] <-- [B]

Same here.

I mean, it's fine to have several different examples, but I think
there's really two main cases here (as you correctly explain later).

> +    (QEMU) block-commit device=node-D base=a.qcow2 top=d.qcow2 job-id=job0
> +    {
> +        "execute": "block-commit",
> +        "arguments": {
> +            "device": "node-D",
> +            "job-id": "job0",
> +            "top": "d.qcow2",
> +            "base": "a.qcow2"
> +        }
> +    }

This is correct, but I don't know if it's worth mentioning that if you
omit the 'top' parameter it defaults to the active layer (node-D in this
example).

Same with 'base'.

Else this part looks good! I'll check the rest of the document tomorrow
and give you my feedback.

Berto
