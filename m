Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A75C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0D72074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adKharob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0D72074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k018V-0000za-ME
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k017l-0000OQ-Dv
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:16:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k017j-0006Vy-0f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595848609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IjlVSEhMS1UDFr7AOo7U2Fy65Tnp7jv0c2Fbs1lFHIE=;
 b=adKharobioNv/Jv51HcE2ymZOPkNNJQ9yCF6rIVT4BZyiifY4A7wjrvfAJmGoXFWIKbiuw
 8cG3CAN60HaNiIrecxxm1Rvgs2X4c2n9torTWB4hOUdZZb939wA0ZFM1Qh/RY+DATaSGZ8
 rP4WkKy6O6x/+yTqwy07PFyejj2ffZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-BO9vF3fcNXu4A22xFSBgvg-1; Mon, 27 Jul 2020 07:16:46 -0400
X-MC-Unique: BO9vF3fcNXu4A22xFSBgvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBAC810B36E0;
 Mon, 27 Jul 2020 11:16:44 +0000 (UTC)
Received: from work-vm (ovpn-114-135.ams2.redhat.com [10.36.114.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E7310013D7;
 Mon, 27 Jul 2020 11:16:39 +0000 (UTC)
Date: Mon, 27 Jul 2020 12:16:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 15/21] migration/block-dirty-bitmap: relax error
 handling in incoming part
Message-ID: <20200727111636.GJ3040@work-vm>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-16-vsementsov@virtuozzo.com>
 <35252620-8a4e-9440-f647-6b15d697365f@redhat.com>
 <685495bd-83a6-6a2a-7ae6-9632e432e771@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <685495bd-83a6-6a2a-7ae6-9632e432e771@virtuozzo.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 quintela@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, andrey.shinkevich@virtuozzo.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 24.07.2020 20:35, Eric Blake wrote:
> > On 7/24/20 3:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > Bitmaps data is not critical, and we should not fail the migration (or
> > > use postcopy recovering) because of dirty-bitmaps migration failure.
> > > Instead we should just lose unfinished bitmaps.
> > > 
> > > Still we have to report io stream violation errors, as they affect the
> > > whole migration stream.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > ---
> > >   migration/block-dirty-bitmap.c | 152 +++++++++++++++++++++++++--------
> > >   1 file changed, 117 insertions(+), 35 deletions(-)
> > > 
> > 
> > > @@ -650,15 +695,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
> > >       if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
> > >           trace_dirty_bitmap_load_bits_zeroes();
> > > -        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
> > > -                                             false);
> > > +        if (!s->cancelled) {
> > > +            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
> > > +                                                 nr_bytes, false);
> > > +        }
> > >       } else {
> > >           size_t ret;
> > >           uint8_t *buf;
> > >           uint64_t buf_size = qemu_get_be64(f);
> > 
> > Pre-existing, but if I understand, we are reading a value from the migration stream...
> 
> Hmm, actually, this becomes worse after patch, as before patch we had the check, that the size at least corresponds to the bitmap.. But we want to relax things in cancelled mode (and we may not have any bitmap). Most correct thing is to use read in a loop to just skip the data from stream if we are in cancelled mode (something like nbd_drop()).
> 
> I can fix this with a follow-up patch.

If the size is bogus, it's probably not worth trying to skip anything
because it could be just a broken/misaligned stream.

Dave

> > 
> > > -        uint64_t needed_size =
> > > -            bdrv_dirty_bitmap_serialization_size(s->bitmap,
> > > -                                                 first_byte, nr_bytes);
> > > +        uint64_t needed_size;
> > > +
> > > +        buf = g_malloc(buf_size);
> > > +        ret = qemu_get_buffer(f, buf, buf_size);
> > 
> > ...and using it to malloc memory.  Is that a potential risk of a malicious stream causing us to allocate too much memory in relation to the guest's normal size?  If so, fixing that should be done separately.
> > 
> > I'm not a migration expert, but the patch looks reasonable to me.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > 
> 
> 
> -- 
> Best regards,
> Vladimir
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


