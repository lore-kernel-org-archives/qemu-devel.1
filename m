Received: from eggs.gnu.org ([208.118.235.92]:57347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sha@pengutronix.de>) id 1gfKfx-0000Xo-Ab
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sha@pengutronix.de>) id 1gfKfw-0007G8-FQ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:17:53 -0500
Received: from metis.ext.pengutronix.de
	([2001:67c:670:201:290:27ff:fe1d:cc33]:37493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sha@pengutronix.de>) id 1gfKfw-0007ER-3k
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:17:52 -0500
Date: Fri, 4 Jan 2019 09:17:41 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Message-ID: <20190104081741.mxdgg4dwm4l5s4ki@pengutronix.de>
References: <20190104015641.e6d525f098c5e272694faa62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104015641.e6d525f098c5e272694faa62@gmail.com>
Subject: Re: [Qemu-devel] barebox on Canon A1100
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Barebox List <barebox@lists.infradead.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Fri, Jan 04, 2019 at 01:56:41AM +0300, Antony Pavlov wrote:
> Hi Sascha!
> 
> I have some good news and some bad news.
> 
> First the good news.
> 
> Barebox was used for Day 18 of QEMU 2018 advent (https://www.qemu-advent-calendar.org/2018/).
> 
> Here is a quote:
> 
>   > This is an image for QEMU's emulated Canon A1100 Arm machine:
>   > Play 2048 in the Barebox firmware environment.

Hey nice :)

> 
> The bad news.
> 
> Current master branch barebox for Canon A1100 does not work under qemu,
> barebox v2017.02.0 was used for qemu advent.
> 
> Thomas Huth reported the problem in the qemu-devel mailing
> list two months ago. Please see https://www.mail-archive.com/qemu-devel@nongnu.org/msg571887.html
> for details.
> 
> The commit a43e2bbc468a71 breaks barebox for Canon A1100:
> 
>   > commit a43e2bbc468a71fb8825e8acafb7fac7ad7c6dad
>   > Author: Sascha Hauer <s.hauer@pengutronix.de>
>   > Date:   Wed Mar 7 10:04:07 2018 +0100
>   >
>   >    ARM: return positive offset in get_runtime_offset()
> 
> Any suggestion?

Yes, try again with a recent barebox. There was a bug in this commit that
should be fixed with the following:

| commit 0230365df6601cd561c9e3e368c96222076ec9f5
| Author: Sascha Hauer <s.hauer@pengutronix.de>
| Date:   Wed Dec 12 08:55:31 2018 +0100
| 
|     ARM: fix setup_c when runtime offset is != 0
|     
|     The runtime offset has to be added to the memcpy source address and
|     substracted from the return address. This should have been changed in
|     a43e2bbc46 which changed from returning the negative runtime offset
|     into changing the positive runtime offset. Instead a43e2bbc46 only
|     changed a zero substraction ("subs r4, r0, #0") into a zero addition
|     ("adds r4, r0, #0") which was used as a equal to zero test and changed
|     nothing. This part is reverted here.
|     
|     Fixes wrong copy / return locations when setup_c is called with
|     different runtime and link addresses.
|     
|     fixes: a43e2bbc46 ("ARM: return positive offset in get_runtime_offset()")
|     
|     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
