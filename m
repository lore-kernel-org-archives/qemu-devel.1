Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ek8pm-0000Ej-Cs
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ek8ph-0000fV-IG
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:35:22 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
References: <20180209113744.11842-1-berto@igalia.com>
	<66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
Date: Fri, 09 Feb 2018 14:35:14 +0100
Message-ID: <w51d11ee165.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qcow2: Check the L1 table parameters from
 all internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Fri 09 Feb 2018 02:04:06 PM CET, Max Reitz wrote:
> I don't like completely refusing to open a qcow2 image if one of the
> snapshots is invalid, without giving the user any way of fixing it.
>
> With this patch, the final two images created in 080 cannot be opened
> at all (not even with qemu-img info).  Without it, you can, you just
> can't load the snapshots.  (Well, in one case.  In the other, you can
> even do that, but that's a bug, as you correctly claim.)
>
> More importantly, though, without this patch, you can delete the
> snapshots.  qemu-img will complain a bit, and you'll have leaks
> afterwards, but that's nothing qemu-img check can't fix.  With this
> patch, you can't, because the image cannot be opened at all so it's
> basically gone for good (unless you get a hex editor).

What you're saying is correct. The alternative however is to add checks
everywhere the snapshot table is used.

There's for example qcow2_check_metadata_overlap() that will happily
allocate a buffer of (l1_size * 8) bytes, that can be up to 32 GB.

qcow2_expand_zero_clusters() has the same problem but there g_realloc()
is used, aborting the process on failure (we should actually use
g_try_realloc() instead, I'll leave that for a different patch).

If we want to allow opening images with corrupted snapshots perhaps we
could still do the checks in qcow2_read_snapshots() but instead of
returning an error add a 'corrupted' flag to QCowSnapshot.

That solution is not without problems because we'd still need to check
for that flag everytime the snapshot is used, and that's calling for
errors in the future.

Berto
