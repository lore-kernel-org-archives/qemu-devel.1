Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5482EC2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE6E20775
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE6E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSw1-0001xo-7p
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1jHSvJ-0001VJ-89
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1jHSvH-00062R-Uk
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:51:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:11610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1jHSvH-000615-M8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:51:51 -0400
IronPort-SDR: 72B3LiyTJGO5BrzHDZWJ44NNvvKMXzzax2X2wEZitY5F8uGF6xnDAn1JPzZqa3QP/NzLmwvttm
 u6vun6kj0UIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 06:51:48 -0700
IronPort-SDR: Jn4rYRODQK1eXiL3X+bxCRLvF6hU99uoIfOl31MZ+wL6iAUUvaSPPzQ2aFy75LgLNxpcnhecsh
 9dymvpvAfGhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; d="scan'208";a="238805514"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga007.fm.intel.com with ESMTP; 26 Mar 2020 06:51:47 -0700
Message-ID: <74894dfd543a9cf505da8633303015c6f894fee8.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] util/bufferiszero: improve avx2 accelerator
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eric Blake <eblake@redhat.com>, "Hu, Robert" <robert.hu@intel.com>, 
 "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
Date: Thu, 26 Mar 2020 21:51:46 +0800
In-Reply-To: <6c9cee4c-8d3b-ed9d-7345-fbaea33477ca@redhat.com>
References: <1585119021-46593-1-git-send-email-robert.hu@linux.intel.com>
 <1585119021-46593-2-git-send-email-robert.hu@linux.intel.com>
 <9eea6e9c-e35c-72e7-4574-7b9a6b72f9a7@redhat.com>
 <9E79D1C9A97CFD4097BCE431828FDD31178F147A@SHSMSX104.ccr.corp.intel.com>
 <6c9cee4c-8d3b-ed9d-7345-fbaea33477ca@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.93
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-03-26 at 08:26 -0500, Eric Blake wrote:
> On 3/25/20 9:09 PM, Hu, Robert wrote:
> > (Don't know why my Linux-Evolution missed this mail.)
> > > -----Original Message-----
> > > Long line; it's nice to wrap commit messages around column 70 or
> > > so (because
> > > reading 'git log' in an 80-column window adds indentation).
> > > 
> > 
> > [Hu, Robert]
> > I think I set my vim on wrap. This probably escaped by paste.
> > I ran checkpatch.pl on the patches before sending. It escaped check
> > but didn't
> > escaped your eagle eye😊 Thank you.
> 
> checkpatch doesn't flag commit message long lines.  Maybe it could
> be 
> patched to do so, but it's not at the top of my list to write that
> patch.
> 
> > 
> > > > I just fix a boudary case on his original patch.
> > > 
> > > boundary
> > 
> > [Hu, Robert]
> > Emm... again spell error. Usually I would paste descriptions into
> > some editors
> > with spell check, but forgot this time.
> > Vim doesn't have spell check I think. What editor would you suggest
> > me to
> > integrate with git editing?
> 
> I'm an emacs user, so I have no suggestions for vim, but I'd be very 
> surprised if there were not some vim expert online that could figure
> out 
> how to wire in a spell-checker to vim.  Google quickly finds: 
> https://www.ostechnix.com/use-spell-check-feature-vim-text-editor/
> 
nice, thanks:)


