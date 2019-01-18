Received: from eggs.gnu.org ([209.51.188.92]:57532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkZum-0005II-K7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkZul-00086p-Qg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:34:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkZul-00083s-KR
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:34:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF87083F44
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 19:34:49 +0000 (UTC)
Date: Fri, 18 Jan 2019 17:34:44 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190118193444.GK4136@habkost.net>
References: <20190118134843.28916-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190118134843.28916-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-gdb: add a QObject pretty printer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com

On Fri, Jan 18, 2019 at 05:48:43PM +0400, Marc-Andr=E9 Lureau wrote:
> Inspired by GObject/GType pretty printer.
>=20
> Example:
> machine_set_accel (obj=3D0x555556807550 [pc-i440fx-4.0-machine],...
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qemu-gdb.py | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  mode change 100644 =3D> 100755 scripts/qemu-gdb.py
>=20
> diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
> old mode 100644
> new mode 100755
> index 690827e6fc6..90c6fd13b93
> --- a/scripts/qemu-gdb.py
> +++ b/scripts/qemu-gdb.py
> @@ -21,6 +21,9 @@ import gdb
> =20
>  import os, sys
> =20
> +if sys.version_info[0] >=3D 3:
> +    long =3D int
[...]
> +class QObjectPrinter:
> +    def __init__(self, val):
> +        self.val =3D val
> +
> +    def to_string(self):
> +        name =3D object_class_name(self.val)
> +        if name:
> +            return ("0x%x [%s]")% (long(self.val), name)
> +        return  ("0x%x") % (long(self.val))

I took a while to find out that int(v) doesn't work if v is a
pointer gdb value.  This is surprising, because int(long_number)
(e.g. int(2**65)) works on Python 2.

Also, this works on Python 2:

  int(self.val.cast(gdb.lookup_type("unsigned long long")))

But it's so ugly that a sys.version_info check still sounds
better.

I would prefer this, though:

  if sys.version_info[0] < 3:
      int =3D long
  ...
      def to_string(self):
          ...
          return  ("0x%x") % (int(self.val))

Because it makes the python2-specific code easier to remove in
the future.

> +
> +
> +def lookup_type(val):
> +    if is_object(val):
> +        return QObjectPrinter(val)
> +    return None
> +
> +
> +gdb.pretty_printers.append(lookup_type)
> --=20
> 2.20.1.98.gecbdaf0899
>=20

--=20
Eduardo
