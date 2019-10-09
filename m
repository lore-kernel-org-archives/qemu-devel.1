Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D01AC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64732206C2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64732206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI0WB-0003S0-JS
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iI0VS-0002zq-6n
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iI0VQ-0002Nj-SY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:11:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:21434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iI0VQ-0002MD-JO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:11:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 18:11:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; d="scan'208";a="345209452"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga004.jf.intel.com with ESMTP; 08 Oct 2019 18:11:05 -0700
Date: Wed, 9 Oct 2019 09:10:48 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] migration/postcopy: map large zero page in
 postcopy_ram_incoming_setup()
Message-ID: <20191009011048.GD26203@richard>
References: <20191005135021.21721-1-richardw.yang@linux.intel.com>
 <20191005135021.21721-3-richardw.yang@linux.intel.com>
 <20191008172423.GH3441@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008172423.GH3441@work-vm>
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
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 06:24:23PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> postcopy_ram_incoming_setup() and postcopy_ram_incoming_cleanup() are
>> counterpart. It is reasonable to map/unmap large zero page in these two
>> functions respectively.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Yes, OK.
>
>> ---
>>  migration/postcopy-ram.c | 34 +++++++++++++++++-----------------
>>  1 file changed, 17 insertions(+), 17 deletions(-)
>> 
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index e554f93eec..813cfa5c42 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -1142,6 +1142,22 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>>          return -1;
>>      }
>>  
>> +    /*
>> +     * Map large zero page when kernel can't use UFFDIO_ZEROPAGE for hugepages
>> +     */
>> +    mis->postcopy_tmp_zero_page = mmap(NULL, mis->largest_page_size,
>> +                                       PROT_READ | PROT_WRITE,
>> +                                       MAP_PRIVATE | MAP_ANONYMOUS,
>> +                                       -1, 0);
>> +    if (mis->postcopy_tmp_zero_page == MAP_FAILED) {
>> +        int e = errno;
>> +        mis->postcopy_tmp_zero_page = NULL;
>> +        error_report("%s: Failed to map large zero page %s",
>> +                     __func__, strerror(e));
>> +        return -e;
>
>Note this starts returning -errno where the rest of this function
>returns 0 or -1;  returning -errno is a good thing I think and it might
>be good to change the other returns.
>

This is reasonable, while I am thinking how caller would handle this.

For example, the return value would be finally returned to
qemu_loadvm_state_main(). If we handle each errno respectively in this
function, the code would be difficult to read and maintain.

Would it be good to classify return value to different category? Like

  POSTCOPY_FATAL
  POSTCOPY_RETRY
  POSTCOPY_DISABLE

>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> +    }
>> +    memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
>> +
>>      /*
>>       * Ballooning can mark pages as absent while we're postcopying
>>       * that would cause false userfaults.
>> @@ -1248,23 +1264,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>>                                             qemu_ram_block_host_offset(rb,
>>                                                                        host));
>>      } else {
>> -        /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
>> -        if (!mis->postcopy_tmp_zero_page) {
>> -            mis->postcopy_tmp_zero_page = mmap(NULL, mis->largest_page_size,
>> -                                               PROT_READ | PROT_WRITE,
>> -                                               MAP_PRIVATE | MAP_ANONYMOUS,
>> -                                               -1, 0);
>> -            if (mis->postcopy_tmp_zero_page == MAP_FAILED) {
>> -                int e = errno;
>> -                mis->postcopy_tmp_zero_page = NULL;
>> -                error_report("%s: %s mapping large zero page",
>> -                             __func__, strerror(e));
>> -                return -e;
>> -            }
>> -            memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
>> -        }
>> -        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
>> -                                   rb);
>> +        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page, rb);
>>      }
>>  }
>>  
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

