Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AAE2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZHoETHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AAE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03DX-0006qn-6v
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k03Cd-0005Zy-Tx
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:30:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k03Cc-0007N9-5v
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595856601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weR4nr05wN7hv1v9UD8G1JBEAt5MHKsXZH8J002YOhI=;
 b=AZHoETHLpOMMTF456l4+jlkdvMiHhJiKm5vmIPh94+2P1u/Ye2NbFjysozXvAQQwqwNukp
 35KNV7OQSReI7xAlxiq+LNn9DsiaBw+yvLakCqpJYXK0UYDsq3qKvhL2QGEbHt04jNXOP8
 J56HjZPKty7mObz7JDIcG2Y/Q4d4AEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-51XNWIKJNvqNI_feuN5RbQ-1; Mon, 27 Jul 2020 09:29:56 -0400
X-MC-Unique: 51XNWIKJNvqNI_feuN5RbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8271C79EC4;
 Mon, 27 Jul 2020 13:29:55 +0000 (UTC)
Received: from work-vm (ovpn-114-135.ams2.redhat.com [10.36.114.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A6C919724;
 Mon, 27 Jul 2020 13:29:45 +0000 (UTC)
Date: Mon, 27 Jul 2020 14:29:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 17/21] migration/savevm: don't worry if bitmap
 migration postcopy failed
Message-ID: <20200727132943.GN3040@work-vm>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-18-vsementsov@virtuozzo.com>
 <f44f62e8-6ed0-1cec-1a89-eebd6c1b5687@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f44f62e8-6ed0-1cec-1a89-eebd6c1b5687@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: kwolf@redhat.com, fam@euphon.net,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 7/24/20 3:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> > First, if only bitmaps postcopy enabled (not ram postcopy)
> 
> is enabled (and not ram postcopy),
> 
> > postcopy_pause_incoming crashes on assertion assert(mis->to_src_file).
> 
> on an
> 
> > 
> > And anyway, bitmaps postcopy is not prepared to be somehow recovered.
> > The original idea instead is that if bitmaps postcopy failed, we just
> > loss some bitmaps, which is not critical. So, on failure we just need
> 
> lose
> 
> > to remove unfinished bitmaps and guest should continue execution on
> > destination.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > ---
> >   migration/savevm.c | 37 ++++++++++++++++++++++++++++++++-----
> >   1 file changed, 32 insertions(+), 5 deletions(-)
> > 
> 
> Definitely a bug fix, but I'd like David's opinion on whether this is still
> 5.1 material (because it is limited to just bitmaps migration, which is
> opt-in) or too risky (because we've already had several releases where it
> was broken, what's one more?).

I think it's OK for 5.1

Dave

> I'm less familiar with the code, so this is weak, but I did read through it
> and nothing jumped out at me, so:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


