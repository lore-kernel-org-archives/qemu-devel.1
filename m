Received: from eggs.gnu.org ([2001:4830:134:3::10]:43059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eKNjn-0005Rz-RY
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eKNjn-00042b-0p
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:14:43 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eKNjm-00042I-OY
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:14:42 -0500
Received: by mail-oi0-x244.google.com with SMTP id y75so4659334oie.4
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 04:14:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512031988-32490-4-git-send-email-thuth@redhat.com>
References: <1512031988-32490-1-git-send-email-thuth@redhat.com>
	<1512031988-32490-4-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Nov 2017 12:14:21 +0000
Message-ID: <CAFEAcA-LBOm=kHja3QJqOw-TT3GF9-i+wJfXdL-FU5NKimknzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/7] tests/boot-serial-test: Add
 support for the mcf5208evb board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>, Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 30 November 2017 at 08:53, Thomas Huth <thuth@redhat.com> wrote:
> We can output a character quite easily here with some few lines of
> assembly that we provide as a mini-kernel for this board.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/boot-serial-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index d997269..dd3828c 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -16,6 +16,14 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>
> +static const uint8_t kernel_mcf5208[] = {
> +    0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
> +    0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
> +    0x11, 0x7c, 0x00, 0x04, 0x00, 0x08,     /* move.b #4,8(%a0)     Enable TX */
> +    0x11, 0x40, 0x00, 0x0c,                 /* move.b %d0,12(%a0)   Print 'T' */
> +    0x60, 0xfa                              /* bra.s  loop */
> +};

This approach doesn't seem to be scalable to me -- are we
really going to have 50 or more fragments of hand-coded hex in
this file to cover the various board models?

I'd much rather see us have a framework for being able
to build test blobs from source using a cross compiler
setup (and docker or similar so anybody can rebuild
the test blobs). That will be much easier to maintain
and easier to extend to having tests that test other
parts of the board or other aspects of TCG emulation.

thanks
-- PMM
