Received: from eggs.gnu.org ([2001:4830:134:3::10]:46880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxnK-0006ou-Uu
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxnJ-00050g-N9
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVxnJ-0004zu-Dt
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:57 -0400
Date: Fri, 14 Jul 2017 11:25:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714102551.GB27446@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-2-lprosek@redhat.com>
	<20170713133206.GA18623@stefanha-x1.localdomain>
	<CABdb735h_vjCsHR+5reKxdHXLZkzfiCiW0qr=xoxXyYJ=1Y3Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <CABdb735h_vjCsHR+5reKxdHXLZkzfiCiW0qr=xoxXyYJ=1Y3Mw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] qemu-error: introduce
 error_report_nolf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 03:48:02PM +0200, Ladi Prosek wrote:
> On Thu, Jul 13, 2017 at 3:32 PM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> > On Thu, Jul 13, 2017 at 01:02:30PM +0200, Ladi Prosek wrote:
> >> +/*
> >> + * Print an error message to current monitor if we have one, else to =
stderr.
> >> + * Format arguments like sprintf().  The resulting message should be a
> >> + * single phrase, with no trailing punctuation.  The no-LF version al=
lows
> >> + * additional text to be appended with error_printf() or error_vprint=
f().
> >> + * Make sure to always close with a newline after all text is printed.
> >> + * Prepends the current location.
> >> + * It's wrong to call this in a QMP monitor.  Use error_setg() there.
> >> + */
> >> +void error_report_nolf(const char *fmt, ...)
> >> +{
> >> +    va_list ap;
> >> +
> >> +    va_start(ap, fmt);
> >> +    error_vreport_nolf(fmt, ap);
> >> +    va_end(ap);
> >>  }
> >
> > Each call to this function prepends the timestamp, so it cannot really
> > be used for a sequence of prints in a single line.
>=20
> True, the _nolf means "does not append \n" rather than "can be called
> repeatedly". You would use error_printf() / error_vprintf() for
> subsequent prints, as mentioned in the comment above this function.
>=20
> > It's a little ugly but I expected something along the lines of
> > g_strdup_vprintf() in virtio_error():
> >
> >   char *msg;
> >
> >   va_start(ap, fmt);
> >   msg =3D g_strdup_vprintf(fmt, ap);
> >   va_end(ap);
> >
> >   error_report("%s: %s", DEVICE(vdev)->id, msg);
> >
> >   g_free(msg);
> >
> > https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.h=
tml#g-strdup-vprintf
>=20
> I wanted to avoid the memory allocation, that's all. Not for
> performance, obviously, but to increase the chances that it will come
> through and always look the same if the process is under memory
> pressure, the heap corrupted or otherwise in a bad state.
>=20
> Both approaches look about the same ugly to me but I can certainly
> change it to the one you're suggesting.

The chance that error_report_nolf() will be used incorrectly is high.
Performance isn't a big concern for printing error messages.  That's why
I suggest a single error_report() call instead.

Stefan

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaJwvAAoJEJykq7OBq3PIBG8H+wTNmgeEZ4PurtYyZWvrkptg
3Bo2+J/EHMlLCgQr+tdm9FH7Ps0767zRgMfSX6yXXeVuiKE4W+b0RUikzGEx2WeA
Bw77y8oHh9pJl1ggHAP+gyJTIkuJTyaFKREqKu5SQYtpHPv9vbIegoErGGnglqNN
zP0T9A+l8LWg1nPL6ZjIhcRQJ27/oHsi80QHfFgMtf+0SZITLkoAOja9x/lUDFf1
z6AYo1gFrTaxpay1VYO47dkDJDTKX3Yd5aPtKhRbt/m9onyE9nRJxZTCFFeE87kO
z2Jm0bmCxMR4uTSEs7Vpl81z81wm/6FwdhNRwI7TnA6yd99c6BRmYkXw/M7sznU=
=UOY8
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
