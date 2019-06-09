Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15384C28EBD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 19:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF04206BB
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 19:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUCaCRT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF04206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37968 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha3qs-0002K3-TB
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 15:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1ha3p8-0000zM-9H
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 15:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1ha3p7-00033P-AK
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 15:49:50 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1ha3p7-000315-1m
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 15:49:49 -0400
Received: by mail-ed1-x544.google.com with SMTP id p15so11070391eds.8
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mkDpxItyHvEjeL3jVf5/iMYhcYhxocG8QpLgwVIpgnw=;
 b=MUCaCRT1K115VzsIquJEqAGzfxbj7bLcSm+xiehzK3G5o/U5VeZcoRGjpaR0imcio/
 u0HOzldLspZiR6L87g3HWdjjJ5tI6pmQB+gSp6zs/LUyaKc7x3YjM5s3ZsoRE1TBSlFW
 hBdQrPj/NXEk2P+J+CAXqRZ6h7oJ2Rv0dI/45lZbqhCDxT3lk4UwremldkE9MwVGxlsq
 xsb+/NBk1F7WlRrrA0YXK+O2AciNK0OhjVrpGUMjfcIdIikmRUoEeS/4IWZORNQwo9/O
 vn2ClWoVtWmxCTr3Rj78OmD8TlUydgPorW61089k8ob0Gih5EyoKctwFoUmV2nmhynhc
 tx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=mkDpxItyHvEjeL3jVf5/iMYhcYhxocG8QpLgwVIpgnw=;
 b=U0tnxNuDq2t+Zn7/cTSacSGos6CaCxS3rFcILCP7iM5TrkA1xDv1BeBFGa9mk9ZqCs
 ianaYjylCH2Egp1karjXnTm92zqw+fDhws5BMdRkC+fWXAuYUz9mv+NgVsqWaMQ5HNPT
 pbazpprPDgsWCg1owX77htmYLmYZ3k3V8pFf/UHNrAGjoWGUuIjDX++n+1YWpF1ohpn8
 M3jCBzD+2Ck6h1ElS9HUSnU8hwVXvHtlwpCt57RvsEsDdJLDpl1vcoArkWbWJFOZWC2p
 1eJZ3F0So/TPXEBKpRLSCsh77r4Ykn/O5gYLfcBdp83IWOflgFwozEf8eP4c1hHRHqrE
 KhRQ==
X-Gm-Message-State: APjAAAXKkbBPI30h6VlKYFTscVRpX7t5zhctnjysFTnEa3+AA15SKTvj
 K09XpyxIoqoBREmxsNYgMy8=
X-Google-Smtp-Source: APXvYqzl3MZxaQy1r2HcMQHs7DjNKMqzF30iMiWrLwImWHzqe+c+n25SR3ZBTonCk4aRqkZMygF2Pg==
X-Received: by 2002:a50:ba28:: with SMTP id g37mr48260399edc.109.1560109786224; 
 Sun, 09 Jun 2019 12:49:46 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id d16sm2294040edx.85.2019.06.09.12.49.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Jun 2019 12:49:45 -0700 (PDT)
Date: Sun, 9 Jun 2019 19:49:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190609194945.hpovxgad75565hlw@master>
References: <20190606013138.13312-1-richardw.yang@linux.intel.com>
 <20190606013138.13312-3-richardw.yang@linux.intel.com>
 <20190607190114.GA2631@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607190114.GA2631@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/xbzrle: cleanup the handling
 cache miss condition
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

On Fri, Jun 07, 2019 at 08:01:14PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> For cache miss condition not in last_stage, we need to insert data into
>> cache. When this step succeed, current_data should be updated. While no
>> matter these checks pass or not, -1 is returned.
>> 
>> Based on this, the logic in cache miss handling could be simplified a
>> little.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/ram.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 878cd8de7a..67ba075cc4 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1572,15 +1572,14 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>>      if (!cache_is_cached(XBZRLE.cache, current_addr,
>>                           ram_counters.dirty_sync_count)) {
>>          xbzrle_counters.cache_miss++;
>> -        if (!last_stage) {
>> -            if (cache_insert(XBZRLE.cache, current_addr, *current_data,
>> -                             ram_counters.dirty_sync_count) == -1) {
>> -                return -1;
>> -            } else {
>> -                /* update *current_data when the page has been
>> -                   inserted into cache */
>> -                *current_data = get_cached_data(XBZRLE.cache, current_addr);
>> -            }
>> +        if (!last_stage &&
>> +            !cache_insert(XBZRLE.cache, current_addr, *current_data,
>> +                          ram_counters.dirty_sync_count)) {
>> +            /*
>> +             * update *current_data when the page has been inserted into
>> +             * cache
>> +             */
>> +            *current_data = get_cached_data(XBZRLE.cache, current_addr);
>
>No this change doesn't gain anything and I find the original easier to
>read.
>
>This function is really subtle, every time I do anything with it I have
>to think really hard about it, so ease of reading is more important.
>

Yep, I agree ease of reading is more important.

Since the original version looks better, I will keep current code. :-)

>Dave
>
>>          }
>>          return -1;
>>      }
>> -- 
>> 2.19.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

