Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A922FC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 01:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7512E227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 01:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7512E227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq5xX-0006cH-Nm
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 21:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36230)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hq5xM-0006Dr-5U
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hq5xL-00050V-4L
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:20:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:59771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hq5xK-0004zZ-Rc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:20:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jul 2019 18:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; d="scan'208";a="160398227"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga007.jf.intel.com with ESMTP; 23 Jul 2019 18:20:31 -0700
Date: Wed, 24 Jul 2019 09:20:07 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190724012007.GC2199@richard>
References: <20190722075339.25121-1-richardw.yang@linux.intel.com>
 <20190722075339.25121-3-richardw.yang@linux.intel.com>
 <20190723164703.GN2719@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723164703.GN2719@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: extract ram_load_precopy
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 05:47:03PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> After cleanup, it would be clear to audience there are two cases
>> ram_load:
>> 
>>   * precopy
>>   * postcopy
>> 
>> And it is not necessary to check postcopy_running on each iteration for
>> precopy.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/ram.c | 73 +++++++++++++++++++++++++++++++------------------
>>  1 file changed, 46 insertions(+), 27 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 6bfdfae16e..5f6f07b255 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -4200,40 +4200,26 @@ static void colo_flush_ram_cache(void)
>>      trace_colo_flush_ram_cache_end();
>>  }
>>  
>> -static int ram_load(QEMUFile *f, void *opaque, int version_id)
>> +/**
>> + * ram_load_precopy: load a page in precopy case
>
>This comment is wrong - although I realise you copied it from the
>postcopy case; they don't just load a single page; they load 'pages'
>

Thanks for pointing out.

Actually, I got one confusion in these two load. Compare these two cases, I
found precopy would handle two more cases:

  * precopy:  RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
              RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE
  * postcopy: RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE

Why postcopy doesn't need to handle the other two cases? Function
ram_save_target_page() does the same thing in precopy and postcopy. I don't
find the reason the behavior differs. Would you mind giving me a hint?

>Other than that, I think it's OK, so:
>
>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

-- 
Wei Yang
Help you, Help me

