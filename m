Received: from eggs.gnu.org ([2001:4830:134:3::10]:52369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1cgRki-0006oU-EB
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 02:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1cgRkd-0005rp-Fp
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 02:54:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xyjxie@linux.vnet.ibm.com>)
	id 1cgRkd-0005rh-5O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 02:54:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1M7om0Q120517
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 02:54:12 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s411n9e1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 02:54:11 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <xyjxie@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 00:54:10 -0700
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170221092137.5b6cecbb@t450s.home>
	<27972408-a43b-60f9-86ad-e4e47f4f8f14@redhat.com>
	<CAFEAcA-L-ofsPmyOMhnAxUnkhHy0Zs1j2uCbUVRHV6a+WG0Thw@mail.gmail.com>
	<20170221114435.2025350d@t450s.home>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 15:54:01 +0800
MIME-Version: 1.0
In-Reply-To: <20170221114435.2025350d@t450s.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <19478f0d-c138-5ddb-d9c1-4598ae0d2cd2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, zhong@linux.vnet.ibm.com

on 2017/2/22 2:44, Alex Williamson wrote:

> On Tue, 21 Feb 2017 18:09:04 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 21 February 2017 at 16:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> On 21/02/2017 17:21, Alex Williamson wrote:
>>>> On Tue, 21 Feb 2017 14:46:55 +0800
>>>> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>>>>   
>>>>> At the moment ram device's memory regions are NATIVE_ENDIAN. This does
>>>>> not work on PPC64 because VFIO PCI device is little endian but PPC64
>>>>> always defines static macro TARGET_WORDS_BIGENDIAN.
>>>>>
>>>>> This fixes endianness for ram device the same way as it is done
>>>>> for VFIO region in commit 6758008e2c4e79fb6bd04fe8e7a41665fa583965.
>>>> The referenced commit was to vfio code where the endianness is fixed,
>>>> here you're modifying shared generic code to assume the same
>>>> endianness as vfio.  That seems wrong.
>>> Is the goal to have the same endianness as VFIO?  Or is it just a trick
>>> to ensure the number of swaps is always 0 or 2, so that they cancel away?
>>>
>>> In other words, would Yongji's patch just work if it used
>>> DEVICE_BIG_ENDIAN and beNN_to_cpu/cpu_to_beNN?  If so, then I think the
>>> patch is okay.
>> I think any patch that proposes adding or removing one or more
>> endianness related swaps should come with a commit message that
>> states very clearly why this exact point in the stack is the
>> correct place to do these swaps, from a design point of view.
>> (This is so we can avoid the pitfall of putting in enough swaps
>> to cancel each other out but at the wrong point in the design.)
>>
>> In this instance I don't understand the patch. The ram_device
>> mem-ops are there to deal with memory regions backed by a
>> lump of RAM, right? Lumps of memory are always the endianness
>> of the host CPU by definition, so DEVICE_NATIVE_ENDIAN and
>> no swapping in the accessors seems like it ought to be the right
>> thing...
> I'm glad I'm not the only one confused.  The clarity I can add is that
> for vfio, we define that any read/write to the vfio file descriptor is
> little endian.  The kernel does cpu_to_leXX/leXX_to_cpu around the
> ioreadXX/iowriteXX calls.  For better or worse, this gets us around the
> implicit CPU endianness of the data there and gives us a standard
> endianness.  mmaps are of course device native endian, but the point of
> the ram device was that some devices (realtek NICs) don't respond well
> to using memcpy through the mmap and we're better off using explicit
> reads and writes.
>
> The part where I get lost is that if PPC64 always sets the target
> to big endian, then adjust_endianness() we will always bswap after a
> read and before a write.  I don't follow how that bswap necessarily
> gets us to QEMU CPU endian such that the cpu_to_leXX/leXX_to_cpu in the
> access functions always do the right thing.  I know we do this
> elsewhere in vfio, perhaps I've deferred to someone convincing me it
> was the right thing at the time, but I'm not able to derive it myself
> currently.
>
> To answer Paolo's question, if PPC64 sets TARGET_WORDS_BIGENDIAN, which
> is a compile time setting, then using DEVICE_BIG_ENDIAN would
> deterministically remove the bswap from adjust_endianness(), but I
> don't know how anything is deterministic about CPU-relative byte swaps
> since (I think) PPC64 could actually be running in either.  +1 to being
> very explicit about which swaps are occurring where.  Thanks,
>

Actually I also have some confusions about the endianness during fixing 
this issue...

I assume that kvm_run->mmio.data is stored as the endianness of device that
guest try to accesss. For one mmio write,  we may do the *first* bswap in
address_space_write_continue(). The ldX_p() will do the bswap when 
target and
host endianness are different. Then adjust_endianness() may do the 
*second* bswap
when target and device endianness are different.

Here are all possible cases:

run->mmio.data    device    target    host    for mr->ops->write()
============================================================
little        native    big    big    little
little        native    little    little    little
little        native    big    little    big (this is the wrong case we 
found)
little        native    little    big    big
==============================================================
little        little    big    big    big (could be fixed by cpu_to_leXX)
little        little    little    little    little
little        little    big    little    little
little        little    little    big    big (could be fixed by cpu_to_leXX)
==============================================================
big        native    big    big    big
big        native    little    little    big
big        native    big    little    little
big        native    little    big    little
==============================================================
big        big    big    big    big
big        big    little    little    little (could be fixed by cpu_to_beXX)
big        big    big    little    little (could be fixed by cpu_to_beXX)
big        big    little    big    big

We can easily find that native_endian device doesn't work when target 
and host
endianness are different. So I fix it like this patch does. But I'm 
wrong to
assume the same endianness as vfio in this patch like Alex said. So maybe
we should consider an endian option in memory_region_init_ram_device_ptr().

Back to my confusion, I failed to understand the objective of those two 
swaps.
Is it possible to pass the run->mmio.data directly to mr->ops->write()? 
Seems
like those two swaps are based on the fact that run->mmio.data is stored as
host-endian rather than the endianness of device that guest try to 
accesss. Am
I missed something important here?

Thanks,
Yongji
