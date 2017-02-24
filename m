Received: from eggs.gnu.org ([2001:4830:134:3::10]:53843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chNjh-0002Hx-Pv
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chNje-00087l-Mw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:49:09 -0500
Date: Fri, 24 Feb 2017 22:49:04 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.20.1702242138290.76443@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.20.1702242239330.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<8936f97ffdf6fe9a71a300113019bfdba0ecef23.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA9m8Yjwjn_B5aBZmWVwXXVj7-BQ1_d76ED4bg3cAWw=bw@mail.gmail.com>
	<alpine.BSF.2.20.1702242138290.76443@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 09/10] sm501: Add some more missing
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 24 Feb 2017, BALATON Zoltan wrote:
> On Fri, 24 Feb 2017, Peter Maydell wrote:
>> On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> Write only to allow clients to initialise these without failing
>>> 
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> 
>> What's the point in write-only register values?
>
> U-boot writes this register during setting up the device and without this it 
> would abort QEMU.
>
>> What does the real hardware do here?
>
> This register contains bits to set up FIFO parameters and memory priorities 
> which we are not emulating so these can be ignored here but the hardware 
> would change parameters according the value written.

Sorry, this is for the arbitration_control register. The other registers 
added in this patch are for the 2D engine which is only partially emulated 
but writing the registers is OK as long as no operation using them is 
called. (That case is handled in sm501_2d_operation.) We need to allow 
writes as these are initialised during boot but not used afterwards. Later 
when implementing more of the 2D engine we may use the written values.

>> If the registers are writes-ignored, there's no need to store
>> the data written into the state struct; if the registers are
>> reads-as-written then implement them that way.

Still not sure what do you mean by read-as-written because I think that's 
exactly what is done here, value stored and read back as is, except for 
video_control where there are reserved bits that are always 0.
