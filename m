Received: from eggs.gnu.org ([2001:4830:134:3::10]:40819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgBEt-0005yw-9C
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgBEq-0004uC-7X
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:48:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dgBEp-0004tx-U3
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2650C0CBC15
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 14:48:34 +0000 (UTC)
References: <1502389816-29772-1-git-send-email-armbru@redhat.com>
	<17b1385e-c14f-d933-661f-56217077ff79@redhat.com>
	<87shgy4gl8.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d96352cf-3c43-b453-7f09-5576e8863205@redhat.com>
Date: Fri, 11 Aug 2017 09:48:32 -0500
MIME-Version: 1.0
In-Reply-To: <87shgy4gl8.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Iw25d5KIsTQJHqxFOihFiGX7RR3M1cQpe"
Subject: [Qemu-devel] marking SCM_RIGHTS qapi commands [was: [PATCH]
 tests/qmp-test: Add generic, basic test of query commands]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Iw25d5KIsTQJHqxFOihFiGX7RR3M1cQpe
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com
Message-ID: <d96352cf-3c43-b453-7f09-5576e8863205@redhat.com>
Subject: marking SCM_RIGHTS qapi commands [was: [PATCH] tests/qmp-test: Add
 generic, basic test of query commands]
References: <1502389816-29772-1-git-send-email-armbru@redhat.com>
 <17b1385e-c14f-d933-661f-56217077ff79@redhat.com>
 <87shgy4gl8.fsf@dusky.pond.sub.org>
In-Reply-To: <87shgy4gl8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 04:08 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 08/10/2017 01:30 PM, Markus Armbruster wrote:
>>> A command is a query if it has no side effect and yields a result.
>>> Such commands are typically named query-FOO, but there are exceptions=
=2E
>>>
>>> The basic idea is to find candidates with query-qmp-schema, filter ou=
t
>>> the ones that aren't queries with an explicit blacklist, and test the=

>>> remaining ones against a QEMU with no special arguments.
>>>
>>> The current blacklist is just add-fd.
>>
>> I guess this is because it has no mandatory parameters.  Hmm - I wonde=
r
>> if introspection should flag WHICH commands require an fd over SCM
>> rights (I guess just add-fd)
>=20
> Actually, add-fd and getfd.

>=20
> An obvious alternative is of course adding another optional member to
> the command object, say a flag "takes file descriptors via SCM_RIGHTS".=

> Do we need to express the number of file descriptors it takes?  The
> underlying infrastructure supports several (TCP_MAX_FDS in
> char-socket.c), but the existing commands take just one.

Yeah, I was definitely leaning towards an additional annotation - maybe
where the .json file has:

{ 'command': 'add-fd', 'data': {'*fdset-id': 'int', '*opaque': 'str'},
  'fds': 1, 'returns': 'AddfdInfo' }

where the new 'fds' is what designates that the command expects to
consume 1 fd by SCM_RIGHTS (defaults to 0 when not present, and could be
larger than one if a command is ever designed to take multiple fds in
one go - although I find SCM_RIGHTS tricky enough with 1 fd that passing
multiple is probably not necessary, so maybe false/true is better than
int).  The introspection output would similarly expose the same optional
member for each command object, repeating what was present in the .json
file.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Iw25d5KIsTQJHqxFOihFiGX7RR3M1cQpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmNw8EACgkQp6FrSiUn
Q2o8sAf+I6PrEyFxH/KS47EWfQ33Cmxbtg1VzIfRRjB2ixyBiG4beRbVTHOJINw4
1LqVj5SLIcW8pucQNxi3XC0/rFfzct+stbrz1QKEaC6Nj9+r/qRtWsx0L76rJPJv
abi1mw0hictOTbFLzl7zJC9BhqWJH7tC8zfw1/hx5kVykuCIi9bk+Ut7rfaJvR2H
LO/g3Hl9/oc1DJ68M1U1AIRXkSLOw9qJFfebLHB4LBw03QiBaONz5nuLv+kKtFs8
GIcniOwZjfEpd1WcBEOorcQhKVEsIPyw/idIONScPrasngpK82UssPvtEYbDRVGF
vYdK79w0ltcnDOAd+jk4WeTX/6+kmA==
=MPeR
-----END PGP SIGNATURE-----

--Iw25d5KIsTQJHqxFOihFiGX7RR3M1cQpe--
