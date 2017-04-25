Received: from eggs.gnu.org ([2001:4830:134:3::10]:54238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d36eq-0000o7-R5
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 16:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d36ep-0005Mj-HW
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 16:01:56 -0400
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<0ffa427b-9f38-c673-ded9-b6f17742f5ca@redhat.com>
	<CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5f1f23d8-2c19-f67c-5bb3-51c2602fbb8e@redhat.com>
Date: Tue, 25 Apr 2017 22:01:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mmNSgoHkdc4Ps8WH6W67OXWTVuUVFikij"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: make sure contain the
 consecutive number of zero bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Lidong Chen <lidongchen@tencent.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mmNSgoHkdc4Ps8WH6W67OXWTVuUVFikij
From: Max Reitz <mreitz@redhat.com>
To: 858585 jemmy <jemmy858585@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Lidong Chen <lidongchen@tencent.com>, qemu block <qemu-block@nongnu.org>
Message-ID: <5f1f23d8-2c19-f67c-5bb3-51c2602fbb8e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: make sure contain the
 consecutive number of zero bytes
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
 <0ffa427b-9f38-c673-ded9-b6f17742f5ca@redhat.com>
 <CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
In-Reply-To: <CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.04.2017 03:50, 858585 jemmy wrote:
> On Mon, Apr 24, 2017 at 10:43 PM, Eric Blake <eblake@redhat.com> wrote:=

>> On 04/23/2017 09:33 AM, jemmy858585@gmail.com wrote:
>>> From: Lidong Chen <lidongchen@tencent.com>
>>>
>>> is_allocated_sectors_min don't guarantee to contain the
>>> consecutive number of zero bytes. this patch fixes this bug.
>>
>> This message was sent without an 'In-Reply-To' header pointing to a 0/=
2
>> cover letter.  When sending a series, please always thread things to a=

>> cover letter; you may find 'git config format.coverletter auto' to be
>> helpful.
>=20
> Thanks for your kind advises.
>=20
>>
>>>
>>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>> ---
>>>  qemu-img.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/qemu-img.c b/qemu-img.c
>>> index b220cf7..df6d165 100644
>>> --- a/qemu-img.c
>>> +++ b/qemu-img.c
>>> @@ -1060,9 +1060,9 @@ static int is_allocated_sectors(const uint8_t *=
buf, int n, int *pnum)
>>>  }
>>>
>>>  /*
>>> - * Like is_allocated_sectors, but if the buffer starts with a used s=
ector,
>>> - * up to 'min' consecutive sectors containing zeros are ignored. Thi=
s avoids
>>> - * breaking up write requests for only small sparse areas.
>>> + * Like is_allocated_sectors, but up to 'min' consecutive sectors
>>> + * containing zeros are ignored. This avoids breaking up write reque=
sts
>>> + * for only small sparse areas.
>>>   */
>>>  static int is_allocated_sectors_min(const uint8_t *buf, int n, int *=
pnum,
>>>      int min)
>>> @@ -1071,11 +1071,12 @@ static int is_allocated_sectors_min(const uin=
t8_t *buf, int n, int *pnum,
>>>      int num_checked, num_used;
>>>
>>>      if (n < min) {
>>> -        min =3D n;
>>> +        *pnum =3D n;
>>> +        return 1;
>>>      }
>>>
>>>      ret =3D is_allocated_sectors(buf, n, pnum);
>>> -    if (!ret) {
>>> +    if (!ret && *pnum >=3D min) {
>>
>> I seem to recall past attempts to try and patch this function, which
>> were then turned down, although I haven't scrubbed the archives for a
>> quick URL to point to. I'm worried that there are more subtleties here=

>> than what you realize.
>=20
> Hi Eric:
> Do you mean this URL?
> https://lists.gnu.org/archive/html/qemu-block/2017-01/msg00306.html
>=20
> But I think the code is not consistent with qemu-img --help.
> qemu-img --help
>   '-S' indicates the consecutive number of bytes (defaults to 4k) that =
must
>        contain only zeros for qemu-img to create a sparse image during
>        conversion. If the number of bytes is 0, the source will not be
> scanned for
>        unallocated or zero sectors, and the destination image will alwa=
ys be
>        fully allocated.
>=20
> another reason:
> if s->has_zero_init is 1(the qcow2 image which have backing_file), the =
empty
> space at the beginning of the buffer still need write and invoke
> blk_co_pwrite_zeroes.

Right, that is indeed a reason that we may want to behave differently in
these cases. But in other cases this is less efficient.

> and split a single write operation into two just because there is small=
 empty
> space at the beginning.
And then there's the fact that, in my opinion, this is actually a
problem at qcow2 level. Some people are working on improving this (see
e.g. Berto's subcluster RFC, which would allow us to implement
bdrv_co_pwrite_zeroes() below cluster granularity).

All in all, I don't think you can generically circumvent this issue here
for all block drivers. The rule we'd have to implement here is: If some
part of a cluster (to be written) is zero and another is not, we should
write the whole cluster. If a whole cluster is zero, we should issue a
write-zeroes request. But that would mean to check where some buffer
passes a cluster boundary and so on, and on top of this all of it is
qcow2-specific; so there goes the genericity...

Max


--mmNSgoHkdc4Ps8WH6W67OXWTVuUVFikij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj/qyASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABjkIALCTzakJ2JrGSuJ2mruI5ynyTbOqbb5B
4h2dEawEzcGhIA9WySi8YnrTYt4OXBLJifquVMPWTaYS9+56/SHAweYg/1C9cxQx
68ODt8PJGc+4LEBaQYEVHigl+5p755JBujvOEhhTj/eBLCP93/1ObZ0J9qvjcUz3
vWR7zvYOQBDsvPMF1GhJmTZThd8zf17k1RgFjeYbUleHCPKYFvJwP/ZRFh5MWrD3
cyMgt87mtMVFAvTDq5fzycjzEWYhl5O3woCmd+TbUQAYhmxu2OcvV/ls7Dg0iYTd
xB5ZTTT/dJhStPVs2sx9sTf1MHW/+4cAa3OgFHdVhkbKXGaRaUDLHIQ=
=3u41
-----END PGP SIGNATURE-----

--mmNSgoHkdc4Ps8WH6W67OXWTVuUVFikij--
