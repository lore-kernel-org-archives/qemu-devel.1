Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22CC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A252225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYRiFwcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A252225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUabv-00017q-29
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kUaar-0000eg-NK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kUaap-0002Rw-Q2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603134794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IMRrkLOgTiUjEV81ZtUAFk803srWz6UgWwCAKUb90w=;
 b=VYRiFwcg8LCyKe561Xz1A1p4t9ptxPmZHoH6wWhNaOtYshCs6mCjDEPaGqR24n/tqzTl5U
 teIuj9xiOa/7Ka72C0+SqDaIo3euXE1ZJ0RS2FiCfnJnCP1Oaojr3E3LJx8KXpJavsCy0/
 8PFDUPS5pigktKEi/gu7nGnRTHe77xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-XO8Y8847O9aWQq8-PXBsdw-1; Mon, 19 Oct 2020 15:13:09 -0400
X-MC-Unique: XO8Y8847O9aWQq8-PXBsdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CF978049CB;
 Mon, 19 Oct 2020 19:13:07 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F149A5D9EF;
 Mon, 19 Oct 2020 19:12:59 +0000 (UTC)
Date: Mon, 19 Oct 2020 20:12:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] intel_iommu: Fix two misuse of "0x%u" prints
Message-ID: <20201019191257.GB3564@work-vm>
References: <20201019173922.100270-1-peterx@redhat.com>
 <CAFEAcA9RHVZQ6KzEJOs8V74E3v6Bw=WaimdYRkcLr-9HR07gng@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9RHVZQ6KzEJOs8V74E3v6Bw=WaimdYRkcLr-9HR07gng@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Mon, 19 Oct 2020 at 18:43, Peter Xu <peterx@redhat.com> wrote:
> >
> > Dave magically found this.  Fix them with "0x%x".
> >
> > Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Hmm, a quick grep finds also some "0x%d" in an arm trace-event file :-)
> I'll send a patch...

See:
  https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg04179.html

Dave

> -- PMM
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


