Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A91C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E52D21721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E52D21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabm8-0006Uq-Ha
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iabgL-0002tr-FY
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iabgF-0008IX-4M
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:31:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:24206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iabgD-00081h-Sd
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:31:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Nov 2019 00:31:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,256,1571727600"; d="scan'208";a="409569123"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2019 00:31:01 -0800
Date: Fri, 29 Nov 2019 16:30:53 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 1/6] migration/multifd: move Params update and pages
 cleanup into multifd_send_fill_packet()
Message-ID: <20191129083053.GB1669@richard>
References: <20191026004520.5515-1-richardw.yang@linux.intel.com>
 <20191026004520.5515-2-richardw.yang@linux.intel.com>
 <878socgmlp.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878socgmlp.fsf@trasno.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 11:57:22AM +0100, Juan Quintela wrote:
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>> Fill data and update/cleanup related field in one place. Also make the
>> code a little clean.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>right cleanup.
>

Hi, Juan

Do you have other comments on the following patches?

-- 
Wei Yang
Help you, Help me

