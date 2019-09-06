Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD56C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 18:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A1920838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 18:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A1920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JQT-0001zu-SI
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 14:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6JOH-0008Jr-Hq
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6JOG-0007dG-3r
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:55:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i6JOB-0007YG-3P; Fri, 06 Sep 2019 14:55:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3AFC53060396;
 Fri,  6 Sep 2019 18:55:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C57065D9CA;
 Fri,  6 Sep 2019 18:55:14 +0000 (UTC)
Message-ID: <4dacc6bde5bc87d48f5d3b255a7a44bbded782ef.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 06 Sep 2019 21:55:13 +0300
In-Reply-To: <e7f3febc-63cb-ea09-0761-45ecae74ad14@redhat.com>
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-2-mlevitsk@redhat.com>
 <e7f3febc-63cb-ea09-0761-45ecae74ad14@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 06 Sep 2019 18:55:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] block/qcow2: refactoring of threaded
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-06 at 13:00 -0500, Eric Blake wrote:
> On 9/6/19 12:31 PM, Maxim Levitsky wrote:
> > This commit tries to clarify few function arguments,
> > and add comments describing the encrypt/decrypt interface
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/qcow2-cluster.c |  8 +++----
> >  block/qcow2-threads.c | 53 ++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 46 insertions(+), 15 deletions(-)
> > 
> > +++ b/block/qcow2-threads.c
> > @@ -234,15 +234,19 @@ static int qcow2_encdec_pool_func(void *opaque)
> >  }
> >  
> >  static int coroutine_fn
> > -qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFunc func)
> 
> Pre-existing bug in alignment...
No problem will fix.

> 
> > +qcow2_co_encdec(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                  uint64_t guest_offset, void *buf, size_t len,
> > +                  Qcow2EncDecFunc func)
> 
> ...so this would be a great time to fix it.
> 
> >  {
> >      BDRVQcow2State *s = bs->opaque;
> > +
> > +    uint64_t offset = s->crypt_physical_offset ?
> > +        host_cluster_offset + offset_into_cluster(s, guest_offset) :
> > +        guest_offset;
> > +
> >      Qcow2EncDecData arg = {
> >          .block = s->crypto,
> > -        .offset = s->crypt_physical_offset ?
> > -                      file_cluster_offset + offset_into_cluster(s, offset) :
> > -                      offset,
> > +        .offset = offset,
> 
> I'm ambivalent on whether the new 'offset' variable gains us anything.
> But it doesn't hurt.
I added it, so that I won't need to wrap the lines even more that 
they are wrapped already since I increased the length of
the parameter names a bit.

> 
> 
> >          .buf = buf,
> >          .len = len,
> >          .func = func,
> > @@ -251,18 +255,45 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> >      return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
> >  }
> >  
> > +
> > +/*
> > + * qcow2_co_encrypt()
> > + *
> > + * Encrypts a sector size aligned contiguous area
> > + *
> > + * @host_cluster_offset - on disk offset of the cluster in which
> > + *                        the buffer resides
> > + *
> > + * @guest_offset - guest (virtual) offset of the buffer
> > + * @buf - buffer with the data to encrypt
> > + * @len - length of the buffer
> > + *
> > + * Note that the area is not cluster aligned and might cross a cluster
> > + * boundary
> 
> Umm, how is it possible for a sector to cross a cluster boundary?  All
> clusters are sector-aligned, and encryption only works on aligned
> sectors.  Oh, I see - if @len is a multiple larger than sector size,
> then we have multiple sectors, and then indeed we may cross clusters.
> But then the docs about being 'a sector size aligned contiguous area' is
> not quite right.

Why? the written area is always both aligned on _sector_ boundary
and multiple of the sector size. At least that what I see from
the existing asserts.


> 
> > + *
> > + *
> > + */
> >  int coroutine_fn
> > -qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len)
> > +qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len)
> >  {
> > -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> > +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf, len,
> >                               qcrypto_block_encrypt);
> 
> 
> Another alignment worth fixing up while in the area.
> 
> >  }
> >  
> > +
> > +/*
> > + * qcow2_co_decrypt()
> > + *
> > + * Decrypts a sector size aligned contiguous area
> > + * Same function as qcow2_co_encrypt
> > + *
> > + */
> > +
> >  int coroutine_fn
> > -qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> > -                 uint64_t offset, void *buf, size_t len)
> > +qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> > +                 uint64_t guest_offset, void *buf, size_t len)
> >  {
> > -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> > +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf, len,
> >                               qcrypto_block_decrypt);
> 
> and again.
> 
> >  }
> > 
> 
> 


Best regards,
	Thanks for the review,
		Maxim Levitsky



