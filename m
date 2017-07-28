Received: from eggs.gnu.org ([2001:4830:134:3::10]:53114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1db0TF-0003tc-9R
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1db0TA-00088b-8y
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:18:05 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1db0TA-00085j-2E
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:18:00 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 33so95601378wrz.4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 01:17:57 -0700 (PDT)
References: <20170724210306.18428-1-bobby.prani@gmail.com>
	<98c62747-c020-e0f8-d0ce-c49bd05bb9d9@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <98c62747-c020-e0f8-d0ce-c49bd05bb9d9@redhat.com>
Date: Fri, 28 Jul 2017 09:17:54 +0100
Message-ID: <871sp1dlfx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] tcg/softmmu: Increase size of TLB cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, qemu-devel@nongnu.org, rth@twiddle.net


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 24/07/2017 23:03, Pranith Kumar wrote:
>> This patch increases the number of entries we allow in the TLB. I went
>> over a few architectures to see if increasing it is problematic. Only
>> armv6 seems to have a limitation that only 8 bits can be used for
>> indexing these entries. For other architectures, I increased the
>> number of TLB entries to a 4K-sized cache.
>>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>
> How did you benchmark this, and can you plot (at least for x86 hosts)
> the results as CPU_TLB_BITS_MAX grows from 8 to 12?

Pranith has some numbers but what we were seeing is the re-fill path
creeping up the perf profiles. Because it is so expensive to re-compute
the entries pushing up the TLB size does ameliorate the problem.

That said I don't think increasing the TLB size is our only solution.
What I've asked for is some sort of idea of the pattern for the eviction
of entries from the TLB and the performance of the victim cache. It may
be tweaking the locality of that cache would be enough.

One idea I had was With an 8 bit TLB you could afford to have 256
dynamically grown arrays in the victim path - one per entry. Then at
flush time you could simply count up the number of victims in the array
for that slot. That would give you a good idea if some regions are
hotter than others.

--
Alex Bennée
