Received: from eggs.gnu.org ([2001:4830:134:3::10]:52539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceqIu-000620-Hr
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceqIt-0000RK-NB
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:43:00 -0500
References: <1487349541-10201-1-git-send-email-pl@kamp.de>
	<1487349541-10201-3-git-send-email-pl@kamp.de>
	<20170217213715.GJ19045@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <feb6aa92-5e7f-9af9-12cb-bd7beae47750@redhat.com>
Date: Fri, 17 Feb 2017 15:42:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170217213715.GJ19045@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5mFX5EREseVHlHA4jDGi4jqc4bIDx7kBu"
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nfs: try to avoid the bounce
 buffer in pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5mFX5EREseVHlHA4jDGi4jqc4bIDx7kBu
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <feb6aa92-5e7f-9af9-12cb-bd7beae47750@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nfs: try to avoid the bounce
 buffer in pwritev
References: <1487349541-10201-1-git-send-email-pl@kamp.de>
 <1487349541-10201-3-git-send-email-pl@kamp.de>
 <20170217213715.GJ19045@localhost.localdomain>
In-Reply-To: <20170217213715.GJ19045@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 03:37 PM, Jeff Cody wrote:
> On Fri, Feb 17, 2017 at 05:39:01PM +0100, Peter Lieven wrote:
>> if the passed qiov contains exactly one iov we can
>> pass the buffer directly.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  block/nfs.c | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/nfs.c b/block/nfs.c
>> index ab5dcc2..bb4b75f 100644
>> --- a/block/nfs.c
>> +++ b/block/nfs.c
>> @@ -295,20 +295,27 @@ static int coroutine_fn nfs_co_pwritev(BlockDriv=
erState *bs, uint64_t offset,
>>      NFSClient *client =3D bs->opaque;
>>      NFSRPC task;
>>      char *buf =3D NULL;
>> +    bool my_buffer =3D false;
>=20
> g_free() is a nop if buf is NULL, so there is no need for the my_buffer=

> variable & check.

Umm, yes there is:

>> +    if (iov->niov !=3D 1) {
>> +        buf =3D g_try_malloc(bytes);
>> +        if (bytes && buf =3D=3D NULL) {
>> +            return -ENOMEM;
>> +        }
>> +        qemu_iovec_to_buf(iov, 0, buf, bytes);
>> +        my_buffer =3D true;
>> +    } else {
>> +        buf =3D iov->iov[0].iov_base;

If we took the else branch, then we definitely do not want to be calling
g_free(buf).

>>      }
>> =20
>> -    qemu_iovec_to_buf(iov, 0, buf, bytes);
>> -
>>      if (nfs_pwrite_async(client->context, client->fh,
>>                           offset, bytes, buf,
>>                           nfs_co_generic_cb, &task) !=3D 0) {
>> -        g_free(buf);
>> +        if (my_buffer) {
>> +            g_free(buf);
>> +        }

It looks correct as-is to me.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5mFX5EREseVHlHA4jDGi4jqc4bIDx7kBu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp25cAAoJEKeha0olJ0NqYFQH/RWRmwnRONBQlM7LM0vmeTPJ
PsVQL/0M3Y0x78yMZNUqyn6ENvWjOe+aG7vJk6my9zseRH3KC23s2nHfERcsLNZ1
LD2GmgNFNm6mGj5AMTzAyY7sdDgz9Y6VliG2e0ZJy9xYeW0w4TcfZtWoyacu7fnS
jTQ+9psTiMqciDdaXcpBFeNJHbPh0MgyK1/ordLpM91ru6MURMvbX/unrk7tf2i7
bAObDFJAb7RbVkBjrTDDe1SGK8l7qd9pSVMXseuc7/IJxmw715bdqnwnreAQmBaf
BUe01dgWeboi1a1wLHFpiUjXSjC37eerpvZIab5VDYjFhU67Hz0/9VkRj1cXw2Y=
=gNez
-----END PGP SIGNATURE-----

--5mFX5EREseVHlHA4jDGi4jqc4bIDx7kBu--
