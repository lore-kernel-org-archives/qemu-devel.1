Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B495CC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AACA20872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AACA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCv9M-0007rh-Do
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 20:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iCv8K-0007FI-Nn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iCv8J-00049V-HQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:26:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:10643)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iCv8J-000485-8R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:26:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 17:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; d="scan'208";a="340245699"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga004.jf.intel.com with ESMTP; 24 Sep 2019 17:26:06 -0700
Date: Wed, 25 Sep 2019 08:25:47 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/3] migration/postcopy: not necessary to do discard when
 canonicalizing bitmap
Message-ID: <20190925002547.GA19466@richard>
References: <20190819061843.28642-1-richardw.yang@linux.intel.com>
 <20190819061843.28642-2-richardw.yang@linux.intel.com>
 <20190924100208.GA2725@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924100208.GA2725@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: pbonzini@redhat.com, quintela@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 11:02:08AM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> All pages, either partially sent or partially dirty, will be discarded in
>> postcopy_send_discard_bm_ram(), since we update the unsentmap to be
>> unsentmap = unsentmap | dirty in ram_postcopy_send_discard_bitmap().
>> 
>> This is not necessary to do discard when canonicalizing bitmap. And by
>> doing so, we separate the page discard into two individual steps:
>> 
>>   * canonicalize bitmap
>>   * discard page
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Yes, I think when I originally wrote it, the set of pages that was
>discarded was different; I think it was actually the set of 
>!unsent & dirty - i.e. only pages that had been sent and then redirtied;
>it later got reworked to include unsent pages as well - so this lot can
>be simplified.
>
>

Thanks for your time :-)

>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>  migration/ram.c | 14 +-------------
>>  1 file changed, 1 insertion(+), 13 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 35552c090b..075ddc468c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2928,7 +2928,7 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
>>  }
>>  
>>  /**
>> - * postcopy_chunk_hostpages_pass: canocalize bitmap in hostpages
>> + * postcopy_chunk_hostpages_pass: canonicalize bitmap in hostpages
>>   *
>>   * Helper for postcopy_chunk_hostpages; it's called twice to
>>   * canonicalize the two bitmaps, that are similar, but one is
>> @@ -2991,18 +2991,6 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>>                                                               host_ratio);
>>              run_start = QEMU_ALIGN_UP(run_start, host_ratio);
>>  
>> -            /* Tell the destination to discard this page */
>> -            if (unsent_pass || !test_bit(fixup_start_addr, unsentmap)) {
>> -                /* For the unsent_pass we:
>> -                 *     discard partially sent pages
>> -                 * For the !unsent_pass (dirty) we:
>> -                 *     discard partially dirty pages that were sent
>> -                 *     (any partially sent pages were already discarded
>> -                 *     by the previous unsent_pass)
>> -                 */
>> -                postcopy_discard_send_range(ms, fixup_start_addr, host_ratio);
>> -            }
>> -
>>              /* Clean up the bitmap */
>>              for (page = fixup_start_addr;
>>                   page < fixup_start_addr + host_ratio; page++) {
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

