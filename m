Received: from eggs.gnu.org ([2001:4830:134:3::10]:60078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eMAw2-0007sd-GW
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eMAvy-0001gG-Kp
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:58:46 -0500
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:51665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eMAvy-0001d7-F2
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:58:42 -0500
Received: from player698.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 13E4FA627A
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 11:58:29 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-15-clg@kaod.org>
	<20171130044922.GC3023@umbus.fritz.box>
	<36b5b7a1-63f1-30ac-0fa6-a22b49df065f@kaod.org>
	<20171201041015.GE30161@umbus.fritz.box>
	<1512225938.2224.69.camel@kernel.crashing.org>
	<1512225979.2224.70.camel@au1.ibm.com>
	<20171204012029.GI2130@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5590f7f8-f2f8-f404-d6bc-a28a04853c3b@kaod.org>
Date: Tue, 5 Dec 2017 10:58:23 +0000
MIME-Version: 1.0
In-Reply-To: <20171204012029.GI2130@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/25] spapr: push the XIVE EQ data in OS
 event queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/04/2017 01:20 AM, David Gibson wrote:
> On Sat, Dec 02, 2017 at 08:46:19AM -0600, Benjamin Herrenschmidt wrote:
>> On Sat, 2017-12-02 at 08:45 -0600, Benjamin Herrenschmidt wrote:
>>> On Fri, 2017-12-01 at 15:10 +1100, David Gibson wrote:
>>>>
>>>> Hm, ok.  Guest endian (or at least, not definitively host-endian) data
>>>> in a plain uint32_t makes me uncomfortable.  Could we use char data[4]
>>>> instead, to make it clear it's a byte-ordered buffer, rather than a
>>>> number as far as the XIVE is concerned.
>>>>
>>>> Hm.. except that doesn't quite work, because the hardware must define
>>>> which end that generation bit ends up in...
>>>
>>> It also needs to be written atomically. Just say it's big endian.
>>
>> Also the guest reads it using be32_to_cpup...
> 
> Ok.  Definitely should be treated as BE and read/written with the be32
> DMA helper functions.
> 

hmm, the stl_be_dma does not return errors but dma_memory_write()
does. 

    static inline void st##_sname##_##_end##_dma(AddressSpace *as,      \
                                                 dma_addr_t addr,       \
                                                 uint##_bits##_t val)   \
    {                                                                   \
        val = cpu_to_##_end##_bits(val);                                \
        dma_memory_write(as, addr, &val, (_bits) / 8);                  \
    }

These macros seem to be only used by spapr_vio and nvram. I can probably 
change them.

C.
