Received: from eggs.gnu.org ([2001:4830:134:3::10]:58683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5ZMB-0007AA-4w
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5ZMA-0006Ak-60
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:04:51 -0400
Date: Tue, 2 May 2017 17:04:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170502150439.GG5805@noname.redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502081832.9546-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v16 00/22] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 02.05.2017 um 10:18 hat Fam Zheng geschrieben:
> v16: Rebase to the latest block-next branch of Kevin.
>      Address Kevin's comments:
>      - on/off => on/off/auto for file.locking option
>      - Add file.locking to QAPI schema
>      - Fall back to POSIX file lock if OFD lock not available
>      - Print warning when falling back, if locking=on specified
>        (This means qemu-io/qemu-img need --image-opts to enable lock)
>      - Drop the BLK_PERM_MAX patch and use an alternative
>      - Use the 'TEST_IMG="$TEST_IMG.base" _make_test_img ...' idiom
>      - Drop reopen callback changes
>      - Don't open s->lock_fd if !s->use_lock
>      - Use the same open flags for the lock fd
>      - Don't leak the returned string for bdrv_perm_names
>      - Clear up comment on raw_apply_lock_bytes
>      - Improve error message text
>      - Pass "0, 0" to raw_handle_perm_lock in raw_abort_perm_update
>      - Filter out test dir in reference output
>      - Add locking to bdrv_host_device.

Looks like we're almost there! :-)

The actual locking code looks good to me now. I had a try at cleaning up
the BDRV_O_INACTIVE handling at the block layer level so that we don't
need the special code in file-posix (and we definitely want to do this),
but it's a bit harder than I thought. So let's merge your file-posix
code as it is and clean up things on top.

Kevin
