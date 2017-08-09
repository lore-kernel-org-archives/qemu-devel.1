Received: from eggs.gnu.org ([2001:4830:134:3::10]:38136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfRHy-0006IT-Cy
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfRHs-0003DJ-7F
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfRHr-0003CP-PH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:44:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8475E68559
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 13:44:38 +0000 (UTC)
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-13-eblake@redhat.com>
	<87mv78riap.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8631eea7-0b8b-e41b-4218-5655a8591dac@redhat.com>
Date: Wed, 9 Aug 2017 08:44:36 -0500
MIME-Version: 1.0
In-Reply-To: <87mv78riap.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rtRH1VvhIbn7goI5e05iFFg3vpBBrRnMX"
Subject: Re: [Qemu-devel] [PATCH v4 12/22] libqtest: Change qmp_fd_send() to
 drop varargs
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
--rtRH1VvhIbn7goI5e05iFFg3vpBBrRnMX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <8631eea7-0b8b-e41b-4218-5655a8591dac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/22] libqtest: Change qmp_fd_send() to
 drop varargs
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-13-eblake@redhat.com>
 <87mv78riap.fsf@dusky.pond.sub.org>
In-Reply-To: <87mv78riap.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 08:18 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> With the previous commit, no external clients are using qmp_fd()
>> or qmp_fd_sendv().  Making qmp_fd_sendv() static lets us refactor
>> the public qmp_fd_send() to be the common point where we send a
>> fixed string over the wire as well as log that string, while
>> qmp_fd_sendv() worries about converting varargs into the final
>> string.  Note that the refactoring changes roles: previously,
>> qmp_fd_send() deferred to qmp_fd_sendv(); now the call chain is
>> in the opposite direction.  Likewise, now that we take a fixed
>> string, we no longer have to special case '\xff'.
>=20
> I'm fine with the reversal of roles.  The name qmp_fd_send() becomes
> slightly problematic, though: it's *not* the ... variant of
> qmp_fd_sendv(), as is the case for similar pairs of function names.

I later rename qmp_fd_sendv() into qtest_qmp_sendv(), in 15/22, along
with another update to its signature.  Alluding to that here won't hurt.

>=20
> I wish libqtest's naming would follow libc conventions more closely.
> libc: printf() and vprintf(), sprintf() and vsprintf().  libqtest:
> qmp_fd_send() and qmp_sendv(), qtest_hmp() and qtest_hmpv(), ...
> Exceptions (sort of): socket_send() and socket_sendf(), qtest_sendf().
> Not sure this is worth cleaning up now.

This would be the series to do it, though, if we have a preferred
alternative name.

>=20
> If we decice it is, then the name qmp_fd_send() would be fine, because
> its va_list buddy would be qmp_fd_vsendf(), and its ... buddy would be
> qmp_fd_sendf().

At the end of the series, qmp_fd_send() has no varargs buddy.
qtest_qmp_sendv() and qtest_qmp_sendf() would be the buddies.

>> -void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>> +static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>>  {
>>      QObject *qobj =3D NULL;
>> -    int log =3D getenv("QTEST_LOG") !=3D NULL;
>>      QString *qstr;
>>      const char *str;
>>
>> -    /* qobject_from_jsonv() silently eats leading 0xff as invalid
>> -     * JSON, but we want to test sending them over the wire to force
>> -     * resyncs */
>> -    if (*fmt =3D=3D '\377') {
>> -        socket_send(fd, fmt, 1);
>> -        assert(!fmt[1]);
>> -        return;
>> -    }
>>      assert(*fmt);
>=20
> Is this assertion (still) useful?  Why can't we leave the job to
> qobject_from_jsonv()?

It is still useful if...

>=20
>>
>>      /*
>> @@ -468,25 +458,17 @@ void qmp_fd_sendv(int fd, const char *fmt, va_li=
st ap)
>>       * is used.  We interpolate through QObject rather than sprintf i=
n
>>       * order to escape strings properly.
>>       */
>> -    if (strchr(fmt, '%')) {
>> -        qobj =3D qobject_from_jsonv(fmt, ap);
>> -        qstr =3D qobject_to_json(qobj);
>> -    } else {
>> -        qstr =3D qstring_from_str(fmt);
>> +    if (!strchr(fmt, '%')) {
>> +        qmp_fd_send(fd, fmt);
>> +        return;

=2E..we take this shortcut. But later in the series, the shortcut no
longer fires (and at that time, I delete the assert).


>> +    /* Send QMP request */
>> +    socket_send(fd, msg, strlen(msg));
>> +    /*
>> +     * BUG: QMP doesn't react to input until it sees a newline, an
>> +     * object, or an array.  Work-around: give it a newline.
>> +     */
>> +    socket_send(fd, "\n", 1);
>=20
> Hmm.
>=20
> Before this series, qmp_fd_sendv() first parses @fmt with
> %-interpolation from @ap, then converts the result back to JSON text.
> Any newlines are lost, so we have to append one.
>=20
> PATCH 10 adds a shortcut when @fmt doesn't contain '%'.  Newlines are
> not lost in that case.  We add one anyway.  Ugh.
>=20
> This patch drops the non-shortcut case.
>=20
> I think qmp_fd_send() should send exactly @msg, and the newline
> appending should move to qmp_fd_sendv(), where the newline loss now
> happens.

In fact, I got rid of the \n hack here in 13/22.  But for one patch
longer, I could keep the workaround in qmp_fd_sendv(), rather than the
churn of moving it to qmp_fd_send() just to delete it in the next patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rtRH1VvhIbn7goI5e05iFFg3vpBBrRnMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLEcQACgkQp6FrSiUn
Q2pzdAf9EGYhNvHoOGuMTvVeGVb2xrthYZvzyxs8xf3JuEb/SNiDh1ilTRgkh2a/
39TMk0/s6eI7eMDFTkPHjP9sdhyzcqLk6EUJTqOsYpIUmQ+rg8io7QEECdCwV+WR
HCv222Tjg7cXRM3O4bFQMAv7cTRXiWV8NRPYjuMcxVFYPUq5TmwwQKqTXocc4byD
nPBIRH4rWB+TDVfLmeuCneLAeneFFLTTkgel6KlOAcMGqdgd2DpiDYo+FHCUxcwN
QzMi9j8u8gaTD24eA+EjPQFeXW3bQrvIfYmpsY93FMb/g5Y1BluEv0zY/WTR5XNe
InoS760Wd2bxWlBSko/yC8g7wrzOPA==
=CKAh
-----END PGP SIGNATURE-----

--rtRH1VvhIbn7goI5e05iFFg3vpBBrRnMX--
