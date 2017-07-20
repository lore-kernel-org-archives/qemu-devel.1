Received: from eggs.gnu.org ([2001:4830:134:3::10]:45850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYISR-000490-D8
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYISO-0008JL-8V
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYISN-0008JB-VW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:54:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E891356D5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 20:53:58 +0000 (UTC)
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-6-eblake@redhat.com>
	<87zibzl8py.fsf@dusky.pond.sub.org>
	<ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9674afa4-78b3-044b-4e5f-4014888ff03e@redhat.com>
Date: Thu, 20 Jul 2017 15:53:56 -0500
MIME-Version: 1.0
In-Reply-To: <ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ma01dJb5CwaMGl0p6FLe6B1WVIScuG73C"
Subject: Re: [Qemu-devel] [PATCH 5/5] qtest: Document calling conventions
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
--ma01dJb5CwaMGl0p6FLe6B1WVIScuG73C
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <9674afa4-78b3-044b-4e5f-4014888ff03e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] qtest: Document calling conventions
References: <20170714190827.4083-1-eblake@redhat.com>
 <20170714190827.4083-6-eblake@redhat.com> <87zibzl8py.fsf@dusky.pond.sub.org>
 <ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
In-Reply-To: <ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 03:37 PM, Eric Blake wrote:
>>> + * @fmt...: QMP message to send to qemu; only recognizes formats
>>> + * understood by json-lexer.c
>>>   *
>>>   * Sends a QMP message to QEMU and consumes the response.
>>>   */
>>
>> These formats are chosen so that gcc can help us check them.  Please a=
dd
>> GCC_FMT_ATTR().  Precedence: qobject_from_jsonf().
>=20
> Will do.  (This patch was originally part of my larger series trying to=

> get rid of qobject_from_jsonf() - I may still succeed at that, but
> separating the easy stuff from the controversial means that the easy
> stuff needs tweaking).

Bleargh.  It's not that simple.

With printf-style, hmp("literal") and hmp("%s", "literal") produce the
same results.

But with json-lexer style, %s MODIFIES its input.
The original qmp("{'execute':\"foo\"}") sends a JSON object
 {'execute':"foo"}
but counterpart qmp("%s", "{'execute':'foo'}") sends a JSON string with
added \ escaping:
 "{'execute':\"foo\"}"

So adding the format immediately causes lots of warnings, such as:

  CC      tests/vhost-user-test.o
tests/vhost-user-test.c: In function =E2=80=98test_migrate=E2=80=99:
tests/vhost-user-test.c:668:5: error: format not a string literal and no
format arguments [-Werror=3Dformat-security]
     rsp =3D qmp(cmd);
     ^~~

  CC      tests/boot-order-test.o
tests/boot-order-test.c: In function =E2=80=98test_a_boot_order=E2=80=99:=

tests/boot-order-test.c:46:26: error: zero-length gnu_printf format
string [-Werror=3Dformat-zero-length]
     qmp_discard_response("");   /* HACK: wait for event */
                          ^~

but we CAN'T rewrite those to qmp("%s", command).

Now you can sort-of understand why my larger series wanted to get rid of
qobject_from_jsonf(), since our use of GCC_FMT_ATTR() there is a lie?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ma01dJb5CwaMGl0p6FLe6B1WVIScuG73C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllxGGQACgkQp6FrSiUn
Q2qAiwf+OlwFCudYipdTxx8cqwaqzQ7brK4OHhAIGeB2iBCzyMbkqYnCPRfA2dPl
w7GV86Qe49FAZesd8VFhGgjABnGZPWo47z1Zcvq9WR7Lr+6HjGVNBJmfLRyfjlt+
6w5aEhKeJw2L+6UGNkVz5ZOrkh+rQl3s8slyw1QIbr7ihN1IGN2GP5ofBzP96KAI
3eYFGuwCK86dkd5Ecx+I7ZRT6vRgys3oxd2+WIgbZRX/OLF47Keie9rUlUpccbIs
AQncRpstR6/HMK9dPKW/VnerI3i0EDI4264GO9F+m6Q3nZEw4L1mC18eXtmc/880
W2jOHq/n1Y2MfrUsH1m3KW9ghjZcKA==
=JoEu
-----END PGP SIGNATURE-----

--ma01dJb5CwaMGl0p6FLe6B1WVIScuG73C--
