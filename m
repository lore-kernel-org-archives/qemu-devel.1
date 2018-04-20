Received: from eggs.gnu.org ([2001:4830:134:3::10]:42795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9bRg-0002v2-Kq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9bRd-0003Jx-Bs
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:11:44 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:36381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9bRd-0003JN-6j
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:11:41 -0400
Received: by mail-qt0-x229.google.com with SMTP id q13-v6so10976455qtl.3
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 12:11:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
	<20180420183557.GA29359@flamenco>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9b39de2c-5682-bbbc-43f9-cc3397ea6e93@amsat.org>
Date: Fri, 20 Apr 2018 16:11:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180420183557.GA29359@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org, pbonzini@redhat.com

On 04/20/2018 03:35 PM, Emilio G. Cota wrote:
> On Fri, Apr 20, 2018 at 16:50:39 +0100, Alex Bennée wrote:
>> Any questions/thoughts/comments?
> 
> Very nice!

Yep :)

> 
> I modified the style a little bit, namely to pass checkpatch and to
> improve grepability by having
>   foo __attribute__((flatten))
>   function(arg1, arg2, ...)
> as opposed to
>   foo __attribute__((flatten)) function(arg1,
>                                         arg2,
>                                         ...)

I thought the same while reviewing and agree.

> 
> I also changed the patches to make the series simpler: one patch
> to add softmmu.c (without compiling it yet), one patch to
> actually use softmmu.c, and a final patch to remove the template
> file.

By "without compiling" you mean it is not compilable?
That would mean not script-bisectable.

> 
> You can get my modifications from:
>   https://github.com/cota/qemu/tree/softmmu
> 
> Note that there are two stray references to softmmu_template
> in comments:
> $ git grep -i 'softmmu_template'
> accel/tcg/translate-all.c: * Called via softmmu_template.h when code areas are written to with
> accel/tcg/translate-all.c: * Called by softmmu_template.h, with iothread mutex not held.
> 
> I don't have time right now to test performance, but at least
> the only function I checked (helper_ret_ldub_mmu) has only grown
> in size by a little bit, from 584 bytes to 614.
> 
> The executable is now larger:

This is odd, I was expecting some shrinking...

What kind of build are doing? More such -ggdb or such -O3?

> 
> - before:
>    text    data     bss     dec     hex filename
> 9864951 2944592 4371560 17181103        10629af aarch64-softmmu/qemu-system-aarch64
> 
> - after:
>    text    data     bss     dec     hex filename
> 9892095 2944592 4371560 17208247        10693b7 aarch64-softmmu/qemu-system-aarch64
> 
> By removing flatten we can decrease the overall size, but this might affect perf:
>    text    data     bss     dec     hex filename
> 9849967 2944592 4371560 17166119        105ef27 aarch64-softmmu/qemu-system-aarch64
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
> 		Emilio
> 
