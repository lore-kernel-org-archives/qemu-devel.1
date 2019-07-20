Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259AAC7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC5F21872
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP3OdzoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC5F21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeWv-0003tg-R4
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeWm-0003UP-4E
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeWl-0008KG-2b
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:51:12 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hoeWk-0008Jo-Ph
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:51:11 -0400
Received: by mail-ed1-x542.google.com with SMTP id w13so35957842eds.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c1Jc2G8QsWbtRKB+w/09uFD4jpkzYZPHbODs61ISE1E=;
 b=uP3OdzoRhorImtMDZBua5lAKpDik0CMTVhv8kJLmRxl81IDvsUmWWSfjC92BByXlXW
 6NvwGXEBCEdfRYmF86Loo8FsdWQAf8ynzlqk4vvBHNKqSV9sGJu6wL1izHl/aruV1v7h
 WypLyXJobIkNmCd6Eiy7H0h5xViMwaacWZ8nILRIu6x2BvurkWlsZqzG9UR7V3dKvCTT
 cLBGUarHa2A669NIYIrtM8LkQX6Wa9bIOkWqLalyuHqvm9W0Lon9oeYatD3enNnLjTEE
 woTLClNVyJiHAdnVp6j1CYp6UM2kAeDBZp2+E6u8DCvUC6m3FjuQiw7i0VK7uGzwOccW
 phuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=c1Jc2G8QsWbtRKB+w/09uFD4jpkzYZPHbODs61ISE1E=;
 b=DueNwmfN8Sf0UxgxQWACSPd/QoWl9ZaSaoxa7bvNh8vCe4een/Hc53bt3knUTCK9Tp
 qOkO8A+/AAaVoXO80f2v35v6YU8C67QW3YSJRcO3WWgoalmV9oihIFOyc1jH/UUaEvP4
 ML2HkPicq1NaOBUae11SQph5oyWXwVtZlZGaXb8K92dByRag8OKn8NbOvbpD5tZgYlkq
 4Cf23J8t6zAXWCVNjEycLck3IWzxD+XOhTpc28ZuDOiDZwcQiX9tOfra6jmiUD5G5u4H
 WLyBSLmqbi3whHixGljbg2TG7dGUZym0KgGXo+xyGnWT47my54XnqL7H046TiwDbOy3E
 13jw==
X-Gm-Message-State: APjAAAWfoWLOUEX24KXw/EAdlJOs544Fo+E4bcBc4soiDSK/RyVbGYXY
 N+qkttUONPOR+60VS/2nv48=
X-Google-Smtp-Source: APXvYqynxZwFolkx02o+6rrw6V4efjoNZtWsMEoblSiUf7R+n5YGX+TrLSKqVANCBoN+VeJjvk00Mw==
X-Received: by 2002:a17:906:504e:: with SMTP id
 e14mr43811646ejk.204.1563587469727; 
 Fri, 19 Jul 2019 18:51:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id q18sm6313526ejm.5.2019.07.19.18.51.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jul 2019 18:51:09 -0700 (PDT)
Date: Sat, 20 Jul 2019 01:51:08 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190720015108.xsme76myaoyukq5h@master>
References: <20190710081111.10302-1-richardw.yang@linux.intel.com>
 <20190719174128.GI3000@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719174128.GI3000@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] migration/postcopy: use static
 PostcopyDiscardState instead of allocating it for each block
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 06:41:28PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> Even we need to do discard for each RAMBlock, we still can leverage the
>> same memory space to store the information.
>> 
>> By doing so, we avoid memory allocation and deallocation to the system
>> and also avoid potential failure of memory allocation which breaks the
>> migration.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/postcopy-ram.c | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>> 
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 9faacacc9e..2e6b076bb7 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -1377,8 +1377,7 @@ void postcopy_fault_thread_notify(MigrationIncomingState *mis)
>>   *   asking to discard individual ranges.
>>   *
>>   * @ms: The current migration state.
>> - * @offset: the bitmap offset of the named RAMBlock in the migration
>> - *   bitmap.
>> + * @offset: the bitmap offset of the named RAMBlock in the migration bitmap.
>>   * @name: RAMBlock that discards will operate on.
>>   *
>>   * returns: a new PDS.
>> @@ -1386,13 +1385,14 @@ void postcopy_fault_thread_notify(MigrationIncomingState *mis)
>>  PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
>>                                                   const char *name)
>>  {
>> -    PostcopyDiscardState *res = g_malloc0(sizeof(PostcopyDiscardState));
>> +    static PostcopyDiscardState res = {0};
>
>Do you think it would be better to make this a static at the top of
>migration/postcopy-ram.c and then we could remove the pds parameters
>from postcopy_discard_send_range and friends?
>If there's only one pds then we don't need to pass the pointer around.
>

It sounds better to me, let me prepare v2.

Thanks

>Dave
>
>> -    if (res) {
>> -        res->ramblock_name = name;
>> -    }
>> +    res.ramblock_name = name;
>> +    res.cur_entry = 0;
>> +    res.nsentwords = 0;
>> +    res.nsentcmds = 0;
>>  
>> -    return res;
>> +    return &res;
>>  }
>>  
>>  /**
>> @@ -1449,8 +1449,6 @@ void postcopy_discard_send_finish(MigrationState *ms, PostcopyDiscardState *pds)
>>  
>>      trace_postcopy_discard_send_finish(pds->ramblock_name, pds->nsentwords,
>>                                         pds->nsentcmds);
>> -
>> -    g_free(pds);
>>  }
>>  
>>  /*
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

