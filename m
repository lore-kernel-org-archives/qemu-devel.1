Received: from eggs.gnu.org ([2001:4830:134:3::10]:56810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqMpJ-0002IV-QK
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqMpI-0006wE-Ve
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:40:05 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqMpI-0006w5-P5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:40:04 -0400
Received: by mail-wm0-x231.google.com with SMTP id u132so16402117wmg.0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:40:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 16:39:43 +0000
Message-ID: <CAFEAcA8HrEsuEYgpe9pJQkwSnSTU74G+3i7vWk8ka5cJ+UWFDQ@mail.gmail.com>
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

On 21 March 2017 at 16:32, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> I found the serial device is always trying to receive all the data when
> ReadFile() is running, then start reading. Even if the fifo is full, the
> _can_receive function still keeps polling if the data is larger than 16
> bytes.

pl011_can_receive() is:

static int pl011_can_receive(void *opaque)
{
    PL011State *s = (PL011State *)opaque;
    int r;

    if (s->lcr & 0x10) {
        r = s->read_count < 16;
    } else {
        r = s->read_count < 1;
    }
    trace_pl011_can_receive(s->lcr, s->read_count, r);
    return r;
}

so if the FIFO fills up then it should start to return 'false',
as it is supposed to.

I'm not sure from your description what exactly is happening,
but you should probably check, for instance:
 * whether pl011_can_receive is returning false but data
   is still being fed to it
 * whether pl011_can_receive is returning true even with
   16 bytes in the fifo (hard to see how, given the code)
 * whether the fifo actually has fewer bytes in it because
   the guest is reading them
 * etc

thanks
-- PMM
