Received: from eggs.gnu.org ([2001:4830:134:3::10]:57337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT6ra-00080W-N4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT6rZ-0006xm-Lm
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:30:34 -0400
Date: Thu, 6 Jul 2017 15:30:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706133017.GE5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-13-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-13-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/21] mirror: Switch mirror_do_read()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> function (no semantic change).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

> -    /* The sector range must meet granularity because:
> +    assert(bytes <= s->buf_size);
> +    /* The range will be sector-aligned because:
>       * 1) Caller passes in aligned values;
> -     * 2) mirror_cow_align is used only when target cluster is larger. */
> -    assert(!(sector_num % sectors_per_chunk));
> -    nb_chunks = DIV_ROUND_UP(nb_sectors, sectors_per_chunk);
> +     * 2) mirror_cow_align is used only when target cluster is larger.
> +     * But it might not be cluster-aligned at end-of-file. */
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> +    nb_chunks = DIV_ROUND_UP(bytes, s->granularity);

The assertion in the old code was about sector_num (i.e.  that the start
of the range is cluster-aligned), not about nb_sectors, so while you add
a new assertion, it is asserting something different. This explains
why you had to switch to sector aligned even though the semantics
shouldn't be changed by this patch.

Is this intentional or did you confuse sector_num and nb_sectors? I
think we can just have both assertions.

The rest of the patch looks okay.

Kevin
