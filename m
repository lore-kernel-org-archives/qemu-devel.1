Received: from eggs.gnu.org ([2001:4830:134:3::10]:51372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9b0I-0007fP-MM
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9b0H-00039U-HS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:43:26 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9b0H-000377-7M
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:43:25 -0400
Received: by mail-wr0-x232.google.com with SMTP id z73-v6so25413742wrb.0
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 11:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180420155045.18862-1-alex.bennee@linaro.org>
	<20180420183557.GA29359@flamenco>
In-Reply-To: <20180420183557.GA29359@flamenco>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Fri, 20 Apr 2018 18:43:12 +0000
Message-ID: <CAHDbmO2xhLYC8nFLvW8r59yPmJwCK82Mk=3_C_10V6kHVzToXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Convert softmmu-template into
 normal code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, pbonzini@redhat.com

Awesome, thanks!

On Fri, 20 Apr 2018, 19:35 Emilio G. Cota, <cota@braap.org> wrote:

> On Fri, Apr 20, 2018 at 16:50:39 +0100, Alex Benn=C3=A9e wrote:
> > Any questions/thoughts/comments?
>
> Very nice!
>
> I modified the style a little bit, namely to pass checkpatch and to
> improve grepability by having
>   foo __attribute__((flatten))
>   function(arg1, arg2, ...)
> as opposed to
>   foo __attribute__((flatten)) function(arg1,
>                                         arg2,
>                                         ...)
>
> I also changed the patches to make the series simpler: one patch
> to add softmmu.c (without compiling it yet), one patch to
> actually use softmmu.c, and a final patch to remove the template
> file.
>
> You can get my modifications from:
>   https://github.com/cota/qemu/tree/softmmu
>
> Note that there are two stray references to softmmu_template
> in comments:
> $ git grep -i 'softmmu_template'
> accel/tcg/translate-all.c: * Called via softmmu_template.h when code area=
s
> are written to with
> accel/tcg/translate-all.c: * Called by softmmu_template.h, with iothread
> mutex not held.
>
> I don't have time right now to test performance, but at least
> the only function I checked (helper_ret_ldub_mmu) has only grown
> in size by a little bit, from 584 bytes to 614.
>
> The executable is now larger:
>
> - before:
>    text    data     bss     dec     hex filename
> 9864951 2944592 4371560 17181103        10629af
> aarch64-softmmu/qemu-system-aarch64
>
> - after:
>    text    data     bss     dec     hex filename
> 9892095 2944592 4371560 17208247        10693b7
> aarch64-softmmu/qemu-system-aarch64
>
> By removing flatten we can decrease the overall size, but this might
> affect perf:
>    text    data     bss     dec     hex filename
> 9849967 2944592 4371560 17166119        105ef27
> aarch64-softmmu/qemu-system-aarch64
>
> This is a slow path though so it might be worth looking into.
>
> BTW I haven't done any testing, just compile-tested for all targets.
>
> So overall I think this should be upgraded from RFC to a proper patch
> series; hopefully we can get this done for 2.13!
>
> Thanks,
>
>                 Emilio
>
