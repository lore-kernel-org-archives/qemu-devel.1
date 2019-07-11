Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C568DC74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB2E20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB2E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWFt-0004w2-Na
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33469)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlWFM-0004NS-Fc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlWFL-0001D5-AD
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlWFL-0001Cr-4c
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:24:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C5F63082145;
 Thu, 11 Jul 2019 10:24:14 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6141D194B5;
 Thu, 11 Jul 2019 10:24:13 +0000 (UTC)
Date: Thu, 11 Jul 2019 11:24:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lin Ma <LMa@suse.com>
Message-ID: <20190711102410.GH3971@work-vm>
References: <BY5PR18MB3313E1E22A22D236D4C2680DC5F30@BY5PR18MB3313.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR18MB3313E1E22A22D236D4C2680DC5F30@BY5PR18MB3313.namprd18.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 11 Jul 2019 10:24:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] migrate_set_speed has no effect if the guest is
 using hugepages.
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lin Ma (LMa@suse.com) wrote:
> Hi all,

Hi Lin,

> When I live migrate a qemu/kvm guest, If the guest is using huge pages, I found that
> the migrate_set_speed command had no effect during stage 2.

Can you explain what you mean by 'stage 2'?

> It was caused by commit 4c011c3 postcopy: Send whole huge pages
> 
> I'm wondering that is it by design or is it a bug waiting for fix?

This is the first report I've seen for it.  How did you conclude that
4c011c3 caused it?  While I can see it might have some effect on the
bandwidth management, I'm surprised it has this much effect.

What size huge pages are you using - 2MB or 1GB?
I can imagine we might have a problem that since we only do the sleep
between the hugepages, if we were using 1GB hugepages then
we'd see <big chunk of data>[sleep]<big chunk of data>[sleep]
which isn't as smooth as it used to be.

Can you give me some more details of your test?

Dave

> 
> Thanks,
> Lin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

