Received: from eggs.gnu.org ([2001:4830:134:3::10]:60521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyxxA-00019c-DZ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyxx9-0004bJ-KW
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:00:16 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyxx9-0004ay-ET
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:00:15 -0400
Received: by mail-ot0-x243.google.com with SMTP id r30-v6so8954354otr.2
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 04:00:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8f878d04-d5c2-77ae-9fb9-d98d41efac3c@amsat.org>
References: <20180320134114.30418-1-peter.maydell@linaro.org>
	<20180320134114.30418-5-peter.maydell@linaro.org>
	<8f878d04-d5c2-77ae-9fb9-d98d41efac3c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 10:59:54 +0000
Message-ID: <CAFEAcA-nShiCLTDvgeLxCoUJciB3uTLCGeLLD0mRLtRFj8WN1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 4/4] target/arm: Always set FAR to
 a known unknown value for debug exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21 March 2018 at 22:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 03/20/2018 02:41 PM, Peter Maydell wrote:
>> For debug exceptions due to breakpoints or the BKPT instruction which
>> are taken to AArch32, the Fault Address Register is architecturally
>> UNKNOWN.  We were using that as license to simply not set
>> env->exception.vaddress, but this isn't correct, because it will
>> expose to the guest whatever old value was in that field when
>> arm_cpu_do_interrupt_aarch32() writes it to the guest IFSR.  That old
>> value might be a FAR for a previous guest EL2 or secure exception, in
>> which case we shouldn't show it to an EL1 or non-secure exception
>> handler. It might also be a non-deterministic value, which is bad
>> for record-and-replay.
>>
>> Clear env->exception.vaddress before taking breakpoint debug
>> exceptions, to avoid this minor information leak.
>
> So this series is worth Cc'ing qemu-stable...?

I don't think so. This isn't a regression -- we've behaved this
way ever since we introduced LPAE support, five years or so ago.
In particular Linux doesn't care about it.

thanks
-- PMM
