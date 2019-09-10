Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DD8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7A12084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7A12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fNH-0008S7-SL
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7fJE-0006Oo-BR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7fJC-0007O0-KZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7fJ8-0007ME-4Z; Tue, 10 Sep 2019 08:31:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EBB0191C2CB;
 Tue, 10 Sep 2019 12:31:41 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EE1E5C21E;
 Tue, 10 Sep 2019 12:31:39 +0000 (UTC)
Message-ID: <dd0b472186f651823a3ba7a74111a8361235109a.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Date: Tue, 10 Sep 2019 15:31:38 +0300
In-Reply-To: <7634baef-f42f-4603-2ec9-3f4aa6cfe278@virtuozzo.com>
References: <20190906195750.17651-1-mlevitsk@redhat.com>
 <20190906195750.17651-2-mlevitsk@redhat.com>
 <7634baef-f42f-4603-2ec9-3f4aa6cfe278@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 10 Sep 2019 12:31:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block/qcow2: refactoring of
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
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2019-09-07 at 19:08 +0000, Vladimir Sementsov-Ogievskiy wrote:
> 06.09.2019 22:57, Maxim Levitsky wrote:
> > This commit tries to clarify few function arguments,
> > and add comments describing the encrypt/decrypt interface
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >   block/qcow2-cluster.c | 10 +++----
> >   block/qcow2-threads.c | 61 ++++++++++++++++++++++++++++++++++---------
> >   2 files changed, 53 insertions(+), 18 deletions(-)
> > 
> > diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> > index f09cc992af..1989b423da 100644
> > --- a/block/qcow2-cluster.c
> > +++ b/block/qcow2-cluster.c
> > @@ -463,8 +463,8 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
> >   }
> >   
> >   static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
> > -                                                uint64_t src_cluster_offset,
> > -                                                uint64_t cluster_offset,
> > +                                                uint64_t guest_cluster_offset,
> > +                                                uint64_t host_cluster_offset,
> >                                                   unsigned offset_in_cluster,
> >                                                   uint8_t *buffer,
> >                                                   unsigned bytes)
> > @@ -474,8 +474,8 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
> >           assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
> >           assert((bytes & ~BDRV_SECTOR_MASK) == 0);
> >           assert(s->crypto);
> > -        if (qcow2_co_encrypt(bs, cluster_offset,
> > -                             src_cluster_offset + offset_in_cluster,
> > +        if (qcow2_co_encrypt(bs, host_cluster_offset,
> > +                             guest_cluster_offset + offset_in_cluster,
> >                                buffer, bytes) < 0) {
> >               return false;
> >           }
> > @@ -496,7 +496,7 @@ static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
> >       }
> >   
> >       ret = qcow2_pre_write_overlap_check(bs, 0,
> > -            cluster_offset + offset_in_cluster, qiov->size, true);
> > +              cluster_offset + offset_in_cluster, qiov->size, true);
> 
> 
> Hmm, unrelated hunk.

I was asked to do this to fix coding style, so that wrapped line,
is 4 characters shifted to the right.

> 
> >       if (ret < 0) {
> >           return ret;
> >       }
> > diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> > index 3b1e63fe41..c3cda0c6a5 100644
> > --- a/block/qcow2-threads.c
> > +++ b/block/qcow2-threads.c
> > @@ -234,15 +234,19 @@ static int qcow2_encdec_pool_func(void *opaque)
> >   }
> >   
> >   static int coroutine_fn
> > -qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFunc func)
> > +qcow2_co_encdec(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                uint64_t guest_offset, void *buf, size_t len,
> > +                Qcow2EncDecFunc func)
> >   {
> >       BDRVQcow2State *s = bs->opaque;
> > +
> > +    uint64_t offset = s->crypt_physical_offset ?
> > +        host_cluster_offset + offset_into_cluster(s, guest_offset) :
> > +        guest_offset;
> > +
> >       Qcow2EncDecData arg = {
> >           .block = s->crypto,
> > -        .offset = s->crypt_physical_offset ?
> > -                      file_cluster_offset + offset_into_cluster(s, offset) :
> > -                      offset,
> > +        .offset = offset,
> >           .buf = buf,
> >           .len = len,
> >           .func = func,
> > @@ -251,18 +255,49 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> >       return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
> >   }
> >   
> > +
> > +/*
> > + * qcow2_co_encrypt()
> > + *
> > + * Encrypts one or more contiguous aligned sectors
> > + *
> > + * @host_cluster_offset - on disk offset of the first cluster in which
> > + * the encrypted data will be written
> 
> 
> It's not quite right, it's not on disk, but on .file child of qcow2 node, which
> may be any other format or protocol node.. So, I called it file_cluster_offset.
> But I'm OK with new naming anyway. And it may be better for encryption related
> logic..

Yes, the .file is the underlying storage for both qcow2 metadata and the data,
and it is unlikely be another qcow2 file. Usually it will be a raw file,
accessed with some protocol.
I will change the wording to not include the 'disk' word though.


To be really honest, the best naming here would be one that follows the virtual memory concepts.
A virtual block/cluster address and a physical block/cluster address.
However we talked with Kevin recently and I also studied quite a lot of qcow2 code,
and the usual convention is guest cluster offset and host cluster offset,
and often guest offsets are just called offsets, which is very confusing IMHO.


> 
>  > + * Used as an initialization vector for encryption
> 
> Hmm, is it default now?


Most of block crypto implementations have IV which derive
some way or another from the sector address.

From what I see, the block address is either used as is,
or encrypted itself with same encryption key,
and the result is used as IV. Even the legacy qcow
encryption uses this, although it uses the virtual block
address, and apparently this is one of its security flaws.

If you don't use any IV, you end up with major security
hole - sectors of the same content will be encrypted
to the same cipertext.

I added this comment to clarify the usage of offset,
since other that this aspect of IV generation, 
the crypto routines only need the data to be encrypted and 
the encryption key which is stored in the crypto context.


> 
> > + *
> > + * @guest_offset - guest (virtual) offset of the first sector of the
> > + * data to be encrypted
> 
> Hmm, stop. It's wrong. Data to be encrypted is in buffer, so, it's not first sector of
> the data to be encrypted, but first sector in which guest writes data (to be encrypted
> in meantime).
No no no!

guest_offset is literally the guest's disk address of the first sector that is in the buffer.
The qcow2_co_encrypt is called from 2 places:

1. qcow2_co_pwritev_part - here indeed the actually guest written data
is encrypted, and the 'offset' is passed which is the offset on which pwritev was called


2. do_perform_cow_encrypt - here the just read data from before or after actually written guest
data is encrypted, and the guest_offset represents the address of that data.
I changed the do_perform_cow_encrypt, so that it receives from the caller the host and guest offset
of the data to be encrypted. It then aligns the host offset on start of the cluster, and passes
the guest offset as is, so that it does the same as qcow2_co_pwritev_part.


So what is wrong here?

>  
> 
> > + * Used as an initialization vector for older, qcow2 native encryption
> > + *
> > + * @buf - buffer with the data to encrypt
> > + * @len - length of the buffer (in sector size multiplies)
> > + *
> > + * Note that the group of the sectors, don't have to be aligned
> > + * on cluster boundary and can also cross a cluster boundary.
> 
> And I doubt in it now. I'm afraid that if we call qcow2_co_encrypt for a group
> of the sectors crossing a cluster boundary, we will finish up with similar bug: we'll
> use first cluster offset as a vector for all the sectors. We still never do it.. So,
> I think it worth assertion and corresponding comment.
> 
> Or is it correct?

Crypto code receives the data to be encrypted and decrypted,
and offset of first sector (512 bytes aligned) of that data (for IV calculation).
If the data spans multiple sectors (this happens already a lot) 
then it able to handle this since the code works.
The relevant code is in do_qcrypto_block_cipher_encdec, and
is actually generic for all the crypto modes.

So there should not be anything special about crossing the cluster
boundary, other that noting this here, just in case.

No only that code can cross a cluster boundary, but it can even be
called for more that one cluster at once. It looks like qcow2 code limits all
the IO in case crypto is used to QCOW_MAX_CRYPT_CLUSTERS, which is 32
currently. I don't know why to be honest.

Remember that crypto code has no notion of clusters. It works purely
on sector (512 bytes) level, and each sector will have its own IV calculated,
based on its sector address.

> 
> > + *
> > + *
> > + */
> >   int coroutine_fn
> > -qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len)
> > +qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len)
> >   {
> > -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> > -                             qcrypto_block_encrypt);
> > +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf, len,
> > +                           qcrypto_block_encrypt);
> >   }
> >   
> > +
> > +/*
> > + * qcow2_co_decrypt()
> > + *
> > + * Decrypts one or more contiguous aligned sectors
> > + * Same function as qcow2_co_encrypt
> 
> Hmm, not exactly same :)
I'll fix that.


> 
> > + *
> > + */
> > +
> >   int coroutine_fn
> > -qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len)
> > +qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len)
> >   {
> > -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> > -                             qcrypto_block_decrypt);
> > +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf, len,
> > +                           qcrypto_block_decrypt);
> >   }
> > 
> 


Best regards,
	Thanks for the review,
		Maxim Levitsky

> 
> -- 
> Best regards,
> Vladimir



