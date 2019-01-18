Received: from eggs.gnu.org ([209.51.188.92]:34201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkYI6-0000Ny-2M
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkYI4-00055G-Te
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:50:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkYI4-00054Z-KE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:50:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1FD62D7E2
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:50:47 +0000 (UTC)
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
Date: Fri, 18 Jan 2019 11:50:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190118173103.4903-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yJjEf01Ns3CAaHu24oLY2oAlIuJm0xUpO"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yJjEf01Ns3CAaHu24oLY2oAlIuJm0xUpO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-4-berrange@redhat.com>
In-Reply-To: <20190118173103.4903-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> The '%m' format specifier instructs glibc's printf() implementation to
> insert the contents of strerror(errno).

That is a glibc-only extension in printf(), but mandatory (and supported
in ALL platforms) in syslog().  However, you are correct that:

> This is not something that
> should ever be used in trace-events files because several of the
> backends do not use the format string and so this error information is
> invisible to them. The errno value should be given as an explicit
> trace argument instead. Use of '%m' should also be avoided as it is not=

> portable to all QEMU build targets.

If all of our traces are compiled to syslog(), it would be portable, but
that's not the case.

What's more, using %m is subject to race conditions - the more code you
have between when the format string containing %m is given, and the
point where the actual error message is emitted, the higher the
probability that some of the intermediate code could have stomped on
errno in the meantime, rendering the logged message incorrect.  And
forcing logging wrappers to save/restore the current state of errno,
just in case they might encounter %m, can get wasteful.

Should checkpatch be taught to flag %m as suspicious?

However, tracing the errno value is NOT what %m did; I'd rather see...

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/vfio/pci.c                 | 2 +-
>  hw/vfio/trace-events          | 2 +-
>  scripts/tracetool/__init__.py | 4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c0cb1ec289..85f1908cfe 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2581,7 +2581,7 @@ static void vfio_populate_device(VFIOPCIDevice *v=
dev, Error **errp)
>      ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_in=
fo);
>      if (ret) {
>          /* This can fail for an old kernel or legacy PCI dev */
> -        trace_vfio_populate_device_get_irq_info_failure();
> +        trace_vfio_populate_device_get_irq_info_failure(errno);

trace_vfio_populate_device_get_irq_info_failure(strerror(errno))

>      } else if (irq_info.count =3D=3D 1) {
>          vdev->pci_aer =3D true;
>      } else {
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index a85e8662ea..6d412afc83 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -37,7 +37,7 @@ vfio_pci_hot_reset_has_dep_devices(const char *name) =
"%s: hot reset dependent de
>  vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int func=
tion, int group_id) "\t%04x:%02x:%02x.%x group %d"
>  vfio_pci_hot_reset_result(const char *name, const char *result) "%s ho=
t reset: %s"
>  vfio_populate_device_config(const char *name, unsigned long size, unsi=
gned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx,=
 offset: 0x%lx, flags: 0x%lx"
> -vfio_populate_device_get_irq_info_failure(void) "VFIO_DEVICE_GET_IRQ_I=
NFO failure: %m"
> +vfio_populate_device_get_irq_info_failure(int err) "VFIO_DEVICE_GET_IR=
Q_INFO failure: %d"

vfio_populate_device_get_irq_info_failur(const char *err)
"VFIO_DEVICE_GET_IRQ_INFO failure: %s"

=2E..if we are trying to match the original intent.

>  vfio_realize(const char *name, int group_id) " (%s) group %d"
>  vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
>  vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offs=
et) "%s 0x%x@0x%x"
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__=
=2Epy
> index 3478ac93ab..6fca674936 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -274,6 +274,10 @@ class Event(object):
>          props =3D groups["props"].split()
>          fmt =3D groups["fmt"]
>          fmt_trans =3D groups["fmt_trans"]
> +        if fmt.find("%m") !=3D -1 or fmt_trans.find("%m") !=3D -1:
> +            raise ValueError("Event format '%m' is forbidden, pass the=
 error "
> +                             "as an explicit trace argument")

Whether or not checkpatch decides to flag %m as suspicious in the
overall code base, I like that you are forbidding it in trace files.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--yJjEf01Ns3CAaHu24oLY2oAlIuJm0xUpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxCEe8ACgkQp6FrSiUn
Q2pBTAf+PHMGEbzaC/46inBtiLh3DxfmyntwWhelmiOM+PSgcmDFNzjyITexYS15
6nkQ29VIRZrQo+6mDzNEEG6+RlrP0a2hN8pGQVYRn9C1WFSZ/mbcSidc/bPRUKKh
GczgEUV9eNeoOdW3Ce0Ab27ZxrpgWRtVbnca+cwQdDP6InIwQqD9BpBTYy63KK0b
rlThx4KwD0X0Df60uJ+x3gspIYGm7Wr+q41BsMwJISahHzNQgJxbVuPemkZbze58
KD7E4naFLk4TSCGODqElIErq6kxKUOgzSm8eEhWo/nOmQLSnpxlTXI1oBg9ssAVL
w1hB7iIeSO3kKX8OvCx3PN0vpkaRyA==
=CGjU
-----END PGP SIGNATURE-----

--yJjEf01Ns3CAaHu24oLY2oAlIuJm0xUpO--
