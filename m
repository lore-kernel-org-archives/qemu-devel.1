Received: from eggs.gnu.org ([2001:4830:134:3::10]:57486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cOMFF-0002bk-Gt
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cOMFB-0002Qe-9g
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:23:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cOMFB-0002QW-2w
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:23:01 -0500
References: <1483311635-27905-1-git-send-email-laurent@vivier.eu>
	<8ab579b1-22ab-25d9-24af-1dd8f8849edc@redhat.com>
	<3bd1cc56-6c52-9757-4652-2a49dfa5ec2c@vivier.eu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8a07a016-d573-9c90-5f87-0bb041b66707@redhat.com>
Date: Tue, 3 Jan 2017 18:22:49 +0800
MIME-Version: 1.0
In-Reply-To: <3bd1cc56-6c52-9757-4652-2a49dfa5ec2c@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dp8393x: fix dp8393x_receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>



On 2017=E5=B9=B401=E6=9C=8803=E6=97=A5 15:26, Laurent Vivier wrote:
> Le 03/01/2017 =C3=A0 04:37, Jason Wang a =C3=A9crit :
>>
>> On 2017=E5=B9=B401=E6=9C=8802=E6=97=A5 07:00, Laurent Vivier wrote:
>>> address_space_rw() access size must be multiplied by width.
>>> dp8393x_receive() must return the number of bytes read, not the lengt=
h
>>> of the last memory access.
>>>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>    hw/net/dp8393x.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>>> index 17f0338..3506bca 100644
>>> --- a/hw/net/dp8393x.c
>>> +++ b/hw/net/dp8393x.c
>>> @@ -766,10 +766,11 @@ static ssize_t dp8393x_receive(NetClientState
>>> *nc, const uint8_t * buf,
>>>            /* EOL detected */
>>>            s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
>>>        } else {
>>> +        size =3D sizeof(uint16_t) * width;
>>>            data[0 * width] =3D 0; /* in_use */
>>>            address_space_rw(&s->as,
>>>                ((s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA]) +
>>> sizeof(uint16_t) * 6 * width,
>>> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data,
>>> sizeof(uint16_t), 1);
>>> +            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
>> I think patch makes different only when width is 2. But if we just wan=
t
>> to tag in_use flag, sizeof(uint16_t) should be sufficient?
> In fact, I'm using this device to implement Quadra 800 macsonic
> emulation, and in this case all registers are byteswapped according the
> size of width (32bit in my case, see kernel sources,
> drivers/net/ethernet/natsemi/sonic.h and macsonic.c), so debugging the
> kernel I've seen used part of the register is never cleared.

Looking at git history this seems a revert of=20
409b52bfe199d8106dadf7c5ff3d88d2228e89b5 ("net/dp8393x: correctly reset=20
in_use field") which claims to fix an issue in NetBSD 5.1. According to=20
the spec (is this correct=20
http://www.ti.com/lit/ds/symlink/dp83936avul-33.pdf?) upper 16 bits were=20
not used in 32bit mode, so I'm not sure this is correct.

Hope Herv=C3=A9 or Aurelien can review this patch.

Thanks

> Thanks,
> Laurent
>
