Received: from eggs.gnu.org ([209.51.188.92]:36131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjmGc-0006gC-4j
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjmGY-0006K6-Ag
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:34:05 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-16-eblake@redhat.com>
	<75e42dc3-440b-f0e8-c52f-99621235b12c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fda418f1-12a6-7d8a-0333-1e62b56dd27e@redhat.com>
Date: Wed, 16 Jan 2019 08:33:52 -0600
MIME-Version: 1.0
In-Reply-To: <75e42dc3-440b-f0e8-c52f-99621235b12c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V1FUsOvSVXaPgdSdpjNCehnAx9cuu2SGG"
Subject: Re: [Qemu-devel] [PATCH v3 15/19] nbd/client: Add
 nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V1FUsOvSVXaPgdSdpjNCehnAx9cuu2SGG
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <fda418f1-12a6-7d8a-0333-1e62b56dd27e@redhat.com>
Subject: Re: [PATCH v3 15/19] nbd/client: Add nbd_receive_export_list()
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-16-eblake@redhat.com>
 <75e42dc3-440b-f0e8-c52f-99621235b12c@virtuozzo.com>
In-Reply-To: <75e42dc3-440b-f0e8-c52f-99621235b12c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/16/19 4:15 AM, Vladimir Sementsov-Ogievskiy wrote:

>> @@ -347,7 +350,8 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportIn=
fo *info, Error **errp)
>>        * flags still 0 is a witness of a broken server. */
>>       info->flags =3D 0;
>>
>> -    trace_nbd_opt_go_start(info->name);
>> +    assert(opt =3D=3D NBD_OPT_GO || opt =3D=3D NBD_OPT_INFO);
>> +    trace_nbd_opt_go_start(nbd_opt_lookup(opt), info->name);
>=20
> I'd prefer to upgrade trace-point name too, as well as other several tr=
ace_nbd_opt_go_* trace
> points in the function.
>=20

Can do.


>> +        /* Send NBD_OPT_ABORT as a courtesy before hanging up */
>> +        nbd_send_opt_abort(ioc);
>> +        break;
>> +    case 1: /* newstyle, but limited to EXPORT_NAME */
>> +        error_setg(errp, "Server does not support export lists");
>> +        /* We can't even send NBD_OPT_ABORT, so merely hang up */
>=20
> But, on the other hand, why not to send it? It will be unknown for the =
server,
> so, it will have to close the connection accordingly to the protocol, i=
sn't it
> better a bit?

The NBD spec says that if the server did not advertise fixed newstyle,
then the client must not send any other NBD_OPT.  And servers that don't
support fixed newstyle are rather rare, so it doesn't really hurt if we
aren't courteous to them.

>=20
>> +        goto out;
>> +    case 0: /* oldstyle, parse length and flags */
>> +        array =3D g_new0(NBDExportInfo, 1);
>> +        array->name =3D g_strdup("");
>> +        count =3D 1;
>> +
>> +        if (nbd_negotiate_finish_oldstyle(ioc, array, errp) < 0) {
>> +            return -EINVAL;
>=20
> goto out, you mean.

Indeed. Thanks for spotting it.

> And with at least this one fixed:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--V1FUsOvSVXaPgdSdpjNCehnAx9cuu2SGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/QNAACgkQp6FrSiUn
Q2obYwf/U+lsEBntsqy1QXnCTN7EXFQEQAUs2rd3iE73p7Hbmv6326Ls8su+6Ac0
yk1zIz0n8Wn4s2WFlVaR72/88Owjc/chRIFdntlS9rxOOTNh10zCkP4W3oSMDjr3
KtutOhc1p5nSeI9rtmaHEOKG3oRJdttXWIYQRQnmhVW2xJMbZ81SV4q82wA1mi/I
0SzYIl2KMlHdwRajT9zDRq3SngVg38ImRepPTwZcapZlIaLahpmKV9kSgNxyyBCz
HmYgSvoTl+aeFOSXwaTSwfQmNWoDeN9LEt6pwJ0qEPHdNevRUF1M5tnNmfDc9KLm
InXFsX9fGpwWoOOjHT7QEv1PZTcCAQ==
=v588
-----END PGP SIGNATURE-----

--V1FUsOvSVXaPgdSdpjNCehnAx9cuu2SGG--
