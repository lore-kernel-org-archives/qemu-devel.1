Received: from eggs.gnu.org ([2001:4830:134:3::10]:58209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqLeo-00078n-2G
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqLek-0008QK-2u
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:29:42 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180222155922.9833-4-eblake@redhat.com>
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-4-eblake@redhat.com>
Date: Mon, 26 Feb 2018 17:29:36 +0100
Message-ID: <w518tbfd89b.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qcow2: Don't allow overflow during
 cluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 22 Feb 2018 04:59:21 PM CET, Eric Blake wrote:
> Our code was already checking that we did not attempt to
> allocate more clusters than what would fit in an INT64 (the
> physical maximimum if we can access a full off_t's worth of
> data).  But this does not catch smaller limits enforced by
> various spots in the qcow2 image description: L1 and normal
> clusters of L2 are documented as having bits 63-56 reserved
> for other purposes, capping our maximum offset at 64PB (bit
> 55 is the maximum bit set).  And for compressed images with
> 2M clusters, the cap drops the maximum offset to bit 48, or
> a maximum offset of 512TB.  If we overflow that offset, we
> would write compressed data into one place, but try to
> decompress from another, which won't work.
>
> I don't have 512TB handy to prove whether things break if we
> compress so much data that we overflow that limit, and don't
> think that iotests can (quickly) test it either.  Test 138
> comes close (it corrupts an image into thinking something lives
> at 32PB, which is half the maximum for L1 sizing - although
> it relies on 512-byte clusters).  But that test points out
> that we will generally hit other limits first (such as running
> out of memory for the refcount table, or exceeding file system
> limits like 16TB on ext4, etc), so this is more a theoretical
> safety valve than something likely to be hit.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
