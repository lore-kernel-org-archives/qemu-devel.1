Received: from eggs.gnu.org ([2001:4830:134:3::10]:44824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddwKn-0003s8-W2
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 06:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddwKm-0000AW-QY
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 06:29:30 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:38827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddwKm-00009e-J0
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 06:29:28 -0400
Received: by mail-wr0-x236.google.com with SMTP id f21so24202178wrf.5
	for <qemu-devel@nongnu.org>; Sat, 05 Aug 2017 03:29:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
	<50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Aug 2017 11:29:06 +0100
Message-ID: <CAFEAcA9bHrS5QrT5dSeB_Eco8MdRbjuyHaqCNYfVfb+W3a==Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/8] boards.h: Define new flag
 ignore_memory_transaction_failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 4 August 2017 at 19:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 08/04/2017 02:20 PM, Peter Maydell wrote:
>> We need this for ARM boards, where we're about to implement support for
>> generating external aborts on memory transaction failures. Too many
>> of our legacy board models rely on the RAZ/WI behaviour and we
>> would break currently working guests when their "probe for device"
>> code provoked an external abort rather than a RAZ.

> I think some firmware will give some surprises, those probing device is n=
ot
> here and expect RAZ/WI. I remember some fw probing PCI space, or enumerat=
ing
> CS this way for ex.

PCI space is funny anyway because IIRC the PCI spec mandates
RAZ/WI (which is handled by QEMU's PCI implementation I think,
it doesn't fall out to the memory system's unmapped-address
handling).

That said: yes, possibly some guest code really wants the fault
(indeed the motivation for this patchset was having some test
guest code which wanted to see the faults), but that guest code
won't work on QEMU today, so if it doesn't boot on QEMU with
this patchsets that's not a regression. We can then (as the
issue arises) look at fixing whatever particular board model
it is to properly model or stub out all its devices so we
can boot that guest code without breaking existing working
guest code.

> RAZ/WI is a bus-feature, this is also bus-dependent to reply with abort o=
r
> behave RAZ/WI. Maybe the effort should be done on how model/use buses in
> QEMU? Bus device would be an alias of unimplemented_device, which current
> purpose is more debugging than avoiding unassigned physical access aborts=
.

You can model this kind of bus-dependent behaviour by having
the bus register a background region which implements the
default behaviour that is desired. (That way accesses to
that part of the address space don't ever respond with
a transaction error, which is what's happening on hardware
where the bus doesn't report errors.)

thanks
-- PMM
