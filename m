Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F310AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC15320709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qw2M8e8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC15320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jazx0-0001Oz-Ri
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 06:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jazwU-0000wP-SM
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:57:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60489
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jazwU-0000vg-7N
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589885869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=18P83L90C0MQbaMN9T9O1kBEtkG7U19aJOLCOSE+DUo=;
 b=Qw2M8e8yy/K/RuRn/ahVtQYEervCOahUWzuiufKeMl3RD4eSscDEITGGRXguTYkXAarHVz
 eSIXFqKGnXPzAu/bRATmEYn/0t3rwiUWfdpDoeDpV+VsBDqZRbeBg7f5787aq03M8SkVC9
 4hj8lK7tARt5OkFagpEeLRzbh9zsqNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-tW2hQ48vOpWLFZbsSqMT8Q-1; Tue, 19 May 2020 06:57:45 -0400
X-MC-Unique: tW2hQ48vOpWLFZbsSqMT8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056F6800D24;
 Tue, 19 May 2020 10:57:44 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C9822D0A8;
 Tue, 19 May 2020 10:57:39 +0000 (UTC)
Date: Tue, 19 May 2020 12:57:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 6/9] block/io: expand in_flight inc/dec section:
 block-status
Message-ID: <20200519105738.GI7652@linux.fritz.box>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-7-vsementsov@virtuozzo.com>
 <12c9ba13-ec91-ed3a-4713-018e0332f61b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <12c9ba13-ec91-ed3a-4713-018e0332f61b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.05.2020 um 00:00 hat Eric Blake geschrieben:
> On 4/27/20 9:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> > It's safer to expand in_flight request to start before enter to
> > coroutine in synchronous wrappers and end after BDRV_POLL_WHILE loop.
> > Note that qemu_coroutine_enter may only schedule the coroutine in some
> > circumstances.
> 
> Wording suggestion:
> 
> It's safer to expand the region protected by an in_flight request to begin
> in the synchronous wrapper and end after the BDRV_POLL_WHILE loop.  Leaving
> the in_flight request in the coroutine itself risks a race where calling
> qemu_coroutine_enter() may have only scheduled, rather than started, the
> coroutine, allowing some other thread a chance to not realize an operation
> is in flight.
> 
> > 
> > block-status requests are complex, they involve querying different
> > block driver states across backing chain. Let's expand only in_flight
> > section for the top bs, keeping other sections as is.
> 
> block-status requests are complex, involving a query of different block
> driver states across the backing chain.  Let's expand only the in_flight
> section for the top bs, and keep the other sections as-is.
> 
> I'd welcome Kevin's review on my next comment, but if I'm correct, I think
> we can further add the following justification to the commit message:
> 
> Gathering block status only requires reads from the block device, and
> backing devices are typically read-only, so losing any in_flight race on a
> backing device is less likely to cause problems with concurrent
> modifications on the overall backing chain.

Actually, my question is what we gain by increasing in_flight only for
the top level. It feels wrong to me, though maybe it doesn't actually
lead to bugs because in practice, we completely drain the parents
instead of just draining requests going to one specific child.

But as this patch shows, not increasing in_flight in some cases is a lot
more work than doing it, and it's harder to understand why it's correct.
So why not simply increase it unconditionally?

This is how other requests work as well. If you make a read request to a
qcow2 image, you'll get in_flight increased for both the qcow2 node and
the file-posix node.

Kevin


