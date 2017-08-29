Received: from eggs.gnu.org ([2001:4830:134:3::10]:47538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dmnHm-0006y4-0y
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dmnHi-0006VC-Ez
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:38:57 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:38604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dmnHi-0006UW-78
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:38:54 -0400
Received: by mail-lf0-f47.google.com with SMTP id d202so17626355lfd.5
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 13:38:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCD-Ti84xKXh=7TCTgDKQ5YhvRtVAqfpO_iVXrU+RjfF1A@mail.gmail.com>
References: <20170828035327.17146-1-bobby.prani@gmail.com>
	<20170828035327.17146-2-bobby.prani@gmail.com>
	<8f6169d2-107c-ef7b-cc6f-1ad40a25365f@linaro.org>
	<CAJhHMCD-Ti84xKXh=7TCTgDKQ5YhvRtVAqfpO_iVXrU+RjfF1A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Aug 2017 22:38:50 +0200
Message-ID: <CABgObfZYMfmCEUDb8Hu768r-bqw5037=mTom7mEaTdS523uh7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] cpus-common: Cache allocated work
 items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, Sergey Fedorov <serge.fdrv@gmail.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Il 28 ago 2017 11:43 PM, "Pranith Kumar" <bobby.prani@gmail.com> ha scritto:

On Mon, Aug 28, 2017 at 1:47 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/27/2017 08:53 PM, Pranith Kumar wrote:
>> Using heaptrack, I found that quite a few of our temporary allocations
>> are coming from allocating work items. Instead of doing this
>> continously, we can cache the allocated items and reuse them instead
>> of freeing them.
>>
>> This reduces the number of allocations by 25% (200000 -> 150000 for
>> ARM64 boot+shutdown test).
>>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>
> Why does this list need to record a "last" element?
> It would seem a simple lifo would be sufficient.
>
> (You would also be able to manage the list via cmpxchg without a separate
lock,
> but perhaps the difference between the two isn't measurable.)
>

Yes, seems like a better design choice. Will fix in next iteration.


More recent glibc will also have an efficient per-thread allocator, and
though I haven't yet benchmarked the newer glibc malloc, GSlice is slower
than at least both tcmalloc and jemalloc. Perhaps you could instead make
work items statically allocated?

Thanks,

Paolo


Thanks,
--
Pranith
