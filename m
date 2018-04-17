Received: from eggs.gnu.org ([2001:4830:134:3::10]:53447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Vpc-000065-79
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8VpY-0004mz-91
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:59:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8VpY-0004mV-2y
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:59:52 -0400
References: <1523698174-22832-1-git-send-email-agk@godking.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e5cbe6c-40d2-3961-b2f5-3b2759c86f87@redhat.com>
Date: Tue, 17 Apr 2018 13:59:50 -0500
MIME-Version: 1.0
In-Reply-To: <1523698174-22832-1-git-send-email-agk@godking.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r5iZ1EzWTkhYuqfvxSjfHsMGfXzp8FaOP"
Subject: Re: [Qemu-devel] qapi: [PATCH v2] Implement query-usbhost QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Kappner <agk@godking.net>, kraxel@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r5iZ1EzWTkhYuqfvxSjfHsMGfXzp8FaOP
From: Eric Blake <eblake@redhat.com>
To: Alexander Kappner <agk@godking.net>, kraxel@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org
Message-ID: <1e5cbe6c-40d2-3961-b2f5-3b2759c86f87@redhat.com>
Subject: Re: qapi: [PATCH v2] Implement query-usbhost QMP command
References: <1523698174-22832-1-git-send-email-agk@godking.net>
In-Reply-To: <1523698174-22832-1-git-send-email-agk@godking.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2018 04:29 AM, Alexander Kappner wrote:
> Implement a QMP command similar to the HMP's "info usbhost" command.
> This allows a QMP client to query which USB devices may be available
> for redirection. Because the availability of the command needs to
> depend on the target's (not the build host's) USB configuration,
> a stub function in host-stub.c is provided for targets without USB supp=
ort.
>=20
> v2 of this patch resolves build failure under some configurations
> without libusb.
>=20
> Signed-off-by: Alexander Kappner <agk@godking.net>
> ---
>  hw/usb/host-libusb.c | 64 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  hw/usb/host-stub.c   |  9 ++++++++
>  qapi/misc.json       | 62 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 135 insertions(+)
>=20

> +++ b/qapi/misc.json
> @@ -270,6 +270,46 @@
>  { 'command': 'query-kvm', 'returns': 'KvmInfo' }
> =20
>  ##
> +# @query-usbhost:
> +#
> +# Returns information about USB devices available on the host
> +#
> +# Returns: a [UsbDeviceInfo]. Returns an error if compiled without
> +# CONFIG_USB_LIBUSB

s/a [UsbDeviceInfo]/a list of UsbDeviceInfo

> +#
> +# Since: TODO (maintainer insert version number if mainlined)

2.13 (it's easier to guess the next version, on the likely chance that
it does not need tweaking, than it is to force the maintainer to have to
tweak the patch on acceptance)


> +##
> +{ 'command': 'query-usbhost', 'returns': ['UsbDeviceInfo'] }
> +
> +##
>  # @UuidInfo:
>  #
>  # Guest UUID information (Universally Unique Identifier).
> @@ -876,6 +916,28 @@
>             'regions': ['PciMemoryRegion']} }
> =20
>  ##
> +# @UsbDeviceInfo:
> +#
> +# @speed: the speed
> +#
> +# @id_vendor: idVendor field from device descriptor

Please, new QMP interfaces should favor '-' over '_' in naming; so this
should be id-vendor, and so on.

> +#
> +# @id_product: idProduct field from device descriptor
> +#
> +# @str_product: string descriptor referenced by iProduct index, if any=


What's the difference between idProduct and iProduct in the text here?

> +#
> +# @str_manufacturer: string descriptor referenced by iManufacturer ind=
ex, if any

Is the 'str_' (or my preferred switch to 'str-') prefix necessary; or
can this field just be 'manufacturer'?

> +#
> +# @dev_addr: address on bus that device is connected to
> +#
> +# @bus_num: bus number device is connected to
> +##
> +{ 'struct': 'UsbDeviceInfo',
> +  'data':
> +  {'speed': 'int', 'id_vendor': 'int', 'id_product' : 'int', 'str_prod=
uct': 'str',
> +   'b_device_class': 'int', 'str_manufacturer' : 'str', 'dev_addr' : '=
int', 'bus_num' : 'int'} }

Long line; please fit things within 80 columns.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--r5iZ1EzWTkhYuqfvxSjfHsMGfXzp8FaOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWRCYACgkQp6FrSiUn
Q2pD5Qf/UnALAOGNM1ngmLUb5lWYViozXnnxKfTJBjthOhhJBYxTQRoc3Oai6ufl
Sasnpgi3cNstXmxhHy4qcFh0WMLD9/g74RN/P0n3U5a5MkAySPPWwzDFAgBVmP71
TJDfA2fqEILy4Nj9x6/UetaeVs0UQqBhiKn8U7iF676h6QFSWm8o5KQ1ULDMV83s
VEnMV04wSXXNHtk8sSW3aSQAAExjjrlIv8cvhHW9U7496DTv8ciDQr1RogW/uxCf
a3RmudCdzjuugfwfuKWkltE84A/+SVjWVMpN7xgCdwRNSp1sKJxnimubDEHd82Y3
nCrKdk2/sYGzhImh52+QxzNqaMn/8Q==
=EQKh
-----END PGP SIGNATURE-----

--r5iZ1EzWTkhYuqfvxSjfHsMGfXzp8FaOP--
