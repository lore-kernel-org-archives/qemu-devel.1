Received: from eggs.gnu.org ([2001:4830:134:3::10]:47650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gKnWk-0000YX-K1
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gKnWb-0000oN-Vq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:51:25 -0500
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:33928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gKnWb-0000nK-MN
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:51:21 -0500
Received: from player738.ha.ovh.net (unknown [10.109.160.40])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 243F22033B5
	for <qemu-devel@nongnu.org>; Thu,  8 Nov 2018 17:51:18 +0100 (CET)
References: <20181026123358.2554-1-ppandit@redhat.com>
	<12cdcb7d-9566-4eb6-52b3-94dc97ea408c@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <21ed9d28-9153-266c-5190-8c17aadff78e@kaod.org>
Date: Thu, 8 Nov 2018 17:51:09 +0100
MIME-Version: 1.0
In-Reply-To: <12cdcb7d-9566-4eb6-52b3-94dc97ea408c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Alexander Graf <agraf@suse.de>, Moguofang <moguofang@huawei.com>, David Gibson <david@gibson.dropbear.id.au>

Hello Laurent,

On 11/8/18 10:10 AM, Laurent Vivier wrote:
> On 26/10/2018 14:33, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While performing PowerNV memory r/w operations, the access length
>> 'sz' could exceed the data[4] buffer size. Add check to avoid OOB
>> access.
>>
>> Reported-by: Moguofang <moguofang@huawei.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  hw/ppc/pnv_lpc.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> Update v2: add error log message
>>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05750.html
>>
>> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
>> index d7721320a2..172a915cfc 100644
>> --- a/hw/ppc/pnv_lpc.c
>> +++ b/hw/ppc/pnv_lpc.c
>> @@ -155,9 +155,15 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
>>      /* XXX Check for magic bits at the top, addr size etc... */
>>      unsigned int sz = (cmd & ECCB_CTL_SZ_MASK) >> ECCB_CTL_SZ_LSH;
>>      uint32_t opb_addr = cmd & ECCB_CTL_ADDR_MASK;
>> -    uint8_t data[4];
>> +    uint8_t data[8];
>>      bool success;
> 
> I'm not sure 8 is enough.
> 
> ECCB_CTL_SZ_MASK is PPC_BITMASK(4, 7), and ECCB_CTL_SZ_LSH is (63 - 7).
> So the bitmask is 4 bits wide, and thus sz can be 0 to 15.
> I think data[] size should be 16.

The bitmask allows more that 8 but the specs says that 1, 2, 4, 8 are the 
possible value size. So We should be fine.

C.  

> 
> Thanks,
> Laurent
> 
