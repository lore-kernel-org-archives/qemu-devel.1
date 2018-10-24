Received: from eggs.gnu.org ([2001:4830:134:3::10]:58588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gFMZf-0002V0-5S
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gFMZb-0007ni-FP
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:04:02 -0400
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:43995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gFMZb-0007ml-8n
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:03:59 -0400
Received: from player763.ha.ovh.net (unknown [10.109.146.76])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 04D0313E3A7
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 19:03:56 +0200 (CEST)
References: <20181022121907.13635-1-ppandit@redhat.com>
	<20181023153710.GZ12127@umbus.hotspot.internet-for-guests.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <679f5ba4-749b-72ee-62a0-40e5efc178e0@kaod.org>
Date: Wed, 24 Oct 2018 19:03:48 +0200
MIME-Version: 1.0
In-Reply-To: <20181023153710.GZ12127@umbus.hotspot.internet-for-guests.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 10/23/18 5:37 PM, David Gibson wrote:
> On Mon, Oct 22, 2018 at 05:49:07PM +0530, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While performing PowerNV memory r/w operations, the access length
>> 'sz' could exceed the data[4] buffer size. Add check to avoid OOB
>> access.
>>
>> Reported-by: Moguofang <moguofang@huawei.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> 
> So, it certainly does look like we can get an overrun here.  But is
> just turning the access into a no-op if the size is too large the
> correct behaviour?  It doesn't seem a very likely behaviour for the
> actual hardware.
> 
> Should we be reporting an error via some register bits?  Or should we
> be masking or truncating the size field instead the size down to
> something smaller?
> 
> BenH or Cedric, do you know how the hardware actually behaves here?

8bytes reads and writes are supported by the ECCB, which interfaces with 
the OPB master, which interfaces with the LPC HC. The HW is bit complex 
in that area. There are a few legacy devices.

skiboot only uses 1 and 4 bytes accesses if I am correct so we didn't 
fall into the trap.

I think using a data[8] would be more appropriate. It would make the 
pnv_lpc_do_eccb() routine a little more complex. I tried to rewrite it
to have a common one with the P9 LPC model but could not find a common
pattern. P9 is purely MMIO based. Something on the TODO list.

8 bytes accesses will then fail anyhow because all MemoryRegionOps have 
a max_access_size = 4.

Thanks,

C.

> 
>> ---
>>  hw/ppc/pnv_lpc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
>> index d7721320a2..f5e5bd4053 100644
>> --- a/hw/ppc/pnv_lpc.c
>> +++ b/hw/ppc/pnv_lpc.c
>> @@ -158,6 +158,10 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
>>      uint8_t data[4];
>>      bool success;
>>  
>> +    if (sz > sizeof(data)) {
>> +        return;
>> +    }
>> +
>>      if (cmd & ECCB_CTL_READ) {
>>          success = opb_read(lpc, opb_addr, data, sz);
>>          if (success) {
> 
