Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B8CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA4D207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Askkn8bQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA4D207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy6kk-0002RN-Bv
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 00:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jy6k3-000219-4O
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:52:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58765
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jy6k0-0004AM-Ni
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595393547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STZrqDrbzeeluizI6/yn1XLp7GJSAlpC12VVmj0kCng=;
 b=Askkn8bQrEYSi+2Pwq0TUDgpeqS230GJTe/GjyVjlnymULXCRvQjuQZFzRFKgPlFo5XIMl
 wYJimFPil5Jbe3wQasag2lfJUxrJ1z1SvCatJKKLOeF/NSDe3XvH5oedd9sVQPV2vFDxoV
 FclgrICBrh82VU47QAriFxMZ/2lUjwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Gd6qNzZfPe6E2fLu5KdHbQ-1; Wed, 22 Jul 2020 00:52:23 -0400
X-MC-Unique: Gd6qNzZfPe6E2fLu5KdHbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19A458005B0;
 Wed, 22 Jul 2020 04:52:22 +0000 (UTC)
Received: from kaapi (ovpn-112-29.phx2.redhat.com [10.3.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E63F874F6B;
 Wed, 22 Jul 2020 04:52:18 +0000 (UTC)
Date: Wed, 22 Jul 2020 10:22:15 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3] e1000e: using bottom half to send packets
In-Reply-To: <307795f9-70bb-b83b-6110-da2c923e4dc2@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2007221020480.4380@xnncv>
References: <20200721151728.112395-1-liq3ea@163.com>
 <307795f9-70bb-b83b-6110-da2c923e4dc2@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1603545069-1595393541=:4380"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
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
Cc: dmitry.fleytman@gmail.com, Li Qiang <liq3ea@163.com>, liq3ea@gmail.com,
 qemu-devel@nongnu.org, alxndr@bu.edu, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-1603545069-1595393541=:4380
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Wed, 22 Jul 2020, Jason Wang wrote --+
| On 2020/7/21 下午11:17, Li Qiang wrote:
| > Alexander Bulekov reported a UAF bug related e1000e packets send.
| >
| > -->https://bugs.launchpad.net/qemu/+bug/1886362
| >
| > This is because the guest trigger a e1000e packet send and set the
| > data's address to e1000e's MMIO address. So when the e1000e do DMA
| > it will write the MMIO again and trigger re-entrancy and finally
| > causes this UAF.
| >
| > Paolo suggested to use a bottom half whenever MMIO is doing complicate
| > things in here:
| > -->https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg03342.html
| >
| > Reference here:
| > 'The easiest solution is to delay processing of descriptors to a bottom
| > half whenever MMIO is doing something complicated.  This is also better
| > for latency because it will free the vCPU thread more quickly and leave
| > the work to the I/O thread.'
| >
| > This patch fixes this UAF.
| >
| > Reported-by: Alexander Bulekov <alxndr@bu.edu>
| > Signed-off-by: Li Qiang <liq3ea@163.com>
| > ---
| > Change since v2:
| > 1. Add comments for the tx bh schdule when VM resumes
| > 2. Leave the set ics code in 'e1000e_start_xmit'
| > 3. Cancel the tx bh and reset tx_waiting in e1000e_core_reset
| 
| 
| So based on our discussion this is probably not sufficient. It solves the
| issue TX re-entrancy but not RX (e.g RX DMA to RDT?) Or is e1000e's RX is
| reentrant?

Fixes: (CVE-2020-15859) -> https://bugzilla.redhat.com/show_bug.cgi?id=1859168

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1603545069-1595393541=:4380--


