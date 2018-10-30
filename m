Received: from eggs.gnu.org ([2001:4830:134:3::10]:54460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gHQU6-0004UU-JO
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gHQU2-0007w9-Bg
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:38:50 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-4-mark.cave-ayland@ilande.co.uk>
	<CAAdtpL5sWp5y4oPVzzsLMf3u1U7zYSauv45eLo9QMnVRtmOS_Q@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <127850f7-baf9-df72-625e-23765a24bc84@ilande.co.uk>
Date: Tue, 30 Oct 2018 09:38:17 +0000
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5sWp5y4oPVzzsLMf3u1U7zYSauv45eLo9QMnVRtmOS_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/11] escc: introduce a selector for
 the register bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

On 29/10/2018 23:36, Philippe Mathieu-Daudé wrote:

> Hi Marc, Laurent.
> 
> On Mon, Oct 29, 2018 at 2:43 PM Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> From: Laurent Vivier <laurent@vivier.eu>
>>
>> On Sparc and PowerMac, the bit 0 of the address
>> selects the register type (control or data) and
>> bit 1 selects the channel (B or A).
>>
>> On m68k Macintosh, the bit 0 selects the channel and
>> bit 1 the register type.
>>
>> This patch introduces a new parameter (bit_swap) to
>> the device interface to indicate bits usage must
>> be swapped between registers and channels.
>>
>> For the moment all the machines use the bit 0,
>> but this change will be needed to emulate Quadra 800.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  hw/char/escc.c         | 30 ++++++++++++++++++++++++------
>>  include/hw/char/escc.h |  1 +
>>  2 files changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>> index 628f5f81f7..cec75b06f9 100644
>> --- a/hw/char/escc.c
>> +++ b/hw/char/escc.c
>> @@ -42,14 +42,21 @@
>>   * mouse and keyboard ports don't implement all functions and they are
>>   * only asynchronous. There is no DMA.
>>   *
>> - * Z85C30 is also used on PowerMacs. There are some small differences
>> - * between Sparc version (sunzilog) and PowerMac (pmac):
>> + * Z85C30 is also used on PowerMacs and m68k Macs.
>> + *
>> + * There are some small differences between Sparc version (sunzilog)
>> + * and PowerMac (pmac):
>>   *  Offset between control and data registers
>>   *  There is some kind of lockup bug, but we can ignore it
>>   *  CTS is inverted
>>   *  DMA on pmac using DBDMA chip
>>   *  pmac can do IRDA and faster rates, sunzilog can only do 38400
>>   *  pmac baud rate generator clock is 3.6864 MHz, sunzilog 4.9152 MHz
>> + *
>> + * Linux driver for m68k Macs is the same as for PowerMac (pmac_zilog),
>> + * but registers are grouped by type and not by channel:
>> + * channel is selected by bit 0 of the address (instead of bit 1)
>> + * and register is selected by bit 1 of the address (instead of bit 0).
> 
> If I understand the datashit correctly, the case bit_swap=true is the
> default implementation of the Z85C30,
> and the current QEMU implementation (from this patch view:
> bit_swap=false) is not: it is PowerMac specific.
> 
> I think the PowerMac uses an evolved Z85C30 with more precise IRQ lines.
> 
> Anyway, not a blocker, but I wanted to share my view that this model
> is eventually going in an incorrect direction.
> I'll try to suggest a patch to clean this during the next merge window.

Oh I see, so you think that what is currently the swapped version is actually how it
is handled in standard hardware? In that case I tend to agree with you that it would
make sense to switch the sense of the property around so that the standard behaviour
is the default.

Also this makes me feel that "bit_swap" isn't a particularly good property name -
perhaps something like "pmac_bit_swap" would be clearer?


ATB,

Mark.
