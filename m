Received: from eggs.gnu.org ([2001:4830:134:3::10]:37865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXsX2-0006VD-A7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXsX1-0005uY-7m
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:13:04 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-8-eblake@redhat.com>
	<5d065e35-6ffd-8db0-f7bb-6be4c01f2a31@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <457d7370-1a21-cfbc-f8fa-4524d9c7e770@redhat.com>
Date: Wed, 19 Jul 2017 12:12:51 -0500
MIME-Version: 1.0
In-Reply-To: <5d065e35-6ffd-8db0-f7bb-6be4c01f2a31@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1PwQi1hCK1JLBwRukBs16Ptmnah5gJ7Ba"
Subject: Re: [Qemu-devel] [PATCH v5 7/9] nbd: Implement NBD_OPT_GO on client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1PwQi1hCK1JLBwRukBs16Ptmnah5gJ7Ba
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org
Message-ID: <457d7370-1a21-cfbc-f8fa-4524d9c7e770@redhat.com>
Subject: Re: [PATCH v5 7/9] nbd: Implement NBD_OPT_GO on client
References: <20170707203049.534-1-eblake@redhat.com>
 <20170707203049.534-8-eblake@redhat.com>
 <5d065e35-6ffd-8db0-f7bb-6be4c01f2a31@virtuozzo.com>
In-Reply-To: <5d065e35-6ffd-8db0-f7bb-6be4c01f2a31@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 11:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.07.2017 23:30, Eric Blake wrote:
>=20
> [..]
>=20
>>
>> +/* Returns -1 if NBD_OPT_GO proves the export @wantname cannot be
>> + * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST an=
d
>> + * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good t=
o
>> + * go (with @info populated). */
>> +static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>> +                      NBDExportInfo *info, Error **errp)
>> +{

>> +        if (reply.type =3D=3D NBD_REP_ACK) {
>> +            /* Server is done sending info and moved into transmissio=
n
>> +               phase, but make sure it sent flags */
>> +            if (len) {
>> +                error_setg(errp, "server sent invalid NBD_REP_ACK");
>> +                nbd_send_opt_abort(ioc);
>=20
> server is already in transmission phase, so we cant send any options
> more, shouldn't CMD_DISC be send here instead?
>=20
>> +                return -1;
>> +            }
>> +            if (!info->flags) {
>> +                error_setg(errp, "broken server omitted
>> NBD_INFO_EXPORT");
>> +                nbd_send_opt_abort(ioc);
>=20
> and here

For NBD_OPT_INFO, receipt of NBD_REP_ACK implies the server is still in
negotiation phase; transmission phases is only technically possible on
NBD_OPT_GO.  That said, either error condition means the server is
buggy, so it really doesn't matter what we do in response (we don't know
if the server moved on to transmission phase or not, because it has
already broken protocol by sending us garbage) - so trying to be
courteous to tell the server we don't like their garbage vs. just
silently disconnecting makes no real difference; even if the server
doesn't like what we send (because it thinks we are out of phase), the
server already broke protocol first.  Either way, we're going to
disconnect, and the server has to mop up after its own bugs.

I don't think a followup patch is essential, but I'd also be okay with a
patch that just eliminates the NBD_OPT_ABORT attempt and does a silent
disconnect instead.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1PwQi1hCK1JLBwRukBs16Ptmnah5gJ7Ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvkxMACgkQp6FrSiUn
Q2qPdwf/S9OC+6pcP/xXQil49/Bv0SeshrzS5EEufCf0xlGOF5a4I1V/W4d0dbax
sK3Frv6O8QLiE33ye4DvlHhioSsl7UHmQu/8NEPnKH3ZaP1jwq9GMoXuvAfLCBuD
dgsdkGIIw4WmJzCGW5+SogZBrcnC3dcyxBbsKw5rIfEpiRshta32OYnhu5x3xP9L
Ug2zw0a4Oyy5if1dC+A9WbjUjBi7fPQOcZsmn4jrq2ZXvuPB8TELsVMrIRjMQCiF
w1HHvYIop9x0hIzFkYacMxzVxQJttx7j3Y/5j/9Q0FPkGG0isbODnCIgsb+/2UXN
H5dDT3+sgDmWnnjC53LVl3jgTxo+xw==
=aaiF
-----END PGP SIGNATURE-----

--1PwQi1hCK1JLBwRukBs16Ptmnah5gJ7Ba--
