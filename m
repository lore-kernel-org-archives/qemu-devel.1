Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AC822282
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElnPs54u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AC822282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnMv-0001aB-8W
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUnLr-0000YG-KL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUnLo-0006o6-TZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603183834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gukFUyA+D13iwUt9camMFBsATv1pNQlra4MhmV+oJxY=;
 b=ElnPs54uIzibOLb7T0LehqMAjnM6yR0ZeOw7zpddI8wdqWB0Wg42plMDUXs9eQ75mVwgh0
 58GDWWssm5Z0HcwF9OJmEFB+WZmNScaJPUvWCBSOGo9CJivKaE0bbhmrfemClD+7ZLwVqd
 H2F9Ib2ow+T59wx0uPeiZSJ2Y32uXwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-guzsp0tFOj-fRLQgLGrr5A-1; Tue, 20 Oct 2020 04:50:33 -0400
X-MC-Unique: guzsp0tFOj-fRLQgLGrr5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D112B8049D5;
 Tue, 20 Oct 2020 08:50:31 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-112-88.ams2.redhat.com [10.36.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA3D15C225;
 Tue, 20 Oct 2020 08:50:30 +0000 (UTC)
Date: Tue, 20 Oct 2020 10:50:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Subject: Re: RFC: tracking valid backing chain issue
Message-ID: <20201020085029.GC4452@merkur.fritz.box>
References: <3b99657c-2016-78cb-4314-27aacb30ca3c@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <3b99657c-2016-78cb-4314-27aacb30ca3c@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.10.2020 um 10:21 hat Nikolay Shirokovskiy geschrieben:
> Hi, all.
> 
> I recently found a corner case when it is impossible AFAIK to find out valid
> backing chain after block commit operation. Imagine committing top image. After
> commit ready state pivot is sent and then mgmt crashed. So far so good. Upon
> next start mgmt can either check block job status for non-autodissmised job or
> inspect backing chain to infer was pivot was successful or not in case of older
> qemu.
> 
> But imagine after mgmt crash qemu process was destroyed too. In this case there
> is no option to know now what is valid backing chain. Yeah libvirt starts qemu
> process with -no-shutdown flags so process is not destroyed in case of shutdown
> but still process can crash.

I don't think this is a problem.

Between completion of the job and finalising it, both the base node and
the top node are equivalent. You can access either and you'll always get
the same data.

So if libvirt didn't save that the job was already completed, it will
use the old image file, and it's fine. And if libvirt already sent the
job-finalize command, it will first have saved that the job was
completed and therefore use the new image, and it's fine, too.

Kevin

> So corner case is very rare. Mgmt crash in a specific short moment and then
> qemu crash before mgmt is up again.
> 
> I guess some 'invalidated' flag for image would help. And also qemu itself
> could check that mgmt is not trying to run on invalid backing chain based
> on this flag.
> 
> Nikolay
> 


