Received: from eggs.gnu.org ([2001:4830:134:3::10]:46208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQDuF-0000RF-0m
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQDuB-00086z-Sd
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQDuB-00086g-FS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:25:19 -0400
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<d7c1b8ff9247a09e54110abe6abe93543d59b8b6.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<20170628132329.GJ29134@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c25da728-d3cf-2b24-19e8-0a67e69fd65c@redhat.com>
Date: Wed, 28 Jun 2017 09:24:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170628132329.GJ29134@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gAPPsmtPhcnANCIqQ5TKRdRjFGoiauhf2"
Subject: Re: [Qemu-devel] [PATCH v6 3/4] net/net: Convert parse_host_port()
 to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: pbonzini@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, kraxel@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gAPPsmtPhcnANCIqQ5TKRdRjFGoiauhf2
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: pbonzini@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, kraxel@redhat.com
Message-ID: <c25da728-d3cf-2b24-19e8-0a67e69fd65c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/4] net/net: Convert parse_host_port() to
 Error
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
 <d7c1b8ff9247a09e54110abe6abe93543d59b8b6.1498654240.git.maozy.fnst@cn.fujitsu.com>
 <20170628132329.GJ29134@redhat.com>
In-Reply-To: <20170628132329.GJ29134@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 08:23 AM, Daniel P. Berrange wrote:
> On Wed, Jun 28, 2017 at 09:08:49PM +0800, Mao Zhongyi wrote:
>> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
>> index 5c326db..78e2b30 100644
>> --- a/include/qemu/sockets.h
>> +++ b/include/qemu/sockets.h
>=20
>>          if (qemu_isdigit(buf[0])) {
>> -            if (!inet_aton(buf, &saddr->sin_addr))
>> +            if (!inet_aton(buf, &saddr->sin_addr)) {
>> +                error_setg(errp, "host address '%s' is not a valid "
>> +                           "IPv4 address", buf);
>>                  return -1;
>> +            }
>>          } else {
>> -            if ((he =3D gethostbyname(buf)) =3D=3D NULL)
>> +            he =3D gethostbyname(buf);
>> +            if (he =3D=3D NULL) {
>> +                error_setg(errp, "can't resolve host address '%s': "
>> +                           "unknown host", buf);
>>                  return - 1;
>> +            }
>=20
> gethostbyname sets  'h_errno' on failure, so you should pass that
> into error_setg_errno, instead of hardcoding 'unknown host' as a
> message

'man gethostbyname' says it is deprecated, and that applications should
use getaddrinfo/getnameinfo instead.  What's our story here?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gAPPsmtPhcnANCIqQ5TKRdRjFGoiauhf2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZU7w7AAoJEKeha0olJ0NqgU4IAJ0sb+LboNnoZsghlK1KsKUc
EVojqDQSeotIG86ITQcZYWzLlZqP/o9wyz59E6kTkLwni2mJfTpnTSl3o5WbFSnL
TcL5tLdTYDFgxekxXwlXG6SFnv/7KOf2yL1hndayEKISwaRNn09TjOgV143XT63m
PJD/1MoZDkptQ+MOEBfcYqejDDFGVrSDNBuz6SSHqI6TXiVCnW3hcxKuT5TZdF5s
uzXreE6PsN1oUfwczBF6zjlBiHY0VZOtgVkVzaIXPRL3DO48lOgfDd0EcJqAH74w
Q1UmllMsJaXtdY6mCwc1ZT1J17Od9SngdNeBAXN+D0l/tsaf40mXBoisvoVtxXo=
=xBg2
-----END PGP SIGNATURE-----

--gAPPsmtPhcnANCIqQ5TKRdRjFGoiauhf2--
