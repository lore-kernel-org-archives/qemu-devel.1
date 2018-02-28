Received: from eggs.gnu.org ([2001:4830:134:3::10]:60908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1er2d0-0002Fr-If
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1er2cx-0000iL-AT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:22:42 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180227162944.17343-5-eblake@redhat.com>
References: <20180227155514.16721-1-eblake@redhat.com>
	<20180227162944.17343-5-eblake@redhat.com>
Date: Wed, 28 Feb 2018 15:22:37 +0100
Message-ID: <w51muztp51u.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 5/5] qcow2: Avoid memory over-allocation
 on compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

On Tue 27 Feb 2018 05:29:44 PM CET, Eric Blake wrote:
> So, it's time to cut back on the waste.  A compressed cluster
> written by qemu will NEVER occupy more than an uncompressed
> cluster, but based on mid-sector alignment, we may still need
> to read 1 cluster + 1 sector in order to recover enough bytes
> for the decompression.  But third-party producers of qcow2 may
> not be as smart, and gzip DOES document that because the
> compression stream adds metadata, and because of the pigeonhole
> principle, there are worst case scenarios where attempts to
> compress will actually inflate an image, by up to 0.015% (or 62
> sectors larger for an unfortunate 2M compression).  In fact,
> the qcow2 spec permits an all-ones sector count, plus a full
> sector containing the initial offset, for a maximum read of
> 2 full clusters; and thanks to the way decompression works,
> even though such a value is probably too large for the actual
> compressed data, it really doesn't matter if we read too much
> (gzip ignores slop, once it has decoded a full cluster).  So
> it's easier to just allocate cluster_data to be as large as we
> can ever possibly see; even if it still wastes up to 2M on any
> image created by qcow2, that's still an improvment of 60M less
> waste than pre-patch.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
