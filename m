Received: from eggs.gnu.org ([2001:4830:134:3::10]:56082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgrg6-0005nC-SK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgrg5-0000qr-Ka
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:35:18 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgrg5-0000pW-Dp
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:35:17 -0500
Received: by mail-wr0-x230.google.com with SMTP id z61so19872751wrc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 03:35:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
	<5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 11:34:55 +0000
Message-ID: <CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>

On 23 February 2017 at 10:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 23/02/2017 11:23, Peter Maydell wrote:
>> On 23 February 2017 at 10:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> On 23/02/2017 11:02, Peter Maydell wrote:
>>>> I'm really not convinced we need DEVICE_HOST_ENDIAN. RAM
>>>> areas should be target-endian (you can probably define
>>>> "target endianness" as "the endianness that RAM areas have".)
>>>
>>> This is not RAM.  This is MMIO, backed by a MMIO area in the host.
>>
>> Hmm, I see...the naming is a bit unfortunate if it's not RAM.
>
> Yeah, it's called like that because it is backed by a RAMBlock but it
> returns false for memory_access_is_direct.

We should probably update the doc comment to note that the
pointer is to host-endianness memory (and that this is not
like normal RAM which is target-endian)...

>>> The
>>> MemoryRegionOps read from the MMIO area (so the data has host
>>> endianness) and do not do any further swap:
>>>
>>>         data = *(uint16_t *)(mr->ram_block->host + addr);
>>>
>>> Here, the dereference is basically the same as ldl_he_p.
>>>
>>> If you wanted to make the MemoryRegion use DEVICE_NATIVE_ENDIAN, you'd
>>> need to tswap around the access.  Or you can use ldl_le_p and
>>> DEVICE_LITTLE_ENDIAN (this is what Yongji's patch open codes), or
>>> ldl_be_p and DEVICE_BIG_ENDIAN.  They are all the same in the end.
>>
>> Using stl_p &c in a DEVICE_NATIVE_ENDIAN MR would work too, right?
>> (This is how all the NATIVE_ENDIAN MRs in exec.c work.)
>
> Yes, it should, as long as the memcpy(...) of {ld,st}*_he_p is compiled
> to a single access, which should be the case.

...and whichever of these approaches we take, we should have
a comment which notes that we are converting from the host
endianness memory to the endianness specified by the MemoryRegion
endianness attribute.

thanks
-- PMM
