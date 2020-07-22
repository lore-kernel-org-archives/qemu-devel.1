Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D17C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09B5206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TB/OuRrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09B5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyIMA-0005N1-5R
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jyILL-0004Nj-U5
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:15:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jyILK-0005O6-4X
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595438145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vVI1hT2smKITjcwWMdqfE1tMWNVOa+Cx+gvmCKoxX+k=;
 b=TB/OuRrLP2Q9pz/M1HBFTnF4kWymKTdnQor4T7RXTBI/tmpuVmmX77g3g2Ou9t6q4V+iB9
 cU1VAa1KHAPbz5U5Xkr+mybdRwV5C8rTRU8Ctdfde7pOmi1aN/7HMzE5ytSYSqCOwPwov5
 PHCU3h4tYztUl1LB67gPhtLIfgWjJKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-U2UaKZo0NHe1Xuh-19If3A-1; Wed, 22 Jul 2020 13:15:43 -0400
X-MC-Unique: U2UaKZo0NHe1Xuh-19If3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C1491DE1;
 Wed, 22 Jul 2020 17:15:42 +0000 (UTC)
Received: from starship (unknown [10.35.206.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3888188D40;
 Wed, 22 Jul 2020 17:15:41 +0000 (UTC)
Message-ID: <c4b88728abb423ce5771b0302559e44c3f0aa24b.camel@redhat.com>
Subject: Re: [PATCH for-5.1 1/2] qcow2: Implement v2 zero writes with
 discard if possible
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 22 Jul 2020 20:15:40 +0300
In-Reply-To: <20200722171456.GC4838@linux.fritz.box>
References: <20200720131810.177978-1-kwolf@redhat.com>
 <20200720131810.177978-2-kwolf@redhat.com>
 <498fc3712cd3a0cb0f6588331c47b5d12b7eac96.camel@redhat.com>
 <20200722171456.GC4838@linux.fritz.box>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-22 at 19:14 +0200, Kevin Wolf wrote:
> Am 22.07.2020 um 19:01 hat Maxim Levitsky geschrieben:
> > On Mon, 2020-07-20 at 15:18 +0200, Kevin Wolf wrote:
> > > qcow2 version 2 images don't support the zero flag for clusters, so for
> > > write_zeroes requests, we return -ENOTSUP and get explicit zero buffer
> > > writes. If the image doesn't have a backing file, we can do better: Just
> > > discard the respective clusters.
> > > 
> > > This is relevant for 'qemu-img convert -O qcow2 -n', where qemu-img has
> > > to assume that the existing target image may contain any data, so it has
> > > to write zeroes. Without this patch, this results in a fully allocated
> > > target image, even if the source image was empty.
> > > 
> > > Reported-by: Nir Soffer <nsoffer@redhat.com>
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  block/qcow2-cluster.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> > > index 4b5fc8c4a7..a677ba9f5c 100644
> > > --- a/block/qcow2-cluster.c
> > > +++ b/block/qcow2-cluster.c
> > > @@ -1797,8 +1797,15 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
> > >      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
> > >             end_offset >= bs->total_sectors << BDRV_SECTOR_BITS);
> > >  
> > > -    /* The zero flag is only supported by version 3 and newer */
> > > +    /*
> > > +     * The zero flag is only supported by version 3 and newer. However, if we
> > > +     * have no backing file, we can resort to discard in version 2.
> > > +     */
> > >      if (s->qcow_version < 3) {
> > > +        if (!bs->backing) {
> > > +            return qcow2_cluster_discard(bs, offset, bytes,
> > > +                                         QCOW2_DISCARD_REQUEST, false);
> > > +        }
> > >          return -ENOTSUP;
> > >      }
> > >  
> > 
> > From my knowelege of nvme, I remember that discard doesn't have to zero the blocks.
> > There is special namespace capability the indicates the contents of the discarded block.
> > (Deallocate Logical Block Features)
> > 
> > If and only if the discard behavier flag indicates that discarded areas are zero,
> > then the write-zero command can have special 'deallocate' flag that hints the controller
> > to discard the sectors.
> > 
> > So woudn't discarding the clusters have theoretical risk of introducing garbage there?
> 
> No, qcow2_cluster_discard() has a defined behaviour. For v2 images, it
> unallocates the cluster in the L2 table (this is only safe without a
> backing file), for v3 images it converts them to zero clusters.

All right then!

Best regards,
	Maxim Levitsky
> 
> Kevin



