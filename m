Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5439EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 01:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B52206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 01:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B52206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWWAW-0002tq-7s
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 20:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iWW9p-0002Si-8u
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 20:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iWW9n-0006PB-VR
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 20:48:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:4778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iWW9n-0006ON-Nq
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 20:48:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Nov 2019 17:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,318,1569308400"; d="scan'208";a="195977620"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga007.jf.intel.com with ESMTP; 17 Nov 2019 17:48:39 -0800
Date: Mon, 18 Nov 2019 09:48:29 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 0/2] not use multifd during postcopy
Message-ID: <20191118014829.GA4382@richard>
References: <20191025232000.25857-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025232000.25857-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for comments.

On Sat, Oct 26, 2019 at 07:19:58AM +0800, Wei Yang wrote:
>We don't support multifd during postcopy, but user still could enable
>both multifd and postcopy. This leads to migration failure.
>
>Patch 1 does proper cleanup, otherwise we may have data corruption.
>Patch 2 does the main job.
>
>BTW, current multifd synchronization method needs a cleanup. Will send another
>patch set.
>
>Wei Yang (2):
>  migration/multifd: clean pages after filling packet
>  migration/multifd: not use multifd during postcopy
>
> migration/ram.c | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me

