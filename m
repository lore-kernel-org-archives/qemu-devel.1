Received: from eggs.gnu.org ([2001:4830:134:3::10]:36385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dO2V0-0006jq-VQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dO2Uw-00041x-8G
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dO2Uw-00041f-1V
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:50:14 -0400
Message-ID: <1498139417.1713.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Jun 2017 15:50:17 +0200
In-Reply-To: <CAFEAcA932_0oPwBxOHg886mTQu9O4wWR2bYH7Xd+Cef_Exr7RA@mail.gmail.com>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-22-f4bug@amsat.org>
	<1498116800.25651.3.camel@redhat.com>
	<CAFEAcA932_0oPwBxOHg886mTQu9O4wWR2bYH7Xd+Cef_Exr7RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 21/21] ui/vnc: silent unuseful OSX
 clang warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On Thu, 2017-06-22 at 08:35 +0100, Peter Maydell wrote:
> On 22 June 2017 at 08:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> > > index 3369451285..08fb573a48 100644
> > > --- a/ui/Makefile.objs
> > > +++ b/ui/Makefile.objs
> > > @@ -6,6 +6,14 @@ vnc-obj-y +=3D vnc-auth-vencrypt.o
> > > =C2=A0vnc-obj-$(CONFIG_VNC_SASL) +=3D vnc-auth-sasl.o
> > > =C2=A0vnc-obj-y +=3D vnc-ws.o
> > > =C2=A0vnc-obj-y +=3D vnc-jobs.o
> > > +ifeq ($(CONFIG_VNC_SASL),y)
> > > +# silent OSX SASL warnings (from https://stackoverflow.com/a/740
> > > 6994
> > > ):
> > > +# because OpenSSL doesn=E2=80=99t offer API compatibility between
> > > versions,
> > > [...] Apple
> > > +# can't provide security updates without breaking existing apps,
> > > so
> > > is migrating
> > > +# from OpenSSL to Common Crypto.
> > > +vnc.o-cflags :=3D -Wno-deprecated-declarations
> > > +vnc-auth-sasl.o-cflags :=3D -Wno-deprecated-declarations
> > > +endif
> >=20
> > Hmm, does clang understand "#pragma GCC diagnostic" ?
> >=20
> > If so, then this can be done in in the code not the makefiles, and
> > also
> > selectively for osx only.
>=20
> It does have some diagnostic pragma support. The awkward part is
> that it has to=C2=A0=C2=A0be in force at the point where the deprecated
> function is used, not where it's declared. So you can't just wrap
> the #include of the ssl header in pragmas, you'd have to either
> do it at every callsite or else over the whole .c file.

Do it on the whole file on osx only is still better because we continue
to get the warnings on non-osx then, which should be enough to avoid
the code bitroting unnoticed.

cheers,
  Gerd
