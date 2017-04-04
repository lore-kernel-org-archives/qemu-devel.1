Received: from eggs.gnu.org ([2001:4830:134:3::10]:46903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvNyk-0005Ig-0M
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvNyg-0002Lj-VH
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:54:34 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40289
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvNyg-0002Kj-NF
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:54:30 -0400
References: <20170404102315.24923-1-kraxel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <72577ece-417f-ed7f-1dcf-6ecc8336e321@ilande.co.uk>
Date: Tue, 4 Apr 2017 13:54:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170404102315.24923-1-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/10] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 04/04/17 11:23, Gerd Hoffmann wrote:

>   Hi,
> 
> Second round.  Helper API should be solid now, after patch discussions
> and initial testing.  API is documented now in the header file.
> Additionally to vga the sparc display adapters (cg3, tcx) are converted
> too.  Still quite some work until we've got them all converted.  Still
> enough progress that I think posting the new revision is useful.
> 
> cheers,
>   Gerd
> 
> Gerd Hoffmann (5):
>   bitmap: add bitmap_copy_and_clear_atomic
>   memory: add support getting and using a dirty bitmap copy.
>   vga: add vga_scanline_invalidated helper
>   vga: make display updates thread safe.
>   [testing] console: remove do_safe_dpy_refresh
> 
> Mark Cave-Ayland (5):
>   cg3: remove TARGET_PAGE_SIZE rounding on dirty page detection
>   cg3: fix up size parameter for memory_region_get_dirty()
>   cg3: make display updates thread safe
>   tcx: introduce tcx_check_dirty() function
>   tcx: make display updates thread safe
> 
>  include/exec/memory.h   | 47 +++++++++++++++++++++++++++
>  include/exec/ram_addr.h |  7 ++++
>  include/qemu/bitmap.h   |  2 ++
>  include/qemu/typedefs.h |  1 +
>  exec.c                  | 75 ++++++++++++++++++++++++++++++++++++++++++
>  hw/display/cg3.c        | 40 +++++++++++------------
>  hw/display/tcx.c        | 86 ++++++++++++++++++-------------------------------
>  hw/display/vga.c        | 50 +++++++++++++++-------------
>  memory.c                | 17 ++++++++++
>  ui/console.c            | 25 +-------------
>  util/bitmap.c           | 11 +++++++
>  11 files changed, 241 insertions(+), 120 deletions(-)

All in all, looks reasonably good here.

I've just noticed that TCX 24-bit is still leaving some artifacts, but
from looking at the code I'm fairly confident that it's bugs in the
existing TCX code where some of the accelerated features aren't
correctly invalidating the external color plane.

Will have a play and see if I can send a patch later.


ATB,

Mark.
