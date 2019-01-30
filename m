Received: from eggs.gnu.org ([209.51.188.92]:55789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gost6-0000NS-6Z
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gost4-00021C-8g
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:38:56 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9dc7c83c-a63c-9cde-1267-43bc62e73436@redhat.com>
Date: Wed, 30 Jan 2019 17:38:33 +0100
MIME-Version: 1.0
In-Reply-To: <300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 01/30/19 15:33, Paolo Bonzini wrote:
> On 30/01/19 15:13, Markus Armbruster wrote:
>>     -global driver=cfi.pflash01,property=secure,value=on
>>
>> Affects *all* such devices, but fortunately we have at most two, and
>> the one we don't want to affect happens to ignore the property value.
>
> Is this true?  I think both need secure=on, at least on x86.

commit f71e42a5c98722d6faa5be84a34fbad90d27dc04
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Apr 8 14:09:43 2015 +0200

    pflash_cfi01: add secure property

    When this property is set, MMIO accesses are only allowed with the
    MEMTXATTRS_SECURE attribute.  This is used for secure access to UEFI
    variables stored in flash.

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

If you don't add "secure=on" to unit#0, then MMIO accesses will be
possible outside of SMM. From those, I'd hazard "MMIO reads" are
generally irrelevant. "MMIO writes" could succeed to the RAM image, but:

- they are never written back to the disk (due to readonly=on),

- the actual contents of unit#0 stops mattering as soon as the SEC phase
  decompresses the PEIFV and DXEFV firmware volumes from it, to DRAM.
  The SMM infrastructure is then constructed in SMRAM from DRAM. By the
  time a 3rd party UEFI application or driver, or an OS, is reached, the
  sensitive bits are all locked in SMRAM.

... But, I wonder if S3 resume would be under threat in this case. In
that case, SEC runs again (from pflash), and it re-decompresses
PEIFV/DXEFV from pflash to DRAM. If the in-memory image of pflash
doesn't revert to the (pristine, due to readonly=on) disk image at
platform reset, then I reckon there could be a problem; the SEC code and
the compressed FVs could have been tampered with in memory.

I guess it's best to apply secure=on to unit#0 as well, after all :)

Thanks!
Laszlo
