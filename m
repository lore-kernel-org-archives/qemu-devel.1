Received: from eggs.gnu.org ([2001:4830:134:3::10]:60740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR0R8-0003Y0-8E
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR0R7-0007QK-BK
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:19:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8484d1a4-b9e4-3d69-090c-22c230878566@amsat.org>
Date: Thu, 7 Jun 2018 16:18:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] cuda/mos6522 migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 06/07/2018 02:17 PM, Mark Cave-Ayland wrote:
> Whilst performing a random migration test for the Mac machines I noticed
> a regression (patch 1) which prevented the loadvm from completing
> successfully. A big thank you to Peter and David on IRC who pointed me
> in the right direction in order to fix the bug.
> 
> Once that was working I spent a bit more time analysing the migration
> stream and realised that the mos6522 device state wasn't being embedded
> within the CUDA device, but instead being maintained separately which is
> solved by patch 2.
> 
> Patch 3 is something I noticed whilst rearranging the existing code based
> upon my better understanding of QOM/qdev and ensures that the timer frequency
> is always set correctly post-migration for the device and its parent class.
> This leaves no remaining functionality in the mos6522 realize function and so
> allows it to be removed.
> 
> Finally patch 4 was suggested by Peter on IRC whilst helping me investigate
> the original migration issue, and removes the last remaining user of
> VMSTATE_TIMER_PTR_TEST from the codebase.

You forgot patch 5 "vmstate: Remove VMSTATE_TIMER_PTR_TEST" :)

> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> 
> Mark Cave-Ayland (4):
>   mos6522: fix vmstate_mos6522_timer version in vmstate_mos6522
>   cuda: embed mos6522_cuda device directly rather than using QOM object
>     link
>   mos6522: move timer frequency initialisation to mos6522_reset
>   mos6522: convert VMSTATE_TIMER_PTR_TEST to VMSTATE_TIMER_PTR
> 
>  hw/misc/macio/cuda.c         | 50 +++++++++++++++++++-------------------------
>  hw/misc/mos6522.c            | 26 ++++++-----------------
>  include/hw/misc/macio/cuda.h | 27 +++++++++++-------------
>  include/hw/misc/mos6522.h    |  4 +++-
>  4 files changed, 42 insertions(+), 65 deletions(-)
> 
