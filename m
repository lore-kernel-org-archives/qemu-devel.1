Received: from eggs.gnu.org ([209.51.188.92]:39450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gyi0b-0007JJ-7n
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gyi0a-0001PD-1q
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:03:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:45481
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gyi0Z-0001NB-OG
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:03:15 -0500
References: <20190215143115.28777-1-alex.bennee@linaro.org>
	<87d0nn6eoi.fsf@zen.linaroharston> <20190219182528.GA19925@flamenco>
	<01acc60d-5f00-20ed-4631-6da98ae4da7e@ilande.co.uk>
	<874l8qnbqt.fsf@zen.linaroharston>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <04dc02ce-c217-d4e0-b0dd-e6dc233bc1b2@ilande.co.uk>
Date: Tue, 26 Feb 2019 19:03:02 +0000
MIME-Version: 1.0
In-Reply-To: <874l8qnbqt.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] softmmu demacro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 26/02/2019 09:24, Alex Bennée wrote:

>> Presumably the issue here is somehow related to the compiler incorrectly
>> extending/reducing the shift when the larger type is involved? Also during my tests
>> the visual corruption was only present for 32-bit accesses, but presumably all the
>> access sizes will need a similar fix.
> 
> So I did fix this in the third patch when I out of lined the unaligned
> helpers so:
> 
>      const tcg_target_ulong size_mask = MAKE_64BIT_MASK(0, size * 8);
> 
> and
> 
>      /* Big-endian combine.  */
>      r2 &= size_mask;
> 
> or
> 
>      /* Little-endian combine.  */
>      r1 &= size_mask;
> 
> I guess I should also apply that to patch 1 for bisectability.

I've done that locally, and while things have improved with progress bars I'm still
seeing some strange blank fills appearing on the display in MacOS. I'll have another
dig further and see what's going on...

> Thanks for digging into the failures. It does make me think that we
> really could do with some system mode tests to properly exercise all
> softmmu code paths:
> 
>   * each size access, load and store
>   * unaligned accesses, load and store (+ potential arch specific handling)
>   * page striding accesses faulting and non-faulting
> 
> I'm not sure how much work it would be to get a minimal bare metal
> kernel that would be able to do these and report success/fail. When I
> did the MTTCG work I used kvm-unit-tests as a fairly complete mini-os
> but maybe that's overkill for what we need here. After all we already
> have migration kernels that just do a simple tick-tock for testing
> migration. It would be nice to have the tests in C with maybe a minimal
> per-arch assembly so we can share the tests across various platforms.

Right. Having unrolled the macros myself whilst softmmu_template.h appears on the
surface to be deceptively simple, it hides quite a few subtle implementation details
which is why I think your work is so valuable here.


ATB,

Mark.
