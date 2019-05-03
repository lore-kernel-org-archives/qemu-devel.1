Received: from eggs.gnu.org ([209.51.188.92]:59277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMa1t-0005Vg-Cz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMa1s-0002rk-Aq
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:23:17 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMa1q-0002pS-AQ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:23:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id a10so5597759otl.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003618.10089-1-driver1998@foxmail.com>
	<aa0dce0b-1be0-7247-8f81-c4f265ba0009@redhat.com>
In-Reply-To: <aa0dce0b-1be0-7247-8f81-c4f265ba0009@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 16:23:01 +0100
Message-ID: <CAFEAcA9a8oQHe+cbSotO+BR2-iqgKOBV5Pg4n1aOBY7_tnvqFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/4] QEMU_PACKED: Remove gcc_struct
 attribute in Windows non x86 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Cao Jiaxi <driver1998@foxmail.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Fri, 3 May 2019 at 06:07, Thomas Huth <thuth@redhat.com> wrote:
>
> On 03/05/2019 02.36, Cao Jiaxi wrote:
> > gcc_struct is for x86 only, and it generates an warning on ARM64 Clang/=
MinGW targets.
> >
> > Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.h | 2 +-
> >  include/qemu/compiler.h               | 2 +-
> >  scripts/cocci-macro-file.h            | 7 ++++++-
> >  slirp/src/util.h                      | 2 +-
> >  4 files changed, 9 insertions(+), 4 deletions(-)

> > diff --git a/slirp/src/util.h b/slirp/src/util.h
> > index 01f1e0e068..278828fe3f 100644
> > --- a/slirp/src/util.h
> > +++ b/slirp/src/util.h
> > @@ -43,7 +43,7 @@
> >  #include <netinet/in.h>
> >  #endif
> >
> > -#if defined(_WIN32)
> > +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> >  # define SLIRP_PACKED __attribute__((gcc_struct, packed))
> >  #else
> >  # define SLIRP_PACKED __attribute__((packed))
> >
>
> The slirp code is currently on its way into a separate module, so you
> might need to provide that hunk to the libslirp folks again... I'm
> putting the slirp maintainers on CC:, maybe they can pick it up from here=
.

Yes, the slirp module has now landed in master, so this patch
definitely needs to be split into two. I've kept in my
target-arm.next tree the parts which are applicable to
the QEMU repo itself (ie everything except the slirp/ change),
so we just need a new patch for the slirp submodule part.

Marc-Andr=C3=A9, Samuel -- what's the process for submitting and
getting reviewed changes to the slirp submodule now it's a
separate project ?

thanks
-- PMM
