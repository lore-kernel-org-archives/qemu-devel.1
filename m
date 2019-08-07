Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15183C31E40
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 00:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0833216F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 00:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0833216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv9cq-0003AR-3q
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 20:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34604)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hv9cF-0002gW-FP
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 20:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hv9cE-0001K3-92
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 20:15:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:53553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hv9cE-0001JG-0T
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 20:15:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Aug 2019 17:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; d="scan'208";a="174333029"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2019 17:15:07 -0700
Date: Wed, 7 Aug 2019 08:14:45 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190807001445.GA24750@richard>
References: <20190806004648.8659-1-richardw.yang@linux.intel.com>
 <20190806004648.8659-2-richardw.yang@linux.intel.com>
 <20190806145117.GF3066@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806145117.GF3066@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH 1/2] migration/postcopy: simplify
 calculation of run_start and fixup_start_addr
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

On Tue, Aug 06, 2019 at 03:51:17PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> The purpose of the calculation is to find a HostPage which is partially
>> dirty.
>> 
>>   * fixup_start_addr points to the start of the HostPage to discard
>>   * run_start points to the next HostPage to check
>> 
>> While in the middle stage, there would two cases for run_start:
>> 
>>   * aligned with HostPage means this is not partially dirty
>>   * not aligned means this is partially dirty
>> 
>> When it is aligned, no work and calculation is necessary. run_start
>> already points to the start of next HostPage and is ready to continue.
>> 
>> When it is not aligned, the calculation could be simplified with:
>> 
>>   * fixup_start_addr = QEMU_ALIGN_DOWN(run_start, host_ratio)
>>   * run_start = QEMU_ALIGN_UP(run_start, host_ratio)
>> 
>> By doing so, run_start always points to the next HostPage to check.
>> fixup_start_addr always points to the HostPage to discard.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Yes that's a lot shorter;  note it doess it on top of your cleanup
>from a couple of weeks back.
>

You are right, I forget to mention it :-)

>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>
>> ---
>>  migration/ram.c | 34 +++++++---------------------------
>>  1 file changed, 7 insertions(+), 27 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c9585487ac..d86661a015 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2956,7 +2956,6 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>>      }
>>  
>>      while (run_start < pages) {
>> -        unsigned long fixup_start_addr;
>>          unsigned long host_offset;
>>  
>>          /*
>> @@ -2964,45 +2963,26 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>>           * page, then we need to fixup this host page.
>>           */
>>          host_offset = run_start % host_ratio;
>> -        if (host_offset) {
>> -            fixup_start_addr = run_start - host_offset;
>> -            /*
>> -             * This host page has gone, the next loop iteration starts
>> -             * from after the fixup
>> -             */
>> -            run_start = fixup_start_addr + host_ratio;
>> -        } else {
>> +        if (!host_offset) {
>>              /* Find the end of this run */
>> -            unsigned long run_end;
>>              if (unsent_pass) {
>> -                run_end = find_next_bit(unsentmap, pages, run_start + 1);
>> +                run_start = find_next_bit(unsentmap, pages, run_start + 1);
>>              } else {
>> -                run_end = find_next_zero_bit(bitmap, pages, run_start + 1);
>> +                run_start = find_next_zero_bit(bitmap, pages, run_start + 1);
>>              }
>>              /*
>>               * If the end isn't at the start of a host page, then the
>>               * run doesn't finish at the end of a host page
>>               * and we need to discard.
>>               */
>> -            host_offset = run_end % host_ratio;
>> -            if (host_offset) {
>> -                fixup_start_addr = run_end - host_offset;
>> -                /*
>> -                 * This host page has gone, the next loop iteration starts
>> -                 * from after the fixup
>> -                 */
>> -                run_start = fixup_start_addr + host_ratio;
>> -            } else {
>> -                /*
>> -                 * No discards on this iteration, next loop starts from
>> -                 * next sent/dirty page
>> -                 */
>> -                run_start = run_end + 1;
>> -            }
>> +            host_offset = run_start % host_ratio;
>>          }
>>  
>>          if (host_offset) {
>>              unsigned long page;
>> +            unsigned long fixup_start_addr = QEMU_ALIGN_DOWN(run_start,
>> +                                                             host_ratio);
>> +            run_start = QEMU_ALIGN_UP(run_start, host_ratio);
>>  
>>              /* Tell the destination to discard this page */
>>              if (unsent_pass || !test_bit(fixup_start_addr, unsentmap)) {
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

