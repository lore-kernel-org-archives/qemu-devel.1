Received: from eggs.gnu.org ([2001:4830:134:3::10]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCqA-0000iL-GJ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCq9-00055q-8j
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:32:42 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:36709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPCq9-00055H-3y
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:32:41 -0500
Received: by mail-ua0-x230.google.com with SMTP id 88so380490663uaq.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 10:32:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d15e8de4-f7d8-1c28-7e5e-31d0aa10819d@sysgo.com>
References: <d15e8de4-f7d8-1c28-7e5e-31d0aa10819d@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 18:32:20 +0000
Message-ID: <CAFEAcA8pXJ3g5e7rw6_FAhnbZfLOOoX-gaavyzKug0y=gDCuQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] vexpress fix flash device-width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Engraf <david.engraf@sysgo.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 December 2016 at 14:02, David Engraf <david.engraf@sysgo.com> wrote:
> The current implementation uses width = 4 and device-width = 2 for the flash
> configuration. When using u-boot or Linux, the flash is detected as 32 x 16
> bit, thus the sector size is doubled to 512 KB. When u-boot sends a sector
> erase, only the first 256 KB are erased because the QEMU flash
> implementation uses the configured sector size of 256 KB and ignores the
> width and device-width ratio.
>
> This patch will change device-width to 4, thus the width and device-width
> are equal and u-boot detects the flash as 32 x 32 bit with the correct
> sector size of 256 KB.

Thanks for this patch. However I'm not sure it is correct, because
I think the real hardware does have 2x16 devices here. On real vexpress
TC2 if you boot Linux it detects the flash as:
"8000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank.
Manufacturer ID 0x000089 Chip ID 0x008919"

So while we presumably have a QEMU bug if this isn't behaving
like the hardware, I don't think that changing the device-width to
4 is the right fix for it. Maybe:
 * our erase implementation is broken?
 * one of the other parameters we use to create the flash
   is wrong?
 * the calculation of the erase block information that we put in
   the flash cfi_table[] is wrong?

(Does u-boot hard-code the erase block sizes, or does
it read them from the CFI data? QEMU's flash doesn't have the
hardware's two-eraseblock-regions setup where part of the disk is
256K erase-blocks and part is 64K blocks, but if u-boot doesn't
hardcode that it should be able to read the data from QEMU's
flash implementation.)

Also, for patches to QEMU we need you to provide a
Signed-off-by: line to say that you're happy to contribute the
patch to QEMU. More detail about what this means here:
http://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line
(the other details of patch formatting are mostly nice-to-haves,
but the s-o-by line is a hard requirement.)

thanks
-- PMM
