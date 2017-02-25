Received: from eggs.gnu.org ([2001:4830:134:3::10]:39021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chfGb-00040D-FH
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chfGZ-00081P-4p
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:32:16 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chfGY-00080m-U9
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:32:15 -0500
Received: by mail-wm0-x232.google.com with SMTP id r141so34672453wmg.1
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 08:32:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1702242239330.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<8936f97ffdf6fe9a71a300113019bfdba0ecef23.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA9m8Yjwjn_B5aBZmWVwXXVj7-BQ1_d76ED4bg3cAWw=bw@mail.gmail.com>
	<alpine.BSF.2.20.1702242138290.76443@zero.eik.bme.hu>
	<alpine.BSF.2.20.1702242239330.76443@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Feb 2017 16:31:53 +0000
Message-ID: <CAFEAcA9MWpWtsS_G-sXt92kRSmteyCVfbTfR4zytnaqOKV6W=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 24 February 2017 at 21:49, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Fri, 24 Feb 2017, BALATON Zoltan wrote:
>>
>> On Fri, 24 Feb 2017, Peter Maydell wrote:
>>>
>>> On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>
>>>> Write only to allow clients to initialise these without failing
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>
>>>
>>> What's the point in write-only register values?

>>> If the registers are writes-ignored, there's no need to store
>>> the data written into the state struct; if the registers are
>>> reads-as-written then implement them that way.
>
>
> Still not sure what do you mean by read-as-written because I think that's
> exactly what is done here, value stored and read back as is, except for
> video_control where there are reserved bits that are always 0.

There are several ways we can make a register behave:

"Read only" -> the guest can only read, it cannot write
"Writes ignored" -> the guest can write but it has no effect
"Reads as written" -> the guest can write, and we store the
data so that when the guest reads it gets back the
value it wrote, but it doesn't have any effect on device behaviour
"Reads as zero" -> the guest can read but it always gets zero
"Write only" -> the guest can write values and we store them
but don't let the guest read them back. This is pointless.

For cases where we don't actually implement some bit of hardware
behaviour yet, it can be a reasonable choice to do either
"read-as-zero/writes-ignored", or "reads as written",
depending on what the guest is expecting. (writes-ignored
is the easiest behaviour to implement, but sometimes guests
won't work if you do that.)

If you're implementing "reads as written" then the commit
message shouldn't say "write only"... But the patch seems
to only add code to the register-write function, not to
the register-read function. That means we're storing
values the guest writes but never doing anything with them.
Either throw away the values immediately ("writes ignored")
or let the guest read them back ("reads as written").

(Optionally, we can also log the access via LOG_UNIMP
to let the user know the guest is trying to use some
bit of the device that doesn't work yet.)

thanks
-- PMM
