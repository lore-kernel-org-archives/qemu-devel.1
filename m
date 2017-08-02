Received: from eggs.gnu.org ([2001:4830:134:3::10]:53176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcr01-0005Fp-0V
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcqzz-0005YZ-Ty
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:35:33 -0400
Date: Wed, 2 Aug 2017 13:34:46 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170802103446.cwpcjzhnrc5mbd6b@postretch>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-4-el13635@mail.ntua.gr>
	<20170802100724.GD5531@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dil272icdj2upp7f"
Content-Disposition: inline
In-Reply-To: <20170802100724.GD5531@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--dil272icdj2upp7f
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 11:07:24AM +0100, Stefan Hajnoczi wrote:
>On Tue, Aug 01, 2017 at 04:49:07PM +0300, Manos Pitsidianakis wrote:
>> diff --git a/block.c b/block.c
>> index 9ebdba28b0..c6aad25286 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1975,6 +1975,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState=
 *child_bs,
>>      child =3D g_new(BdrvChild, 1);
>>      *child =3D (BdrvChild) {
>>          .bs             =3D NULL,
>> +        .parent_bs      =3D NULL,
>>          .name           =3D g_strdup(child_name),
>>          .role           =3D child_role,
>>          .perm           =3D perm,
>> @@ -2009,6 +2010,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *par=
ent_bs,
>>      if (child =3D=3D NULL) {
>>          return NULL;
>>      }
>> +    child->parent_bs =3D parent_bs;
>>
>>      QLIST_INSERT_HEAD(&parent_bs->children, child, next);
>>      return child;
>> @@ -3729,6 +3731,12 @@ const char *bdrv_get_parent_name(const BlockDrive=
rState *bs)
>>                  return name;
>>              }
>>          }
>> +        if (c->parent_bs && c->parent_bs->implicit) {
>> +            name =3D bdrv_get_parent_name(c->parent_bs);
>> +            if (name && *name) {
>> +                return name;
>> +            }
>> +        }
>>      }
>>
>>      return NULL;
>
>This should be a separate patch.
>
>Who updates parent_bs if the parent is changed (e.g.
>bdrv_replace_node())?
>
>We already have bs->parents.  Why is BdrvChild->parent_bs needed?
>

If I haven't misunderstood this, BdrvChild holds only the child part of=20
the parent-child relationship and there's no way to access a parent from=20
bs->parents. bdrv_replace_node() will thus only replace the child part=20
in BdrvChild from the aspect of the parent. In the old child bs's=20
perspective, one of the nodes of bs->parents is removed and in the new=20
child bs's perspective a new node in bs->parents was inserted. parent_bs=20
thus remains immutable.

child->parent_bs is needed in this patch because in jobs if a job-ID is=20
not specified the parent name is used, but this fails if the parent is=20
an implicit node instead of BlockBackend and causes a regression=20
(certain job setups suddenly need an explicit job ID instead of just=20
working).

>> -void blk_io_limits_disable(BlockBackend *blk)
>> +void blk_io_limits_disable(BlockBackend *blk, Error **errp)
>>  {
>> -    assert(blk->public.throttle_group_member.throttle_state);
>> -    bdrv_drained_begin(blk_bs(blk));
>
>Is it safe to drop drained_begin?  We must ensure that no I/O requests
>run during this function.

Thanks, I will put it back in.

>> -    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
>> -    bdrv_drained_end(blk_bs(blk));
>> +    BlockDriverState *bs, *throttle_node;
>> +
>> +    throttle_node =3D blk_get_public(blk)->throttle_node;
>
>Is blk_get_public() still necessary?  Perhaps we can do away with the
>concept of the public struct now.  It doesn't need to be done in this
>patch though.

I can include a patch to move throttle_node to BlockBackend and remove=20
all BlockBackendPublic code, is that okay?

>
>> +
>> +    assert(throttle_node && throttle_node->refcnt =3D=3D 1);
>
>Are you sure the throttle_node->refcnt =3D=3D 1 assertion holds?  For
>example, does the built-in NBD server have a reference to the throttle
>node if nbd-server-add is called after throttling has been enabled?
>
>Since we have the blk->throttle_node pointer we know we're the owner.
>Others may be using the node too but we may choose to remove it at any
>time.

Hm.. If that's possible I guess we want the removal to be visible to the=20
nbd server too. I will use bdrv_replace_node() instead.

--dil272icdj2upp7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmBqsYACgkQc2J8L2kN
9xC2Sw//b0xcMIo5spFik5GQ8lkFg6Vrc4rFdCrlw7YYxocZkfMSr59MXVC6lt6A
OW+O1eYTBpHzVWV+Q3QSvnV5lKLGBSmx5ETX0xa0OvqMZ4zEMjhZysNKx9a8bMyJ
KhZ53C6D6oxEOYmMhD14S6DR6I1PNfd3pkFpCFTb9IG0jDG+WxggaLz3+W9VpbQo
jS/4CMeqB7DMQ2q1RYcRWy+AUhftDEtSwlPYC4LEYs3psI0z8lAIrjah16kzkN2E
ubtxMFIVCDQRfP22PGTmPghD26LeCXd4yx0LiSJK0EI055xLBUMQXcIdTKVx5JFb
YqmpuVK840YJ3ksNgbJXNsomFGcVjCFjk/7av2qJtpBQnWG+cMBrLmBrvPZWogQd
smkvL2nHAEC/5FZV6NbDnp6mOJTJDxwshCHNUZVp+hYqfhrcM1sKIXMMtUGvrxNn
f+NhqTfQmvzFPdm2pOIxpkA4OG4Ejsv/wrVoOQGmudiwnO97r8DEKoYqAde99hEY
9ie5isSQnFR6TjY/KxbSFZBodw2uc90nEhSpMijXONpaBl8LzdILnBfZnjmN4zlh
WrHxsJ3AtFq4pcYbS9A0i7U4SYEsEQCuK0LP0D5bU9Ng3zlvulUZR2SJADggLRzE
aZmXRMw7F/Oz7NixIwAWBx5fQj1ngR+cmPmDyD/I9g/yHRouzCU=
=c5Sa
-----END PGP SIGNATURE-----

--dil272icdj2upp7f--
