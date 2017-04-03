Received: from eggs.gnu.org ([2001:4830:134:3::10]:47159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cuuWE-0000aS-Sm
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 01:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cuuWB-0003UI-Mk
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 01:27:10 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35858
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cuuWB-0003SP-FR
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 01:27:07 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4ccee8ca-8045-784e-5074-3007d8667238@ilande.co.uk>
Date: Mon, 3 Apr 2017 06:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <1490881315.28523.11.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 30/03/17 14:41, Gerd Hoffmann wrote:

>   Hi,
> 
>> Excellent! I can help out with converting and/or testing the SPARC
>> devices (cg3/tcx) if required.
> 
> Sure, test results and patches are very welcome.

I've spent a bit of time over the weekend attempting to convert the
SPARC CG3/TCX framebuffers over to use your new code and pushed the
result to my github branch here:
https://github.com/mcayland/qemu/commits/vga-fixes-sparc.

Feel free to steal/test/borrow as required. The two main things I've
discovered to date are:

1) Problems with asserts() in cpu_physical_memory_snapshot_get_dirty()

Using your current git branch, I get an assert() using VGA under
qemu-system-ppc on startup unless I change the first assert to
"assert(start >= snap->start)".

I'm also not convinced by the second assert "assert(start + length <
snap->end)" either. In the example CG3/TCX conversions I ended up having
to subtract 1 from the size of the region passed to
memory_region_snapshot_get_dirty() in order to avoid it firing when
accessing the last scanline which seems wrong. I didn't explicitly add a
patch to change this to "<=" in my git patchset just in case it broke
further assumptions in the bitmap code relating to the end address.


2) Redraw issues with CG3/TCX after conversion

Despite the conversion from your patches looking reasonably
straightforward, I still see problems with areas of the screen not
updating after conversion. I can easily reproduce these locally as follows:

./qemu-system-sparc -vga cg3 -prom-env 'auto-boot?=false'
./qemu-system-sparc -vga tcx -g 1024x768x8 -prom-env 'auto-boot?=false'
./qemu-system-sparc -vga tcx -g 1024x768x24 -prom-env 'auto-boot?=false'

You can trigger extra screen updates by typing "show-devs" into OpenBIOS
which will cause a lot of screen activity as it writes the device tree
out to the framebuffer. I'm wondering if maybe this is related to the
difference in sizes between DIRTY_MEMORY_BLOCK_SIZE and TARGET_PAGE_BITS
for qemu-system-sparc?

Finally on a slightly unrelated note, the TCX driver still has old code
for 8 and 16 bpp surfaces in QEMU. Am I right in understanding that all
surfaces in QEMU are now 32-bit and the 8/16 bpp code can be removed?


ATB,

Mark.
