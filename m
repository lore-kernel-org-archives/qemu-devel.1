Received: from eggs.gnu.org ([2001:4830:134:3::10]:55232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKoJd-0005NX-4M
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKoJY-0003fi-3m
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:29 -0500
Date: Thu, 30 Nov 2017 16:09:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171130160922.GB17703@stefanha-x1.localdomain>
References: <20171129144956.11409-1-famz@redhat.com>
	<20171129144956.11409-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20171129144956.11409-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 3/9] blockjob: Implement AioContext
 drain ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 10:49:50PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  blockjob.c | 47 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
>=20
> diff --git a/blockjob.c b/blockjob.c
> index ff9a614531..86d060c89c 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -148,6 +148,23 @@ static void block_job_attached_aio_context(AioContex=
t *new_context,
>                                             void *opaque);
>  static void block_job_detach_aio_context(void *opaque);
> =20
> +static void block_job_drained_begin(void *opaque)
> +{
> +    BlockJob *job =3D opaque;
> +    block_job_pause(job);
> +}

This is buggy because block_job_pause() increments a counter.  Remember
the .drained_begin() semantics are that it can be called any number of
times (see comment in previous patch)!

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIC0yAAoJEJykq7OBq3PI+xUH/RnHEhHjuOgcmXbM1yW0g7/s
QpnUixzQWIwrddQ43DlFPpEw/rgm8XJ8eJSC91q0QnnOzn7Oq/vR+ZuvgH3AGnge
azlBL744jNqMNz6+gKB04VgvcT69rnoV1cPf95SBJV1LwLdZa//sfkG3DpXRjfp5
IVGOMNOdabdXJ0JIApvLa9ysfhGiIGeGYyn+nmV8U2NBhAmD+kFIVklRaJci26hC
CIuxBi1CjWILHJIIpuAgxEjHIVjxx3HAA7rsKMDawpkTp621sR4Bk405q9UIyWUx
SY5OoZzxSEPyzA1eEYPIK4wWwhxOMqRnTGLGV83fyi5z/J5McBm2UKc8MjzADdc=
=uUEJ
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
