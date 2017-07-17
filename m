Received: from eggs.gnu.org ([2001:4830:134:3::10]:34077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXB5u-0002ad-4M
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXB5t-0002eX-4F
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:10 -0400
References: <20170714183224.7209-1-eblake@redhat.com>
	<20170714183224.7209-3-eblake@redhat.com>
	<20d98b63-0520-9062-0b76-b5dde45c7acf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0ce4600-6feb-c7d6-7886-f81b710037dd@redhat.com>
Date: Mon, 17 Jul 2017 13:49:54 -0500
MIME-Version: 1.0
In-Reply-To: <20d98b63-0520-9062-0b76-b5dde45c7acf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HwAoMQs2N0ml1kGH2TsQcLiQg7gLdudxp"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] nbd: Fix server reply to
 NBD_OPT_EXPORT_NAME of older clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HwAoMQs2N0ml1kGH2TsQcLiQg7gLdudxp
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org
Message-ID: <d0ce4600-6feb-c7d6-7886-f81b710037dd@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/2] nbd: Fix server reply to
 NBD_OPT_EXPORT_NAME of older clients
References: <20170714183224.7209-1-eblake@redhat.com>
 <20170714183224.7209-3-eblake@redhat.com>
 <20d98b63-0520-9062-0b76-b5dde45c7acf@redhat.com>
In-Reply-To: <20d98b63-0520-9062-0b76-b5dde45c7acf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 01:27 PM, John Snow wrote:
>=20
>=20
> On 07/14/2017 02:32 PM, Eric Blake wrote:
>> A typo in commit 23e099c set the size of buf[] used in response
>> to NBD_OPT_EXPORT_NAME according to the length needed for old-style
>> negotiation (4 bytes of flag information) instead of the intended
>> 2 bytes used in new style.  If the client doesn't enable
>> NBD_FLAG_C_NO_ZEROES, then the server sends two bytes too many,
>> and is then out of sync in response to the client's next command
>> (the bug is masked when modern qemu is the client, since we enable
>> the no zeroes flag).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  nbd/server.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 49ed574..bcb241c 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -283,7 +283,7 @@ static int nbd_negotiate_handle_export_name(NBDCli=
ent *client, uint32_t length,
>>                                              Error **errp)
>>  {
>>      char name[NBD_MAX_NAME_SIZE + 1];
>> -    char buf[8 + 4 + 124] =3D "";
>> +    char buf[8 + 2 + 124] =3D "";
>=20
> Is it worth naming these values with some kind of constant to help
> describe what the components are? Or at least documenting nearby what
> these pieces are? It's clearly written to help illustrate the length of=

> segments of the reply, but I'm not sure what the segments are.

Good question.  In nbd/nbd_internal.h, we have some:

/* Size of all NBD_OPT_*, without payload */
#define NBD_REQUEST_SIZE        (4 + 2 + 2 + 8 + 8 + 4)
/* Size of all NBD_REP_* sent in answer to most NBD_OPT_*, without
payload */
#define NBD_REPLY_SIZE          (4 + 4 + 8)

But this is in response to NBD_OPT_EXPORT_NEXT, which is different from
all other NBD_OPT_* (hence the "most" in the comment above).  I don't
know if buf[sizeof(uint64_t) + sizeof(uint16_t) + sizeof(int[124])] is
any cleaner to read, but at least having another defined constant in
nbd_internal.h alongside the existing constants can't hurt.

Either way, the length is broken out to match the code below, which is
populating it via:

    stq_be_p(buf, client->exp->size);
    stw_be_p(buf + 8, client->exp->nbdflags | myflags);
    len =3D no_zeroes ? 10 : sizeof(buf);

(that is, 8 bytes size, 2 bytes flags, then 124 bytes of NUL)

>=20
> Also, do we have a policy on how much stuff we're allowed to put on the=

> stack? I know we've been moving some larger allocations off, but I don'=
t
> know what the rule of thumb is.

Rule of thumb is that anything larger than 4k makes it too easy to
accidentally miss the guard page, and should be reworked to use other
means.  Stuff under 1k, like this, is no problem.

>=20
>>      size_t len;
>>      int ret;
>>
>> @@ -800,7 +800,7 @@ static int nbd_negotiate_options(NBDClient *client=
, uint16_t myflags,
>>   */
>>  static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp=
)
>>  {
>> -    char buf[8 + 8 + 8 + 128];
>> +    char buf[8 + 8 + 8 + 2 + 2 + 124];
>=20
> I assume this is a semantic fix instead of a logical one, but I don't
> know exactly what or why.

Yes, semantic fix.  The code below populates this as:

    memset(buf, 0, sizeof(buf));
    memcpy(buf, "NBDMAGIC", 8);
=2E..
        stq_be_p(buf + 8, NBD_CLIENT_MAGIC);
        stq_be_p(buf + 16, client->exp->size);
        stw_be_p(buf + 26, client->exp->nbdflags | myflags);

(that is, 8 bytes general magic, 8 bytes old-style magic, 8 bytes size,
2 bytes left 0, 2 bytes of flags [hmm, the code could have used
stl_be_p(buf + 24, flags...) with no semantic change], then 124 bytes of
NUL)

If the spec helps,
https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md,
search for Oldstyle negotiation, then search for the two instances of
the string "size of the export in bytes" (second hit is the newstyle
counterpart, covering the first part of this patch).

>=20
>>      int ret;
>>      const uint16_t myflags =3D (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_TR=
IM |
>>                                NBD_FLAG_SEND_FLUSH | NBD_FLAG_SEND_FUA=
 |
>>
>=20
> Sincerely, someone who has never read our NBD code before.
>=20

Your pre-freeze reviews are much appreciated, even if it is in areas
where you are less familiar.  Thanks!

Sounds like I'll post a v2 with some magic numbers hoisted to the header
for consistency.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HwAoMQs2N0ml1kGH2TsQcLiQg7gLdudxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlltBtIACgkQp6FrSiUn
Q2qG6Qf/btVMEh2Oy5lIoDrDcvVU1AtR6r2VoOsnKXrPkufE47IajU999Fc907hE
P044s0ww8R3oBgZsg2YmkNfOMtIsasW1Oaz/r5sPk1VsBzhPuVk5PZvjrwpl7Lxx
7F0qJkL+nfHPW2Z5TTqpKCgJ6y71O+NB8C9/GWbIywC4y8MMFU46X43lzzHZ8nw+
xwlW/yaC3lG12su+2wB+9q5VT3wzF2TqHz3tAqVFYqaZPQ0PhuwlzsBMztIY77Gj
fG58l8G4bJOfvwbVq5d91hhVG98BUHaThmcrZ0u7pn++d704gWOuR35mUILPzGBs
tCGmc3eVpIQTAyIXvNTGZwt7fKKNUw==
=zRGK
-----END PGP SIGNATURE-----

--HwAoMQs2N0ml1kGH2TsQcLiQg7gLdudxp--
