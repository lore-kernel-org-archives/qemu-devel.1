Received: from eggs.gnu.org ([209.51.188.92]:52835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1w1L-0006AP-D6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1w1K-0004Ev-JY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:37:23 -0500
Date: Thu, 7 Mar 2019 17:37:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307163715.GL5786@linux.fritz.box>
References: <20190227172256.30368-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227172256.30368-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/20] qcow2: External data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 27.02.2019 um 18:22 hat Kevin Wolf geschrieben:
> There are use cases where raw images are given (e.g. existing physical
> disks), but advanced features like dirty bitmaps or backing files are
> wanted that require use of a proper image format like qcow2.
> 
> This series adds an incompatible feature bit to qcow2 which allows to
> use an external data file: Metadata is kept in the qcow2 file like
> usual, but guest data is written to an external file. Clusters in the
> data file are not reference counted, instead we use a flat layout where
> host cluster offset == guest cluster offset. The external data file is
> therefore readable as a raw image (though writing to it invalidates the
> associated qcow2 metadata). Features that require refcounting such as
> internal snapshots or compression are not supposed in such setups.
> 
> Major changes since the RFC (many more minor changes):
> 
> - Added a 'data-file-raw' flag to the spec to keep the data file a valid
>   self-consistent raw image (write_zeroes must always be propagated)
> - Added QAPI documentation
> - Added some test cases
> - Implemented data file support or error paths for discard, check,
>   compressed writes, snapshots
> - Fixed qcow2_co_block_status()
> - Rearranged qcow2_do_open() code for data files for better error
>   handling (e.g. no more fallback to default data file if an explicit,
>   but invalid data-file option is given)

Thanks, made the trivial changes suggested during review and applied to
the block branch.

Kevin
