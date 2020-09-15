Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB3C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078FA20756
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5HbH5re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078FA20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI4la-0004TO-VF
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 02:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kI4l3-0003uT-Ul
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kI4l1-0007rs-Up
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600152482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YeTNc40+FZqEoTA+BSEvWtcBPqHmM1LeeGwkf+tpksI=;
 b=Z5HbH5reo8p0Z9/JTWsjZ2lF2eGR/u4Zgz2ro0eH9Au4yzVXhJP8Fj5vVARa0soIC+Maua
 1A3r+hB2HGvB/8nuzPQH/PszL7AI57bC1zFk/Mq4Xxyb4jEnYwA9JYYd8uJF40NLVCeVE3
 YyKfA8EsQN4y/gZRBvg6DnAej51Berg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-634NUJJiO1OWYhSjxufzWw-1; Tue, 15 Sep 2020 02:47:58 -0400
X-MC-Unique: 634NUJJiO1OWYhSjxufzWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 484B98015B1;
 Tue, 15 Sep 2020 06:47:57 +0000 (UTC)
Received: from kaapi (ovpn-116-229.sin2.redhat.com [10.67.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1387839F;
 Tue, 15 Sep 2020 06:47:50 +0000 (UTC)
Date: Tue, 15 Sep 2020 12:17:48 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] hw: usb: hcd-ohci: check len and frame_number
 variables
In-Reply-To: <20200912014825.eg73ixfjkknzd46n@mozz.bu.edu>
Message-ID: <nycvar.YSQ.7.78.906.2009151150360.10832@xnncv>
References: <20200911122703.126696-1-ppandit@redhat.com>
 <CAKXe6SLFG1XMCw7yNM3bres29jiqJ5oLpJUgzXGjj8ay=NkwHQ@mail.gmail.com>
 <20200911192045.3amzn6zlaynpxbfy@mozz.bu.edu>
 <20200912014825.eg73ixfjkknzd46n@mozz.bu.edu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Gerd Hoffmann <kraxel@redhat.com>, Yongkang Jia <j_kangel@163.com>,
 Gaoning Pan <pgn@zju.edu.cn>, Yi Ren <yunye.ry@alibaba-inc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 11 Sep 2020, Alexander Bulekov wrote --+
| > On 200911 2257, Li Qiang wrote:
| > > Could you also provide the reproducer?

* Sorry, we can not share reproducers on the list, I'm afraid.

* Thank you Alex for the -qtests.

| > > I think it is better to split this patch to 2 or three as the infinite
| > > loop as the buffer overflow are independent.
| > > 
| > > 1. here the infinite loop
| > > 2. here the stack buffer overflow
| > > 3. Then here is the heap overflow.
| > > 
| > > So I think it can be more easier to review to split this to 3 patches.

* These issues are in the same UHCI controller and share the same pattern, 
  triggered while processing ED/TD lists. They can be combined as a single 
  CVE.

* Infinite-loop is different. I'll break it into two patches, one for OOB 
  access and one to avoid an infinite loop case.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


