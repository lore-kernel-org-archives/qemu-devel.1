Received: from eggs.gnu.org ([2001:4830:134:3::10]:41363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSyq-0001oa-1h
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSyo-00077h-MR
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:33:08 -0400
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-15-eblake@redhat.com>
	<87d184ojqp.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ecd3699b-1a73-a8e2-5dac-b4f227f106b9@redhat.com>
Date: Wed, 9 Aug 2017 10:32:50 -0500
MIME-Version: 1.0
In-Reply-To: <87d184ojqp.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OR7xngO92GJGMpwA2u4lvKjoLPH1grhxu"
Subject: Re: [Qemu-devel] [PATCH v4 14/22] libqtest: Separate
 qmp_discard_response() from command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OR7xngO92GJGMpwA2u4lvKjoLPH1grhxu
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <ecd3699b-1a73-a8e2-5dac-b4f227f106b9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 14/22] libqtest: Separate
 qmp_discard_response() from command
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-15-eblake@redhat.com>
 <87d184ojqp.fsf@dusky.pond.sub.org>
In-Reply-To: <87d184ojqp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 10:15 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Upcoming patches will be adding new convenience methods for
>> constructing QMP commands.  But making every variation of sending
>> support every variation of response handling becomes unwieldy;
>> it's easier to specify that discarding a JSON response is
>> unassociated with sending the command, where qmp_async() already
>> fits the bill for sending a command without tying up a reference
>> to the response.
>>
>> Doing this renders qtest_qmp[v]_discard_response() unused.
>>
>> Bonus: gets rid of a non-literal format string, which is a step
>> towards compile-time format string checking without triggering
>> -Wformat-nonliteral.
>=20
> Where?  (I'm feeling lazy today)
>=20

Sure:

>=20
> +++ b/tests/ide-test.c
> @@ -624,7 +624,6 @@ static void test_retry_flush(const char *machine)
>      QPCIDevice *dev;
>      QPCIBar bmdma_bar, ide_bar;
>      uint8_t data;
> -    const char *s;
>=20
>      prepare_blkdebug_script(debug_path, "flush_to_disk");
>=20
> @@ -652,8 +651,8 @@ static void test_retry_flush(const char *machine)
>      qmp_eventwait("STOP");
>=20
>      /* Complete the command */
> -    s =3D "{'execute':'cont' }";
> -    qmp_discard_response(s);
> +    qmp_async("{'execute':'cont' }");
> +    qmp_discard_response();

Yes, I can update the commit message to focus in on it more precisely.

>> +++ b/tests/libqtest.c
>> @@ -235,7 +235,8 @@ QTestState *qtest_init(const char *extra_args)
>>      /* Read the QMP greeting and then do the handshake */
>>      greeting =3D qtest_qmp_receive(s);
>>      QDECREF(greeting);
>> -    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }"=
);
>> +    greeting =3D qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }");
>> +    QDECREF(greeting);
>=20
> Here, you replace
>=20
>        qtest_qmp_discard_response(ARGS...);
>=20
> effectively by
>=20
>        QDECREF(qtest_qmp(ARGS...));
>=20
> which is how qtest_qmp_discard_response() does its job before this
> patch.  Okay.

I deleted qtest_qmp_discard_response().  If I had kept it around (but
made it static instead), I could have written this one as:

/* Read the QMP greeting and then do the handshake */
qtest_qmp_discard_response(s);
qtest_qmp_async(s, "{'execute': 'qmp_capabilities'}");
qtest_qmp_discard_response(s);

But as the only place that needed to pass 's' on through, I was just as
comfortable open-coding the QDECREF after the fact.

>> +++ b/tests/ahci-test.c
>> @@ -1596,8 +1596,9 @@ static void test_atapi_tray(void)
>>      rsp =3D qmp_receive();
>>      QDECREF(rsp);

Hmm - this code already was manually using QDECREF()...

>>
>> -    qmp_discard_response("{'execute': 'x-blockdev-remove-medium', "
>> -                         "'arguments': {'device': 'drive0'}}");
>> +    qmp_async("{'execute': 'x-blockdev-remove-medium', "
>> +              "'arguments': {'device': 'drive0'}}");
>> +    qmp_discard_response();

which means this could have reused rsp =3D qmp(...); QDECREF(rsp); as wel=
l.

>=20
> Here, you replace the same pattern (less the QTestState argument) by
>=20
>        qmp_async(F, ...);
>        qmp_discard_response();
>=20
> Also okay.  But why two ways to do the same things?
>=20
> Apropos QTestState argument: do we have a test with more than one state=
,
> or is having two versions of every function just "avoiding global state=

> is virtuous" self-flagellation?

We DO have tests that use more than one state - AND those tests prefer
calling the qmp() version (rather than the qtest_qmp() version) with
manipulation of the global_qtest as needed.  See my cleanup in 15/22.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OR7xngO92GJGMpwA2u4lvKjoLPH1grhxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLKyIACgkQp6FrSiUn
Q2rosQgAgn+2v9cWO1iECnBeZQHTofm8bERSBK7MRY/bh/J+xsVQGlL9bbWAYk5l
4TG+xSzWdZBO7nBLmXBEx5zTSW+JL89Uynqqwbyj2mowYIeLc9dNsutGsCjtOTWI
UrDAk8/9UrIEw7cWogI72dlqlNsZr6nefibdQb2g4tIY2VtxqUni0+ReJRymOers
ZO2H8bvhUruBTUJrg+QpvMMwHm+zeYHBO93i/eRD6g1jIrkN5VtVT/JQkDazgnu/
dkqE8l+T/KFnDAW53bWLJRlx1CR0KYc6eq4EReEl0xvHrZ4JyoJcDqCs5qJc4AJy
FaFfbfiO0zcdp4PLxf+DtH5hw+57aA==
=WxDt
-----END PGP SIGNATURE-----

--OR7xngO92GJGMpwA2u4lvKjoLPH1grhxu--
