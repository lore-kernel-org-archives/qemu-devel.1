Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D56C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 01:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC97122387
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 01:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC97122387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq5mK-0003QP-5B
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 21:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34482)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hq5m9-0002zX-6E
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hq5m8-0004bU-3S
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:09:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:35615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hq5m7-0004ae-Rn
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:09:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jul 2019 18:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; d="scan'208";a="169726582"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2019 18:08:56 -0700
Date: Wed, 24 Jul 2019 09:08:32 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190724010832.GA2199@richard>
References: <20190720223939.11327-1-richardw.yang@linux.intel.com>
 <20190723172353.GO2719@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723172353.GO2719@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH] migration/postcopy: use mis->bh instead of
 allocating a QEMUBH
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

On Tue, Jul 23, 2019 at 06:23:53PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> For migration incoming side, it either quit in precopy or postcopy. It
>> is save to use the mis->bh for both instead of allocating a dedicated
>
>     ^^^^ 'safe' not 'save'
>

oops,  thanks for pointing out.

>> QEMUBH for postcopy.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Yes, I think that's OK; it's a little subtle.  Once postcopy is in 'run'
>then the main incoming code will exit before running it's bh, so you're
>right that it's free for us to use.
>
>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>  migration/savevm.c | 17 ++++-------------
>>  1 file changed, 4 insertions(+), 13 deletions(-)
>> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 25fe7ea05a..0105068579 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1856,16 +1856,10 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>>      return 0;
>>  }
>>  
>> -
>> -typedef struct {
>> -    QEMUBH *bh;
>> -} HandleRunBhData;
>> -
>>  static void loadvm_postcopy_handle_run_bh(void *opaque)
>>  {
>>      Error *local_err = NULL;
>> -    HandleRunBhData *data = opaque;
>> -    MigrationIncomingState *mis = migration_incoming_get_current();
>> +    MigrationIncomingState *mis = opaque;
>>  
>>      /* TODO we should move all of this lot into postcopy_ram.c or a shared code
>>       * in migration.c
>> @@ -1897,8 +1891,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
>>          runstate_set(RUN_STATE_PAUSED);
>>      }
>>  
>> -    qemu_bh_delete(data->bh);
>> -    g_free(data);
>> +    qemu_bh_delete(mis->bh);
>>  }
>>  
>>  /* After all discards we can start running and asking for pages */
>> @@ -1906,7 +1899,6 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
>>  {
>>      PostcopyState old_ps = POSTCOPY_INCOMING_LISTENING;
>>      PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_RUNNING, &old_ps);
>> -    HandleRunBhData *data;
>>  
>>      trace_loadvm_postcopy_handle_run();
>>      if (ps != old_ps) {
>> @@ -1914,9 +1906,8 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
>>          return -1;
>>      }
>>  
>> -    data = g_new(HandleRunBhData, 1);
>> -    data->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, data);
>> -    qemu_bh_schedule(data->bh);
>> +    mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
>> +    qemu_bh_schedule(mis->bh);
>>  
>>      /* We need to finish reading the stream from the package
>>       * and also stop reading anything more from the stream that loaded the
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

