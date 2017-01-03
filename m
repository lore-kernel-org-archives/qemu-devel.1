Received: from eggs.gnu.org ([2001:4830:134:3::10]:60723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cOJUN-0001aM-V5
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cOJUJ-0007Oa-0E
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:26:31 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:60153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cOJUI-0007O9-Le
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:26:26 -0500
References: <1483311635-27905-1-git-send-email-laurent@vivier.eu>
	<8ab579b1-22ab-25d9-24af-1dd8f8849edc@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3bd1cc56-6c52-9757-4652-2a49dfa5ec2c@vivier.eu>
Date: Tue, 3 Jan 2017 08:26:03 +0100
MIME-Version: 1.0
In-Reply-To: <8ab579b1-22ab-25d9-24af-1dd8f8849edc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] dp8393x: fix dp8393x_receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>

Le 03/01/2017 à 04:37, Jason Wang a écrit :
> 
> 
> On 2017年01月02日 07:00, Laurent Vivier wrote:
>> address_space_rw() access size must be multiplied by width.
>> dp8393x_receive() must return the number of bytes read, not the length
>> of the last memory access.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   hw/net/dp8393x.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index 17f0338..3506bca 100644
>> --- a/hw/net/dp8393x.c
>> +++ b/hw/net/dp8393x.c
>> @@ -766,10 +766,11 @@ static ssize_t dp8393x_receive(NetClientState
>> *nc, const uint8_t * buf,
>>           /* EOL detected */
>>           s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
>>       } else {
>> +        size = sizeof(uint16_t) * width;
>>           data[0 * width] = 0; /* in_use */
>>           address_space_rw(&s->as,
>>               ((s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA]) +
>> sizeof(uint16_t) * 6 * width,
>> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data,
>> sizeof(uint16_t), 1);
>> +            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
> 
> I think patch makes different only when width is 2. But if we just want
> to tag in_use flag, sizeof(uint16_t) should be sufficient?

In fact, I'm using this device to implement Quadra 800 macsonic
emulation, and in this case all registers are byteswapped according the
size of width (32bit in my case, see kernel sources,
drivers/net/ethernet/natsemi/sonic.h and macsonic.c), so debugging the
kernel I've seen used part of the register is never cleared.

Thanks,
Laurent
