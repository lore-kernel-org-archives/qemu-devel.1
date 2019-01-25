Received: from eggs.gnu.org ([209.51.188.92]:38439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmyj8-0007oE-Qv
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmyj7-0007Q9-Nl
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:28:46 -0500
Date: Fri, 25 Jan 2019 10:28:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190125102842.GB28305@stefanha-x1.localdomain>
References: <20190123212234.32068-1-stefanha@redhat.com>
	<20190123212234.32068-3-stefanha@redhat.com>
	<f58f9085-c895-1fa5-9fae-afe4ac8de39a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <f58f9085-c895-1fa5-9fae-afe4ac8de39a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] pflash: flush rom device memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, jim@groklearning.com, Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jusual@mail.ru, Richard Henderson <rth@twiddle.net>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 12:11:55PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 1/23/19 10:22 PM, Stefan Hajnoczi wrote:
> > pflash devices should mark the memory region dirty and invalidate TBs
> > after directly writing to the RAM backing the ROM device.
> >=20
> > Note that pflash_cfi01_get_memory() is used by several machine types to
> > populate ROM contents directly.  Callers are untouched by this patch
> > because they only modify memory before the guest is started.
=2E..
> > @@ -763,6 +766,8 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
> >              error_setg(errp, "failed to read the initial flash content=
");
> >              return;
> >          }
> > +
> > +        memory_region_flush_rom_device(&pfl->mem, 0, total_len);
>=20
> The device realize() is also executed before the guest is started, is
> this call really necessary?

My rationale was that machine init only happens before the guest is
started while ->realize() is called by hotplug too.

That said, can pflash devices be hotplugged?

If you guys prefer not flushing from pflash ->realize() then I'll drop
it.

Stefan

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSuTaAAoJEJykq7OBq3PIVtgH/3jX/5SKfR95RxpxWSFIAMsV
e22lJdwugIsjiczcIJAKW8o3WjWh/2NVzmFN0rTtXYWUf1E5TJ8OAdv/OJ3/YDPB
/o/0mEVUrD73RodPdRsASZOIsuoB+Waoc7FK1+ea34dpt/d3c+k82GvW/I3s9yxq
zu7K/4REkOYNGw4PN58IK0xQpWDFQ1m6JizU1RbS9sdL+xAYgU5KQddkUGPOfPPO
6OlmC6aZYFNgLO2PCl34Mja0ii/p5FQuiRAYP5vQhRH3OXtN8kg1SqqCk8To4ceI
3eGe+sUaLVYYuVKNnnWekCVMKmuvyxr/im843ogBufzho7l6FKeeYXEWXFhFtvc=
=g+Wg
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
