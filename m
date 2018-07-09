Received: from eggs.gnu.org ([2001:4830:134:3::10]:39302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcW7R-0004VN-6a
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcW7Q-0005dX-EY
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:22:21 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcW7Q-0005dE-8E
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:22:20 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so35793526oib.6
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 06:22:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <01f5d4ef-cea1-ff81-82cc-30a617a3c648@redhat.com>
References: <1528185295-14199-1-git-send-email-slp@redhat.com>
	<4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
	<CAJ+F1CLjAXcdkUS2cj_6x2UnE1jTcFAfy88yDWfomp6+Mt7v+g@mail.gmail.com>
	<CAFEAcA8WN1K-r0u6ZDBFRwRa1WZAMBf2MQhkhg-WDRazfVjQzw@mail.gmail.com>
	<CAJ+F1CKk=3amSNTSusbPj1MUM+ksTse2YVddLyTf5jqr6RDyFQ@mail.gmail.com>
	<01f5d4ef-cea1-ff81-82cc-30a617a3c648@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 14:21:59 +0100
Message-ID: <CAFEAcA8J40JyvMgtNjscVsPYaGxavEctC+pk6eqPXoUjZMhpyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 9 July 2018 at 14:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 09/07/2018 14:23, Marc-Andr=C3=A9 Lureau wrote:
>> I suppose the patch should also change qemu_chr_fe_write() to
>> qemu_chr_fe_write_all() to be complete and let the chardev handle
>> EAGAIN.
>
> No, using qemu_chr_fe_write_all() is even more wrong, because hw/char
> devices should never block (and hw/char/serial.c handles flow control
> properly).
>
> However, indeed it seems to me that the logic of the patch is backwards:
>
> - -1/EAGAIN should retry
>
> - 0 should *not* retry, because it means the other side has hung up

This seems weird, because it doesn't follow the usual pattern
for non-blocking functions, where 0 just means "nothing was
written" and actual error conditions like the other side having
gone away are reported via -1 and some errno.

> - everything else should not retry.

thanks
-- PMM
