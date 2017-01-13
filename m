Received: from eggs.gnu.org ([2001:4830:134:3::10]:41023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cS1jf-0007Tv-58
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cS1jb-0002RT-4B
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cS1ja-0002Qm-UC
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:35 -0500
Date: Fri, 13 Jan 2017 13:17:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170113131727.GA10706@stefanha-x1.localdomain>
References: <20170113115651.17607-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20170113115651.17607-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: check if nvdimm is enabled before
 plugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com, Xiao Guangrong <guangrong.xiao@linux.intel.com>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 07:56:51PM +0800, Haozhong Zhang wrote:
> The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
> is disabled. QEMU should refuse to plug any NVDIMM device in this case
> and report the misconfiguration.
>=20
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Message-Id: 20170112110928.GF4621@stefanha-x1.localdomain
> Message-Id: 20170111093630.2088-1-stefanha@redhat.com
> ---
>  hw/i386/pc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 25e8586..3907609 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1715,6 +1715,11 @@ static void pc_dimm_plug(HotplugHandler *hotplug_d=
ev,
>      }
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> +        if (!pcms->acpi_nvdimm_state.is_enabled) {
> +            error_setg(&local_err,
> +                       "nvdimm is not enabled: missing 'nvdimm' in '-M'"=
);
> +            goto out;
> +        }

A warning is definitely useful to notify users of a possible
configuration error.

I wonder what happens when you plug an NVDIMM into a motherboard where
the firmware lacks support.  Does it:
 * Refuse to boot?
 * Treat the DIMM as regular RAM?
 * Boot but the DIMM will not be used by firmware and kernel?

QEMU should act the same way as real hardware.

Stefan

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYeNNmAAoJEJykq7OBq3PIgZkH/jWlWnVpAfuqMD4cQVDeSekI
y34fryEMWRevAkvu+5hcvzETrzyuPHLKzdObIiyDBzjxvoKraEaQ4JE9ZC+3dC6X
qW8hCz9xNC5CREBF3wdoqi8E7HcXWPo00a4nlBZkIQWIlgBmnYIxDb20JWhS0A6S
gdAjytIaTCdaO6BT08bEvu6tYE8xedr6ww78N34cpJk50/2u/EzfatQYflQaVDhw
24UJdao9T2/f9TfZAPuAqIbf3IMNhmqw/hqvGu4I4jvdFITXxLbyzbBuUwPBEtyj
PJqH0/kKsov7jRLURyTFGzrGZXj+LqQEscwsilJKCCp8dXNzk9fkuSF8SvjMv1A=
=xAB/
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
