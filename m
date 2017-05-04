Received: from eggs.gnu.org ([2001:4830:134:3::10]:48058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6GoP-0003kC-Jp
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6GoO-0003uq-C6
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:28:53 -0400
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-4-vsementsov@virtuozzo.com>
	<e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
	<9392b02d-e251-d3f7-dbf5-b2bce1aa7620@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27047727-9208-d2f9-96f7-40829e869b54@redhat.com>
Date: Thu, 4 May 2017 08:28:32 -0500
MIME-Version: 1.0
In-Reply-To: <9392b02d-e251-d3f7-dbf5-b2bce1aa7620@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mBaSEsGK7Xh4rdaGj534dn1uoITis5WO5"
Subject: Re: [Qemu-devel] [PATCH 03/18] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mBaSEsGK7Xh4rdaGj534dn1uoITis5WO5
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <27047727-9208-d2f9-96f7-40829e869b54@redhat.com>
Subject: Re: [PATCH 03/18] nbd: Minimal structured read for server
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-4-vsementsov@virtuozzo.com>
 <e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
 <9392b02d-e251-d3f7-dbf5-b2bce1aa7620@virtuozzo.com>
In-Reply-To: <9392b02d-e251-d3f7-dbf5-b2bce1aa7620@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 05:58 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> @@ -70,6 +70,25 @@ struct NBDSimpleReply {
>>>   };
>>>   typedef struct NBDSimpleReply NBDSimpleReply;
>>>   +typedef struct NBDStructuredReplyChunk {
>>> +    uint32_t magic;
>>> +    uint16_t flags;
>>> +    uint16_t type;
>>> +    uint64_t handle;
>>> +    uint32_t length;
>>> +} QEMU_PACKED NBDStructuredReplyChunk;
>>> +
>>> +typedef struct NBDStructuredRead {
>>> +    NBDStructuredReplyChunk h;
>>> +    uint64_t offset;
>>> +} QEMU_PACKED NBDStructuredRead;
>>> +
>>> +typedef struct NBDStructuredError {
>>> +    NBDStructuredReplyChunk h;
>>> +    uint32_t error;
>>> +    uint16_t message_length;
>>> +} QEMU_PACKED NBDStructuredError;
>> Definitely a subset of all types added in the NBD protocol extension,
>> but reasonable for a minimal implementation.  Might be worth adding
>> comments to the types...
>=20
> Hmm, for me their names looks descriptive enough, but my sight may be
> biased.. What kind of comments do you want?

I guess I was thinking of existing structs in include/block/nbd.h:

/* Handshake phase structs - this struct is passed on the wire */

struct nbd_option {
    uint64_t magic; /* NBD_OPTS_MAGIC */
    uint32_t option; /* NBD_OPT_* */
    uint32_t length;
} QEMU_PACKED;
typedef struct nbd_option nbd_option;


and compared to:

/* Transmission phase structs
 *
 * Note: these are _NOT_ the same as the network representation of an NBD=

 * request and reply!
 */
struct NBDRequest {
    uint64_t handle;
    uint64_t from;
    uint32_t len;
    uint16_t flags; /* NBD_CMD_FLAG_* */
    uint16_t type; /* NBD_CMD_* */
};
typedef struct NBDRequest NBDRequest;

where the comments make it obvious whether QEMU_PACKED matters because
we are using the struct to directly map bytes read/written on the wire.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mBaSEsGK7Xh4rdaGj534dn1uoITis5WO5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCyyAAAoJEKeha0olJ0NqzqMIAIBd6FQxu0P0lk7Op/9cYy9x
Ul8NuR7hRjQ7CAbHHSntnkFOdcjI0gkRtNJhKVWH/fWECFodLQJPqbVlwU7w+mPL
VkAaIo8bTMMmigXsUYZ7IYYUuUHtsKpE0JCxGG6PuxGUYNm5tMsiy1nPJ5+kXaiq
DgeiveNUWPANi3BueCECiAHOvzANg4uZYvAnR1IhjYFkiVrHUZ3fZHC8vMV7V6S5
1QCQEvV3jGA3KW/LBRBeBCTWSd02ixiGczGrZRhnm67qneIC/68U5IPODNiZjS/K
sY8mo2IFaRiXdK5tVpH4/v0ojwAME8V7LD4F7XMrwypXDNWNgkyE1M36EaiIC4o=
=Wlk5
-----END PGP SIGNATURE-----

--mBaSEsGK7Xh4rdaGj534dn1uoITis5WO5--
