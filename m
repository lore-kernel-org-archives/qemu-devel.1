Received: from eggs.gnu.org ([2001:4830:134:3::10]:44750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duerJ-0002go-TV
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duerE-0000tw-8s
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:09 -0400
Date: Wed, 20 Sep 2017 14:37:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170920123740.GE4730@localhost.localdomain>
References: <20170920114310.13080-1-el13635@mail.ntua.gr>
	<20170920114310.13080-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920114310.13080-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/block-backend.c: remove
 blk_pread_unthrottled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Am 20.09.2017 um 13:43 hat Manos Pitsidianakis geschrieben:
> blk_pread_unthrottled was used to bypass I/O throttling on the BlockBackend in
> the case of async I/O. This is not needed anymore and we can just call
> blk_pread() directly.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

We already did a related commit to the same effect in block/io.c:

	commit 90c78624f157ba41c3761c1a54864de03a7ec350
	Author: Kevin Wolf <kwolf@redhat.com>
	Date:   Thu Apr 7 18:33:29 2016 +0200

		block: Don't disable I/O throttling on sync requests

		We had to disable I/O throttling with synchronous requests because we
		didn't use to run timers in nested event loops when the code was
		introduced. This isn't true any more, and throttling works just fine
		even when using the synchronous API.

		The removed code is in fact dead code since commit a8823a3b ('block: Use
		blk_co_pwritev() for blk_write()') because I/O throttling can only be
		set on the top layer, but BlockBackend always uses the coroutine
		interface now instead of using the sync API emulation in block.c.

		Signed-off-by: Kevin Wolf <kwolf@redhat.com>
		Message-Id: <1458660792-3035-2-git-send-email-kwolf@redhat.com>
		Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
		Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
		Signed-off-by: Kevin Wolf <kwolf@redhat.com>

The same reasoning (at least the first part) applies to this patch.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
