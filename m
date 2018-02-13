Received: from eggs.gnu.org ([2001:4830:134:3::10]:38936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elY7p-0005d4-Uk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elY7o-0005Bj-Ue
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:47:50 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elY7o-0005BV-Pb
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:47:48 -0500
Received: by mail-ot0-x244.google.com with SMTP id a7so16930564otk.9
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 02:47:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKM7bO2dwPVkUSz5Mc=CrBWvFFAYY1vD4Q4bMht4=dVoww@mail.gmail.com>
References: <cover.1516746211.git.alistair.francis@xilinx.com>
	<29c39a6f9ce3734bf693581348ed78f4bff3e0ef.1516746211.git.alistair.francis@xilinx.com>
	<CAFEAcA-eOMvYYv--wjs+i1wGG3AN1VueqZjtnE5vpBH=UavkfQ@mail.gmail.com>
	<CAKmqyKPAmzwFkY5MAiPA-epY-HCbBfBpHGWdanvEef2keaSXew@mail.gmail.com>
	<CAFEAcA8Fo5gVsjVB5PdU6sKWZAZ2ZscUzEhiDMwZY-LiDGtqOA@mail.gmail.com>
	<CAKmqyKM7bO2dwPVkUSz5Mc=CrBWvFFAYY1vD4Q4bMht4=dVoww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 10:47:27 +0000
Message-ID: <CAFEAcA_VHsONyCXjDsFmiKrRGpC9Zu+XA1=bYPHTTU1dBVUhGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 8 February 2018 at 17:21, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Thu, Feb 8, 2018 at 7:42 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Doing it this way round means that it gets complicated when the
>> guest writes to the RTC, though. At the moment I can't see anywhere
>> that sets the current_tm fields except for reset and post-migration.
>> Isn't something missing here? I'm wondering if this choice of
>> migration state is going to paint us into a corner for handling
>> guest-writes-to-rtc.
>
> I don't have guest write support. The main focus was just allowing
> users to set the time when they boot QEMU. We haven't seen any request
> to allow guests to set the time, so I didn't bother.
>
> Wouldn't adding guest write support just be as simple as converting
> the value written to a current_tm field?

Yes, but then why are we using the current_tm format at all?
It's not what the guest wants to see for reads, it's not what writes
would naturally be, and it's not what you're using at runtime (you
convert it immediately to a tick_offset and ignore the current_tm
stuff). I guess it can be made to work, it just seems like a weird
format to use for migration.

I've also just reread the patch and am a bit confused -- don't
you need some code that writes the correct value for the current
guest time to the current_tm fields before migration ?

thanks
-- PMM
