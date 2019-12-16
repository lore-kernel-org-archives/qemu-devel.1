Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DC2C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 02:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8DB206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 02:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8DB206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iggEf-0004do-PT
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 21:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iggE1-00047h-Lq
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 21:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iggE0-00010B-Ja
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 21:35:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:60978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iggE0-0000xX-Bt
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 21:35:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Dec 2019 18:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,320,1571727600"; d="scan'208";a="389313356"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga005.jf.intel.com with ESMTP; 15 Dec 2019 18:35:04 -0800
Date: Mon, 16 Dec 2019 10:35:02 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [Patch v2 0/6] migration/postcopy: enable compress during postcopy
Message-ID: <20191216023502.GA21865@richard>
References: <20191107123907.29791-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107123907.29791-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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

Would this one be picked up in this version?

On Thu, Nov 07, 2019 at 08:39:01PM +0800, Wei Yang wrote:
>This patch set tries enable compress during postcopy.
>
>postcopy requires to place a whole host page, while migration thread migrate
>memory in target page size. This makes postcopy need to collect all target
>pages in one host page before placing via userfaultfd.
>
>To enable compress during postcopy, there are two problems to solve:
>
>    1. Random order for target page arrival
>    2. Target pages in one host page arrives without interrupt by target
>       page from other host page
>
>The first one is handled by counting the number of target pages arrived
>instead of the last target page arrived.
>
>The second one is handled by:
>
>    1. Flush compress thread for each host page
>    2. Wait for decompress thread for before placing host page
>
>With the combination of these two changes, compress is enabled during
>postcopy.
>
>---
>v2:
>     * use uintptr_t to calculate place_dest
>     * check target pages belongs to the same host page
>
>Wei Yang (6):
>  migration/postcopy: reduce memset when it is zero page and
>    matches_target_page_size
>  migration/postcopy: wait for decompress thread in precopy
>  migration/postcopy: count target page number to decide the
>    place_needed
>  migration/postcopy: set all_zero to true on the first target page
>  migration/postcopy: enable random order target page arrival
>  migration/postcopy: enable compress during postcopy
>
> migration/migration.c | 11 -------
> migration/ram.c       | 67 +++++++++++++++++++++++++++++++++----------
> 2 files changed, 52 insertions(+), 26 deletions(-)
>
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me

