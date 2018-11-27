Received: from eggs.gnu.org ([208.118.235.92]:41553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRkOq-0005BG-Bv
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 15:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRkOo-0004lw-L7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 15:56:04 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRkOo-0004lP-Ej
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 15:56:02 -0500
Received: by mail-ot1-x342.google.com with SMTP id g27so21465470oth.6
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 12:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20181127184929.20065-1-jsnow@redhat.com>
	<f2257e95-b17c-55d4-1d5f-cc09db3d6a58@redhat.com>
In-Reply-To: <f2257e95-b17c-55d4-1d5f-cc09db3d6a58@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 20:55:49 +0000
Message-ID: <CAFEAcA8kROZgFPUxzmMEGX9h-RddWRsDoxmdYMBOrR+vbtB5Xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scsi: Address spurious clang warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 27 Nov 2018 at 19:02, Eric Blake <eblake@redhat.com> wrote:
>
> On 11/27/18 12:49 PM, John Snow wrote:
> > Some versions of Clang prior to 6.0 (and some builds of clang after,
> > such as 6.0.1-2.fc28) fail to recognize { 0 } as a valid initializer
> > for a struct with subobjects when -Wmissing-braces is enabled.
> >
> > https://bugs.llvm.org/show_bug.cgi?id=21689 and
> > https://reviews.llvm.org/rL314499 suggests this should be fixed in 6.0,
> > but it might not be the case for older versions or downstream versions.
> >
> > For now, follow the precedent of ebf2a499 and replace the standard { 0 }
> > with the accepted { } to silence this warning and allow the build to
> > work under clang 6.0.1-2.fc28, and builds prior to 6.0.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> >
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> I'm okay if this goes into -rc3 as a build-fix; I'm also okay if it
> slips to 4.0.
>
> > ---
> >
> > What I am actually less clear on is why this appears to be a problem
> > only now; since the introduction of { 0 } was in 2.11. It might be
> > a regression only in the fedora distribution of Clang 6.0.

Upstream clang 6.0 should have this bug fixed (ie it does
not warn about this construct), so it is odd that Fedora's does not.

> Or even a redefinition of struct dm_ioctl in some header where you are
> just now picking up a new struct layout that tickles the Clang issue in
> relation to the previous layout (since it is possible to have two
> structs that are ABI-compatible but where only one of the two has a
> nested substruct).
>
> > +++ b/scsi/qemu-pr-helper.c
> > @@ -236,7 +236,7 @@ static void dm_init(void)
> >           perror("Cannot open " CONTROL_PATH);
> >           exit(1);
> >       }
> > -    struct dm_ioctl dm = { 0 };
> > +    struct dm_ioctl dm = { };
>
> Random thought: would it be worth having "qemu/compiler.h" define a macro:
>
> #if ...broken clang
> #define ZERO_INIT {}
> #else
> #define ZERO_INIT {0}
> #endif
>
> and then rewrite all our '= { 0? }' initializers into '= ZERO_INIT'?  Or
> is that aesthetically too ugly?

I think that's worse than just writing {} everywhere (which
does work on every compiler we need to support, including
older gcc which also used to warn here).

thanks
-- PMM
