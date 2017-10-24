Received: from eggs.gnu.org ([2001:4830:134:3::10]:54344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6t52-0006kf-3G
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 02:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6t50-0006qz-Tp
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 02:52:52 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:50200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6t50-0006qm-MD
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 02:52:50 -0400
Received: by mail-wr0-x230.google.com with SMTP id p96so5703538wrb.7
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 23:52:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <FC571E15-495F-4D4D-9001-7FF76A74D162@gmail.com>
References: <20171023025016.3088-1-programmingkidx@gmail.com>
	<20171023160959.GC10220@stefanha-x1.localdomain>
	<CAFEAcA_13y2-uM11Ko_79TpEsfpFWMTz2-mAiwFseHfAM5CPgA@mail.gmail.com>
	<FC571E15-495F-4D4D-9001-7FF76A74D162@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2017 07:52:28 +0100
Message-ID: <CAFEAcA-x89pucjLdZT7wp4yKcVdOa=W2v697JCiWeR+4QWW6cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [libfdt][PATCH v3] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, devicetree-compiler@vger.kernel.org, ian@freebsd.org

On 24 October 2017 at 04:45, Programmingkid <programmingkidx@gmail.com> wrote:
> I was operating under the assumption that MAC_OS_X_VERSION_MAX_ALLOWED
> would equal the version of the host.

It indicates the highest version of OSX whose features the
program being compiled is allowed to use. That isn't necessarily
the same as the highest version of OSX the SDK we're compiling
against supports -- you can be building against a 10.9-aware
SDK and tell it "only use features up to and including those
on 10.7."

> After making this little test program:

You don't need to test this kind of thing, it is documented,
and in general reading the documentation is more reliable and
more informative than testing.

> Is using MAC_OS_X_VERSION_MAX_ALLOWED not a reliable macro to
> use to test for the version of the Mac OS? The ui/cocoa.m file
> seems to use it and have no problems.

QEMU's usage differs in two ways:
(1) we just use the macros to #ifdef out code that would
be trying to use functions that don't exist in the older
versions, which is exactly what it's intended for. We
don't try to implement our own versions of those functions
under the same names
(2) we control QEMU's build process and so we can guarantee
that we aren't using the "build on a 10.9 SDK but make sure
you don't use features that aren't in 10.7" functionality.
libfdt is a library that can be included in many other
programs, so we can't make that assumption.

>> It uses the clang 'attribute availability' syntax:
>> https://clang.llvm.org/docs/AttributeReference.html#availability
>
> This feature appears to be a clang/gcc-only feature.

This was a reply to Stefan's question about how the OSX
availability headers are implemented. (As it happens the OSX
headers do have an "if not clang then just #define away
the availability attributes" codepath.)

thanks
-- PMM
