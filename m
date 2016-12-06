Received: from eggs.gnu.org ([2001:4830:134:3::10]:37250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cENKz-0000Pt-8L
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cENKy-0008C9-E4
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:31:45 -0500
References: <20161203181914.7467-1-eblake@redhat.com>
	<0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
	<d6e0a4ba-d64b-7b9d-a7a1-53170ddbb543@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <18e3382e-ec17-f25c-06e5-e49004a80f94@redhat.com>
Date: Tue, 6 Dec 2016 22:31:33 +0100
MIME-Version: 1.0
In-Reply-To: <d6e0a4ba-d64b-7b9d-a7a1-53170ddbb543@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BgXTVvHGeNcX9CLTfxjv6GjCsnl55EmjQ"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Discard/zero clusters by byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BgXTVvHGeNcX9CLTfxjv6GjCsnl55EmjQ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <18e3382e-ec17-f25c-06e5-e49004a80f94@redhat.com>
Subject: Re: [PATCH] qcow2: Discard/zero clusters by byte count
References: <20161203181914.7467-1-eblake@redhat.com>
 <0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
 <d6e0a4ba-d64b-7b9d-a7a1-53170ddbb543@redhat.com>
In-Reply-To: <d6e0a4ba-d64b-7b9d-a7a1-53170ddbb543@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.12.2016 22:26, Eric Blake wrote:
> On 12/06/2016 03:01 PM, Max Reitz wrote:
>> On 03.12.2016 19:19, Eric Blake wrote:
>>> Passing a byte offset, but sector count, when we ultimately
>>> want to operate on cluster granularity, is madness.  Clean up
>>> the interfaces to take byte offset and count.  Rename
>>> qcow2_discard_clusters() and qcow2_zero_clusters() to the
>>> shorter qcow2_discard() and qcow2_zero() to make sure backports
>>> don't get confused by changed units.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>
>>> 2.9 material, depends on 'Don't strand clusters near 2G intervals
>>> during commit'
>>>
>=20
>>> @@ -1595,20 +1593,24 @@ static int zero_single_l2(BlockDriverState *b=
s, uint64_t offset,
>>>      return nb_clusters;
>>>  }
>>>
>>> -int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int n=
b_sectors,
>>> -                        int flags)
>>> +int qcow2_zero(BlockDriverState *bs, uint64_t offset, uint64_t count=
,
>>> +               int flags)
>>
>> Hmm, I personally liked qcow2_zero_clusters() better. qcow2_zero()
>> doesn't really express that it means the verb "to zero".
>>
>> Also, while you are making a good point why the function should be
>> renamed, qcow2_zero_clusters() was much more accurate because offset a=
nd
>> count are expected to be cluster-aligned.
>>
>> The only alternative I can come up with would be "qcow2_write_zeroes";=

>> that at least solves the first issue I have with this, but not the
>> second one...
>=20
> Maybe qcow2_cluster_zeroize() and qcow2_cluster_discard()?

I think qcow2_discard() is fine (it works with any alignment (even
though it will only discard whole clusters) and "discard" is mainly used
as a verb, so at least I'm not confused there). I like
qcow2_cluster_zeroize() if nothing else then for the "zeroize" alone. :-)=


Max

>                                                            That gets th=
e
> benefit of the rename (to force all callers to use the right semantics)=
,
> while still being legible as an object-verb naming: the action
> ('discard' or 'zeroize') is performed on 'qcow2 cluster' objects.


--BgXTVvHGeNcX9CLTfxjv6GjCsnl55EmjQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHLjUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfocH/0rwpXgEE4UORHgfjsVMTDe6iANNcrlZ
MQraNOX7r36lrm4xbqAqjbVlPKJy1ApymOIShXtS//mSsGXkC5vpvTXiAXw7eo+6
GAf6WRA3XZvC5iNu8eLPjPpK0j21uKcSUA0RKHT9Xs8WRf7cHrOH/AoQrf4SaZB4
dnZESijQcM3OV0ta+u8PnXyrAQi+/ZC44iG+PBTD1gmwuWAoSWHC/9rJCc1Ejs14
gralmjtetL7UaLLzVR3u0GgXRi7YApXDUW/YE1OzLiQH/fq2S0FHRfKBC9SnAWic
1vOWj+Gw+qTQgp9rskinV0WKi/ny/X0LN96dcj7i74bDcvYsAEfZSqM=
=Wo3P
-----END PGP SIGNATURE-----

--BgXTVvHGeNcX9CLTfxjv6GjCsnl55EmjQ--
