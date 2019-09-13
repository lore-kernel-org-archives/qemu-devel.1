Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0A4206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0A4206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lX7-0004lw-Ib
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8lWE-00046U-To
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8lWD-0002CD-Es
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8lWA-00029H-BA; Fri, 13 Sep 2019 09:21:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C5F6882EA;
 Fri, 13 Sep 2019 13:21:41 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 876155D9C3;
 Fri, 13 Sep 2019 13:21:38 +0000 (UTC)
Message-ID: <5da45f0775d5a1cb4cf88e8ba3eac600ca53400a.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:21:37 +0300
In-Reply-To: <abd660bc-5e3c-ec6d-e595-6830e1b6f0d1@redhat.com>
References: <20190912223754.875-1-mlevitsk@redhat.com>
 <20190912223754.875-2-mlevitsk@redhat.com>
 <abd660bc-5e3c-ec6d-e595-6830e1b6f0d1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 13 Sep 2019 13:21:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block/qcow2: refactoring of
 threaded encryption code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-13 at 12:37 +0200, Max Reitz wrote:
> On 13.09.19 00:37, Maxim Levitsky wrote:
> > This commit tries to clarify few function arguments,
> > and add comments describing the encrypt/decrypt interface
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/qcow2-cluster.c |  8 +++---
> >  block/qcow2-threads.c | 63 ++++++++++++++++++++++++++++++++++-------=
--
> >  2 files changed, 54 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> > index f09cc992af..b95e64c237 100644
> > --- a/block/qcow2-cluster.c
> > +++ b/block/qcow2-cluster.c
> > @@ -463,8 +463,8 @@ static int coroutine_fn do_perform_cow_read(Block=
DriverState *bs,
> >  }
> > =20
> >  static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs=
,
> > -                                                uint64_t src_cluster=
_offset,
> > -                                                uint64_t cluster_off=
set,
> > +                                                uint64_t guest_clust=
er_offset,
> > +                                                uint64_t host_cluste=
r_offset,
> >                                                  unsigned offset_in_c=
luster,
> >                                                  uint8_t *buffer,
> >                                                  unsigned bytes)
> > @@ -474,8 +474,8 @@ static bool coroutine_fn do_perform_cow_encrypt(B=
lockDriverState *bs,
> >          assert((offset_in_cluster & ~BDRV_SECTOR_MASK) =3D=3D 0);
> >          assert((bytes & ~BDRV_SECTOR_MASK) =3D=3D 0);
> >          assert(s->crypto);
> > -        if (qcow2_co_encrypt(bs, cluster_offset,
> > -                             src_cluster_offset + offset_in_cluster,
> > +        if (qcow2_co_encrypt(bs, host_cluster_offset,
> > +                             guest_cluster_offset + offset_in_cluste=
r,
> >                               buffer, bytes) < 0) {
> >              return false;
> >          }
> > diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> > index 3b1e63fe41..6da1838e95 100644
> > --- a/block/qcow2-threads.c
> > +++ b/block/qcow2-threads.c
> > @@ -234,15 +234,19 @@ static int qcow2_encdec_pool_func(void *opaque)
> >  }
> > =20
> >  static int coroutine_fn
> > -qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                  uint64_t offset, void *buf, size_t len, Qcow2EncDe=
cFunc func)
> > +qcow2_co_encdec(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                uint64_t guest_offset, void *buf, size_t len,
> > +                Qcow2EncDecFunc func)
> >  {
> >      BDRVQcow2State *s =3D bs->opaque;
> > +
> > +    uint64_t offset =3D s->crypt_physical_offset ?
> > +        host_cluster_offset + offset_into_cluster(s, guest_offset) :
> > +        guest_offset;
> > +
> >      Qcow2EncDecData arg =3D {
> >          .block =3D s->crypto,
> > -        .offset =3D s->crypt_physical_offset ?
> > -                      file_cluster_offset + offset_into_cluster(s, o=
ffset) :
> > -                      offset,
> > +        .offset =3D offset,
> >          .buf =3D buf,
> >          .len =3D len,
> >          .func =3D func,
> > @@ -251,18 +255,51 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t =
file_cluster_offset,
> >      return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
> >  }
> > =20
> > +
> > +/*
> > + * qcow2_co_encrypt()
> > + *
> > + * Encrypts one or more contiguous aligned sectors
> > + *
> > + * @host_cluster_offset - underlying storage offset of the first clu=
ster
> > + * in which the encrypted data will be written
> > + * Used as an initialization vector for encryption
>=20
> s/as an/for generating the/
>=20
> (AFAIU)
Yes, this is better.


>=20
> > + *
> > + * @guest_offset - guest (virtual) offset of the first sector of the
> > + * data to be encrypted
> > + * Used as an initialization vector for older, qcow2 native encrypti=
on
>=20
> I wouldn=E2=80=99t be so specific here.  I think it=E2=80=99d be better=
 to just have a
> common sentence like =E2=80=9CDepending on the encryption method, eithe=
r of
> these offsets may be used for generating the initialization vector for
> encryption.=E2=80=9D
Nothing against this either.


>=20
> Well, technically, host_cluster_offset will not be used itself.  Before
> we can use it, of course we have to add the in-cluster offset to it
> (which qcow2_co_encdec() does).
>=20
> This makes me wonder whether it wouldn=E2=80=99t make more sense to pas=
s a
> host_offset instead of a host_cluster_offset (i.e. make the callers add
> the in-cluster offset to the host offset already)?

This is what I wanted to do in first place, and it would be the cleanest
solution, but that would need to update the 3rd caller of this function,
the qcow2_co_pwritev_part, which does pass the cluster offset and guest f=
ull offset.
You know what, I'll just do it. A bit more changes, but much cleaner code=
 that
eliminates the possibility of this bug of happening again.


>=20
> > + *
> > + * @buf - buffer with the data to encrypt, that after encryption
> > + *        will be written to the underlying storage device at
> > + *        @host_cluster_offset
>=20
> I think just =E2=80=9Cbuffer with the data to encrypt=E2=80=9D is suffi=
cient.  (The rest
> is just the same as above.)
I wrote it to clarify this since Vladimir told me that its not clear enou=
gh.
Note though that I made a mistake here since the data will be written not=
 at
host_cluster_offset but in host_cluster_offset + offset_into_cluster(s, g=
uest_offset


> + * @len - length of the buffer (in sector size multiplies)
>=20
> =E2=80=9CIn sector size multiples=E2=80=9D to me means that it is a sec=
tor count (in
> that =E2=80=9Cone sector size multiple=E2=80=9D is equal to 512 byes).
>=20
> Maybe =E2=80=9Cmust be a BDRV_SECTOR_SIZE multiple=E2=80=9D instead?
All right.

>=20
> > + *
> > + * Note that the group of the sectors, don't have to be aligned
> > + * on cluster boundary and can also cross a cluster boundary.
>=20
> Maybe =E2=80=9CNote that while the whole range must be aligned on secto=
rs, it
> does not have to be aligned on clusters and can also cross cluster
> boundaries=E2=80=9D?
>=20
> (=E2=80=9CThe group of sectors=E2=80=9D sounds a bit weird to me.  I do=
n=E2=80=99t quite know,
> why.  I think that for some reason it makes me think of a non-continuou=
s
> set of sectors.  Also, the caller doesn=E2=80=99t pass sector indices, =
but byte
> offsets, that just happen to have to be aligned to sectors.  (I suppose
> because that=E2=80=99s the simplest way to make it a multiple of the en=
cryption
> block size.))
All right, this sounds better

>=20
> > + *
> > + */
> >  int coroutine_fn
> > -qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len)
> > +qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len)
> >  {
> > -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len=
,
> > -                             qcrypto_block_encrypt);
> > +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, bu=
f, len,
> > +                           qcrypto_block_encrypt);
> >  }
> > =20
> > +
> > +/*
> > + * qcow2_co_decrypt()
> > + *
> > + * Decrypts one or more contiguous aligned sectors
> > + * Similar to qcow2_co_encrypt
>=20
> Hm.  This would make me wonder in what way it is only similar to
> qcow2_co_encrypt().  Sure, it decrypts instead of encrypting, but maybe
> there=E2=80=99s more...?
I don't think so, since we have symmetrical encryption here.

>=20
> So maybe =E2=80=9CIts interface is the same as qcow2_co_encrypt()'s=E2=80=
=9D?
That would be lawyer territory, since interface is not technically the sa=
me,
since it decrypts rather that encrypts the data in the buffer...
I think that this wording should be good enough.


>=20
> Max
>=20
> > + *
> > + */
> > +
> >  int coroutine_fn
> > -qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len)
> > +qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len)
> >  {
> > -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len=
,
> > -                             qcrypto_block_decrypt);
> > +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, bu=
f, len,
> > +                           qcrypto_block_decrypt);
> >  }
> >=20
>=20
>=20


Best regards,
	Maxim Levitsky



