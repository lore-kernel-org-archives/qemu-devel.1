Received: from eggs.gnu.org ([2001:4830:134:3::10]:49408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f306s-0004Il-OQ
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f306r-000540-Fk
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:06:58 -0400
References: <20180330130950.1931229-1-eblake@redhat.com>
	<ba967166-28fb-e460-d85c-e3cc5c09f6df@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <675406e7-4895-faf2-3865-0ea219a91c30@redhat.com>
Date: Mon, 2 Apr 2018 09:06:45 -0500
MIME-Version: 1.0
In-Reply-To: <ba967166-28fb-e460-d85c-e3cc5c09f6df@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s1H251EEtyJ5kCpjL5lHGp2o2RLNj4ThZ"
Subject: Re: [Qemu-devel] [PATCH for-2.12] nbd: trace meta context
 negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s1H251EEtyJ5kCpjL5lHGp2o2RLNj4ThZ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <675406e7-4895-faf2-3865-0ea219a91c30@redhat.com>
Subject: Re: [PATCH for-2.12] nbd: trace meta context negotiation
References: <20180330130950.1931229-1-eblake@redhat.com>
 <ba967166-28fb-e460-d85c-e3cc5c09f6df@virtuozzo.com>
In-Reply-To: <ba967166-28fb-e460-d85c-e3cc5c09f6df@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2018 11:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.03.2018 16:09, Eric Blake wrote:
>> Having a more detailed log of the interaction between client and
>> server is invaluable in debugging how meta context negotiation
>> actually works.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 nbd/client.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++++++
>> =C2=A0 nbd/trace-events | 6 ++++++
>> =C2=A0 3 files changed, 16 insertions(+)
>>

>> @@ -800,6 +804,7 @@ static int nbd_negotiate_meta_query(NBDClient
>> *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The only supported namespace for now=
 is 'base'. So query
>> should start
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with 'base:'. Otherwise, we can=
 ignore it and skip the
>> remainder. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len < baselen) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_q=
uery_skip("length too short");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_=
skip(client, len, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> @@ -809,6 +814,7 @@ static int nbd_negotiate_meta_query(NBDClient
>> *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strncmp(query, "base:", baselen) !=3D=
 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_q=
uery_skip("not for base: namespace");
>=20
> Hmm, reasonable example of using same trace-point in several places in
> the code. Is it a precedent?

Yes, trace points have been reused before; as long as the parameters are
the same and the message is reasonable, the only reason to NOT share a
trace is if you ever see yourself needing to select between the two
trace points individually. But for both of these points, it seems to me
that you'd either be tracing everything nbd_* or nothing, rather than
trying to catch just one of these points.

>> +++ b/nbd/trace-events
>> @@ -10,6 +10,8 @@ nbd_receive_query_exports_start(const char
>> *wantname) "Querying export list for
>> =C2=A0 nbd_receive_query_exports_success(const char *wantname) "Found
>> desired export name '%s'"
>> =C2=A0 nbd_receive_starttls_new_client(void) "Setting up TLS"
>> =C2=A0 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshak=
e"
>> +nbd_opt_meta_request(const char *context, const char *export)
>> "Requesting to set meta context %s for export %s"
>> +nbd_opt_meta_reply(const char *context, int id) "Received mapping of
>> context %s to id %d"
>=20
> actual type is uint32_t, I'd prefer to reflect it here.
>=20

It doesn't make a difference on 'unsigned int' vs. 'uint32_t' in
trace-events.  We guarantee that int is 32 bits on all platforms qemu
compiles on, and "%u" is a lot less typing than "%"PRIu32.  But you are
right that id is unsigned, and printing a negative value for an id could
be confusing, so I'll at least tweak it for that.

>=20
> Must-have trace-points, anyway:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks; I'll make those trace-events tweaks, and queue in my NBD tree
for a pull request today.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s1H251EEtyJ5kCpjL5lHGp2o2RLNj4ThZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrCOPUACgkQp6FrSiUn
Q2oo4gf7BtYnrx90ASjAtO/CJ4VxdJrXUko+uzVV385DCg6EWSbd1r9J1Bw1udML
QkJSy3bRrrbVEYF7sYi5IPHTTOB23lwdy6rC2XpQ03+KZTQTKgBqL5nfosop0Gsc
gaefgPu6aynqicc495EqVE1+qplCSNynXihJ/b4gluzGTwoDyAdU/tD7P18n5He+
rIONrN//sd2ZrJWArYxRGY9B1b9Qg0Y0Hw57vVAh//b5Sxk2qENo6gGvd06pTSxO
/o6nGbUFNhFNWT4F/cj7U+MHStTJo5LxAd8qU4gaqY4ZFy1jLdAZkU74SQchg4A7
s3Femi4WYxyThEhxBWmUH1IE6bDA9A==
=qviP
-----END PGP SIGNATURE-----

--s1H251EEtyJ5kCpjL5lHGp2o2RLNj4ThZ--
