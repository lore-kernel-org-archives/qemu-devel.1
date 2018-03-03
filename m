Received: from eggs.gnu.org ([2001:4830:134:3::10]:35075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5vs-0000nl-SR
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5vn-0001Q0-VB
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:06:32 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5vn-0001Pq-Nx
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 07:06:27 -0500
Received: by mail-wm0-x241.google.com with SMTP id s206so6494372wme.0
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 04:06:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<CAFEAcA_3z8nxiD4xQnFcn3=bUMjLpQUoH8jZQmQkkycC2vWq1w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <62d00de6-0465-152e-67d5-676f407bc6f8@amsat.org>
Date: Sat, 3 Mar 2018 09:05:52 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3z8nxiD4xQnFcn3=bUMjLpQUoH8jZQmQkkycC2vWq1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 00/20] SDCard: bugfixes,
 support UHS-I (part 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

Hi Peter,

On 02/22/2018 11:31 AM, Peter Maydell wrote:
> On 15 February 2018 at 22:13, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Some refactors, few bugfixes, better SD/SPI support.
>>
>> With this series apply, machines can use SD cards in UHS-I mode.
>> (mostly imported from Alistair Francis work)
>>
>> MMC mode split out for another series,
>> so UHS enabled MMC cards are still not usable:
>>
>>   kernel: mmc0: SDHCI controller on PCI [0000:00:05.0] using ADMA
>>   kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
>>   kernel: mmc0: Skipping voltage switch
>>   [mmc kthread looping]
>>
>> Since v3:
>> - simpler SPI handling, improved descriptions (Alistair review)
>> - inverted patches 16/17 order
>>
>> Since v2:
>> - split again in 2... other part is cleanup/tracing
>>
>> Since v1:
>> - rewrote mostly all patches to keep it simpler.
>>
>> $ git backport-diff
>> 001/20:[----] [-C] 'sdcard: Don't always set the high capacity bit'
>> 002/20:[----] [-C] 'sdcard: update the CSD CRC register regardless the CSD structure version'
>> 003/20:[----] [-C] 'sdcard: fix the 'maximum data transfer rate' to 25MHz'
>> 004/20:[----] [-C] 'sdcard: clean the SCR register and add few comments'
>> 005/20:[----] [--] 'sdcard: remove commands from unsupported old MMC specification'
>> 006/20:[----] [--] 'sdcard: simplify using the ldst API'
>> 007/20:[0008] [FC] 'sdcard: use the correct masked OCR in the R3 reply'
>> 008/20:[----] [-C] 'sdcard: use the registerfields API for the CARD_STATUS register masks'
>> 009/20:[----] [--] 'sdcard: handle CMD54 (SDIO)'
>> 010/20:[down] 'sdcard: handle the Security Specification commands'
>> 011/20:[down] 'sdcard: use a more descriptive label 'unimplemented_spi_cmd''
>> 012/20:[0034] [FC] 'sdcard: handles more commands in SPI mode'
>> 013/20:[----] [--] 'sdcard: check the card is in correct state for APP CMD (CMD55)'
>> 014/20:[----] [--] 'sdcard: warn if host uses an incorrect address for APP CMD (CMD55)'
>> 015/20:[----] [--] 'sdcard: simplify SEND_IF_COND (CMD8)'
>> 016/20:[----] [--] 'sdcard: simplify SD_SEND_OP_COND (ACMD41)'
>> 017/20:[----] [--] 'sdcard: add SD SEND_TUNING_BLOCK (CMD19)'
>> 018/20:[----] [--] 'sdcard: implement the UHS-I SWITCH_FUNCTION entries (Spec v3)'
>> 019/20:[----] [-C] 'sdcard: add a 'uhs' property, update the OCR register ACCEPT_SWITCH_1V8 bit'
>> 020/20:[----] [--] 'sdcard: add an enum for the SD PHY Spec version'
> 
> I've applied patches 1 to 16 to target-arm.next.

Thanks!

> Removing the CMD11 support worries me a bit -- presumably it was put there
> because some guest actually uses it -- but my test images seem to
> still boot OK...

Yes you are right, this command was available in the first MMC specs but
not included in the SD specs. The SD/MMC differences are not always easy
to track and implement, the last series is supposed to handle MMC in a
clearer way, I'll see to restore this command once there.

> 
> thanks
> -- PMM
> 
