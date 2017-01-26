Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWt8L-0000lJ-Fk
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 18:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWt8H-0000RP-Ui
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 18:07:13 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWt8H-0000RD-Pc
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 18:07:09 -0500
Received: by mail-vk0-x233.google.com with SMTP id k127so164894170vke.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 15:07:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8a528a03-d97e-7c16-70f6-229b80563b2d@redhat.com>
References: <1485377117-18105-1-git-send-email-thuth@redhat.com>
	<f60c6090-0ca8-8ce9-8015-4e8e34123a5a@vivier.eu>
	<CAKmqyKMyzquxEGTF4Un_1WvwBNXOoJU1g67_9fFarVy-yeff+Q@mail.gmail.com>
	<8a528a03-d97e-7c16-70f6-229b80563b2d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Jan 2017 23:06:48 +0000
Message-ID: <CAFEAcA8O7QEcXQU0iMguSAfT-qsQgmYC_gOCjGmV5ph2w5EVmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix crash when
 running without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 26 January 2017 at 05:50, Thomas Huth <thuth@redhat.com> wrote:
> I think there is no real use case yet. But this fix is 1) simpler than
> doing an error_report() + exit() here, and 2) maybe the vision of
> constructing machines on the fly with QEMU will eventually come true one
> day in the distant future, so with that patch here, the code would
> already be prepared for the case when QEMU gets started without CPUs and
> the CPUs are then later added via QOM...

For the latter to work you'd need to do something more anyway,
because you still need to be able to say "load this image
into this CPU's address space", even if the CPUs are getting
added later via QOM. You'd need to say "delay the image
load until we actually have a CPU to load it for" or
something... Passing a NULL address space to load_elf_as()
etc is saying "I am definitely a board which has
system_address_space as its one and only address space",
which is OK if you're a board model but a bit more dubious
if you're a generic device like this one.

thanks
-- PMM
