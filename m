Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E0C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 12:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0B02080C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 12:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcjrNp3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0B02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2EGn-0005UM-EQ
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 08:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i2EFs-000533-59
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i2EFq-0004A4-Vi
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:37:51 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i2EFq-00048q-Mw
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:37:50 -0400
Received: by mail-ed1-x541.google.com with SMTP id r12so26310172edo.5
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hFwS4xrvTlMHCaSxaZ2tYxQRTDE8swQvFt53Y5SQtdc=;
 b=RcjrNp3MzjUC0UnYPoJWullbn2aEoKWqYwXpVfc3ecybeyE17HjwCsAg7OPqXUPpi1
 SYg9fnsQDFY3DBm1tPuc9VABbSBokTtePBWcv8+/+X2b2iophHUwMjyeaZTRt92LoBaD
 H5gjeTZqARoB7Rn7SlYlV7i+jG6BYObxkqessaKivlAbP/XQ2swT1ly+07HvflH5ailV
 KqzlK2R2rcSokhRIBCOAUDarszI6UKSrK1mLjMNsH08i6DjjKWpyWOGISDNoaCLhH8CL
 pGE0XSgXMb/eqKZhEVAymHFqYkxhz1wP+qIt+7MUd3uxZeLornhn7oKxVSZG0DsZNPLq
 dFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=hFwS4xrvTlMHCaSxaZ2tYxQRTDE8swQvFt53Y5SQtdc=;
 b=nzPgsl09+USMkvafHARcYMpv4dkSlqSTuTgBU/LYgPyFSPkM4qM1HMtPssNfAHOC0u
 SfpmRv+F/yGE3f8qpX9cQq8sHMTyvjF8Zv6XfmnLMUUBTSgrCAhifzqBfZ98aEDCaKef
 BSShZ8hZ58GfyrQPDWe0x+JJRgnrL4TWq+t2vS+I+aoCkNfDeguuvpT4ehYWId349KHN
 xfwdltBo32Vwrom2vlenqF+6LCDWSnOGmANZs4ek56YaWy5XfBL8ajQQyFS08eH9nn19
 WXIEf19Bq/5uSJdvVZvCFjcUtToPeQqQsV8WTuRjVh48rO7Q4RkvWw/+vCIr+Wtfbunz
 JNmg==
X-Gm-Message-State: APjAAAXA5aA96dH2FWI7svU0KjO2t0IS9KRHNS8p+PiLDZTx+ghS0Zkd
 hLaaWNPpE3FlTl/okvvskIk=
X-Google-Smtp-Source: APXvYqzpB4BMWNoeh7B414xQp6r9IaxZ00dGntadA16MICI/g0TNmcBCcppgp5/Hg1DQQaH8H8MP7A==
X-Received: by 2002:a17:906:8481:: with SMTP id
 m1mr16359202ejx.43.1566823068994; 
 Mon, 26 Aug 2019 05:37:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id f2sm1265061eds.87.2019.08.26.05.37.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 26 Aug 2019 05:37:47 -0700 (PDT)
Date: Mon, 26 Aug 2019 12:37:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190826123747.i4anq4suy5gi76jg@master>
References: <20190725032722.32271-1-richardw.yang@linux.intel.com>
 <20190823162701.GQ2784@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823162701.GQ2784@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [RFC PATCH] migration/postcopy: skip compression
 when postcopy is active
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

On Fri, Aug 23, 2019 at 05:27:01PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> Now postcopy is not compatible with compression. And we disable setting
>> these two capability at the same time. While we can still leverage
>> compress before postcopy is active, for example at the bulk stage.
>> 
>> This patch skips compression when postcopy is active instead of
>> forbidding setting these capability at the same time.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>So I think this is OK, because ram_save_complete has a call to
>flush_compressed_data in it.
>
>However I think we should hold it until you figure out the other series
>that really enables compress; the problem is that as soon as you
>allow the capability, then there's nothing to distinguish this version
>and the version that fully enables it.  So how would you stop this
>version being used as the source to the version which fully enables it?
>
>So I think if we do the other series, then you should start off like
>this and then remove the capability check right at the end.
>

Agree, it is not proper to leave this middle state.

>Dave
>
>> ---
>>  migration/migration.c | 11 -----------
>>  migration/ram.c       | 10 ++++++++++
>>  2 files changed, 10 insertions(+), 11 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5a496addbd..33c373033d 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -995,17 +995,6 @@ static bool migrate_caps_check(bool *cap_list,
>>  #endif
>>  
>>      if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
>> -        if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
>> -            /* The decompression threads asynchronously write into RAM
>> -             * rather than use the atomic copies needed to avoid
>> -             * userfaulting.  It should be possible to fix the decompression
>> -             * threads for compatibility in future.
>> -             */
>> -            error_setg(errp, "Postcopy is not currently compatible "
>> -                       "with compression");
>> -            return false;
>> -        }
>> -
>>          /* This check is reasonably expensive, so only when it's being
>>           * set the first time, also it's only the destination that needs
>>           * special support.
>> diff --git a/migration/ram.c b/migration/ram.c
>> index da12774a24..a0d3bc60b2 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2384,6 +2384,16 @@ static bool save_page_use_compression(RAMState *rs)
>>          return false;
>>      }
>>  
>> +    /*
>> +     * The decompression threads asynchronously write into RAM
>> +     * rather than use the atomic copies needed to avoid
>> +     * userfaulting.  It should be possible to fix the decompression
>> +     * threads for compatibility in future.
>> +     */
>> +    if (migration_in_postcopy()) {
>> +        return false;
>> +    }
>> +
>>      /*
>>       * If xbzrle is on, stop using the data compression after first
>>       * round of migration even if compression is enabled. In theory,
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

