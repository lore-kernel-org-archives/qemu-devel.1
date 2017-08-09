Received: from eggs.gnu.org ([2001:4830:134:3::10]:48301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfTxW-0003bt-Pg
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfTxT-0000vM-KB
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfTxT-0000tD-5t
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1733C1202D5
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 16:35:46 +0000 (UTC)
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-16-eblake@redhat.com>
	<877eycoius.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63f6e8ad-6dd4-1ec8-7acb-306f6d957930@redhat.com>
Date: Wed, 9 Aug 2017 11:35:43 -0500
MIME-Version: 1.0
In-Reply-To: <877eycoius.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5nw1He5UTXdulWUFg7N51xlDsQ8dj5rg6"
Subject: Re: [Qemu-devel] [PATCH v4 15/22] libqtest: Delete qtest_qmp()
 wrappers
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
--5nw1He5UTXdulWUFg7N51xlDsQ8dj5rg6
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <63f6e8ad-6dd4-1ec8-7acb-306f6d957930@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 15/22] libqtest: Delete qtest_qmp()
 wrappers
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-16-eblake@redhat.com>
 <877eycoius.fsf@dusky.pond.sub.org>
In-Reply-To: <877eycoius.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 10:34 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> None of our tests were directly using qtest_qmp() and friends;
>> even tests like postcopy-test.c that manage multiple connections
>> get along just fine changing global_qtest as needed (other than
>> one callsite where it forgot to use the inlined form).  It's
>> also annoying that we have qmp_async() but qtest_async_qmp(),
>> with inconsistent naming for tracing through the wrappers.
>>

> What about all the other functions taking a QTestState?  Aren't they
> just as silly?

What's left after this patch:

- qtest_init()
  qtest_init_without_qmp_handshake()
  qtest_quit()
necessary for setting up parallel state.

and then a lot of functions that have static inline wrappers (for
example, qmp_receive(), inb(), ...).

So yes, I could additionally get rid of more wrappers and have even more
functions implicitly depend on global_qtest.

>=20
> Having two of every function is tiresome, but consistent.
>=20
> Having just one is easier to maintain, so if it serves our needs,
> possibly with the occasional state switch, I like it.
>=20
> What I don't like is a mix of the two.

Okay, I'll prune even harder in the next revision.  Deleting cruft is fun=
!

>> +++ b/tests/libqtest.c
>> @@ -233,9 +233,10 @@ QTestState *qtest_init(const char *extra_args)
>>      QDict *greeting;
>>
>>      /* Read the QMP greeting and then do the handshake */
>> -    greeting =3D qtest_qmp_receive(s);
>> +    greeting =3D qmp_fd_receive(s->qmp_fd);
>=20
> Why doesn't this become qmp_receive()?

Because in THIS version of the patch, qmp_receive() is still a static
inline wrapper that calls qtest_qmp_receive(global_qtest) - but
global_qtest is not set here.  (If I delete qtest_qmp_receive() and have
qmp_receive() not be static inline, then we STILL want to operate
directly on the just-created s->qmp_fd rather than assuming that
global_qtest =3D=3D s, when in the body of qtest_init).

>> @@ -446,7 +447,7 @@ QDict *qtest_qmp_receive(QTestState *s)
>>   * Internal code that converts from interpolated JSON into a message
>>   * to send over the wire, without waiting for a reply.
>>   */
>> -static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>> +static void qtest_qmp_sendv(QTestState *s, const char *fmt, va_list a=
p)
>=20
> Why this move in the other direction?

Because it fixes the disparity you pointed out in 12/22 about
qmp_fd_sendv() no longer being a sane pairing to qmp_fd_send(), AND
because I needed the .../va_list pairing to work in order for...

>> -char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
>> +static char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
>>  {
>>      char *cmd;
>>      QDict *resp;
>>      char *ret;
>>
>>      cmd =3D g_strdup_vprintf(fmt, ap);
>> -    resp =3D qtest_qmp(s, "{'execute': 'human-monitor-command',"
>> -                     " 'arguments': {'command-line': %s}}",
>> -                     cmd);
>> +    qtest_qmp_send(s, "{'execute': 'human-monitor-command',"
>> +                   " 'arguments': {'command-line': %s}}", cmd);
>> +    resp =3D qtest_qmp_receive(s);

=2E..this to work.  So now my sane pairing is
qtest_qmp_send()/qtest_qmp_sendv() - although your argument that
qtest_qmp_sendf() might have been a nicer name for the ... form may
still have merit - at least any time the sendv() form is in a public
header.  Then again, by the end of the series, I managed to get rid of
all va_list in libqtest.h, needing it only in libqtest.c.

>> @@ -889,7 +854,7 @@ void qmp_async(const char *fmt, ...)
>>      va_list ap;
>>
>>      va_start(ap, fmt);
>> -    qtest_async_qmpv(global_qtest, fmt, ap);
>> +    qtest_qmp_sendv(global_qtest, fmt, ap);
>>      va_end(ap);
>>  }
>=20
> Hmm.  Before this patch, qmp_async() is the ... buddy of va_list
> qmp_fd_sendv().  If we keep qmp_fd_sendv(), they should be named
> accordingly.

What name to use, though?  By the end of the series, we have
qmp_async(...) but no public va_list form.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5nw1He5UTXdulWUFg7N51xlDsQ8dj5rg6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLOeAACgkQp6FrSiUn
Q2p5bgf+ITe6ZWF8qmsHefzidObfWSocRevqOttQX9s35d1lyfyF6UXlv0B1cYWl
zLcJHt7waUB6iLS0nl93sDg64+5bqVsr9q7OjNZ5fjlvwh/QAraRoPT/FXDQASFl
2HB+EGIf5bPxOdF5fnFJsiO5mVdt8ahWl4hiF7YiB07V666S5Rw9n+8xAsyzYNWW
bMC+se4wwdknaEEYouMQ9/86rLMXnsNFdEDf6eI2hZtb26JaXe7zCCiXIsILBDKo
BlFsAULsmQoMienqyt5+KYuCBLhpjNmA+FfRQmOi9hN4TN19ZUzYIuQc4MJDq4vB
OP7KW+M7EHlpoDF4nbpMihxZtaJlGQ==
=xyqA
-----END PGP SIGNATURE-----

--5nw1He5UTXdulWUFg7N51xlDsQ8dj5rg6--
