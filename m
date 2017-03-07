Received: from eggs.gnu.org ([2001:4830:134:3::10]:39926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clCRm-0008PT-UW
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clCRl-0005Uz-Rn
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:34:26 -0500
Date: Tue, 7 Mar 2017 11:34:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170307103416.GF5871@noname.str.redhat.com>
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195434.16782-1-mreitz@redhat.com>
	<ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
	<c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
	<0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
	<d0b3a805-8a05-bfea-2567-1f2cdc7c25e2@redhat.com>
	<2efea3b9-8372-8f43-a357-5f79f430724d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <2efea3b9-8372-8f43-a357-5f79f430724d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some
 bdrv_truncate() error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.03.2017 um 21:53 hat Eric Blake geschrieben:
> On 03/06/2017 02:48 PM, Max Reitz wrote:
> > On 06.03.2017 21:21, Eric Blake wrote:
> >> On 03/06/2017 02:14 PM, Max Reitz wrote:
> >>
> >>>>>      if (S_ISREG(st.st_mode)) {
> >>>>>          if (ftruncate(s->fd, offset) < 0) {
> >>>>> +            /* The generic error message will be fine */
> >>>>>              return -errno;
> >>>>
> >>>> Relying on a generic error message in the caller is awkward. I see i=
t as
> >>>> evidence of a partial conversion if we have an interface that requir=
es a
> >>>> return of a negative errno value to make up for when errp is not set.
> >>>
> >>> I'm not sure what you mean by this exactly.
> >>
> >> The ideal conversion would be having .bdrv_truncate switch to a void
> >> return; then no caller is messing with negative errno values (especial=
ly
> >> since some of them are just synthesizing errno values, rather than
> >> actually encountering one, and since some of them are probably using -1
> >> when they should be using errno). But such a conversion requires that
> >> all drivers be updated to properly set errp.
> >=20
> > Not sure if that is an ideal conversion. I very much prefer negative
> > return value + error object because that allows constructs like
> >=20
> > if (foo(..., errp) < 0) {
> >     return;
> > }
>=20
> Fair point - Markus has argued that we should convert functions from
> void to easy-to-spot return sentinels for easier logic (less boilerplate
> in creating a local error, checking it, and propagating it).
>=20
> But the point remains that returning -1 is simpler to code than
> returning negative errno, when some of the existing drivers are already
> synthesizing errno.  And (temporarily) forcing a void return would make
> it easy to spot who still needs conversion, even if we then go back to
> returning int (but this time, with the simpler -1 for error, rather than
> negative errno).

Note that bdrv_truncate() is a bit special because it is called in some
paths that only have a -errno return and no Error** parameter, like
bdrv_co_pwritev() implementations, and I don't think we intend to
convert those to Error**.

Sharing some code between bdrv_truncate() and write after EOF is
something that I'd like to have anyway. Some of the things that
bdrv_truncate() does are missing in bdrv_aligned_pwritev(), and in the
age of -blockdev where you can use any node for anything, this is a bug.

Kevin

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYvoyoAAoJEH8JsnLIjy/WOm8P/2oiqtQJDOjEmQ0pDRg2ah4W
hAH/9Au97tpnh5EYYWHq2eYMq75bhqzJz/yspmvmwXl5LYbcbubaAfGdNG9hmANF
opP+6b63NTCfKB7DJp4qP0sfwRk/2BsLYylMleZ852HlHxqbU4/ubn4c8VHPk/za
nBPKWaJZATTamXRMzWnENe+EzSsAyu5na2NqMGqEP6mXilOdQmlFR2/rFb9n+u2G
Toytr32ajS6Ml538U2wTpwlpcDYLVK0dIX4NqplbFW/AKZe/epE2JEo8glcbNgQ9
o8McgHfD9rTlgbftQEIpUCjOAzWOnhjsmdFca/VCRaWM0dclio4166PX35OvJoOi
rXjrWi9DyDswvxykg0Jbfns1L2BP4W1byYdk2IpSd45LRe9aykRarGatXkDAC/Es
u7PA18SQ6vMKXY1cWDX5PaOIiYysNYt4b4XGQU/7ycCKaRPFglrBFGyi/qF/eVI+
s22G3zNeSgqPsHsv1HCZxfP6H10P6bgK/L3ykFcRS49yl1eREOEKq2B7Ty3gWIwB
Cp0yT5lHOXJG5VOZpPcAvZmmQ2UnbYX14hSP2FfFkiPXa5fVga0+4kGZ/BNKlK9V
TFHZtGBKdmfq6RmqTOpGeOr16OgHFlscZGDq6x8WCwftS8xubntS8kXumG1FHD4j
0uZRAV9MwCKI6n9udW9k
=Oek6
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
