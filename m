Received: from eggs.gnu.org ([2001:4830:134:3::10]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxaHB-0001pk-QI
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxaH7-0008KL-RF
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:58:57 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-3-eblake@redhat.com>
	<b5fd50f3-7bd0-115c-bc67-0df49b05cb76@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d34a1afa-d4a4-e82f-a372-1f7e24d3bbcd@redhat.com>
Date: Thu, 28 Sep 2017 09:58:37 -0500
MIME-Version: 1.0
In-Reply-To: <b5fd50f3-7bd0-115c-bc67-0df49b05cb76@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D2olUSFlmPnm62DQB3awdaoX20SK8JujV"
Subject: Re: [Qemu-devel] [PATCH v4 02/23] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D2olUSFlmPnm62DQB3awdaoX20SK8JujV
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <d34a1afa-d4a4-e82f-a372-1f7e24d3bbcd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/23] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-3-eblake@redhat.com>
 <b5fd50f3-7bd0-115c-bc67-0df49b05cb76@redhat.com>
In-Reply-To: <b5fd50f3-7bd0-115c-bc67-0df49b05cb76@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 01:31 PM, John Snow wrote:
>=20
>=20
> On 09/13/2017 12:03 PM, Eric Blake wrote:
>> Not all callers care about which BDS owns the mapping for a given
>> range of the file.  In particular, bdrv_is_allocated() cares more
>> about finding the largest run of allocated data from the guest
>> perspective, whether or not that data is consecutive from the
>> host perspective.  Therefore, doing subsequent refinements such
>> as checking how much of the format-layer allocation also satisfies
>> BDRV_BLOCK_ZERO at the protocol layer is wasted work - in the best
>> case, it just costs extra CPU cycles during a single
>> bdrv_is_allocated(), but in the worst case, it results in a smaller
>> *pnum, and forces callers to iterate through more status probes when
>> visiting the entire file for even more extra CPU cycles.
>>
>> This patch only optimizes the block layer.  But subsequent patches
>> will tweak the driver callback to be byte-based, and in the process,
>> can also pass this hint through to the driver.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>>   *
>> + * If 'mapping' is true, the caller is querying for mapping purposes,=

>> + * and the result should include BDRV_BLOCK_OFFSET_VALID where
>> + * possible; otherwise, the result may omit that bit particularly if
>> + * it allows for a larger value in 'pnum'.

I decided one more tweak to the comment will help:

+ * If 'mapping' is true, the caller is querying for mapping purposes,
+ * and the result should include BDRV_BLOCK_OFFSET_VALID and
+ * BDRV_BLOCK_ZERO where possible; otherwise, the result may omit those
+ * bits particularly if it allows for a larger value in 'pnum'.


>> @@ -1836,12 +1844,13 @@ static int64_t coroutine_fn bdrv_co_get_block_=
status(BlockDriverState *bs,
>>          }
>>      }
>>
>> -    if (local_file && local_file !=3D bs &&
>> +    if (mapping && local_file && local_file !=3D bs &&
>=20
> Tentatively this looks OK to me, but I have to admit I'm a little shaky=

> on this portion because I've not really investigated this function too
> much. I am at the very least convinced that when mapping is true that
> the function is equivalent and that existing callers don't have their
> behavior changed too much.
>=20
> Benefit of the doubt:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Then I'll tentatively keep your R-b even with the comment tweak, unless
you say otherwise :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D2olUSFlmPnm62DQB3awdaoX20SK8JujV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnNDh0ACgkQp6FrSiUn
Q2qCZAgAoF9hYQY93B/03QnEgib3eJaBE5WHki3yFHknNN+NIfnCIRXiMqTilpvW
SEmT31FBEjMSLVJMzGDUuhYIc79upnnmeSOlMkQz3B1wtWmNCJfxbO28AtCDWPUx
x9wA0RxxFlEM8aRWnL0p/w6R8X8dVtGiaGlmCACLqf9OYfr4g9EfeowDpU3psdHr
eVrgcmbi2JRe6tQO856JUCjDMr9oFs3z7f+9RxM1N4w8GRnxJ5KLEZa3DQvmYuRY
g+RMcgN8eyaa1VyOtGeyrnj+JKtSYB/dHP8iiIUT/y3jbsmBki5ewB5mopSXRO9h
iHOUOV8x4YsniOzU22jXq0nMZobb2Q==
=nXpw
-----END PGP SIGNATURE-----

--D2olUSFlmPnm62DQB3awdaoX20SK8JujV--
