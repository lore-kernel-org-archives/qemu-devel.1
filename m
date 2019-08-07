Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC16C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 22:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024A22089E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 22:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwyitQcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024A22089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvU5K-0002tZ-5K
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 18:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47023)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hvU4g-0002Ro-HF
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 18:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hvU4f-0001Zx-I2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 18:06:26 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hvU4f-0001ZG-9s
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 18:06:25 -0400
Received: by mail-ed1-x542.google.com with SMTP id w20so87996154edd.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Q6zI2PweNOX7jbOdwdPf9A34zZwyEeiIDpJnvIcO1A8=;
 b=HwyitQcl/TKPJTw3TLNam0HQyXuj3bf/ooZUWXkIN4zMkXHD4+nJBYqc8rFnqkUnnZ
 yKrPPghoxAlMrRLif+cPmYUbDRozFrqsaj5vgVyaTwYWVmKNS5Y+ADXZ7ccdy4UBjSdy
 mRY28JQcwJXRVNofl0BPS8Nc9Q+0J3YiVWE3ozc+rCr2PrypxVy1ZWUEHF/5yx9vrEWX
 hlnP7QHjrfGB3zFOxZmLJWPw83qTAFshTnu8sxS5h+RVBAvfrP+oKfW9xHeUKDXG85VC
 rGkgrfWeWp6SAsCsL5CxY3cSEJTc2/+uTf4DKIy9C3k1LYLwWe0FbvexFccd8cFLPyag
 Tvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q6zI2PweNOX7jbOdwdPf9A34zZwyEeiIDpJnvIcO1A8=;
 b=PA5MF1AVnC8oPlACr+Sn48iBVHB+vzf2lYBFEj8m2a9nDDTxgoe8owJWmli4SKl5ZO
 BEez5E2JZ53mL3qHq1LrjPHlfvRFUYyHRxdpQk28qCfclTp7q498f/BdZQlNGw/bywbA
 IpRCprP/K9x0KKNcqTktax5fIVCj27wNPtDqmobEQgh73f2fm2BoCpKVAW2NhG1zC/an
 /QN6qRmv6OKZdhKq8Ey9pypGE6HaAcNz0Iq/G81q8IzNUsS6lIxRflOTlq6gerYh08cr
 MBOl1vCD1YOPDywPn+FLFVJkSNpmSNYEJ5PTgjidOrvTP+0oqnqE5XEpnmPQz8ATf1Wx
 DM+A==
X-Gm-Message-State: APjAAAV9CO6RdV1ewILTeu7HDUv/iZ8CQ2YnwDSI4UBcyDN8R+o4Wn9B
 swHGuZzUBEdZFmXC12HNXlY=
X-Google-Smtp-Source: APXvYqyMmLTjtvAs2n/h+9eZC+BCb2sbWhxYxcWkq5EDwxZPKHw3TGhqWYYkg3BylNraze0Bpth77g==
X-Received: by 2002:a17:907:2101:: with SMTP id
 qn1mr10549346ejb.3.1565215583777; 
 Wed, 07 Aug 2019 15:06:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id g11sm15230254ejm.86.2019.08.07.15.06.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 07 Aug 2019 15:06:22 -0700 (PDT)
Date: Wed, 7 Aug 2019 22:06:22 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190807220622.er4n4mo2fdxtca4e@master>
References: <20190718084816.6990-1-richardw.yang@linux.intel.com>
 <20190807174948.GK27871@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807174948.GK27871@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] migration: rename
 migration_bitmap_sync_range to ramblock_sync_dirty_bitmap
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
Cc: pbonzini@redhat.com, quintela@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 06:49:48PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> Rename for better understanding of the code.
>> 
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>this needs fixing after 'just pass RAMBlock is enough'
>

You mean rebase it? Hmm... let me take a look.

>Dave
>
>> ---
>>  migration/ram.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c5f9f4b0ef..66792568e2 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1669,7 +1669,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>>      return ret;
>>  }
>>  
>> -static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
>> +static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb,
>>                                          ram_addr_t length)
>>  {
>>      rs->migration_dirty_pages +=
>> @@ -1762,7 +1762,7 @@ static void migration_bitmap_sync(RAMState *rs)
>>      qemu_mutex_lock(&rs->bitmap_mutex);
>>      rcu_read_lock();
>>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> -        migration_bitmap_sync_range(rs, block, block->used_length);
>> +        ramblock_sync_dirty_bitmap(rs, block, block->used_length);
>>      }
>>      ram_counters.remaining = ram_bytes_remaining();
>>      rcu_read_unlock();
>> @@ -4175,7 +4175,7 @@ static void colo_flush_ram_cache(void)
>>      memory_global_dirty_log_sync();
>>      rcu_read_lock();
>>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> -        migration_bitmap_sync_range(ram_state, block, block->used_length);
>> +        ramblock_sync_dirty_bitmap(ram_state, block, block->used_length);
>>      }
>>      rcu_read_unlock();
>>  
>> -- 
>> 2.17.1
>> 
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

