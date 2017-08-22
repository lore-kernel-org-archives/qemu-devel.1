Received: from eggs.gnu.org ([2001:4830:134:3::10]:44916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dk6Uy-0003Qj-SF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dk6Ux-0000u0-RD
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:33:28 -0400
Date: Tue, 22 Aug 2017 13:31:26 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170822103126.3aeusdpvr55iwhym@postretch>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-4-el13635@mail.ntua.gr>
	<w51ziatm05h.fsf@maestria.local.igalia.com>
	<20170821153948.agdtsvy3m5u4jfip@postretch>
	<w51bmn7hqlz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5qscq2coteceqsta"
Content-Disposition: inline
In-Reply-To: <w51bmn7hqlz.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] block: require job-id when device
 is a node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--5qscq2coteceqsta
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 11:57:28AM +0200, Alberto Garcia wrote:
>On Mon 21 Aug 2017 05:39:48 PM CEST, Manos Pitsidianakis wrote:
>>>> -    if (job_id =3D=3D NULL && !(flags & BLOCK_JOB_INTERNAL)) {
>>>> -        job_id =3D bdrv_get_device_name(bs);
>>>> -        if (!*job_id) {
>>>> -            error_setg(errp, "An explicit job ID is required for this=
 node");
>>>> -            return NULL;
>>>> -        }
>>>> -    }
>>>> -
>>>> -    if (job_id) {
>>>> -        if (flags & BLOCK_JOB_INTERNAL) {
>>>> +    if (flags & BLOCK_JOB_INTERNAL) {
>>>> +        if (job_id) {
>>>>              error_setg(errp, "Cannot specify job ID for internal bloc=
k job");
>>>>              return NULL;
>>>>          }
>>>
>>>When BLOCK_JOB_INTERNAL is set, then job_id must be NULL...
>>>
>>>> -
>>>> +    } else {
>>>> +        /* Require job-id. */
>>>> +        assert(job_id);
>>>>          if (!id_wellformed(job_id)) {
>>>>              error_setg(errp, "Invalid job ID '%s'", job_id);
>>>>              return NULL;
>>>> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int=
=2Eh
>>>> index f13ad05c0d..ff906808a6 100644
>>>> --- a/include/block/blockjob_int.h
>>>> +++ b/include/block/blockjob_int.h
>>>> @@ -112,8 +112,7 @@ struct BlockJobDriver {
>>>>
>>>>  /**
>>>>   * block_job_create:
>>>> - * @job_id: The id of the newly-created job, or %NULL to have one
>>>> - * generated automatically.
>>>> + * @job_id: The id of the newly-created job, must be non %NULL.
>>>
>>>...but here you say that it must not be NULL.
>>>
>>>And since job_id can be NULL in some cases I think I'd replace the
>>>assert(job_id) that you added to block_job_create() with a normal
>>>pointer check + error_setg().
>>>
>>>> @@ -93,9 +93,6 @@ static void test_job_ids(void)
>>>>      blk[1] =3D create_blk("drive1");
>>>>      blk[2] =3D create_blk("drive2");
>>>>
>>>> -    /* No job ID provided and the block backend has no name */
>>>> -    job[0] =3D do_test_id(blk[0], NULL, false);
>>>> -
>>>
>>>If you decide to handle NULL ids by returning and error instead of
>>>asserting, we should keep a couple of tests for that scenario.
>>>
>>>Berto
>>>
>>
>> Thanks, I will change that. What cases are you thinking of besides
>> internal jobs though?
>
>Both cases (external job with a NULL id and internal job with non-NULL
>id), checking that block_job_create() does return an error.

I thought we handled the external job case by requiring job_id is set=20
before calling block_job_create(). I will check my patch again.

>
>> And should documentation of block_job_create reflect that internal
>> jobs have job_id =3D=3D NULL?
>
>Yes, it should document the restrictions of the job_id parameter.
>
>Berto
>

--5qscq2coteceqsta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmcB/4ACgkQc2J8L2kN
9xAOHg/+N+8ccSpG4mmO3GhfQjH46Zb4aH5PwYWylI/x9LMQ8G1HLwaSDBoYDBQY
Qal9kkgBviZb+X1kW9rFu8dvEUONSmCiRkYn9Z2B1UnkpXu7F9ek/0N7AjCrApn8
a6WtjvEOktTm0r1t+oUwO9okWI1sahLhbXvMsktMH9NMc93DeNxhd82HxzWAoQ1V
DiZ8I3ZKalazD0a8G71WMNWOm/kMUbnYvoccQjlg+bCR4WRxlbO2B3VukVxGHy1y
2HwNQrT+DaO7/qtvFf77Z1m5/fw2r6WTxIhHfjpqSxDy4bnkkCN86J9o7C7wIxCh
P4LxiBFBjd9cd4R2dkW2cGkyMP9iJy2boeP76l+NlYDmyuVsC1T76Lxyju8YYhYK
z2lZW6WTyIhfXUtvNd5rx2Wk/d1TZXV4dW0V7FHsEkMoSmKaGyVxO5pqY97IKr/c
Ye12hFowJ3V8hCran75i0PNYsBXxVUPKWFdrUXuH7tkDrmc6FuvGTOTAnpyHAr4+
Y30nMy8VBSyQEwm9TBZVuH98IZ3RH1eywImsXbjGl574wrZ+oY7+nj6wjgnGEPFr
u0Yv/DVcuNNgP+ky0SnYBk3YlHycTiKshtCyGccakeVdWCXYkDoK9x9TEV7XL0Rz
OxP6Bnocb51wKZFTBnvywsurqVTYkDuyrG3oARlKChdgP6D87oY=
=lNWW
-----END PGP SIGNATURE-----

--5qscq2coteceqsta--
