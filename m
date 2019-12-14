Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FEDC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5EE20866
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5EE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEgw-0003OZ-35
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1igEfZ-0002VT-91
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1igEfX-0004T1-ED
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:09:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:41617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1igEfX-00041m-3O
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:09:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Dec 2019 09:47:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,314,1571727600"; d="scan'208";a="239618593"
Received: from chenzh5-mobl2.ccr.corp.intel.com (HELO [10.249.175.19])
 ([10.249.175.19])
 by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2019 09:47:35 -0800
Subject: Re: [PATCH] colo: fix return without releasing RCU
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>
References: <1576246112-23406-2-git-send-email-pbonzini@redhat.com>
 <20191213150341.GG3713@work-vm>
From: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <344c0a76-6a7d-ae34-fa09-e49284789dbc@intel.com>
Date: Sun, 15 Dec 2019 01:47:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213150341.GG3713@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/13/2019 11:03 PM, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> Use WITH_RCU_READ_LOCK_GUARD to avoid exiting colo_init_ram_cache
>> without releasing RCU.
>>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>


>
>> ---
>>   migration/ram.c | 33 +++++++++++++++++----------------
>>   1 file changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 7dd7f81..8d7c015 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3891,26 +3891,27 @@ int colo_init_ram_cache(void)
>>   {
>>       RAMBlock *block;
>>   
>> -    rcu_read_lock();
>> -    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> -        block->colo_cache = qemu_anon_ram_alloc(block->used_length,
>> -                                                NULL,
>> -                                                false);
>> -        if (!block->colo_cache) {
>> -            error_report("%s: Can't alloc memory for COLO cache of block %s,"
>> -                         "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
>> -                         block->used_length);
>> -            RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> -                if (block->colo_cache) {
>> -                    qemu_anon_ram_free(block->colo_cache, block->used_length);
>> -                    block->colo_cache = NULL;
>> +    WITH_RCU_READ_LOCK_GUARD() {
>> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> +            block->colo_cache = qemu_anon_ram_alloc(block->used_length,
>> +                                                    NULL,
>> +                                                    false);
>> +            if (!block->colo_cache) {
>> +                error_report("%s: Can't alloc memory for COLO cache of block %s,"
>> +                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
>> +                             block->used_length);
>> +                RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> +                    if (block->colo_cache) {
>> +                        qemu_anon_ram_free(block->colo_cache, block->used_length);
>> +                        block->colo_cache = NULL;
>> +                    }
>>                   }
>> +                return -errno;
>>               }
>> -            return -errno;
>> +            memcpy(block->colo_cache, block->host, block->used_length);
>>           }
>> -        memcpy(block->colo_cache, block->host, block->used_length);
>>       }
>> -    rcu_read_unlock();
>> +
>>       /*
>>       * Record the dirty pages that sent by PVM, we use this dirty bitmap together
>>       * with to decide which page in cache should be flushed into SVM's RAM. Here
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

