Received: from eggs.gnu.org ([2001:4830:134:3::10]:47118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXP9g-0004A7-IQ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXP9f-0006eM-R1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:27:48 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXP9f-0006ck-CD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:27:47 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so1595414otl.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:27:47 -0800 (PST)
MIME-Version: 1.0
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<20181213101940.GC5171@redhat.com>
In-Reply-To: <20181213101940.GC5171@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 11:27:35 +0000
Message-ID: <CAFEAcA_rBakXJZuPGgcsvC9m75oeTbg=q-=mOCFJuungF-VR8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 13 Dec 2018 at 10:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Dec 12, 2018 at 06:09:37PM -0800, Li Qiang wrote:
> > Assert that the return value is not an error. This is like commit
> > 7e6478e7d4f for qemu_set_cloexec.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  util/oslib-posix.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index c1bee2a581..4ce1ba9ca4 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
> >  {
> >      int f;
> >      f =3D fcntl(fd, F_GETFL);
> > -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> > +    assert(f !=3D -1);
>
> This leads to *awful* diagnostics. We need to print something
> useful when it fails so we stand a chance of understanding what
> is wrong.

It's the same thing we do in qemu_set_cloexec(), though,
and nobody's complained about that that I know of. I think
we need to understand whether we're getting asserts in
vhost_user_test because of something silly like passing -1
as the fd, or because the fcntl() can legitimately fail.
If the former, the assert isn't a big deal because when
we hit it in newly developed code the problem is going
to be obvious when run under a debugger. If the latter,
we need to actually pass out the error status and fix
all the callers to check it...

thanks
-- PMM
