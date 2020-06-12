Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC26C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 03:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BCC20823
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 03:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BCC20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jja2n-0001kx-MX
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 23:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maozhongyi@cmss.chinamobile.com>)
 id 1jja24-0001HG-HR
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 23:07:04 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:15285)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jja1z-000464-W8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 23:07:03 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65ee2f13ca77-4eca7;
 Fri, 12 Jun 2020 11:06:36 +0800 (CST)
X-RM-TRANSID: 2ee65ee2f13ca77-4eca7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.144.6] (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55ee2f13b5a9-cc943;
 Fri, 12 Jun 2020 11:06:36 +0800 (CST)
X-RM-TRANSID: 2ee55ee2f13b5a9-cc943
Subject: Re: [PATCH 9/9] migration/ram: calculate un/encoded_size only
 whenneeded.
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
 <20200603080904.997083-10-maozhongyi@cmss.chinamobile.com>
 <20200611190548.GE2969@work-vm>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <0e396c84-670b-9a54-0b2f-7ae0c0119588@cmss.chinamobile.com>
Date: Fri, 12 Jun 2020 11:06:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20200611190548.GE2969@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=221.176.66.80;
 envelope-from=maozhongyi@cmss.chinamobile.com; helo=cmccmta2.chinamobile.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 23:06:48
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, maozhongyi@cmss.chinamobile.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/12/20 3:05 AM, Dr. David Alan Gilbert wrote:
> * Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>   migration/ram.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 41cc530d9d..ca20030b64 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -910,14 +910,15 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
>>           xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
>>               rs->xbzrle_cache_miss_prev) / page_count;
>>           rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
>> -        encoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
>> -                         TARGET_PAGE_SIZE;
>> -        encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
>>           if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
>>               xbzrle_counters.encoding_rate = 0;
>> -        } else if (!encoded_size) {
>> +        } else if (xbzrle_counters.bytes == rs->xbzrle_bytes_prev) {
> 
> No, I don't think this change is worth it - this is really just the same
> as 'encoded_size', and then we may as well keep the two together.

ok, thanks, let's keep 'encode_size' here.

BTW, this change borrows from the behavior of comppressed:

...
         compressed_size = compression_counters.compressed_size -
                           rs->compressed_size_prev;
         if (compressed_size) {
             double uncompressed_size = (compression_counters.pages -
                                     rs->compress_pages_prev) * 
TARGET_PAGE_SIZE;

             /* Compression-Ratio = Uncompressed-size / Compressed-size */
             compression_counters.compression_rate =
                                         uncompressed_size / 
compressed_size;
...


It splits 'compressed_size' and 'uncompressed_size', and calculates
'uncompressed_size' only when needed. Although 'unencoded_size' is
calculated, it is not necessarily used. if you think this split is
unnecessary, just discard it, so do I need to drop this patch and
resend the v2?

Thanks,
Mao

> 
> Dave
> 
>>               xbzrle_counters.encoding_rate = UINT64_MAX;
>>           } else {
>> +            unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
>> +                             TARGET_PAGE_SIZE;
>> +            encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
>> +
>>               xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
>>           }
>>           rs->xbzrle_pages_prev = xbzrle_counters.pages;
>> -- 
>> 2.17.1
>>
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 



