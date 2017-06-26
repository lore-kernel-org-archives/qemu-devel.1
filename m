Received: from eggs.gnu.org ([2001:4830:134:3::10]:36138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPSvD-0000Iv-Qm
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPSvC-0002dZ-UT
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:15:15 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPSvC-0002cl-NV
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:15:14 -0400
Received: by mail-wm0-x230.google.com with SMTP id 62so5600763wmw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 05:15:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87mv8vc5va.fsf@frigg.lan>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan>
	<CAFEAcA-434=WhBxC=KB2HBhrPG9b+z1i3jqeFgiE=H8ceZJYzg@mail.gmail.com>
	<87mv91tn7d.fsf@linaro.org> <87r2y8gsy1.fsf@frigg.lan>
	<87efu89di5.fsf@linaro.org> <87shindrqi.fsf@frigg.lan>
	<CAFEAcA8VqE13i3BBs34KSh6cY=McxP=CmxU8nXpp4WaPTSLiRg@mail.gmail.com>
	<87mv8vc5va.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 13:14:52 +0100
Message-ID: <CAFEAcA8m8cKnVeqvoGnP7uNetMyPTPkc3GRELNa3OLoGS5FgEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Jayanto Minocha <jayanto@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26 June 2017 at 13:04, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
> Peter Maydell writes:
>
>> On 26 June 2017 at 10:26, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrot=
e:
>>> There's two places where memory access tracing is triggered:
>>>
>>> * tcg_gen_qemu_ld/st_...
>>> * ld/st templates (both softmmu and user)
>>>
>>> AFAIK, helpers use the ld/st templates to access guest memory.
>
>> Mostly, but there are one or two special cases, for instance
>> the ARM HELPER(dc_zva) in target/arm/helper.c, which has a
>> fastpath that uses tlb_vaddr_to_host to look up the host memory
>> address and then memset to do the clear-to-zeroes operation.
>
> Should that be replaced with a cpu_memset or similar?

Possibly -- PPC and S390 also have a fast-memset like this
(and S390 also has a fast-memmove). However I would be wary
of there being architecture-specific corner cases (eg
needing to get the right vaddr for a fault if the accesses
fault).

thanks
-- PMM
