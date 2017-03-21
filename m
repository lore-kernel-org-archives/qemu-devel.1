Received: from eggs.gnu.org ([2001:4830:134:3::10]:44186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cqNJE-0000LV-7n
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cqNJC-0003sH-VY
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:11:00 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cqNJC-0003ru-P4
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:10:58 -0400
Received: by mail-qk0-x244.google.com with SMTP id v127so22933935qkb.1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:10:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CbwRd0u+RJiXZZP11J6pU4Pw-FDGbf=hLSBPejNb78bDA@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA8HrEsuEYgpe9pJQkwSnSTU74G+3i7vWk8ka5cJ+UWFDQ@mail.gmail.com>
	<CAJy91CZ=QbhyeakFCSq3n6+d_cGO8hpT8o8EUwUTdkX-iE1eLg@mail.gmail.com>
	<CAFEAcA9XRwW0=UzuAXwjB-a_vWepfh+mus9bgpmdsCoQH6sDEQ@mail.gmail.com>
	<CAJy91CbwRd0u+RJiXZZP11J6pU4Pw-FDGbf=hLSBPejNb78bDA@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Tue, 21 Mar 2017 18:10:57 +0100
Message-ID: <CAJy91CauUOcdEL1vAc2BeBCsFRNNpHypuGaqm3QaFq8xE3Q+5g@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 March 2017 at 17:59, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:

>
>
> On 21 March 2017 at 17:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 21 March 2017 at 16:47, Jiahuan Zhang <jiahuanzhang90@gmail.com>
>> wrote:
>> > The actual situation is, pl011_can_receive is returning false, the fifo
>> is
>> > full,   pl011_read does't start.
>> > At this moment, only pl011_can_recieve is keeping returning 0.
>>
>> OK, so the incoming data has filled up the FIFO, and the UART
>> is now sitting waiting for the guest to read the data...
>>
>
> Yes. And I think the guest reading can start when the fifo is nonempty.
> In the guest program, I first check the flag register, once the fifo is
> nonempty,
> then move on to read from the data register.
>
> This works to read small data, smaller than 16 bytes.
>
>>
>> >>  * whether pl011_can_receive is returning true even with
>> >>    16 bytes in the fifo (hard to see how, given the code)
>> >>  * whether the fifo actually has fewer bytes in it because
>> >>    the guest is reading them
>> >
>> >
>> > No, because the guest application does't get any data.
>>
>> ...so if the guest isn't getting any data that suggests it's
>> the guest code's bug (ie it is not actually reading out of
>> the FIFO).
>>
>
> What I found is pl011 expects to read all the data into fifo,
> though pl011_can_receive returns false.
> Only when all the data is read, pl011_read can start.
>

The only thing I can consider about my guest application is the interrupt.
Since in pl011_put_fifo(),

*if* (s->read_count == s->read_trigger){

s->int_level |= PL011_INT_RX;

pl011_update(s);

}

I try to enable the interrupt in the guest program, but still not work.


>> thanks
>> -- PMM
>>
>
>
