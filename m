Received: from eggs.gnu.org ([2001:4830:134:3::10]:45530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drlJL-00071P-Dw
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drlJF-0002hv-Ia
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:33:07 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-29-eblake@redhat.com>
	<52e5f270-4648-b3ce-bdaf-c4b59700ff01@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b777963c-a914-b941-26f2-6492b2fb4f84@redhat.com>
Date: Tue, 12 Sep 2017 08:32:43 -0500
MIME-Version: 1.0
In-Reply-To: <52e5f270-4648-b3ce-bdaf-c4b59700ff01@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f5hwr9t3iCGB9X42TnovvQo0RdHTxvP5b"
Subject: Re: [Qemu-devel] [PATCH v7 28/38] libqtest: Add qtest_[v]startf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Ben Warren <ben@skyportsystems.com>, "open list:IDE" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f5hwr9t3iCGB9X42TnovvQo0RdHTxvP5b
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?=
 <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "open list:IDE" <qemu-block@nongnu.org>
Message-ID: <b777963c-a914-b941-26f2-6492b2fb4f84@redhat.com>
Subject: Re: [PATCH v7 28/38] libqtest: Add qtest_[v]startf()
References: <20170911172022.4738-1-eblake@redhat.com>
 <20170911172022.4738-29-eblake@redhat.com>
 <52e5f270-4648-b3ce-bdaf-c4b59700ff01@redhat.com>
In-Reply-To: <52e5f270-4648-b3ce-bdaf-c4b59700ff01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 05:14 AM, Thomas Huth wrote:
> On 11.09.2017 19:20, Eric Blake wrote:
>> We have several callers that were formatting the argument strings
>> themselves; consolidate this effort by adding new convenience
>> functions directly in libqtest, and update all call-sites that
>> can benefit from it.
> [...]
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index e8c2e11817..b535d7768f 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -245,6 +245,27 @@ QTestState *qtest_start(const char *extra_args)
>>      return global_qtest =3D s;
>>  }
>>
>> +QTestState *qtest_vstartf(const char *fmt, va_list ap)
>> +{
>> +    char *args =3D g_strdup_vprintf(fmt, ap);
>> +    QTestState *s;
>> +
>> +    s =3D qtest_start(args);
>> +    global_qtest =3D NULL;
>=20
> Don't you need a g_free(args) here?

D'oh.  Yes, I do.

>> +    qtest_quit(qtest_startf("-device %s", model));
>=20
> Just my personal taste, but I think I'd be nicer to keep this on
> separate lines:
>=20
>     QTestState *s;
>=20
>     s =3D qtest_startf("-device %s", model);
>     qtest_quit(s);

Sure.  I debated about it.  If we ever do more than just create/destroy,
then having the separate lines makes it easier to stick the actual test
in between the two lines, so I'll avoid my abbreviation and go with the
longer form on respin.

>>  static void test_mon_partial(const void *data)
>>  {
>>      char *s;
>> -    char *cli;
>> +    const char *args =3D data;
>>
>> -    cli =3D make_cli(data, "-smp 8 "
>> -                   "-numa node,nodeid=3D0,cpus=3D0-1 "
>> -                   "-numa node,nodeid=3D1,cpus=3D4-5 ");
>> -    qtest_start(cli);
>> +    global_qtest =3D qtest_startf("%s -smp 8 "
>> +                                "-numa node,nodeid=3D0,cpus=3D0-1 "
>> +                                "-numa node,nodeid=3D1,cpus=3D4-5 ", =
args);
>=20
> Does GCC emit a warning if you'd used data here directly? Otherwise I
> think you could simply do this without the local args variable...

Passing void* through varargs, with the intent of the receiver parsing
it as char*, is technically undefined in C.  I don't know if gcc warns,
but I'm also worried that clang might warn.  I prefer to err on the side
of defined behavior in this case, even though it annoyingly requires a
temporary variable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--f5hwr9t3iCGB9X42TnovvQo0RdHTxvP5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm34fsACgkQp6FrSiUn
Q2pydgf/eKLbWHOoqDhulq3TT2tjc72vsJV4vhQBbZL8VvI2hTNfcrY6jOPpWP2O
xXPcstWMtlX21+haWwOVClNKFmjr6CbMZeHnF+J3EJj1VyHfRBL3ZK2b4f0sUoMH
Th+MkX53QmN+eeeQVnCvEgB4tX/cq1ipPpW4E6DJFN7gGYQwfgHeGpCrA9EAUzwZ
R6NC4k7sG583CzBVLr2HD5SbqYTKcg8xZwKESAhw/ktaYyAU/MqC3+dW5smsXzYn
KESZB0YN1dVMqL87hI2VhPHMXqH/sMz+XSffe8ji6TVceNuO4YuAfze5aJZ1JDnT
AT3GfazR0Txc9AYToh/85n2wLCCygA==
=hwnc
-----END PGP SIGNATURE-----

--f5hwr9t3iCGB9X42TnovvQo0RdHTxvP5b--
