Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpDx5-00035B-Ca
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpDx2-0005Ka-9d
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:36:11 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cover.1530270904.git.berto@igalia.com>
References: <cover.1530270904.git.berto@igalia.com>
Date: Mon, 13 Aug 2018 16:36:04 +0200
Message-ID: <w51mutq72qz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/5] Some bs->options fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

On Fri 29 Jun 2018 01:36:58 PM CEST, Alberto Garcia wrote:
> Hi everyone,
>
> this is part of the blockdev-reopen work that I'm doing, but since
> I'll be away during most of July I thought that I could send already a
> couple of patches that I think are ready and don't need anything else
> from the rest of the series.
>
> There's two main fixes here:
>
>   1) bs->options are not kept up to date after an image is reopened
>      and no longer reflect its state.
>
>   2) bs->options and bs->explicit_options also contain the options of
>      a BDS's children, so there's data that is duplicated and will be
>      inconsistent as soon as you change the children's options
>      directly.
>
> The fix for (2) involves removing all children options from both
> QDicts. In the cases of node name references ("backing": "node-name")
> those remain in the QDict (they're technically parent options). I
> think we don't really need them and it should be possible to get rid
> of them, but it's a little more complicated (we need them during
> bdrv_reopen() to ensure that the user didn't try to change any of
> them).
>
> Regards,
>
> Berto
>
> Alberto Garcia (5):
>   qdict: Make qdict_extract_subqdict() accept dst = NULL
>   block: Remove children options from bs->{options,explicit_options}
>   block: Simplify bdrv_reopen_abort()
>   block: Update bs->options if bdrv_reopen() succeeds
>   block: Simplify append_open_options()
>
>  block.c               | 42 +++++++++++++++++++++++++++++++-----------
>  qobject/block-qdict.c | 11 ++++++++---
>  2 files changed, 39 insertions(+), 14 deletions(-)
>
> -- 
> 2.11.0
