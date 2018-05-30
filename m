Received: from eggs.gnu.org ([2001:4830:134:3::10]:58597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrOV-0000YT-Ai
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrOQ-0006YD-Di
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:03:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529062838.20556-1-clg@kaod.org>
	<20180529062838.20556-3-clg@kaod.org>
	<b0cb42ea-16f7-7806-814c-f472867e1a6a@amsat.org>
	<e21c77e5-c1de-eaf9-5357-1147f5d14ca0@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <da14dbd1-1064-c721-0104-fe872643e4aa@amsat.org>
Date: Wed, 30 May 2018 00:03:11 -0300
MIME-Version: 1.0
In-Reply-To: <e21c77e5-c1de-eaf9-5357-1147f5d14ca0@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/6] ftgmac100: add IEEE 802.1Q
 VLAN support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 05/29/2018 01:56 PM, Cédric Le Goater wrote:
> On 05/29/2018 03:34 PM, Philippe Mathieu-Daudé wrote:
>> Hi Cédric,
>>
>> On 05/29/2018 03:28 AM, Cédric Le Goater wrote:
>>> The ftgmac100 NIC supports VLAN tag insertion and the MAC engine also
>>> has a control to remove VLAN tags from received packets.
>>>
>>> The VLAN control bits and VLAN tag information are contained in the
>>> second word of the transmit and receive descriptors. The Insert VLAN
>>> bit and the VLAN Tag available bit are only valid in the first segment
>>> of the packet.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>  hw/net/ftgmac100.c | 32 +++++++++++++++++++++++++++++++-
>>>  1 file changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
>>> index 7598d08c9cb9..50af1222464a 100644
>>> --- a/hw/net/ftgmac100.c
>>> +++ b/hw/net/ftgmac100.c
>>> @@ -443,6 +443,24 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>>>              break;
>>>          }
>>>  
>>> +        /* Check for VLAN */
>>> +        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
>>> +            bd.des1 & FTGMAC100_TXDES1_INS_VLANTAG &&
>>> +            be16_to_cpu(PKT_GET_ETH_HDR(ptr)->h_proto) != ETH_P_VLAN) {
>>> +            if (frame_size + len + 4 > sizeof(s->frame)) {
>>> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes\n",
>>> +                              __func__, len);
>>> +                s->isr |= FTGMAC100_INT_XPKT_LOST;
>>> +                len =  sizeof(s->frame) - frame_size - 4;
>>> +            }
>>> +            memmove(ptr + 16, ptr + 12, len - 12);
>>> +            ptr[12] = 0x81;
>>> +            ptr[13] = 0x00;
>>
>>                stw_be_p(ptr + 12, ETH_P_VLAN);
>>
>>> +            ptr[14] = (uint8_t) bd.des1 >> 8;
>>> +            ptr[15] = (uint8_t) bd.des1;
>>
>>                stw_be_p(ptr + 12, bd.des1);
> 
> ptr + 14

copy/paste mistake ;)

>>> +            len += 4;
>>> +        }
>>> +
>>>          ptr += len;
>>>          frame_size += len;
>>>          if (bd.des0 & FTGMAC100_TXDES0_LTS) {
>>> @@ -858,7 +876,19 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>>>              buf_len += size - 4;
>>>          }
>>>          buf_addr = bd.des3;
>>> -        dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
>>> +        if (first && proto == ETH_P_VLAN && buf_len >= 18) {
>>> +            bd.des1 = (buf[14] << 8) | buf[15] | FTGMAC100_RXDES1_VLANTAG_AVAIL;
>>
>>                bd.des1 = lduw_be_p(buf + 14) |
>> FTGMAC100_RXDES1_VLANTAG_AVAIL;
>>
>>> +            if (s->maccr & FTGMAC100_MACCR_RM_VLAN) {
>>> +                dma_memory_write(&address_space_memory, buf_addr, buf, 12);
>>> +                dma_memory_write(&address_space_memory, buf_addr + 12, buf + 16,
>>> +                                 buf_len - 16);
>>> +            } else {
>>> +                dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
>>> +            }
>>> +        } else {
>>> +            bd.des1 = 0;
>>> +            dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
>>> +        }
>>>          buf += buf_len;
>>>          if (size < 4) {
>>>              dma_memory_write(&address_space_memory, buf_addr + buf_len,
>>>
>>
>> With ldst API uses:
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
> 
> Sure, I will fix these.

Thanks!
