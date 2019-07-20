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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5799C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0ACB21849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFRgD3pD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ACB21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeJy-0007F1-V9
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeJo-0006qB-UG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeJo-0002S7-0m
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:37:48 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hoeJn-0002RP-Qh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:37:47 -0400
Received: by mail-ed1-x541.google.com with SMTP id x19so30007908eda.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TuO/OqhMJsu0rI8Tqp8qeyMYei2x1mXe/RAZ1qhTFPo=;
 b=mFRgD3pDqz1idvWAuFk9BKBk1tlpiwGrxV3oNc9jtOm4uC/tstKg8zTWNBvzO7ZxH0
 TrnHJ/XGIq1QICOamsypyFLE23JJwK04kVOZ8FqY3droSx2CiAg1Bo7W34GIJtM7b73S
 mJjoP486L8/GnMwYv0fUdRr7pbGUIvIQ/Fz2jHVGksyyrGG+zvMEdm0icJgXXTCZHXHR
 8Z42gpsmcOCsT9Tfi5BO8ZFsPPHY1JaumZsrF0SRVjzSN2tOGQH0O/7njnwTI4/VT0Lp
 bahNxM2xscCznn9xAPkmfYbg4s+bBHGWaRjj92rrmosR2O+1PKLJ6wQ0EdLb4hgppMVo
 Hcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=TuO/OqhMJsu0rI8Tqp8qeyMYei2x1mXe/RAZ1qhTFPo=;
 b=hK+HHaUaN6Go1mnc7+kQC0GH3eByoZUwIW5G7DPhnRoN1lexqlK6CKlJ0FGRkZKM+G
 pI8Q5o55eUvjLL1GXnmdsiUxzlrtUpswZ4xgSrzC6GyBpP2oPvykJCb1nFwdSqU+qjoX
 x5wzdkFsInwaNQKbusrLipTGT2fqXyMelU7Zf0DHUxeYRj97fGGtVhvlKxX2GQFpoFmf
 3NPc8qbHs+vqOb87GpnhwZk/0SkLuNLQq1O832Zbqkc88vQ4m1OrBcmB/3S//2dr96EC
 OcTc7h4jHDIOukGwwBIEYUh/gifDrnuLOyCbiw0Qq5p6nbcukp4I/uBUo+1v/JE9iRTD
 p/Vw==
X-Gm-Message-State: APjAAAWNfR8yoOlEKbMEa5YvCTn74gUOF3OfPEFgY1VpEb7rM0RnHETy
 b0kq1WZRVYvXBeEfjNBu50w4ZCw/
X-Google-Smtp-Source: APXvYqzDVfuU0LI8Xrq8eg+Zz3+Lt1qzxJHpM3lOJNB64Te/5ne+DAs2vNEJ9gE5ntTwbkhFelGd+g==
X-Received: by 2002:a17:906:4d89:: with SMTP id
 s9mr43101854eju.160.1563586666916; 
 Fri, 19 Jul 2019 18:37:46 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id h10sm8518410edn.86.2019.07.19.18.37.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jul 2019 18:37:46 -0700 (PDT)
Date: Sat, 20 Jul 2019 01:37:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190720013745.orrrhp2iuh2tsatr@master>
References: <20190626004211.4822-1-richardw.yang@linux.intel.com>
 <20190719151002.GC3000@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719151002.GC3000@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] migration: current_migration is never NULL
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

On Fri, Jul 19, 2019 at 04:10:02PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> migration_object_init() create and assign current_migration, which means
>> it will never be null until migration_shutdown().
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/migration.c | 4 ----
>>  1 file changed, 4 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 0fd2364961..43fd8297ef 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1667,10 +1667,6 @@ bool migration_is_idle(void)
>>  {
>>      MigrationState *s = current_migration;
>>  
>> -    if (!s) {
>> -        return true;
>> -    }
>> -
>
>I'd prefer to keep that because it's used by migrate_add_blocker
>and without this check it means we'd only be able to add a blocker
>after the migration object init - which is probably fine but we
>would have to check all the cases and make sure no one breaks it in
>the future;  where as this check makes it just work and we don't
>need to worry about the order.
>

Reasonable, Thanks :-)

>Dave
>
>>      switch (s->state) {
>>      case MIGRATION_STATUS_NONE:
>>      case MIGRATION_STATUS_CANCELLED:
>> -- 
>> 2.19.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

