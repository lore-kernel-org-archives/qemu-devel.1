Received: from eggs.gnu.org ([209.51.188.92]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gnEmh-00078S-JV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 22:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gnEmf-0002St-Dx
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 22:37:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gnEmY-0002P7-J4
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 22:37:25 -0500
Date: Sat, 26 Jan 2019 01:37:12 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190126033712.GQ4136@habkost.net>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-15-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190125140017.6092-15-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 14/14] scripts/qemu.py: allow arches use
 KVM for their 32bit cousins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Fri, Jan 25, 2019 at 02:00:17PM +0000, Alex Benn=E9e wrote:
> A lot of architectures can run their 32 bit cousins on KVM so the
> kvm_available function needs to be a little less restricting when
> deciding if KVM is available.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  scripts/qemu.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 0a5e02eb56..2934ee12c5 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -25,9 +25,18 @@ import tempfile
> =20
>  LOG =3D logging.getLogger(__name__)
> =20
> +# Mapping host architecture to any additional architectures it can
> +# support which often includes its 32 bit cousin.
> +ADDITIONAL_ARCHES =3D {
> +    "x86_64" : "i386",
> +    "aarch64" : "armhf"
> +}
> =20
>  def kvm_available(target_arch=3DNone):
> -    if target_arch and target_arch !=3D os.uname()[4]:
> +    host_arch =3D os.uname()[4]
> +    if target_arch and target_arch !=3D host_arch:
> +        if target_arch =3D=3D ADDITIONAL_ARCHES[host_arch]:

This will crash host_arch isn't "x86_64" or "aarch64".  I suggest
ADDITIONAL_ARCHES.get(host_arch)

> +            return True

I don't think we should skip the /dev/kvm check here.


>          return False
>      return os.access("/dev/kvm", os.R_OK | os.W_OK)
> =20
> --=20
> 2.17.1
>=20

--=20
Eduardo
