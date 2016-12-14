Received: from eggs.gnu.org ([2001:4830:134:3::10]:44163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHC16-0007jh-3m
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHC12-0007Pe-Vu
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:02:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cHC12-0007PO-NG
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:02:48 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C858B8FCF8
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 16:02:47 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-5-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aeb7472e-69f4-b73e-7db2-bf88559b3116@redhat.com>
Date: Wed, 14 Dec 2016 10:02:46 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-5-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DIVmitePocAUOTV5nb4gTBXbb7SJ0sP33"
Subject: Re: [Qemu-devel] [PATCH 04/54] char: move callbacks in CharDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DIVmitePocAUOTV5nb4gTBXbb7SJ0sP33
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <aeb7472e-69f4-b73e-7db2-bf88559b3116@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/54] char: move callbacks in CharDriver
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-5-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> This makes the code more declarative, and avoids to duplicate the

s/to duplicate/duplicating/

> information on all instances.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/baum.c       |  13 +-
>  backends/msmouse.c    |  13 +-
>  backends/testdev.c    |  10 +-
>  gdbstub.c             |   7 +-
>  hw/bt/hci-csr.c       |   8 +-
>  qemu-char.c           | 427 +++++++++++++++++++++++++++++++-----------=
--------
>  spice-qemu-char.c     |  36 +++--
>  ui/console.c          |  26 +--
>  ui/gtk.c              |  11 +-
>  include/sysemu/char.h |  46 +++---

Again, seeing the .h changes first makes a huge difference on code
review.  I'm manually reformatting:

>  10 files changed, 370 insertions(+), 227 deletions(-)

> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index c8750ede21..09e40ef9b8 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -85,24 +85,11 @@ typedef struct CharBackend {
>      int fe_open;
>  } CharBackend;
>
> +typedef struct CharDriver CharDriver;
> +
>  struct CharDriverState {
> +    const CharDriver *driver;
>      QemuMutex chr_write_lock;
> -    int (*chr_write)(struct CharDriverState *s, const uint8_t *buf,
int len);

So all the callbacks are moved into the CharDriver struct...

> @@ -125,7 +112,8 @@ struct CharDriverState {
>   *
>   * Returns: a newly allocated CharDriverState, or NULL on error.
>   */
> -CharDriverState *qemu_chr_alloc(ChardevCommon *backend, Error **errp);=

> +CharDriverState *qemu_chr_alloc(const CharDriver *driver,
> +                                ChardevCommon *backend, Error **errp);=


=2E..and all the entry points are now passed that struct as a new paramet=
er.

>
>  /**
>   * @qemu_chr_new_from_opts:
> @@ -473,15 +461,33 @@ void qemu_chr_set_feature(CharDriverState *chr,
>                            CharDriverFeature feature);
>  QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e);
>
> -typedef struct CharDriver {
> +struct CharDriver {

=2E..the struct already existed, but is now more useful.

Looks worthwhile. I suspect the rest of the patch is mechanical.

> @@ -688,7 +686,10 @@ static void register_types(void)
>  {
>      static const CharDriver driver =3D {
>          .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
> -        .parse =3D NULL, .create =3D chr_baum_init
> +        .parse =3D NULL, .create =3D chr_baum_init,

And now you see why I asked for trailing commas in 2/54 :)

> +        .chr_write =3D baum_write,
> +        .chr_accept_input =3D baum_accept_input,
> +        .chr_free =3D baum_free,
>      };
> =20

> +++ b/gdbstub.c
> @@ -1730,6 +1730,10 @@ int gdbserver_start(const char *device)
>      CharDriverState *chr =3D NULL;
>      CharDriverState *mon_chr;
>      ChardevCommon common =3D { 0 };
> +    static const CharDriver driver =3D {
> +        .kind =3D -1,
> +        .chr_write =3D gdb_monitor_write

Trailing comma.

Interesting that this is a new use of CharDriver with an out-of-range
=2Ekind. But I think your code in 3/54 was careful to explicitly handle a=

=2Ekind that does not map to one of the public types, so that you are abl=
e
to use this as an internal-only driver.


> =20
> +static const CharDriver null_driver =3D {
> +    .kind =3D CHARDEV_BACKEND_KIND_NULL, .create =3D qemu_chr_open_nul=
l,

One initializer per line is fine.

> +    .chr_write =3D null_chr_write
> +};
> +

>=20
> @@ -864,14 +880,6 @@ static CharDriverState *qemu_chr_open_mux(const ch=
ar *id,
> =20
>      chr->opaque =3D d;
>      d->focus =3D -1;
> -    chr->chr_free =3D mux_chr_free;
> -    chr->chr_write =3D mux_chr_write;
> -    chr->chr_accept_input =3D mux_chr_accept_input;
> -    /* Frontend guest-open / -close notification is not support with m=
uxes */
> -    chr->chr_set_fe_open =3D NULL;
> -    if (drv->chr_add_watch) {
> -        chr->chr_add_watch =3D mux_chr_add_watch;
> -    }

Here, the callback was only conditionally registered...

> +static const CharDriver mux_driver =3D {
> +    .kind =3D CHARDEV_BACKEND_KIND_MUX,
> +    .parse =3D qemu_chr_parse_mux, .create =3D qemu_chr_open_mux,
> +    .chr_free =3D mux_chr_free,
> +    .chr_write =3D mux_chr_write,
> +    .chr_accept_input =3D mux_chr_accept_input,
> +    .chr_add_watch =3D mux_chr_add_watch,
> +};

=2E..but here, it is always registered.  Is that an unintentional semanti=
c
change?


> +#ifdef HAVE_CHARDEV_SERIAL
> +static const CharDriver serial_driver =3D {
> +    .alias =3D "tty", .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> +    .parse =3D qemu_chr_parse_serial, .create =3D qmp_chardev_open_ser=
ial,
> +#ifdef _WIN32
> +    .chr_write =3D win_chr_write,
> +    .chr_free =3D win_chr_free,
> +#else
> +    .chr_add_watch =3D fd_chr_add_watch,
> +    .chr_write =3D fd_chr_write,
> +    .chr_update_read_handler =3D fd_chr_update_read_handler,
> +    .chr_ioctl =3D tty_serial_ioctl,
> +    .chr_free =3D qemu_chr_free_tty,
> +#endif
> +};
> +#endif


> @@ -4910,49 +5037,33 @@ void qemu_chr_cleanup(void)
> =20
>  static void register_types(void)
>  {
> -    int i;
> -    static const CharDriver drivers[] =3D {
> -        { .kind =3D CHARDEV_BACKEND_KIND_NULL, .parse =3D NULL,
> -          .create =3D qemu_chr_open_null },
> -        { .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
> -          .parse =3D qemu_chr_parse_socket, .create =3D qmp_chardev_op=
en_socket },
> -        { .kind =3D CHARDEV_BACKEND_KIND_UDP, .parse =3D qemu_chr_pars=
e_udp,
> -          .create =3D qmp_chardev_open_udp },
> -        { .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
> -          .parse =3D qemu_chr_parse_ringbuf, .create =3D qemu_chr_open=
_ringbuf },
> -        { .kind =3D CHARDEV_BACKEND_KIND_FILE,
> -          .parse =3D qemu_chr_parse_file_out, .create =3D qmp_chardev_=
open_file },
> -        { .kind =3D CHARDEV_BACKEND_KIND_STDIO,
> -          .parse =3D qemu_chr_parse_stdio, .create =3D qemu_chr_open_s=
tdio },
> -#if defined HAVE_CHARDEV_SERIAL
> -        { .kind =3D CHARDEV_BACKEND_KIND_SERIAL, .alias =3D "tty",
> -          .parse =3D qemu_chr_parse_serial, .create =3D qmp_chardev_op=
en_serial },

It feels like some code motion between 3/54 and 4/54 (you are moving
where the CharDriver is declared); is it worth tweaking the series to
avoid the code motion by declaring the structs in the right place to
begin with?  Not necessarily a show-stopper to the series, though.

> +    static const CharDriver *drivers[] =3D {
> +        &null_driver,
> +        &socket_driver,
> +        &udp_driver,
> +        &ringbuf_driver,
> +        &file_driver,
> +        &stdio_driver,
> +#ifdef HAVE_CHARDEV_SERIAL
> +        &serial_driver,
>  #endif

Overall impression is that I still like where this is headed.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DIVmitePocAUOTV5nb4gTBXbb7SJ0sP33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYUW0mAAoJEKeha0olJ0NqbUoH/iHYi8Lyjygk75X9wr7B2u3I
MI0ViPn3NiZ2zXo1FchnPcxVvrJVAg3kI2gGorObT+GwyIwmSeaNdxfJ7fMlboit
02Zn+fgljSUtZV2sIylsXP5SMq5rW72Md2pkl3o7+JTOV6UCwgNFgRZQ7afOxbu/
+AezWD14szLFcAH6tENmTJe4bCJR3r8C7eHSxuHeAETGcD+PXYawwrXZVCNQWL98
Evvl48nf0reX8ceviyPi9BiLoYnCzHjUUIqFwA1XTMKZQxs6F/Wfis+CB9QxzoAP
Xqa24Oik8Jm88kNYSicheceg4oHDSMCIu0UZJrW/CLNDp6xP16LHXngUBrAB+js=
=KqzV
-----END PGP SIGNATURE-----

--DIVmitePocAUOTV5nb4gTBXbb7SJ0sP33--
