Received: from eggs.gnu.org ([209.51.188.92]:49058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL7Xv-0001mT-T6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL7Xu-0002Th-Lb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:46:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hL7Xu-0002T0-DA
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:46:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id a9so16473204wrp.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190429134757.13570-1-marcandre.lureau@redhat.com>
	<6f4b8998-341a-9169-b368-db4a6b00b65d@redhat.com>
In-Reply-To: <6f4b8998-341a-9169-b368-db4a6b00b65d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Apr 2019 16:46:03 +0200
Message-ID: <CAJ+F1C+aXyC8UAaCKU7sD9LTZPDEaYhSufp9auxipxavDj3F+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when
 seccomp support is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Otubo <otubo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi

On Mon, Apr 29, 2019 at 4:26 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 29/04/2019 15:47, Marc-Andr=C3=A9 Lureau wrote:
> > $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> > qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> > Segmentation fault
> >
> > Commit 5780760f5e ("seccomp: check TSYNC host capability") wrapped one
> > use of the sandbox option group to produce a sensible error, it didn't
> > do the same for another call to qemu_opts_parse_noisily():
> >
> > (gdb) bt
> >     at util/qemu-option.c:829
> >  #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffff=
ab5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
> >      at util/qemu-option.c:829
> >  #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized o=
ut>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/qem=
u-option.c:890
> >  #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at vl.c:3589
> >
> > Fixes: 5780760f5ea6163939a5dabe7427318b4f07d1a2
> > Cc: david@gibson.dropbear.id.au
> > Cc: otubo@redhat.com
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  vl.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/vl.c b/vl.c
> > index 4019a4387d..5fc4994d3c 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -3866,17 +3866,19 @@ int main(int argc, char **argv, char **envp)
> >                  qtest_log =3D optarg;
> >                  break;
> >              case QEMU_OPTION_sandbox:
> > -#ifdef CONFIG_SECCOMP
> > -                opts =3D qemu_opts_parse_noisily(qemu_find_opts("sandb=
ox"),
> > -                                               optarg, true);
> > +                olist =3D qemu_find_opts("sandbox");
> > +                if (!olist) {
> > +#ifndef CONFIG_SECCOMP
>
> Why do you move the #ifdef? We have two separate error cases here.
> And it seems better no to check for "-sandbox" when seccomp is disabled.

I tried to remove the #ifdef altogether to simplify the code, then
realized the error message could be useful.

I don't think it's a problem to lookup "-sandbox" when seccomp is disabled.

--=20
Marc-Andr=C3=A9 Lureau
