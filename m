Received: from eggs.gnu.org ([2001:4830:134:3::10]:49601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9yI-0006tl-Th
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9yE-0000zl-M6
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:00:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH9yE-0000vj-Bw
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:00:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id n5-v6so9256036wrw.12
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:00:49 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025151103.GA19931@flamenco> <878t2j21ko.fsf@linaro.org>
	<20181029154728.GA17805@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181029154728.GA17805@flamenco>
Date: Mon, 29 Oct 2018 16:00:46 +0000
Message-ID: <871s88agk1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC v4 00/71] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>, Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Alistair Francis <alistair23@gmail.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>


Emilio G. Cota <cota@braap.org> writes:

> On Sat, Oct 27, 2018 at 10:14:47 +0100, Alex Benn=C3=A9e wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>> > [I forgot to add the cover letter to git send-email; here it is]
>> >
>> > v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04179.html
>> >
>> > "Why is this an RFC?" See v3 link above. Also, see comment at
>> > the bottom of this message regarding the last patch of this series.
>>
>> I'm also seeing his hang on check-tcg, specifically qemu-aarch64 ./tests=
/linux-test
>
> Thanks for reporting. The last patch in the series is the one
> that causes the hang. I didn't test that patch much, since I
> did not intend to get it merged.

See patch 3, I think it's just because the per-cpu locks aren't
available in linux-user, breaking the exclusive mechanism.

> Over the weekend I had a bit of time to think about an actual fix, i.e.
> how to reduce safe work calls for TLB invalidations. The idea is to check
> whether the remote invalidation is necessary at all; we can take the remo=
te
> tlb's lock, and check whether the address we want to invalidate has been
> read by the remote CPU since its latest flush. On some quick tests
> booting an aarch64 system I measured that only up to ~2% of remote
> invalidations are actually necessary.
>
> I just did a search on google scholar and found a similar approach
> to reduce remote TLB shootdowns on ARM, this time for hardware.
> This paper
>   "TLB Shootdown Mitigation for Low-Power Many-Core Servers with
>   L1 Virtual Caches"
>   https://dl.acm.org/citation.cfm?id=3D3202975
> addresses the issue by employing bloom filters in hardware to
> determine whether an address has been accessed by a TLB before
> performing an invalidation (and the corresponding icache flush).
>
> In software, using a per-TLB hash table might be enough. I'll try
> to have something ready for v5.

OK.

--
Alex Benn=C3=A9e
