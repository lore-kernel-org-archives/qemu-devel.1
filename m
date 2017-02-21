Received: from eggs.gnu.org ([2001:4830:134:3::10]:52186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgEsR-000253-21
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgEsP-0001lx-Tg
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:09:27 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgEsP-0001lr-MW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:09:25 -0500
Received: by mail-wr0-x22c.google.com with SMTP id s27so40399174wrb.2
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 10:09:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <27972408-a43b-60f9-86ad-e4e47f4f8f14@redhat.com>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170221092137.5b6cecbb@t450s.home>
	<27972408-a43b-60f9-86ad-e4e47f4f8f14@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 18:09:04 +0000
Message-ID: <CAFEAcA-L-ofsPmyOMhnAxUnkhHy0Zs1j2uCbUVRHV6a+WG0Thw@mail.gmail.com>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, zhong@linux.vnet.ibm.com

On 21 February 2017 at 16:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 21/02/2017 17:21, Alex Williamson wrote:
>> On Tue, 21 Feb 2017 14:46:55 +0800
>> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>>
>>> At the moment ram device's memory regions are NATIVE_ENDIAN. This does
>>> not work on PPC64 because VFIO PCI device is little endian but PPC64
>>> always defines static macro TARGET_WORDS_BIGENDIAN.
>>>
>>> This fixes endianness for ram device the same way as it is done
>>> for VFIO region in commit 6758008e2c4e79fb6bd04fe8e7a41665fa583965.
>>
>> The referenced commit was to vfio code where the endianness is fixed,
>> here you're modifying shared generic code to assume the same
>> endianness as vfio.  That seems wrong.
>
> Is the goal to have the same endianness as VFIO?  Or is it just a trick
> to ensure the number of swaps is always 0 or 2, so that they cancel away?
>
> In other words, would Yongji's patch just work if it used
> DEVICE_BIG_ENDIAN and beNN_to_cpu/cpu_to_beNN?  If so, then I think the
> patch is okay.

I think any patch that proposes adding or removing one or more
endianness related swaps should come with a commit message that
states very clearly why this exact point in the stack is the
correct place to do these swaps, from a design point of view.
(This is so we can avoid the pitfall of putting in enough swaps
to cancel each other out but at the wrong point in the design.)

In this instance I don't understand the patch. The ram_device
mem-ops are there to deal with memory regions backed by a
lump of RAM, right? Lumps of memory are always the endianness
of the host CPU by definition, so DEVICE_NATIVE_ENDIAN and
no swapping in the accessors seems like it ought to be the right
thing...

thanks
-- PMM
