Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308FBC4CEC8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5572206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5572206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8qBG-0001qd-0i
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 14:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8qAU-0001DA-Vh
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8qAT-0000cu-C7
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:19:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8qAO-0000au-4F; Fri, 13 Sep 2019 14:19:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A2B6307CDEA;
 Fri, 13 Sep 2019 18:19:31 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 676C45D9C3;
 Fri, 13 Sep 2019 18:19:29 +0000 (UTC)
Message-ID: <51f8e8ba359602a8b9056e5800a97b29ec19cd29.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Date: Fri, 13 Sep 2019 21:19:28 +0300
In-Reply-To: <63f11a7a-44a6-9556-063b-3d762a6e9293@virtuozzo.com>
References: <20190913172741.5662-1-mlevitsk@redhat.com>
 <20190913172741.5662-3-mlevitsk@redhat.com>
 <63f11a7a-44a6-9556-063b-3d762a6e9293@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 13 Sep 2019 18:19:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 2/3] block/qcow2: refactor threaded
 encryption code
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
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-13 at 17:51 +0000, Vladimir Sementsov-Ogievskiy wrote:
> 13.09.2019 20:27, Maxim Levitsky wrote:
> > Change the qcow2_co_encrypt to just receive full host and
> > guest offsets and in pariticular remove the
> > offset_in_cluster parameter of do_perform_cow_encrypt,
> > since it is misleading, because that offset can be larger than
> > cluster size currently.
> > 
> > Remove the do_perform_cow_encrypt by merging it with
> > qcow2_co_encrypt
> > 
> > Also document the qcow2_co_encrypt arguments to prevent
> > that bug from happening again
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >   block/qcow2-cluster.c | 35 +++++--------------
> >   block/qcow2-threads.c | 81 ++++++++++++++++++++++++++++++++++++-------
> >   block/qcow2.c         |  5 +--
> >   block/qcow2.h         |  8 ++---
> >   4 files changed, 83 insertions(+), 46 deletions(-)
> > 
> > diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> > index bfeb0241d7..f42b8a404c 100644
> > --- a/block/qcow2-cluster.c
> > +++ b/block/qcow2-cluster.c
> > @@ -462,28 +462,6 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
> >       return 0;
> >   }
> >   
> > -static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
> > -                                                uint64_t src_cluster_offset,
> > -                                                uint64_t cluster_offset,
> > -                                                unsigned offset_in_cluster,
> > -                                                uint8_t *buffer,
> > -                                                unsigned bytes)
> > -{
> > -    if (bytes && bs->encrypted) {
> > -        BDRVQcow2State *s = bs->opaque;
> > -        assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
> > -        assert((bytes & ~BDRV_SECTOR_MASK) == 0);
> > -        assert(s->crypto);
> > -        if (qcow2_co_encrypt(bs,
> > -                start_of_cluster(s, cluster_offset + offset_in_cluster),
> > -                src_cluster_offset + offset_in_cluster,
> > -                buffer, bytes) < 0) {
> > -            return false;
> > -        }
> > -    }
> > -    return true;
> > -}
> > -
> >   static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
> >                                                uint64_t cluster_offset,
> >                                                unsigned offset_in_cluster,
> > @@ -891,11 +869,14 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
> >   
> >       /* Encrypt the data if necessary before writing it */
> >       if (bs->encrypted) {
> > -        if (!do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
> > -                                    start->offset, start_buffer,
> > -                                    start->nb_bytes) ||
> > -            !do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
> > -                                    end->offset, end_buffer, end->nb_bytes)) {
> > +        if (!qcow2_co_encrypt(bs,
> > +                              m->offset + start->offset,
> > +                              m->alloc_offset + start->offset,
> > +                              start_buffer, start->nb_bytes) ||
> 
> You got caught)

Ha!, I am just too tired.

> second argument qcow2_co_encrypt is host_offset and third is guest_offset.
> 
> I noticed this difference when reviewing previous version, and it's actually
> additional reason to drop the function. Unfortunately, I didn't said.
> 
> Also, we can use return value of qcow2_co_encrypt instead of dropping it,
> 
> something like classical
> 
> ret = qcow2_co_encrypt(..)
> if (ret < 0) {
>     goto fail;
> }
> 
> ret = qcow2_co_encrypt(..)
> if (ret < 0) {
>     goto fail;
> }
> 
> Also, IMHO, too much changes too keep reviewed-by mark. Still, maybe it's my
> "with it least fixed" is misleading, may be interpreted like removing the
> function and corresponding refactoring is included..
Yea. So V7 there will be...
Re-factoring is hard (but worth it) :-(

> 
> 
> > +            !qcow2_co_encrypt(bs,
> > +                              m->offset + end->offset,
> > +                              m->alloc_offset + end->offset,
> > +                              end_buffer, end->nb_bytes)) {
> >               ret = -EIO;
> >               goto fail;
> >           }
> > diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> > index 3b1e63fe41..b31d45fb2b 100644
> > --- a/block/qcow2-threads.c
> > +++ b/block/qcow2-threads.c
> > @@ -234,15 +234,15 @@ static int qcow2_encdec_pool_func(void *opaque)
> >   }
> >   
> >   static int coroutine_fn
> > -qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFunc func)
> > +qcow2_co_encdec(BlockDriverState *bs, uint64_t host_offset,
> > +                uint64_t guest_offset, void *buf, size_t len,
> > +                Qcow2EncDecFunc func)
> >   {
> >       BDRVQcow2State *s = bs->opaque;
> > +
> >       Qcow2EncDecData arg = {
> >           .block = s->crypto,
> > -        .offset = s->crypt_physical_offset ?
> > -                      file_cluster_offset + offset_into_cluster(s, offset) :
> > -                      offset,
> > +        .offset = s->crypt_physical_offset ? host_offset : guest_offset,
> >           .buf = buf,
> >           .len = len,
> >           .func = func,
> > @@ -251,18 +251,73 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> >       return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
> >   }
> >   
> > +
> > +/*
> > + * qcow2_co_encrypt()
> > + *
> > + * Encrypts one or more contiguous aligned sectors
> > + *
> > + * @host_offset - underlying storage offset of the first sector of the
> > + * data to be encrypted
> > + *
> > + * @guest_offset - guest (virtual) offset of the first sector of the
> > + * data to be encrypted
> > + *
> > + * @buf - buffer with the data to encrypt, that after encryption
> > + *        will be written to the underlying storage device at
> > + *        @host_offset
> > + *
> > + * @len - length of the buffer (must be a BDRV_SECTOR_SIZE multiple)
> > + *
> > + * Depending on the encryption method, @host_offset and/or @guest_offset
> > + * may be used for generating the initialization vector for
> > + * encryption.
> > + *
> > + * Note that while the whole range must be aligned on sectors, it
> > + * does not have to be aligned on clusters and can also cross cluster
> > + * boundaries
> > + */
> >   int coroutine_fn
> > -qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len)
> > +qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len)
> >   {
> > -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> > -                             qcrypto_block_encrypt);
> > +
> > +    BDRVQcow2State *s = bs->opaque;
> > +    assert(QEMU_IS_ALIGNED(guest_offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(host_offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(len, BDRV_SECTOR_SIZE));
> > +    assert(s->crypto);
> 
> Hmm, better to move these asertions to _encdec I think, and don't duplicate
> them in two functions.

OK.

> 
> > +
> > +    if (!len) {
> > +        return 0;
> > +    }
> 
> Aha, that's why you don't check this in perform_cow. That's OK,
> but still, better keep it in _encdec and don't duplicate.


OK.

> 
> > +
> > +    return qcow2_co_encdec(bs, host_offset, guest_offset, buf, len,
> > +                           qcrypto_block_encrypt);
> >   }
> >   
> > +
> > +/*
> > + * qcow2_co_decrypt()
> > + *
> > + * Decrypts one or more contiguous aligned sectors
> > + * Similar to qcow2_co_encrypt
> > + */
> > +
> >   int coroutine_fn
> > -qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len)
> > +qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len)
> >   {
> > -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> > -                             qcrypto_block_decrypt);
> > +    BDRVQcow2State *s = bs->opaque;
> > +    assert(QEMU_IS_ALIGNED(guest_offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(host_offset, BDRV_SECTOR_SIZE));
> > +    assert(QEMU_IS_ALIGNED(len, BDRV_SECTOR_SIZE));
> > +    assert(s->crypto);
> > +
> > +    if (!len) {
> > +        return 0;
> > +    }
> > +
> > +    return qcow2_co_encdec(bs, host_offset, guest_offset, buf, len,
> > +                           qcrypto_block_decrypt);
> >   }
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 57734f20cf..ac768092bb 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -2069,7 +2069,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
> >   
> >                   assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> >                   assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> > -                if (qcow2_co_decrypt(bs, cluster_offset, offset,
> > +                if (qcow2_co_decrypt(bs, cluster_offset + offset_in_cluster,
> > +                                     offset,
> >                                        cluster_data, cur_bytes) < 0) {
> >                       ret = -EIO;
> >                       goto fail;
> > @@ -2288,7 +2289,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
> >               qemu_iovec_to_buf(qiov, qiov_offset + bytes_done,
> >                                 cluster_data, cur_bytes);
> >   
> > -            if (qcow2_co_encrypt(bs, cluster_offset, offset,
> > +            if (qcow2_co_encrypt(bs, cluster_offset + offset_in_cluster, offset,
> >                                    cluster_data, cur_bytes) < 0) {
> >                   ret = -EIO;
> >                   goto out_unlocked;
> > diff --git a/block/qcow2.h b/block/qcow2.h
> > index 998bcdaef1..a488d761ff 100644
> > --- a/block/qcow2.h
> > +++ b/block/qcow2.h
> > @@ -758,10 +758,10 @@ ssize_t coroutine_fn
> >   qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
> >                       const void *src, size_t src_size);
> >   int coroutine_fn
> > -qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len);
> > +qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len);
> >   int coroutine_fn
> > -qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len);
> > +qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len);
> >   
> >   #endif
> > 


Best regards,
	Maxim Levitsky


