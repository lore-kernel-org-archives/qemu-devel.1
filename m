Received: from eggs.gnu.org ([2001:4830:134:3::10]:46151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqNP7-0002q6-MB
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqNP6-0005eS-Oh
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:17:05 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:34882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqNP6-0005eK-EK
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:17:04 -0400
Received: by mail-wm0-x22c.google.com with SMTP id u132so17158362wmg.0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:17:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CbwRd0u+RJiXZZP11J6pU4Pw-FDGbf=hLSBPejNb78bDA@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA8HrEsuEYgpe9pJQkwSnSTU74G+3i7vWk8ka5cJ+UWFDQ@mail.gmail.com>
	<CAJy91CZ=QbhyeakFCSq3n6+d_cGO8hpT8o8EUwUTdkX-iE1eLg@mail.gmail.com>
	<CAFEAcA9XRwW0=UzuAXwjB-a_vWepfh+mus9bgpmdsCoQH6sDEQ@mail.gmail.com>
	<CAJy91CbwRd0u+RJiXZZP11J6pU4Pw-FDGbf=hLSBPejNb78bDA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 17:16:42 +0000
Message-ID: <CAFEAcA_etsFstPtUzs0AZjWD35MhMLhwru0ibJzS_upgE-nsng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 March 2017 at 16:59, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
>
>
> On 21 March 2017 at 17:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On 21 March 2017 at 16:47, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
>> > The actual situation is, pl011_can_receive is returning false, the fifo
>> > is
>> > full,   pl011_read does't start.
>> > At this moment, only pl011_can_recieve is keeping returning 0.
>>
>> OK, so the incoming data has filled up the FIFO, and the UART
>> is now sitting waiting for the guest to read the data...
>
>
> Yes. And I think the guest reading can start when the fifo is nonempty.
> In the guest program, I first check the flag register, once the fifo is
> nonempty,
> then move on to read from the data register.

Which flag are you testing?

> What I found is pl011 expects to read all the data into fifo,
> though pl011_can_receive returns false.
> Only when all the data is read, pl011_read can start.

This doesn't make sense. If our pl011 didn't allow reads
of data before the FIFO was full then you'd see small
data not working, but large data working.

In any case our pl011_read implementation will happily
return you any data it has as long as the fifo is not
completely empty, and even if the guest buggily reads
from an empty FIFO it will return you the last character
read (this is how the h/w works, IIRC).

(This would be much easier if you actually said what your
guest code did, rather than requiring me to guess.)

thanks
-- PMM
