Received: from eggs.gnu.org ([2001:4830:134:3::10]:33465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1ciemQ-0006pt-LZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1ciemL-0000Zz-MQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:13:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xyjxie@linux.vnet.ibm.com>)
	id 1ciemL-0000ZN-DN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:13:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SA95AB000793
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:13:07 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28w3d4j7ps-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:13:07 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <xyjxie@linux.vnet.ibm.com>;
	Tue, 28 Feb 2017 03:13:06 -0700
References: <1488171164-28319-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170228004101.GG17615@umbus.fritz.box>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 28 Feb 2017 18:12:56 +0800
MIME-Version: 1.0
In-Reply-To: <20170228004101.GG17615@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <ba290b8f-5967-eb50-3ba5-514a28bd0dda@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] memory: Introduce DEVICE_HOST_ENDIAN
 for ram device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, qemu-devel@nongnu.org, alex.williamson@redhat.com, aik@ozlabs.ru, peter.maydell@linaro.org, paulus@samba.org, mdroth@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com

on 2017/2/28 8:41, David Gibson wrote:

> On Mon, Feb 27, 2017 at 12:52:44PM +0800, Yongji Xie wrote:
>> At the moment ram device's memory regions are DEVICE_NATIVE_ENDIAN. It's
>> incorrect. This memory region is backed by a MMIO area in host, so the
>> uint64_t data that MemoryRegionOps read from/write to this area should be
>> host-endian rather than target-endian. Hence, current code does not work
>> when target and host endianness are different which is the most common case
>> on PPC64. To fix it, this introduces DEVICE_HOST_ENDIAN for the ram device.
>>
>> This has been tested on PPC64 BE/LE host/guest in all possible combinations
>> including TCG.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> The effect of the patch is certainly correct.  I remain a little
> concerned that the name "host endian" might cause more confusion than
> it resolves, but a better term isn't immediately obvious to me.

If the memory region's endianness indicates the endianness of multi-byte 
value that
MemoryRegionOps read from/write to this memory region, should "host endian"
be reasonable?

For a mmio store, QEMU just get a bunch of bytes in the memory at the 
beginning.
Then we use ldX_p to load a target-endian multi-byte value from the 
memory.  Then
adjust_endianness() change the endianness of the multi-byte value from 
target-endian
to memory region's endianness.

For the mmap MMIO area, we should use host-endian multi-byte value to 
access it.

*(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;

Here it is the same as stl_he_p().

The "host-endian" means we load a bunch of bytes as a host-endian value, 
and write the
value to the mmap MMIO area. That's my understanding. Not sure if it's 
correct.

Thanks,
Yongji
