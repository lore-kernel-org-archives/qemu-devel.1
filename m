Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D25C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C68D20775
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4npMGtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C68D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwP4Q-0000j4-Lb
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwP3Z-0008CD-LB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:01:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwP3Y-0000Ij-1c
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594987294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7cjmXmMnw3Ue/cOI7T57yHVRBZIQGBUMUyGg+N8Fiwc=;
 b=H4npMGtVTXdt71MjPpVifIhgDl7j48LPxoXmx1aow3KF1zNHWnS2eHW9kcb8em6Mu28zpj
 qMDCuHm2zmtFuJ4/mOccs3jcdyaXjKIr8BjRcNL3C46Xe+EPJk1OxdCsI245KL/2EFfmGF
 NE98WSuC2TTK1KlScSbS46Ef1ZTwSi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Rwh9HIDZPdC2oquBoxhWRA-1; Fri, 17 Jul 2020 08:01:30 -0400
X-MC-Unique: Rwh9HIDZPdC2oquBoxhWRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30BC11E00;
 Fri, 17 Jul 2020 12:01:23 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7294478A52;
 Fri, 17 Jul 2020 12:01:21 +0000 (UTC)
Date: Fri, 17 Jul 2020 14:01:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 for-5.1 0/2] Fix crash due to NBD export leak
Message-ID: <20200717120119.GC4550@linux.fritz.box>
References: <20200714162234.13113-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200714162234.13113-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.07.2020 um 18:22 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all!
> 
> We've faced crash bug, which is reproducing on master branch as well.
> The case is described in 01, where fix is suggested.
> New iotest in 02 crashes without that fix.
> 
> v3: resend for convenience, as all preparatory patches are merged.
> 01-02: add Eric's r-b and t-b marks
> 
> ====
> 
> This is a crash-fix, so it would be good to fix in 5.1. Still neither
> Eric nor I are sure in patch 01: is AIO_WAIT_WHILE used correctly?

Anything specific you had doubts about?

At first sight it looks good to me. It's always called in the main loop
and we don't hold any AioContext locks, so using NULL as the context is
fine. You also made sure to use aio_wait_kick() so that we won't hang
even though the condition has become false.

I'm applying this to my block branch now. If your doubts were about
something more subtle that I missed, we can unstage/revert the patch.

Kevin


