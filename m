Received: from eggs.gnu.org ([209.51.188.92]:38720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm0wF-0005F9-Ik
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm0w7-00009N-6E
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm0w6-0008PI-6z
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 088F680471
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 17:19:52 +0000 (UTC)
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-4-berrange@redhat.com>
	<c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
	<20190122143257.GR13143@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
Date: Tue, 22 Jan 2019 11:19:42 -0600
MIME-Version: 1.0
In-Reply-To: <20190122143257.GR13143@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WjRaHWeMCRn7TThlEXfjCLuVKV7mWsl5e"
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WjRaHWeMCRn7TThlEXfjCLuVKV7mWsl5e
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-4-berrange@redhat.com>
 <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
 <20190122143257.GR13143@redhat.com>
In-Reply-To: <20190122143257.GR13143@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 8:32 AM, Daniel P. Berrang=C3=A9 wrote:

>>> +++ b/hw/vfio/pci.c
>>> @@ -2581,7 +2581,7 @@ static void vfio_populate_device(VFIOPCIDevice =
*vdev, Error **errp)
>>>      ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_=
info);
>>>      if (ret) {
>>>          /* This can fail for an old kernel or legacy PCI dev */
>>> -        trace_vfio_populate_device_get_irq_info_failure();
>>> +        trace_vfio_populate_device_get_irq_info_failure(errno);
>>
>> trace_vfio_populate_device_get_irq_info_failure(strerror(errno))
>=20
> The caveat is that 'strerror' is not required to be thread safe,
> however, given that this is Linux only code I guess we can assume
> the glibc impl which fortunately is thread safe.

If we are going to worry about thread-safety of strerror(), we have a
LOT of code to scrub (we are using it rather liberally throughout the
code base).

>=20
> On this point though, does anyone know of any platforms we support[1],
> or are likely to support in future, where 'strerror' is *not* thread
> safe ?

I'm not coming up with one, and I think the problem is independent of
this series (if we DO have a problem, it's a series all its own to
eradicate the use of strerror() in favor of something safer, either
picking strerror_l() or dealing with the glibc vs. BSD differences in
strerror_r()).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--WjRaHWeMCRn7TThlEXfjCLuVKV7mWsl5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHUK4ACgkQp6FrSiUn
Q2psJQf/bcuWUHilpz8SqKOzESHOAhmi8HSaEBYay5ODldTO0QbEOydeRofwUVHa
3wUu031uCthG2V+7I7xsBBSt4yNUGQr0p/gKqky4dL4TcXhYN0Yj7zrF0LPl4Kqa
Ky+n8EtoKvRZG3NVx9NUfw81qzLZtOj0USPrtjy1dhKl4cD2SYEUlBA5+k8U0yCr
ps4FnZ0fhCcXIbLtSjG+/PttVLGGP3ZDb4zunWSzr2upGG6gqQSTJlr9OpCRa0YT
JNqV/7g4OEEpN/v31BITVdlgF21F6c368KyrnX/Q992H36x48t79NkvtIFwbmxdw
DRldoir2wAWHk0KE8iQYDAvsGBPKtw==
=yVds
-----END PGP SIGNATURE-----

--WjRaHWeMCRn7TThlEXfjCLuVKV7mWsl5e--
