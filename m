Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxHGt-000491-Gb
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxHGs-0007GF-Or
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:41:23 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-13-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <28a79c88-ca25-70c3-9e5b-fc794854fb34@redhat.com>
Date: Wed, 27 Sep 2017 14:41:04 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-13-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 12/23] block: Convert
 bdrv_get_block_status_above() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
> 
> Changing the name of the function from bdrv_get_block_status_above()
> to bdrv_block_status_above() ensures that the compiler enforces that
> all callers are updated.  For now, the io.c layer still assert()s
> that all callers are sector-aligned, but that can be relaxed when a
> later patch implements byte-based block status in the drivers.
> 
> For the most part this patch is just the addition of scaling at the
> callers followed by inverse scaling at bdrv_block_status().  But some
> code, particularly bdrv_block_status(), gets a lot simpler because
> it no longer has to mess with sectors.  Likewise, mirror code no
> longer computes s->granularity >> BDRV_SECTOR_BITS, and can therefore
> drop an assertion (fix a neighboring assertion to use is_power_of_2
> while there).
> 

Huh, I suppose so, yeah. Do you have a test that covers what happens in
this newly available use case?

> For ease of review, bdrv_get_block_status() was tackled separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Looks mechanically correct, anyway.

Reviewed-by: John Snow <jsnow@redhat.com>
