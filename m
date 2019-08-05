Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC6BC19759
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 00:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149882086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 00:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149882086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huQxf-0003Qv-5m
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 20:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41512)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1huQxC-0002kW-AT
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 20:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1huQxB-0007uV-3g
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 20:34:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:6599)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1huQxA-0007u2-Qm
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 20:34:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Aug 2019 17:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,347,1559545200"; d="scan'208";a="373537832"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 04 Aug 2019 17:34:18 -0700
Date: Mon, 5 Aug 2019 08:33:50 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190805003350.GA1311@richard>
References: <1564741121-1840-1-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564741121-1840-1-git-send-email-ivanren@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH v3] migration: always initial ram_counters
 for a new migration
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
Cc: qemu-devel@nongnu.org, richardw.yang@linux.intel.com, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 06:18:41PM +0800, Ivan Ren wrote:
>From: Ivan Ren <ivanren@tencent.com>
>
>This patch fix a multifd migration bug in migration speed calculation, this
>problem can be reproduced as follows:
>1. start a vm and give a heavy memory write stress to prevent the vm be
>   successfully migrated to destination
>2. begin a migration with multifd
>3. migrate for a long time [actually, this can be measured by transferred bytes]
>4. migrate cancel
>5. begin a new migration with multifd, the migration will directly run into
>   migration_completion phase
>
>Reason as follows:
>
>Migration update bandwidth and s->threshold_size in function
>migration_update_counters after BUFFER_DELAY time:
>
>    current_bytes = migration_total_bytes(s);
>    transferred = current_bytes - s->iteration_initial_bytes;
>    time_spent = current_time - s->iteration_start_time;
>    bandwidth = (double)transferred / time_spent;
>    s->threshold_size = bandwidth * s->parameters.downtime_limit;
>
>In multifd migration, migration_total_bytes function return
>qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
>s->iteration_initial_bytes will be initialized to 0 at every new migration,
>but ram_counters is a global variable, and history migration data will be
>accumulated. So if the ram_counters.multifd_bytes is big enough, it may lead
>pending_size >= s->threshold_size become false in migration_iteration_run
>after the first migration_update_counters.
>
>Signed-off-by: Ivan Ren <ivanren@tencent.com>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
>Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
>---
>v2->v3:
>- fix the bug of update_iteration_initial_status function prototype
>

Code looks good. Have you verified on this version?

BTW, you didn't address the multifd count in this patch, right?


-- 
Wei Yang
Help you, Help me

