Received: from eggs.gnu.org ([2001:4830:134:3::10]:33643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSl4-0002Z4-I4
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSl3-0007HF-25
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfSl2-0007Gk-PW
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:18:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5B88C2C73
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 15:18:51 +0000 (UTC)
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-14-eblake@redhat.com>
	<87inhwokot.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08e17b38-5137-2986-b85f-7fc6f140f275@redhat.com>
Date: Wed, 9 Aug 2017 10:18:49 -0500
MIME-Version: 1.0
In-Reply-To: <87inhwokot.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MCgRXRla4BAF3ArcbDIfjFJPn5Aw8EeP8"
Subject: Re: [Qemu-devel] [PATCH v4 13/22] libqtest: Add qmp_raw()
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
--MCgRXRla4BAF3ArcbDIfjFJPn5Aw8EeP8
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <08e17b38-5137-2986-b85f-7fc6f140f275@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 13/22] libqtest: Add qmp_raw()
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-14-eblake@redhat.com>
 <87inhwokot.fsf@dusky.pond.sub.org>
In-Reply-To: <87inhwokot.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 09:54 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> The majority of calls into libqtest's qmp() and friends are passing
>> a JSON object that includes a command name; we can prove this by
>> adding an assertion.  The only outlier is qmp-test, which is testing
>> appropriate error responses to protocol violations and id support,
>> by sending raw strings, where those raw strings don't need
>> interpolation anyways.
>>
>> Adding a new entry-point makes a clean separation of which input
>> needs interpolation, so that upcoming patches can refactor qmp()
>> to be more like the recent additions to test-qga in taking the
>> command name separately from the arguments for an overall
>> reduction in testsuite boilerplate.
>>
>> This change also lets us move the workaround for the QMP parser
>> limitation of not ending a parse until } or newline: all calls
>> through qmp() are passing an object ending in }, so only the
>> few callers of qmp_raw() have to worry about a trailing newline.
>> +++ b/tests/libqtest.c
>> @@ -451,7 +451,7 @@ static void qmp_fd_sendv(int fd, const char *fmt, =
va_list ap)
>>      QString *qstr;
>>      const char *str;
>>
>> -    assert(*fmt);
>> +    assert(strstr(fmt, "execute"));
>=20
> I doubt this assertion is worthwhile.

Indeed, and it disappears later in the series.  But it was useful in the
interim, to prove that ALL callers through this function are passing a
command name (and therefore my later patches to rewrite qmp() to take a
command name aren't overlooking any callers).

>=20
> One , qmp_fd_sendv() works just fine whether you include an 'execute' o=
r
> not.  Two, there are zillions of other ways to send nonsense with
> qmp_fd_sendv().  If you do, your test doesn't work, so you fix it.
>=20
> Rejecting nonsensical QMP input is QEMU's job, not libqtest's.

I'm fine omitting the assertions in the next spin, even if they proved
useful in this revision for making sure I converted everything.


>>
>>      /* Test command failure with 'id' */
>> -    resp =3D qmp("{ 'execute': 'human-monitor-command', 'id': 2 }");
>> +    resp =3D qmp_raw("{ 'execute': 'human-monitor-command', 'id': 2 }=
");
>>      g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
>>      g_assert_cmpint(qdict_get_int(resp, "id"), =3D=3D, 2);
>>      QDECREF(resp);
>=20
> I'm afraid I don't like this patch.  All the extra function buys us is
> an assertion that isn't even tight, and the lifting of a newline out of=

> a place where it shouldn't be.

Maybe you'll change your mind by the end of the series, once you see the
changes to make qmp() shorter (and where those changes necessitate a
qmp_raw() as the backdoor for anything that is not a normal
command+arguments).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MCgRXRla4BAF3ArcbDIfjFJPn5Aw8EeP8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLJ9kACgkQp6FrSiUn
Q2pXrQf+KPO3U5mHSj15NL8Ejn+f6oHbVvy7Ei2BGTbqD4mA1YsWDa0sK4guwnd5
aOuPn92dcpXnpMxGGcJsLSlOCjZXnxZjAfIrDZYP72YA86DA4KSKidIoCylvMAHG
zycaz3c1REJM0oPX9ihtZwqNcqwfnAiJyNtgFkB1TimEkklHaq1I+sS9LnEHFvAO
we7VMbEd39c2UnS/uvgGmXmVvjwFuu5E08UnODO1vjW8QtaWjA5WZ6uICmEbD1XI
fEVhiOTNUBac9eGBT7KmyZVHRVBUixN+9s3BTmL+1hPlGJj9jmGnKDBg6aXsRtKm
MhnSW26ah7EaOTzjN4MKrL2YLYBFpQ==
=JF3X
-----END PGP SIGNATURE-----

--MCgRXRla4BAF3ArcbDIfjFJPn5Aw8EeP8--
