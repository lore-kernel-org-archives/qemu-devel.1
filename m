Received: from eggs.gnu.org ([2001:4830:134:3::10]:45390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ93l-0000cB-C4
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ93k-0007Mc-Id
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:14:53 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170627192458.15519-19-eblake@redhat.com> (Eric Blake's message
	of "Tue, 27 Jun 2017 14:24:56 -0500")
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-19-eblake@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 28 Jun 2017 11:14:39 +0200
Message-ID: <87d19o79ts.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 18/20] block: Make bdrv_is_allocated()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
>
> Changing the signature of the function to use int64_t *pnum ensures
> that the compiler enforces that all callers are updated.  For now,
> the io.c layer still assert()s that all callers are sector-aligned
> on input and that *pnum is sector-aligned on return to the caller,
> but that can be relaxed when a later patch implements byte-based
> block status.  Therefore, this code adds usages like
> DIV_ROUND_UP(,BDRV_SECTOR_SIZE) to callers that still want aligned
> values, where the call might reasonbly give non-aligned results
> in the future; on the other hand, no rounding is needed for callers
> that should just continue to work with byte alignment.
>
> For the most part this patch is just the addition of scaling at the
> callers followed by inverse scaling at bdrv_is_allocated().  But
> some code, particularly bdrv_commit(), gets a lot simpler because it
> no longer has to mess with sectors; also, it is now possible to pass
> NULL if the caller does not care how much of the image is allocated
> beyond the initial offset.
>
> For ease of review, bdrv_is_allocated_above() will be tackled
> separately.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
