Received: from eggs.gnu.org ([2001:4830:134:3::10]:60959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhDoQ-0002X7-QA
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhDoQ-0000Y4-0n
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:45:38 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:38020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhDoP-0000Vr-R1
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:45:37 -0400
Received: by mail-wr0-x234.google.com with SMTP id m57so3328923wrm.5
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 04:45:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a808c0865b720e22ca2929ec3d362d4610fbad51.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
	<a808c0865b720e22ca2929ec3d362d4610fbad51.1502708830.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Aug 2017 12:45:16 +0100
Message-ID: <CAFEAcA-Jac8wFzQ9vRyKjcEwDKYBdXysNyDP7ERFfXFhVcF56w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 7/7] hw/misc/mmio_interface: Return after
 error_setg() to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>

On 14 August 2017 at 12:07, Michael Tokarev <mjt@tls.msk.ru> wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> QEMU currently abort()s if the user tries to specify the mmio_interface
> device without parameters:
>
> x86_64-softmmu/qemu-system-x86_64 -nographic -device mmio_interface
> qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
>  Assertion `*errp == ((void *)0)' failed.
> Aborted (core dumped)
>
> This happens because the realize function is trying to set the errp
> twice in this case. After setting an error, the realize function
> should immediately return instead.

It seems like it should be an error to permit this to be
created from the command line at all -- the device is intended
only as an internal implementation detail of the memory system,
and it has a PROP_PTR property which can't be sensibly set
from the command line.

This patch is a correct fix for an immediate problem, but we should disable
using this via -device somehow.

thanks
-- PMM
