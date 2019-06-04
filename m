Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D1C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB152173E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB152173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY4ta-0008MX-CT
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:34:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hY4sY-0007zw-GU
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hY4sX-0007pB-Hv
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:33:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:18047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hY4sX-0007oR-AR
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:33:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Jun 2019 01:33:07 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga004.jf.intel.com with ESMTP; 04 Jun 2019 01:33:06 -0700
Date: Tue, 4 Jun 2019 16:32:37 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190604083237.GB28403@richard>
References: <20190604061727.6857-1-richardw.yang@linux.intel.com>
	<20190604070614.GD15459@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604070614.GD15459@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH v3] migratioin/ram: leave RAMBlock->bmap
 blank on allocating
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 03:06:14PM +0800, Peter Xu wrote:
>On Tue, Jun 04, 2019 at 02:17:27PM +0800, Wei Yang wrote:
>> During migration, we would sync bitmap from ram_list.dirty_memory to
>> RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().
>> 
>> Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
>> means at the first round this sync is meaningless and is a duplicated
>> work.
>> 
>> Leaving RAMBlock->bmap blank on allocating would have a side effect on
>> migration_dirty_pages, since it is calculated from the result of
>> cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
>> set migration_dirty_pages to 0 in ram_state_init().
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>Thanks for updating the comments.
>

My pleasure :-)

>Acked-by: Peter Xu <peterx@redhat.com>
>
>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

