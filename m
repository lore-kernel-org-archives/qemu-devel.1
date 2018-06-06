Received: from eggs.gnu.org ([2001:4830:134:3::10]:49945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQecw-00039I-Jp
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQecv-0004mp-NP
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:01:50 -0400
References: <20180606190955.20845-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bb8a0410-ec4f-a434-2319-b5e365297f64@redhat.com>
Date: Wed, 6 Jun 2018 16:01:43 -0400
MIME-Version: 1.0
In-Reply-To: <20180606190955.20845-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] atapi: change unlimited recursion to
 while loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org



On 06/06/2018 03:09 PM, John Snow wrote:
> Real hardware doesn't have an unlimited stack, so the unlimited
> recursion in the ATAPI code smells a bit.  In fact, the call to
> ide_transfer_start easily becomes a tail call with a small change
> to the code (patch 5); however, we also need to turn the call back to
> ide_atapi_cmd_reply_end into another tail call before turning the
> (double) tail recursion into a while loop.
> 
> In particular, patch 1 ensures that the call to the end_transfer_func is
> the last thing in ide_transfer_start.  To do so, it moves the write of
> the PIO Setup FIS before the PIO transfer, which actually makes sense:
> the FIS is sent by the device to inform the AHCI about the transfer,
> so it cannot come after!  This is the main change from the RFC, and
> it simplifies the rest of the series (the RFC had to introduce an
> "end_transfer" callback just for writing the PIO Setup FIS).
> 
> I tested this manually with READ CD commands sent through sg_raw,
> and the existing AHCI tests still pass.
> 
> v2: reworked PIO Setup FIS based on spec reading, adjusted tests.
> 
> John Snow (2):
>   libqos/ahci: track sector size
>   ahci: move PIO Setup FIS before transfer, fix it for ATAPI commands
> 
> Paolo Bonzini (5):
>   ide: push end_transfer_func out of start_transfer callback, rename
>     callback
>   ide: call ide_cmd_done from ide_transfer_stop
>   ide: make ide_transfer_stop idempotent
>   atapi: call ide_set_irq before ide_transfer_start
>   ide: introduce ide_transfer_start_norecurse
> 
>  hw/ide/ahci.c             | 31 ++++++++++++-------------------
>  hw/ide/atapi.c            | 44 ++++++++++++++++++++++++--------------------
>  hw/ide/core.c             | 39 ++++++++++++++++++++-------------------
>  hw/ide/trace-events       |  2 +-
>  include/hw/ide/internal.h |  4 +++-
>  tests/libqos/ahci.c       | 45 +++++++++++++++++++++++++++------------------
>  tests/libqos/ahci.h       |  3 +--
>  7 files changed, 88 insertions(+), 80 deletions(-)
> 

I know this is weird, but it will make it easier for me later:

Patches 3-7 (authored by Paolo):

Reviewed-by: John Snow <jsnow@redhat.com>
