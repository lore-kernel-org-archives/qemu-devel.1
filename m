Received: from eggs.gnu.org ([2001:4830:134:3::10]:33350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqCWg-0004Gg-Qb
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqCWc-0004vV-3c
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:12:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqCWb-0004uU-U2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:12:22 -0400
Date: Fri, 8 Sep 2017 14:12:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908061217.GC4511@lemon>
References: <20170907082918.7299-1-famz@redhat.com>
	<20170907082918.7299-8-famz@redhat.com>
	<58759972-657f-ae54-d3bb-ff84963e4f7e@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <58759972-657f-ae54-d3bb-ff84963e4f7e@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/9] buildsys: Move libcacard cflags/libs
 to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 09/07 14:46, Philippe Mathieu-Daud=E9 wrote:
>=20
>=20
> On 09/07/2017 05:29 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   configure            | 4 ++--
> >   hw/usb/Makefile.objs | 6 ++++--
> >   2 files changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/configure b/configure
> > index b1320b1994..85fef3d16f 100755
> > --- a/configure
> > +++ b/configure
> > @@ -4237,8 +4237,6 @@ if test "$smartcard" !=3D "no"; then
> >       if $pkg_config libcacard; then
> >           libcacard_cflags=3D$($pkg_config --cflags libcacard)
> >           libcacard_libs=3D$($pkg_config --libs libcacard)
> > -        QEMU_CFLAGS=3D"$QEMU_CFLAGS $libcacard_cflags"
> > -        libs_softmmu=3D"$libs_softmmu $libcacard_libs"
> >           smartcard=3D"yes"
> >       else
> >           if test "$smartcard" =3D "yes"; then
> > @@ -5831,6 +5829,8 @@ fi
> >   if test "$smartcard" =3D "yes" ; then
> >     echo "CONFIG_SMARTCARD=3Dy" >> $config_host_mak
> > +  echo "SMARTCARD_CFLAGS=3D$libcacard_cflags" >> $config_host_mak
> > +  echo "SMARTCARD_LIBS=3D$libcacard_libs" >> $config_host_mak
> >   fi
> >   if test "$libusb" =3D "yes" ; then
> > diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> > index 97f1c4561a..795ff25a5e 100644
> > --- a/hw/usb/Makefile.objs
> > +++ b/hw/usb/Makefile.objs
> > @@ -26,8 +26,10 @@ common-obj-$(CONFIG_USB_BLUETOOTH)    +=3D dev-blu=
etooth.o
> >   ifeq ($(CONFIG_USB_SMARTCARD),y)
> >   common-obj-y                          +=3D dev-smartcard-reader.o
> > -common-obj-$(CONFIG_SMARTCARD)        +=3D ccid-card-passthru.o
> > -common-obj-$(CONFIG_SMARTCARD)        +=3D ccid-card-emulated.o
> > +common-obj-$(CONFIG_SMARTCARD)        +=3D smartcard.mo
> > +smartcard.mo-objs :=3D ccid-card-passthru.o ccid-card-emulated.o
> > +smartcard.mo-cflags :=3D $(SMARTCARD_CFLAGS)
> > +smartcard.mo-libs :=3D $(SMARTCARD_LIBS)
>=20
> this line here looks more natural to me:
>=20
> common-obj-$(CONFIG_SMARTCARD)        +=3D smartcard.mo

Do you mean to move this line *after* the .mo variables? I personally fin=
d the
current (top-down) order easier to understand, and it more common.

Fam

>=20
> >   endif
> >   ifeq ($(CONFIG_POSIX),y)
> >=20
>=20
