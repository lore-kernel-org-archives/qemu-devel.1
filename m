Received: from eggs.gnu.org ([2001:4830:134:3::10]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flLiW-00041N-QH
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 18:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flLiV-00047B-UO
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 18:05:08 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:41531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1flLiV-00046f-Nw
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 18:05:07 -0400
Received: by mail-oi0-x242.google.com with SMTP id k12-v6so6300091oiw.8
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 15:05:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180802124345.GA25289@stefanha-x1.localdomain>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-7-stefanha@redhat.com>
	<CAFEAcA8m2f-DRiDNF0ry4nMH9bzZ1gODV4MTgtLwR5jTNdgeJA@mail.gmail.com>
	<20180802124345.GA25289@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Aug 2018 23:04:46 +0100
Message-ID: <CAFEAcA9SHbSf8=UhS697fkTe9h2bBBoF66DVj04_i9t53YvOOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 6/7] loader: Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Su Hang <suhang16@mails.ucas.ac.cn>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

On 2 August 2018 at 13:43, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 30, 2018 at 07:01:53PM +0100, Peter Maydell wrote:
>> I'm still not convinced we want to add another random
>> special case only-works-on-one-architecture-and-some-boards
>> feature to the -kernel command line option.
>>
>> Adding it to the "generic loader" device might be more plausible?
>
> I'm not sure I understand the purpose of the generic loader.
>
> As a user -kernel <myfile> is easier than -device
> loader,file=<myfile>,cpu-num=1.
>
> Can you explain the advantage to moving hex file loading to the generic
> loader?

It means we have a command line option for loading hex files
that works for every board and every CPU architecture.
(Similarly, if you want a way to load an ELF file that
works the same way for all boards and CPUs, the generic
loader is it -- -kernel will not reliably do the job.
You can also use it to load more than one ELF file or
to load different ELF files for different CPUs, neither
of which you can do with -kernel.)

-kernel, like all our legacy short options, is, yes,
easier to use; it's also a twisted mess of different
"do what I mean" functionality that varies depending
on the guest CPU architecture and subtype, the machine
being emulated, and other random things like "did the
user also tell us to start a BIOS image". It mostly means
"run a Linux kernel", with some extras wedged in on the
side where we thought we could do it without breaking the
kernel case. Oh, and we don't document anywhere what
it actually does. I'm reluctant to add yet another layer of
"do what I mean" to it that only has an effect on a subset
of Arm boards.

thanks
-- PMM
