Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA10C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 06:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD3921882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 06:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD3921882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSar7-0006YS-Fz
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 01:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iSaqP-00063C-60
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 01:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iSaqN-0002fL-TW
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 01:00:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:36796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iSaqN-0002Mw-KA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 01:00:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 22:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; d="scan'208";a="233146158"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 22:00:22 -0800
Date: Thu, 7 Nov 2019 14:00:11 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 5/6] migration/postcopy: enable random order target page
 arrival
Message-ID: <20191107060010.GA13394@richard>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <20191018004850.9888-6-richardw.yang@linux.intel.com>
 <20191106200828.GL2802@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106200828.GL2802@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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

On Wed, Nov 06, 2019 at 08:08:28PM +0000, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> After using number of target page received to track one host page, we
>> could have the capability to handle random order target page arrival in
>> one host page.
>> 
>> This is a preparation for enabling compress during postcopy.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/ram.c | 16 +++-------------
>>  1 file changed, 3 insertions(+), 13 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index b5759793a9..da0596411c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -4015,7 +4015,6 @@ static int ram_load_postcopy(QEMUFile *f)
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>      /* Temporary page that is later 'placed' */
>>      void *postcopy_host_page = mis->postcopy_tmp_page;
>> -    void *last_host = NULL;
>>      bool all_zero = false;
>>      int target_pages = 0;
>>  
>> @@ -4062,24 +4061,15 @@ static int ram_load_postcopy(QEMUFile *f)
>>               * that's moved into place later.
>>               * The migration protocol uses,  possibly smaller, target-pages
>>               * however the source ensures it always sends all the components
>> -             * of a host page in order.
>> +             * of a host page in one chunk.
>>               */
>>              page_buffer = postcopy_host_page +
>>                            ((uintptr_t)host & (block->page_size - 1));
>>              /* If all TP are zero then we can optimise the place */
>>              if (target_pages == 1) {
>>                  all_zero = true;
>> -            } else {
>> -                /* not the 1st TP within the HP */
>> -                if (host != (last_host + TARGET_PAGE_SIZE)) {
>> -                    error_report("Non-sequential target page %p/%p",
>> -                                  host, last_host);
>> -                    ret = -EINVAL;
>> -                    break;
>> -                }
>
>I think this is losing more protection than needed.
>I think you can still protect against a page from a different host-page
>arriving until we've placed the current host-page.
>So something like:
>
>    if (((uintptr_t)host & ~(block->page_size - 1)) !=
>        last_host)
>

OK, looks reasonable.

>and then set last_host to the start of the host page.
>

I think it is not necessary to update the last_host on each target page. We
can just set it at the first target page.

>Then you'll check if that flush is really working.
>
>Dave
>
>>              }
>>  
>> -
>>              /*
>>               * If it's the last part of a host page then we place the host
>>               * page
>> @@ -4090,7 +4080,6 @@ static int ram_load_postcopy(QEMUFile *f)
>>              }
>>              place_source = postcopy_host_page;
>>          }
>> -        last_host = host;
>>  
>>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
>>          case RAM_SAVE_FLAG_ZERO:
>> @@ -4143,7 +4132,8 @@ static int ram_load_postcopy(QEMUFile *f)
>>  
>>          if (!ret && place_needed) {
>>              /* This gets called at the last target page in the host page */
>> -            void *place_dest = host + TARGET_PAGE_SIZE - block->page_size;
>> +            void *place_dest = (void *)QEMU_ALIGN_DOWN((unsigned long)host,
>> +                                                       block->page_size);
>>  
>>              if (all_zero) {
>>                  ret = postcopy_place_page_zero(mis, place_dest,
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

