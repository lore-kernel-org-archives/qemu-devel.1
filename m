Received: from eggs.gnu.org ([209.51.188.92]:46820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm15C-0004of-Mj
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm14p-0005NV-Fq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:47:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm14n-0004a5-9V
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:47:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27B4889AC2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 18:10:17 +0000 (UTC)
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-4-berrange@redhat.com>
	<c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
	<20190122143257.GR13143@redhat.com>
	<c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
	<20190122172333.GA13143@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d0997e0-9019-c7c2-56d6-26c70f0d5c7e@redhat.com>
Date: Tue, 22 Jan 2019 12:10:06 -0600
MIME-Version: 1.0
In-Reply-To: <20190122172333.GA13143@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="erhuOHA7Ww3KiA52jDxtXaceMV3lMft7O"
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
--erhuOHA7Ww3KiA52jDxtXaceMV3lMft7O
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <9d0997e0-9019-c7c2-56d6-26c70f0d5c7e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-4-berrange@redhat.com>
 <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
 <20190122143257.GR13143@redhat.com>
 <c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
 <20190122172333.GA13143@redhat.com>
In-Reply-To: <20190122172333.GA13143@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 11:23 AM, Daniel P. Berrang=C3=A9 wrote:

>=20
>>> On this point though, does anyone know of any platforms we support[1]=
,
>>> or are likely to support in future, where 'strerror' is *not* thread
>>> safe ?
>>
>> I'm not coming up with one, and I think the problem is independent of
>> this series (if we DO have a problem, it's a series all its own to
>> eradicate the use of strerror() in favor of something safer, either
>> picking strerror_l() or dealing with the glibc vs. BSD differences in
>> strerror_r()).
>=20
> Agree that its not really something for this series - this just
> made me think of it again.

Shoot - FreeBSD strerror() is not threadsafe:
https://github.com/freebsd/freebsd/blob/master/lib/libc/string/strerror.c=
#L119

char *
strerror(int num)
{
	static char ebuf[NL_TEXTMAX];

	if (strerror_r(num, ebuf, sizeof(ebuf)) !=3D 0)
		errno =3D EINVAL;
	return (ebuf);
}

>=20
> We went through the scrubbing in libvirt to use the sane, but still
> tedious to call, variant of strerror_r() many years ago. With luck
> though it is a worry that can be confined the dustbin of ancient
> UNIX history....unless someone can point to evidence to the contrary ?

libvirt has it easy - they let gnulib do all the work of futzing around
with getting a working strerror() despite platform bugs and despite
glibc's insistence on a non-POSIX signature if _GNU_SOURCE is defined.
We'll have to do a bit more legwork.

That said, I've added it to:
https://wiki.qemu.org/Contribute/BiteSizedTasks#Error_checking

if someone wants to do the grunt work.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--erhuOHA7Ww3KiA52jDxtXaceMV3lMft7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHXH4ACgkQp6FrSiUn
Q2r9Dwf+KWFCGGDeHfW1rjhKCWpToHoCSBdFyU2UVa5XmzU1ZDGuz8mhDUPS1vPe
FMB+n15IZlB6ReswngWriEhf9igdcJgmaLLM2SWSvEH1XGAdLti+8gNBgw8mZyB/
9cWLNC5c6uD78TBIYqpIW77AIMlBkyRwBDEZwPt5uqwzgLck4o3YD3LhK8467SoY
X5X/PBIz/AaU3s2R2XlWuTbtZBhoHMsjRf6ciaVUeNeA2xhhL1T3f3cX/cbVezWw
YPnpd1u/hzm1f3/17k+rz+e6u9UwqqYA/yod8KkFEKE1Li3EOepw2Acn/Pedd9RX
KIWHS1jrfT2V2nAB+hx91wydKk3F1g==
=J/TP
-----END PGP SIGNATURE-----

--erhuOHA7Ww3KiA52jDxtXaceMV3lMft7O--
