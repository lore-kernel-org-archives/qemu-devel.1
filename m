Received: from eggs.gnu.org ([2001:4830:134:3::10]:51991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUaY6-0001VN-7x
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUaY1-0004Fy-EC
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:24:34 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:32850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUaY1-0004FG-6j
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:24:29 -0400
Received: by mail-wr0-f169.google.com with SMTP id r103so143316020wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:24:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87pod89v9e.fsf@linaro.org>
References: <20170710142850.10468-1-alex.bennee@linaro.org>
	<CAFEAcA-eLe6b-0pKkoam1TBQD680W0nunARrSFxQTgUkoqug+w@mail.gmail.com>
	<87pod89v9e.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 16:23:07 +0100
Message-ID: <CAFEAcA_gfVo6yJhQ0u+CjSsNC7ub+oTu8R9KbhUjxzz+TqDAkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] include/exec/cpu-defs.h: try and make
 SoftMMU page size match target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 10 July 2017 at 16:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 10 July 2017 at 15:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>>> While the SoftMMU is not emulating the target MMU of a system there is
>>> a relationship between its page size and that of the target. If the
>>> target MMU is full featured the functions called to re-fill the
>>> entries in the SoftMMU entries start moving up the perf profiles. If
>>> we can we should try and prevent too much thrashing around by having
>>> the page sizes the same.
>>>
>>> Ideally we should use TARGET_PAGE_BITS_MIN but that potentially
>>> involves a fair bit of #include re-jigging so I went for 10 bits (1k
>>> pages) which I think is the smallest of all our emulated systems.
>>
>> The figures certainly show an improvement, but it's not clear
>> to me why this is related to the target's page size rather than
>> just being a "bigger is better" kind of thing?
>
> Well this was driven by a discussion with Pranith last week. In his
> (admittedly memory intensive) bench-marking he was seeing around 30%
> overhead is coming from mmu related functions with the hottest being
> get_phys_addr_lpae() followed by address_space_do_translate(). We
> theorised that even given the high hit rate of the fast path the slow
> path was triggered by moving over SoftMMU's effective page boundary. A
> quick experiment in extending the size of the TLB made his hot spots
> disappear.
>
> I don't see quite such a hot-spot in my simple boot/build benchmark test
> but after helper_lookup_tb_ptr quite a lot of hits are part of the
> re-fill chain:

Right, but why do we know that the target page size matters rather
than this just being "smaller TLB -> more TLB misses -> more calls
to the slow path -> functions called in the slow path appear more
in profiling" ?

thanks
-- PMM
