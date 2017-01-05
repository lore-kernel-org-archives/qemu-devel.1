Received: from eggs.gnu.org ([2001:4830:134:3::10]:53196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPFlC-0004GJ-Cm
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPFl9-0000yB-9i
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:39:46 -0500
Received: from relay6-d.mail.gandi.net ([2001:4b98:c:538::198]:49343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cPFl9-0000wF-3N
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:39:43 -0500
References: <20170103211705.27876-1-jcd@tribudubois.net>
	<CAFEAcA91iJ_8MeKmMp7_fDfdc+aKLHHs4--CyYh=0FQP+SmxLw@mail.gmail.com>
	<ea377760-4e9e-a5c7-2d2d-ccf8112b23c7@gmail.com>
	<6206996c-51ad-d561-f98a-f39702c3c826@tribudubois.net>
	<CAFEAcA9CT4iJHBLA1re6VabfwdFxfKcZQjx1JcTiu0mDvqHOcw@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <2efc8f93-4277-4d2b-11ff-8f2986776c19@tribudubois.net>
Date: Thu, 5 Jan 2017 22:39:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9CT4iJHBLA1re6VabfwdFxfKcZQjx1JcTiu0mDvqHOcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] [m25p80] Abort in case we overrun the
 internal data buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "mar.krzeminski" <mar.krzeminski@gmail.com>

Le 05/01/2017 à 21:51, Peter Maydell a écrit :
>> So what would be the preferred behavior?
>>
>> Asserting (and ending Qemu)
>> Resetting (and hiding the misbehavior).
> If the guest can trigger this behaviour, then we should
> not assert or abort or otherwise cause QEMU to exit.
> The preferred behaviour is:
>   * act like the real hardware does in this situation
>     (whatever that is)
>   * if this is something that only broken guest code would
>     do, log it with qemu_log_mask(LOG_GUEST_ERROR, ...)

I guess a real SPI controllers should not trigger this behavior like I 
did in the i.MX SPI controller emulation. It was a bug in my code and 
the crash (SIGSEGV) forced me to try to find a solution. At first I 
tried to fix the SPI device instead of the SPI controller because a 
SIGSEGV did not seem like an expected reaction and I was missing hints 
that my code was misbehaving.

But it is also possible for a guest to emulates the SPI controller 
through bit banging (for example). And in this case the guest could end 
up misbehaving in its software implementation.

So I think this behavior could be triggered either by buggy SPI 
controller emulator or by buggy guest software. And it seems hard to 
determine where the fault comes from from within Qemu. Obviously if the 
fault is in a Qemu emulator we would not want to tag the error as a 
LOG_GUEST_ERROR. On the other hand, it would be nice to warn the user if 
the guest if it is indeed misbehaving so that he can fix his code.

>
> thanks
> -- PMM
>
>
