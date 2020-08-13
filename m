Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528CBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E07920774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsKZ5yOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E07920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Ii8-00016c-D7
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 15:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6IhW-0000ZG-6l
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:15:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6IhT-0005vR-Vm
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597346142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4h0KXjjVyz6cTzwI8KUV1xFcFl8JYxzMuInJl8TrX4=;
 b=EsKZ5yOFNpphpvQFjAMHv3KuhMFn7CPmO+PBOeL+bzSEOsiMZVKvQ36/W9h4mdiWx+Iujw
 73jM0+xanZDYANsm5xnMUVplBTl8iQWHzftwO5Tw3B2jg3xLPQg5MAPOH+j7zdw8+JgsSH
 JK6Xf4LHSdBk6RdMI2IzzBlBvWn9iPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-4kM90PGDNLCn2Ihj6pWvqg-1; Thu, 13 Aug 2020 15:15:40 -0400
X-MC-Unique: 4kM90PGDNLCn2Ihj6pWvqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4A11854FC0;
 Thu, 13 Aug 2020 19:15:39 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BAD160C04;
 Thu, 13 Aug 2020 19:15:31 +0000 (UTC)
Date: Thu, 13 Aug 2020 13:15:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 07/11] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
Message-ID: <20200813131530.09ad0a4c@x1.home>
In-Reply-To: <681519bf-92ca-6247-490a-e9193b0bd385@redhat.com>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-8-kuhn.chenqun@huawei.com>
 <20200813105911.2312adb5@x1.home>
 <681519bf-92ca-6247-490a-e9193b0bd385@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:29:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 pannengyuan@huawei.com, qemu-devel@nongnu.org,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 20:02:45 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 8/13/20 6:59 PM, Alex Williamson wrote:
> > On Thu, 13 Aug 2020 15:37:08 +0800
> > Chen Qun <kuhn.chenqun@huawei.com> wrote:
> >   
> >> Clang static code analyzer show warning:
> >> hw/vfio/platform.c:239:9: warning: Value stored to 'ret' is never read
> >>         ret = event_notifier_test_and_clear(intp->interrupt);
> >>         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> >> ---
> >> Cc: Alex Williamson <alex.williamson@redhat.com>
> >> Cc: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>  hw/vfio/platform.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> >> index ac2cefc9b1..869ed2c39d 100644
> >> --- a/hw/vfio/platform.c
> >> +++ b/hw/vfio/platform.c
> >> @@ -236,7 +236,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
> >>          trace_vfio_intp_interrupt_set_pending(intp->pin);
> >>          QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
> >>                               intp, pqnext);
> >> -        ret = event_notifier_test_and_clear(intp->interrupt);
> >> +        event_notifier_test_and_clear(intp->interrupt);
> >>          return;
> >>      }  
> > 
> > Testing that an event is pending in our notifier is generally a
> > prerequisite to doing anything in the interrupt handler, I don't
> > understand why we're just consuming it and ignoring the return value.
> > The above is in the delayed handling branch of the function, but the
> > normal non-delayed path would only go on to error_report() if the
> > notifier is not pending and then inject an interrupt anyway.  This all
> > seems rather suspicious and it's a unique pattern among the vfio
> > callers of this function.  Is there a more fundamental bug that this
> > function should perform this test once and return without doing
> > anything if it's called spuriously, ie. without a notifier pending?
> > Thanks,  
> 
> Hum that's correct that other VFIO call sites do the check. My
> understanding was that this could not fail in this case as, if we
> entered the handler there was something to be cleared. In which
> situation can this fail?

I'm not sure what the right answer is, I see examples either way
looking outside of vfio code.  On one hand, maybe we never get called
spuriously, on the other if it's the callee's responsibility to drain
events from the fd and we have it readily accessible whether there were
any events pending, why would we inject an interrupt if the result that
we have in hand shows no pending events?  The overhead of returning
based on that result is minuscule.

qemu_set_fd_handler() is a wrapper for aio_set_fd_handler().  Stefan is
a possible defacto maintainer of some of the aio code.  Stefan, do you
have thoughts on whether callbacks from event notifier fds should
consider spurious events?  Thanks,

Alex


