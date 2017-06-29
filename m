Received: from eggs.gnu.org ([2001:4830:134:3::10]:58898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQYZA-0006BG-SU
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQYZ8-0006TB-8T
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:29:00 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1498661881-9605-2-git-send-email-kchamart@redhat.com>
References: <1498661881-9605-1-git-send-email-kchamart@redhat.com>
	<1498661881-9605-2-git-send-email-kchamart@redhat.com>
Date: Thu, 29 Jun 2017 14:28:55 +0200
Message-ID: <w51k23v5660.fsf@maestria.local.igalia.com>
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
> +Once a 'mirror' job has started, there are two possible actions when a
> +``drive-mirror`` job is active:
> +
> +1. Issuing the command ``block-job-cancel``: will, after completing
> +   synchronization of the content from the disk image chain to the
> +   target image, [E] -- create a point-in-time (which is at the time of
> +   *triggering* the cancel command) copy, contained in image [E], of the
> +   backing file.

A point-in-time [...] copy [...] of the backing file ? That would be a
copy of the whole chain or the topmost image (depending on the sync
mode).

> +The ``"sync": "full"``, from the above, means: copy the *entire* chain
> +to the destination.

I think it's in general a good idea to describe the different sync modes
before doing this, because they're not completely obvious when you first
try to use these commands.

> +Notes on ``blockdev-mirror``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  [...]
> +(1) Create the target image (using ``qemu-img``), say, backup.qcow2

If we're doing a mirror here, backup.qcow2 is probably not the best
name :-)

> +Live disk backup --- ``drive-backup`` and ``blockdev-backup``
> +-------------------------------------------------------------
> +
> +The ``drive-backup`` (and its newer equivalent ``blockdev-backup``) allows
> +you to create a point-in-time snapshot.
> +
> +In this case, the point-in-time is when you *start* the ``drive-backup``
> +(or its newer equivalent ``blockdev-backup``) command.
> +
> +Currently, there are four different types of synchronization modes:
> +
> +(1) ``full`` -- Synchronize the content of entire disk image chain to
> +    the target
> +(2) ``top`` -- Synchronize only the contents of the top-most disk image
> +    in the chain to the target
> +(3) ``none`` -- Synchronize only the new writes from this point on
> +(4) ``incremental`` -- Synchronize content that is described by the
> +    dirty bitmap

Here's the kind of summary of the different sync modes that I was
talking about earlier.

One note about sync=none, though. If I'm not wrong drive-backup makes a
point-in-time copy of the data at the moment when the command is issued
(that's one difference from drive-mirror). Therefore drive-backup never
synchronizes "new writes from this point on".

I don't think that drive-backup sync=none copies any data then, can
anyone clarify?

The rest of the document looks good to me, thanks!

Berto
