Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfR2s-0006kn-CD
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfR2o-0007nA-EM
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfR2o-0007mT-5j
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1366F6B36D
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 13:29:05 +0000 (UTC)
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-12-eblake@redhat.com>
	<87shh1t1dv.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88df9222-443c-08a1-f7a1-eb6130c783a3@redhat.com>
Date: Wed, 9 Aug 2017 08:29:02 -0500
MIME-Version: 1.0
In-Reply-To: <87shh1t1dv.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LSkAApoeWOB27bjo1sTVDSn8qTke6fOSU"
Subject: Re: [Qemu-devel] [PATCH v4 11/22] test-qga: Simplify command
 construction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LSkAApoeWOB27bjo1sTVDSn8qTke6fOSU
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <88df9222-443c-08a1-f7a1-eb6130c783a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/22] test-qga: Simplify command
 construction
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-12-eblake@redhat.com>
 <87shh1t1dv.fsf@dusky.pond.sub.org>
In-Reply-To: <87shh1t1dv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 06:40 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> When you build qga input manually like this:
>>
>>     cmd =3D g_strdup_printf("{'execute': 'guest-file-write',"
>>                           " 'arguments': {'handle': %" PRId64 ","
>>                           " 'buf-b64': '%s' } }", id, enc);
>>     ret =3D qmp_fd(fixture->fd, cmd);
>>     g_free(cmd);
>>
>> you're responsible for escaping the interpolated values for JSON.
>> Not done here, and therefore works only because the base64 encoding
>> does not include % or '.
>>
>> As a bonus, this eliminates the last external caller using varargs
>> for qmp_fd_send(); the next patch will simplify that interface to
>=20
> I'm blind... where?
>=20

>> -    cmd =3D g_strdup_printf("\xff{'execute': 'guest-sync-delimited',"=

>> -                          " 'arguments': {'id': %u } }", r);
>> -    qmp_fd_send(fixture->fd, cmd);
>> -    g_free(cmd);
>> +    qmp_fd_send(fixture->fd, "\xff");

Oh, the only old caller wasn't using varargs either. So none of the
public callers were passing a format string containing %, making the ...
in the public signature pointless (the next patch gets rid of it).  I'll
see what I can do to tweak the commit message.

>=20
> I was starting to type "opportunity to switch to the \377 used in
> libqtest.c", but then I noticed that one will go away in the next
> patch.  Nevermind then.

Really, I moved the special handling of \377 out of libqtest.c into a
direct string passed to qmp_fd_send(), across the combination of
11+12/22.  We used to have to special case it in libqtest.c, because all
of our input was unconditionally taking the round trip of input string
-> QObject -> output string; but once we can output a string directly
without the round trip, we don't need the special casing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LSkAApoeWOB27bjo1sTVDSn8qTke6fOSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLDh4ACgkQp6FrSiUn
Q2qaswf9Hgl9FucZJB5venJwYBI8WvIHXG0lEw2+fIgTspba5HmpDru7WpsJctAI
oVjeoRjUNc1uxSGZT+IcYesoSWWTxf4ldC38sfb9ZQdEbmaYF4VY0jt8/z3SrDZN
MFUt8+EpqIJwo6Na+PY61LdbaOZVKP3D3lx910SDME4yGula9fJeMXmnx4psJ6Dn
vrvr2mi6p0+EAE58Od5lB5LPAttBC5j+LTWg+kNadDgmBgyEzEpoIa5Zon4KGep6
Y+UN4XZScsRtplQtpcvqf8UtlcudwV5c/X+g7WF8WiHhK9S10hvryW5bV+Y/Rj1c
l0pthKVAFPuoVUYRwkGxpweS6IOd6g==
=dOd5
-----END PGP SIGNATURE-----

--LSkAApoeWOB27bjo1sTVDSn8qTke6fOSU--
