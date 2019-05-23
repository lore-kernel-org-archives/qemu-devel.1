Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3787C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 21:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B138217D9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 21:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B138217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43561 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTvFy-0006Ih-MJ
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 17:28:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTvF5-0005tl-K2
	for qemu-devel@nongnu.org; Thu, 23 May 2019 17:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTvF4-0002Ea-LN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 17:27:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hTvF4-0002Ac-Ex
	for qemu-devel@nongnu.org; Thu, 23 May 2019 17:27:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6166F8830F;
	Thu, 23 May 2019 21:27:12 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA3195D707;
	Thu, 23 May 2019 21:27:09 +0000 (UTC)
Date: Thu, 23 May 2019 18:27:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190523212708.GD10764@habkost.net>
References: <20190516125807.17025-1-bwiedemann@suse.de>
	<20190523185737.GB2994@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523185737.GB2994@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 23 May 2019 21:27:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386: Fix nested SVM on older Opterons
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Bernhard M. Wiedemann" <bwiedemann@suse.de>, bsd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 07:57:38PM +0100, Dr. David Alan Gilbert wrote:
> * Bernhard M. Wiedemann (bwiedemann@suse.de) wrote:
> > Without this patch, a VM on a Opteron G3 host will have the svm flag, but
> > the kvm-amd module fails to load in there, complaining that it needs
> > cpuid 0x8000000a
> > 
> > I have successfully built and tested this for 3+ years in production
> > on Opteron G3 servers.

Have you reproduced the bug on QEMU 2.8 or newer?  The problem
you describe should be fixed by the following commit (from ~2.5
years ago).

commit 0c3d7c0051576d220e6da0a8ac08f2d8482e2f0b
Author: Eduardo Habkost <ehabkost@redhat.com>
Date:   Wed Sep 21 15:01:35 2016 -0300

    target-i386: Enable CPUID[0x8000000A] if SVM is enabled

    SVM needs CPUID[0x8000000A] to be available. So if SVM is enabled
    in a CPU model or explicitly in the command-line, adjust CPUID
    xlevel to expose the CPUID[0x8000000A] leaf.

    Reviewed-by: Richard Henderson <rth@twiddle.net>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo

