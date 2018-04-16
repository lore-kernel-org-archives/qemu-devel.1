Received: from eggs.gnu.org ([2001:4830:134:3::10]:39197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f86BX-00052u-Gd
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f86BW-00017s-LL
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:36:51 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:42953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f86BW-00017a-Gv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:36:50 -0400
Received: by mail-oi0-x22e.google.com with SMTP id 26-v6so5366152ois.9
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 08:36:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874lkbb264.fsf@linaro.org>
References: <20180416140322.904-1-alex.bennee@linaro.org>
	<CAFEAcA-1GVMOSJVQ5p8+qpo8P-+fBq0-6TaA2mdvLDbk3fiihg@mail.gmail.com>
	<874lkbb264.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 16:36:29 +0100
Message-ID: <CAFEAcA_edPjsu5vvZSreJhzzo-pv04Bg3bRrkDaUx8=djNWXrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: support reading of
 CNTVCT_EL0 from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, takeharu.kato@linaro.org, Renato Golin <renato.golin@linaro.org>

On 16 April 2018 at 16:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>> CNTVCT_EL0 isn't much use without CNTFRQ_EL0 which tells
>> you how fast it ticks...
>
> I've added it but of course:
>
>     /* Note that CNTFRQ is purely reads-as-written for the benefit
>      * of software; writing it doesn't actually change the timer frequenc=
y.
>      * Our reset value matches the fixed frequency we implement the timer=
 at.
>      */
>
> So it's not like we do anything with it internally.

But we do correctly use it to report the frequency of our
system-mode CNTVCT counters, as the comment says.

> I assume in real
> life you could mess with this but still have a monotonically
> increasing counter.

It's purely a reporting mechanism. In real hardware the
firmware is supposed to know how fast the system clock is
and and set CNTFRQ up appropriately to tell the OS that that's
how fast the CNTVCT counter runs. (Notice that CNTFRQ is only
RW to the highest implemented exception level, and RO below that.)

>> It looks like other targets use cpu_get_host_ticks() for an
>> arbitrary time-counter thingy. Not sure you can get the frequency
>> for it, though :-(
>
> Hmm I've just used:
>
>   return cpu_get_clock()/GTIMER_SCALE;
>
> For now....

I guess that will work -- it boils down to a gettimeofday()
syscall, which will be ok for speed if it's in a VDSO and
a bit worse if it's a real syscall.

thanks
-- PMM
