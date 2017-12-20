Received: from eggs.gnu.org ([2001:4830:134:3::10]:53292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRaDL-0004YG-T9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRaDJ-0004uL-8J
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:58:59 -0500
Received: from chuckie.co.uk ([82.165.15.123]:40686
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRaDJ-0004tY-19
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:58:57 -0500
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
	<afe1431d-7484-88ac-333b-e042fa0fb32d@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <19ebcc01-3299-2ec9-7089-cba5abde400f@ilande.co.uk>
Date: Wed, 20 Dec 2017 08:58:48 +0000
MIME-Version: 1.0
In-Reply-To: <afe1431d-7484-88ac-333b-e042fa0fb32d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 00/13] net: introduce common net_crc32()
 and net_crc32_le() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, sw@weilnetz.de

On 20/12/17 08:35, Jason Wang wrote:
> 
> 
> On 2017年12月16日 02:41, Mark Cave-Ayland wrote:
>> Whilst trying to debug a CRC32 endian issue for NIC multicast hash 
>> lookups, it
>> struck me that it would make sense to have a common set of standard 
>> ethernet
>> CRC32 functions (both little and big endian variants) in net.c.
>>
>> Patches 1 and 2 introduce the new net_crc32() and net_crc32_le() 
>> functions for
>> use by NIC multicast hash lookups.
>>
>> Patches 3 to 5 switch the pcnet, eepro100 and sunhme drivers over to 
>> use the
>> new functions instead of having their own private implementations.
>>
>> Patch 6 fixes the sungem multicast filter CRC calculation, since we 
>> can see from
>> the Linux sungem driver that the CRC is calculated using 
>> ether_crc32_le() and so
>> the direct use of the zlib crc32() function is incorrect. The solution 
>> here is to
>> simply use the corresponding net_crc32_le() function.
>>
>> Patches 7 to 12 switch the remaining users of compute_mcast_idx() over 
>> to use
>> the new net_crc32() function as it becomes much easier to spot errors 
>> in the
>> multicast hash calculations (see below).
>>
>> Finally patch 13 removes the now unused compute_mcast_idx() function.
>>
>> One of the motivations for removing compute_mcast_idx() and using the 
>> CRC and
>> bitshift inline is because it makes it much easier to spot potential 
>> errors
>> when comparing with the corresponding driver source code. This led to 
>> the following
>> curiosities whilst developing the patchset:
>>
>> 1) The sungem multicast filter CRC calculation was incorrect (fixed by 
>> patch 6 as
>>     I was able to test locally)
>>
>> 2) After conversion we can see in eepro100.c line 1682 that there is 
>> one single
>>     remaining multicast hash calculation that doesn't apply a BITS(7, 
>> 2) mask to
>>     the filter index when compared with all the others. This looks 
>> incorrect, but
>>     I don't have an easy way to verify this.
>>
>> 3) In ftgmac100.c we see a comment next to the multicast hash filter 
>> calculation
>>     that states "TODO: this does not seem to work for ftgmac100". Upon 
>> consulting the
>>     Linux driver source we can see that ether_crc32_le() is used in 
>> the driver
>>     suggesting that changing net_crc32() to net_crc32_le() should fix 
>> the calculation.
>>     Again I've left this as I don't have an easy way to verify the fix.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Series looks good to me.
> 
> A small question is that, is this better to keep compute_mcast_idx()?
> 
> Thanks

Hi Jason,

I did think about this, however at the very minimum you'd need 
big-endian and little-endian variants of compute_mcast_idx(), and then 
you see that eepro100 applies a different bitmask/shift which is yet 
another variant...

For this reason I moved them all inline to the QEMU driver and that made 
it possible to compare the hash calculation directly with the 
corresponding Linux driver which found the 3 potential bugs above. So I 
think this is a net win (pardon the pun) on all sides :)


ATB,

Mark.
