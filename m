Received: from eggs.gnu.org ([2001:4830:134:3::10]:56682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLhc-0007cf-At
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLhb-0006nJ-16
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:06:20 -0500
Date: Wed, 10 Jan 2018 19:05:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110190558.GJ24212@stefanha-x1.localdomain>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-9-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
Content-Disposition: inline
In-Reply-To: <20180110091846.10699-9-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 8/9] docs: Add section for NVMe VFIO
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 05:18:45PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  docs/qemu-block-drivers.texi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> index 503c1847aa..66b27cc4f7 100644
> --- a/docs/qemu-block-drivers.texi
> +++ b/docs/qemu-block-drivers.texi
> @@ -785,6 +785,38 @@ warning: ssh server @code{ssh.example.com:22} does n=
ot support fsync
>  With sufficiently new versions of libssh2 and OpenSSH, @code{fsync} is
>  supported.
> =20
> +@node disk_images_nvme
> +@subsection NVMe disk images
> +
> +You can access disk images on a NVMe controller with the built-in VFIO b=
ased
> +NVMe driver. Before starting QEMU, bind the host NVMe controller to vfio=
-pci.

The text dives straight into vfio-pci without any explanation of this
feature.  Please include something like:

NVM Express (NVMe) storage controllers can be accessed directly by a
userspace driver in QEMU.  This bypasses the host kernel file system and
block layers while retaining QEMU block layer functionality, such as
block jobs, I/O throttling, etc.  Disk I/O performance is typically
higher than with -drive file=3D/dev/sda.

> +For example:
> +
> +@example
> +# modprobe vfio-pci
> +# lspci -n -s 0000:06:0d.0
> +06:0d.0 0401: 1102:0002 (rev 08)
> +# echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
> +# echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
> +
> +# qemu-system-x86_64 -drive file=3Dnvme://@var{host}:@var{bus}:@var{slot=
}.@var{func}/@var{namespace}
> +@end example
> +
> +Alternative syntax using properties:
> +
> +@example
> +qemu-system-x86_64 -drive file.driver=3Dnvme,file.device=3D@var{host}:@v=
ar{bus}:@var{slot}.@var{func},file.namespace=3D@var{namespace}
> +@end example
> +
> +@var{host}:@var{bus}:@var{slot}.@var{func} is the NVMe controller's PCI =
device
> +address on the host.
> +
> +@var{namespace} is the NVMe namespace number, starting from 1.
> +
> +The controller will be exclusively used by the QEMU process once started=
=2E To be
> +able to share storage between multiple VMs and other applications on the=
 host,
> +please use file based protocols.

I suggest moving this up to the beginning in the hopes that people will
read it before asking questions on IRC or qemu-devel :).

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVmQWAAoJEJykq7OBq3PIOv8H+QEf0iFoV0Ynnu8hRFpi01YY
jUyuA9F2Gbgi9qBqcXJqUNTemGoc3eHRxERfToCBHP+BsZyDZHUZZjcGs3ZZYXUA
ePc9RL7opqNrkW0oXMDmB4BuYAitixuxB1+/xLpMCFjDhzZFG6ZYgdlDbpMbIo8j
1pr6jsy+5jqjPl0Qi998mczL3+YWKoYuin86vGG1aaCnAdQkBTFP9KvFwd7XftAZ
NBZtuoDnFKL0kPCMsAj4dpVkr0XAFEQ6DxtFZA4mmaaH7XQzx/Eyb3zAh36x8/u/
2v7DaCus4OSuJnhU5dS5n4MAW5YfeKHMpGuG0dCVTdFZXbAxJy3tI7AGAUdsuc8=
=7c6a
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--
