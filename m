Received: from eggs.gnu.org ([2001:4830:134:3::10]:46433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5EQD-0001RR-1i
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5EQ7-00069q-78
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:15:53 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:52722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5EQ7-00069a-0g
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:15:47 -0400
Received: by mail-wm0-x22c.google.com with SMTP id k4so17775778wmc.1
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:15:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB0159A19F056CEE571E0397009E420@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <20171018001608.8388-1-Andrew.Baumann@microsoft.com>
	<CAFEAcA-6saNdT9k9Oo+cMoPWR-miaDq08EhN=3pbVzbadwzOwA@mail.gmail.com>
	<MWHPR21MB0159A19F056CEE571E0397009E420@MWHPR21MB0159.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 18:15:25 +0100
Message-ID: <CAFEAcA-=gSFmV+teOKtuwOc--Kd4Nd=DQL+b8+5XEE8BOY6qVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] arm: implement cache/shareability
 attribute bits for PAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 19 October 2017 at 18:04, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
>> From: Peter Maydell [mailto:peter.maydell@linaro.org]
>> Sent: Thursday, 19 October 2017 09:51
>>
>> On 18 October 2017 at 01:16, Andrew Baumann
>> <Andrew.Baumann@microsoft.com> wrote:
>> Hi; thanks for this patch. Looks like you forgot to add your
>> signed-off-by line.
>
> Thanks for the review!
>
> I didn=E2=80=99t sign the patch, because it wasn't ready to go in, and my=
 (limited)
> understanding of the protocol is that that's one of the things you're
> certifying in a signature.

Usually the way we do it is that if you have something that isn't
ready to go in, you mark it as [RFC], but you leave your signed-off-by
tag on it. That way if you should (hypothetically) disappear without
having time to update the RFC to a working version, somebody else
can start with the code you posted to the list and work on it.

Signed-off-by is really saying "I did this work and it's ok for this
to be distributed under the project's license", rather than a claim
about the quality of the code.

>> So you want the page table walk functions to directly fill in
>> the information about cacheability and shareability, including
>> doing lookups in MAIR registers (or PRRR/NMRR registers, which
>> QEMU stores in the same CPUState fields, but they have a different
>> format.)
>
> I agree. FWIW, the original reason for doing it here was that I
> didn't want to slow down the normal page-table walk with additional
> logic to compute the attributes, which isn't necessary for a TLB
> fill. If we're adding extra out parameters to the walker, then I
> can make those optional and skip computing them when the parameter
> is NULL.

Sure, though I think that if we've got to the point of having to
do a page table walk then we're already very much in the slow path,
so I don't mind if we just fill out the attributes every time.

thanks
-- PMM
