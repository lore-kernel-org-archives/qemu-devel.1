Received: from eggs.gnu.org ([2001:4830:134:3::10]:39035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5d3E-0001Gy-DB
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5d3D-0000Ha-Bc
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:33:48 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-9-eblake@redhat.com>
	<7573697c-4eb8-2c98-82c3-53a0ab884c65@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bab67a31-3f07-1d77-153a-6b78fcbb9d24@redhat.com>
Date: Fri, 20 Oct 2017 14:33:39 -0500
MIME-Version: 1.0
In-Reply-To: <7573697c-4eb8-2c98-82c3-53a0ab884c65@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tmf76XdWUkKGBoLU1ihXxWgF9hvGV5aqa"
Subject: Re: [Qemu-devel] [PATCH v5 08/11] nbd/client: refactor
 nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tmf76XdWUkKGBoLU1ihXxWgF9hvGV5aqa
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <bab67a31-3f07-1d77-153a-6b78fcbb9d24@redhat.com>
Subject: Re: [PATCH v5 08/11] nbd/client: refactor nbd_receive_starttls
References: <20171019222637.17890-1-eblake@redhat.com>
 <20171019222637.17890-9-eblake@redhat.com>
 <7573697c-4eb8-2c98-82c3-53a0ab884c65@virtuozzo.com>
In-Reply-To: <7573697c-4eb8-2c98-82c3-53a0ab884c65@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 02:26 PM, Vladimir Sementsov-Ogievskiy wrote:
> 20.10.2017 01:26, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Split out nbd_request_simple_option to be reused for structured reply
>> option.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v5: only check length for ACK responses
>> v4: reduce redundant traces, typo fix in commit message
>> ---

>> +/* nbd_request_simple_option: Send an option request, and parse the
>> reply
>> + * return 1 for successful negotiation,
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 if operation is unsupp=
orted,
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1 with errp set for any=
 other error
>> + */
>> +static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error
>> **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 nbd_opt_reply reply;
>> +=C2=A0=C2=A0=C2=A0 int error;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (nbd_send_option_request(ioc, opt, 0, NULL, err=
p) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (nbd_receive_option_reply(ioc, opt, &reply, err=
p) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 error =3D nbd_handle_reply_err(ioc, &reply, errp);=

>> +=C2=A0=C2=A0=C2=A0 if (error <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (reply.type !=3D NBD_REP_ACK) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Server r=
ejected request for option %d (%s) "
>=20
> Looks like now it is not rejected (nbd_handle_reply_err return >0 only
> for successful replies), but it should be
> Server replied ... with unexpected reply ...

Hmm.  For NBD_OPT_STARTTLS, NBD_REP_ERR_POLICY is an example of an
expected (error) reply.  Then again, we can't reach here on that reply,
because it would have already been handled in nbd_handle_reply_error().
Okay, I can see where you are coming from - since we already treated all
NBD_REP_ERR_* as rejection messages, anything else that the server sends
is unexpected if it is not ACK.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tmf76XdWUkKGBoLU1ihXxWgF9hvGV5aqa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqT5MACgkQp6FrSiUn
Q2pgMQf/fPxs11l2c8YQVWEfHdGpMZoynXoIK7X2WVNf/yHeIVh264t5IqVTUY1y
ZnDyGvgLVJ4Cl6bEDwnx8FbwmtHZ+9p9NyH+ztRhtv+vaimkQmwe28xPfLW1q4OD
asjoIixtniMP5mSyQBenjfv5vmREVpWjJy8Fo/jYym0lRQRn0pf4Yz/y4kwfWy/z
E2pgkCAK845OwjEvfKgdxfOqpXX8h1WPfTRe5E2UvK54o6qEaB0P7TrWkQpwIVru
szyJ8ewlgnFFuRWTa80kUmkLDyP9RRDhQyAXN5k9SEitsSc1b1PQnf1OTSllUsuA
PaNCADr9+I+ZWGXdZG7uhubTH9+K/Q==
=87jd
-----END PGP SIGNATURE-----

--tmf76XdWUkKGBoLU1ihXxWgF9hvGV5aqa--
