Received: from eggs.gnu.org ([2001:4830:134:3::10]:34145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGlXH-0006mb-Ie
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGlXF-0007EM-TI
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:50:51 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGlXF-0007E8-MS
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:50:49 -0500
Received: by mail-wr0-x244.google.com with SMTP id a63so7952706wrc.12
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:50:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8NGnmG_8SipvPN5_dPhokH2zZAXykN2KiW10XhB-9xXQ@mail.gmail.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
	<20171116115926.16627-8-pbonzini@redhat.com>
	<CAFEAcA-06-VmH7Pvymo-o-HmiQ-uQ67Hs0KhWZfxswBxsfD2-g@mail.gmail.com>
	<bf4bedd9-0ef8-cff3-6153-531fba597237@redhat.com>
	<CAFEAcA9Rnd3gtrHb389e6fOEAae4aLhJnQWU-vKyzTM4o-riOQ@mail.gmail.com>
	<001b01d361e9$d46ace40$7d406ac0$@ru>
	<CAFEAcA8NGnmG_8SipvPN5_dPhokH2zZAXykN2KiW10XhB-9xXQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 12:50:27 +0000
Message-ID: <CAFEAcA9PUOyK_vEnMKJkZV5s7o4zHDRedUY7z0ZH0i5ULEGzwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/11] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 20 November 2017 at 11:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 20 November 2017 at 10:25, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>>> From: Peter Maydell [mailto:peter.maydell@linaro.org]
>>> On 17 November 2017 at 20:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> > On 17/11/2017 21:07, Peter Maydell wrote:
>>> >> Hi. This commit breaks booting of Debian on aarch64 virt board.
>>> >> (repro instructions for creating the image available at:
>>> >> https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-virt-
>>> board/)
>>> >> The guest kernel never prints anything to the serial port.
>>> >>
>>> >> Reverting this commit fixes master for me, so I plan to do
>>> >> that on Monday.
>>> >
>>> > Maybe you can also test moving the atomic_set inside the "if".  It does
>>> > seem to be a genuine bugfix.
>>>
>>> No, that doesn't help: guest still sits there like a lemon.
>>
>> Maybe this is a more complex problem?
>> I tried removing this if and aarch64 still does not work.
>
> Reverting the commit fixes it for me; I have that going through
> build tests and will push the revert later today.

Revert pushed to git master.

More generally, this commit seems to assume that QEMU always
does:
 * set exception_index to something
 * handle that
 * clear exception_index to -1

but it's not clear to me that it's actually always the case
that it gets cleared back to -1.

thanks
-- PMM
