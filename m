Received: from eggs.gnu.org ([2001:4830:134:3::10]:35792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNwcE-0002E5-3v
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNwcA-0004Yu-3e
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dNwc9-0004Yn-TY
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:33:18 -0400
Message-ID: <1498116800.25651.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Jun 2017 09:33:20 +0200
In-Reply-To: <20170622033231.19344-22-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-22-f4bug@amsat.org>
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
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index 3369451285..08fb573a48 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -6,6 +6,14 @@ vnc-obj-y +=3D vnc-auth-vencrypt.o
> =C2=A0vnc-obj-$(CONFIG_VNC_SASL) +=3D vnc-auth-sasl.o
> =C2=A0vnc-obj-y +=3D vnc-ws.o
> =C2=A0vnc-obj-y +=3D vnc-jobs.o
> +ifeq ($(CONFIG_VNC_SASL),y)
> +# silent OSX SASL warnings (from https://stackoverflow.com/a/7406994
> ):
> +# because OpenSSL doesn=E2=80=99t offer API compatibility between vers=
ions,
> [...] Apple
> +# can't provide security updates without breaking existing apps, so
> is migrating
> +# from OpenSSL to Common Crypto.
> +vnc.o-cflags :=3D -Wno-deprecated-declarations
> +vnc-auth-sasl.o-cflags :=3D -Wno-deprecated-declarations
> +endif

Hmm, does clang understand "#pragma GCC diagnostic" ?

If so, then this can be done in in the code not the makefiles, and also
selectively for osx only.

See include/ui/gtk.h for an example.

cheers,
  Gerd
