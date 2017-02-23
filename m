Received: from eggs.gnu.org ([2001:4830:134:3::10]:35618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgvwe-00014w-TN
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgvwe-0001x2-1S
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:08:40 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgvwd-0001wg-S1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:08:39 -0500
Received: by mail-wm0-x231.google.com with SMTP id v186so176304839wmd.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 08:08:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c76578aa-ec76-f904-b0fc-72676e4ce515@redhat.com>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
	<5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
	<CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
	<3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
	<CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
	<41630a89-e645-7d7e-b7c2-356fd6dcadee@redhat.com>
	<CAFEAcA_Mh9ZrJeu4f==ko1k2yLkfPe2AwNbUHcxkmS6Lzuvk0Q@mail.gmail.com>
	<2565ef99-9c16-e836-08c6-0915f5d4b0f8@redhat.com>
	<CAFEAcA_BgiXrjW9aRNFkXEEjS+kjibJ_UisJtiLgrPh=0re5qA@mail.gmail.com>
	<c76578aa-ec76-f904-b0fc-72676e4ce515@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 16:08:18 +0000
Message-ID: <CAFEAcA_waGB88XyzGxFbE_OyLAPnY70aEVQYzbS0k3KR+FF9DA@mail.gmail.com>
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

On 23 February 2017 at 15:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 23/02/2017 16:29, Peter Maydell wrote:
>>> No, they look entirely the same.  The only difference is that they go
>>> through MemoryRegionOps instead of memcpy.
>> Then we have a different problem, because the thing this patch
>> is claiming to fix is that the memory the device is backed by
>> (from vfio) is little-endian and we're not accessing it right.
>>
>> RAM of the usual sort is target-endian (by which I mean "when the guest
>> does a write of 32-bits 0x12345678, and you look at the memory byte
>> by byte then the order of bytes is either 0x12 0x34 0x56 0x78 if
>> TARGET_LITTLE_ENDIAN or 0x78 0x56 0x34 0x12 if TARGET_BIG_ENDIAN").
>
> Okay, I think I see what you mean.
>
> MMIO regions do not expect their datum in any endianness; they just get
> a uint64_t representing an 8/16/32/64-bit value.  The datum undergoes a
> conversion if necessary, according to target and MemoryRegionOps
> endiannesses, before the callback is invoked.

Yep. However, how they implement 8/16/32/64 bit transfers
implies an endianness model (assuming it is consistent and
the device provides enough of the operations to determine one).

> In the ramd case, the ops convert between
> bunch-of-bytes-stored-into-RAM-by-host and uint64_t (to uint64_t for
> read, from uint64_t for write).  The conversion from/to target
> endianness has been done already by the memory.c core code.  The ops'
> task is to ensure that this bunch of bytes has the exact order that the
> guest desired.  There's more than one way to do it---all that's needed
> is that the order used by the ops matches the one specified by the ops'
> endianness, resulting in an even number of swaps.
>
> However, DEVICE_NATIVE_ENDIAN would have to be paired with tswap, which
> the current code does not do, hence the bug.  To have no swap at all,
> you'd need DEVICE_HOST_ENDIAN.

Yes, I agree that the current ramdevice code has this bug (and
that we can fix it by any of the various options).

>> AIUI what we want for this VFIO case is "when the guest does
>> a 32-bit write of 0x12345678 then the bytes are 0x12 0x34 0x56 0x78
>> regardless of whether TARGET_BIG_ENDIAN or not".
>
> No, I don't think so.  This is not specific to VFIO.  You can do it with
> any device, albeit VFIO is currently the only one using ramd regions.

The commit message in the patch that started this thread off
says specifically that "VFIO PCI device is little endian".
Is that wrong?

thanks
-- PMM
