Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD78C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F26F208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F26F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6KCW-0008Hw-GW
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6KBV-0007iO-DL
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6KBT-0004AD-VD
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:46:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i6KBO-00047j-Q5; Fri, 06 Sep 2019 15:46:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AED37C04D312;
 Fri,  6 Sep 2019 19:46:09 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ACCD194BB;
 Fri,  6 Sep 2019 19:46:07 +0000 (UTC)
Message-ID: <df8809e370526d5c0eb7987268c185b147855d07.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 06 Sep 2019 22:46:06 +0300
In-Reply-To: <3ac8c65d-4bca-372c-d863-1f794292f5cb@redhat.com>
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-3-mlevitsk@redhat.com>
 <3ac8c65d-4bca-372c-d863-1f794292f5cb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 06 Sep 2019 19:46:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] block/qcow2: fix the corruption when
 rebasing luks encrypted files
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

On Fri, 2019-09-06 at 14:17 -0500, Eric Blake wrote:
> On 9/6/19 12:32 PM, Maxim Levitsky wrote:
> > This fixes subltle corruption introduced by luks threaded encryption
> 
> subtle

I usually put the commit messages to a spellchecker, but this time
I forgot to do this. I will try not to in the future.

> 
> > in commit 8ac0f15f335
> > 
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1745922
> > 
> > The corruption happens when we do
> >    * write to two or more unallocated clusters at once
> >    * write doesn't fully cover nether first nor last cluster
> 
> s/nether/neither/
> 
> or even:
> 
> write doesn't fully cover either the first or the last cluster
I think I didn't wrote the double negative correctly here.
I meant a write that doesn't cover first sector fully and doesn't cover second sector.
I'll just write it like that I guess.

> 
> > 
> > In this case, when allocating the new clusters we COW both area
> 
> areas
> 
> > prior to the write and after the write, and we encrypt them.
> > 
> > The above mentioned commit accidently made it so, we encrypt the
> 
> accidentally
> 
> s/made it so, we encrypt/changed the encryption of/
> 
> > second COW are using the physical cluster offset of the first area.
> 
> s/are using/to use/
I actually meant to write 'area' here. I just haven't proofed the commit
message at all I confess. Next time I do better.

> 
> > 
> > Fix this by:
> >  * remove the offset_in_cluster parameter of do_perform_cow_encrypt
> >    since it is misleading. That offset can be larger that cluster size.
> >    instead just add the start and end COW are offsets to both host and guest offsets
> >    that do_perform_cow_encrypt receives.
> > 
> > *  in do_perform_cow_encrypt, remove the cluster offset from the host_offset
> >    And thus pass correctly to the qcow2_co_encrypt, the host cluster offset and full guest offset
> > 
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/qcow2-cluster.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> > 
> > +++ b/block/qcow2-cluster.c
> > @@ -463,20 +463,20 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
> >  }
> >  
> >  static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
> > -                                                uint64_t guest_cluster_offset,
> > -                                                uint64_t host_cluster_offset,
> > -                                                unsigned offset_in_cluster,
> > +                                                uint64_t guest_offset,
> > +                                                uint64_t host_offset,
> >                                                  uint8_t *buffer,
> >                                                  unsigned bytes)
> >  {
> >      if (bytes && bs->encrypted) {
> >          BDRVQcow2State *s = bs->opaque;
> > -        assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
> > +        assert((guest_offset & ~BDRV_SECTOR_MASK) == 0);
> > +        assert((host_offset & ~BDRV_SECTOR_MASK) == 0);
> >          assert((bytes & ~BDRV_SECTOR_MASK) == 0);
> 
> Pre-existing, but we could use QEMU_IS_ALIGNED(x, BDRV_SECTOR_SIZE) for
> slightly more legibility than open-coding the bit operation.
> 
> Neat trick about power-of-2 alignment checks:
> 
> assert(QEMU_IS_ALIGNED(offset_in_cluster | guest_offset |
>                        host_offset | bytes, BDRV_SECTOR_SIZE));

In my book, a shorter code is almost always better, so why not.
> 
> gives the same result in one assertion.  (I've used it elsewhere in the
> code base, but I'm not opposed to one assert per variable if you think
> batching is too dense.)
> 
> I'll let Dan review the actual code change, but offhand it makes sense
> to me.
> 

Best regards,
	Thanks for the review,
		Maxim Levitsky



