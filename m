Received: from eggs.gnu.org ([209.51.188.92]:45667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glfHQ-00015z-7x
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glfHP-00006w-EJ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:30:44 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glfHN-0008UX-VV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:30:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id c206so15489197oib.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 11:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-5-lersek@redhat.com>
	<fd79f085-f3d8-dc06-9d43-9c4fcea69317@redhat.com>
	<8d4dc6b0-d4d9-2919-194f-c27cb40699b3@redhat.com>
In-Reply-To: <8d4dc6b0-d4d9-2919-194f-c27cb40699b3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 19:30:23 +0000
Message-ID: <CAFEAcA8uVAXMuwVk2ZLAP34Hk_tp9dvWjy06gauyohesOvCuNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, 21 Jan 2019 at 19:09, Laszlo Ersek <lersek@redhat.com> wrote:
> It wasn't clear to me whether and how multi-threaded builds were
> supposed to be used by maintainers, whenever they'd update
> "tests/data/uefi-boot-images/*".
>
> I saw that "make" was invoked everywhere as $(MAKE), but that didn't
> clarify any intent around "-j". So I didn't test "-j" at all, and in
> fact I wouldn't have expected it to work:

The usual assumption with make is that "-jN" should work
and at least (if the thing being built can't actually
be parallelized usefully) be no worse than if you'd not
specified a -j option. We have occasionally had problems
with -jN in 'make check' (usually because several test cases
were trying to use the same temp filename or similar) but
we've treated them as bugs and squashed them.

> The "build" base tool in edk2 implements part of the job with generated
> makefiles and invoking "make" itself, thus, despite .NOTPARALLEL, it
> likely inherits the outermost -j<N> setting -- and it doesn't expect such.
>
> So the best I can offer here is to check $MAKEFLAGS in "build.sh", and
> exit with an early, explicit error if $MAKEFLAGS contains "-j", "-l", or
> their long variants (--jobs, --load-average).

Could you sanitize MAKEFLAGS in build.sh instead to remove the
parallelization options?

thanks
-- PMM
