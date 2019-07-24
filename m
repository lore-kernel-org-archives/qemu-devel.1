Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B18EC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 22:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B77421880
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 22:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfCs6Xjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B77421880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqPWk-0008Fg-5X
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 18:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50492)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hqPWZ-0007ii-Eq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 18:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hqPWY-0004i5-47
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 18:14:15 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hqPWX-0004hW-Ss
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 18:14:14 -0400
Received: by mail-ed1-x544.google.com with SMTP id p15so48394067eds.8
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=q1660KRXlea+tkHnI0A482rbUotIUgya/I+q885yiW8=;
 b=OfCs6XjgNeWhNEdyVdmZrR0EoGinBl7ehjMrr6akHioQF9XXfsY/t9xm93wkZykomX
 58wzYLqB2Oe5AetElWXSKa3mO0Z5YAdSYCnZUBYVWlxXuc8oOFfCroR/gmBnmJaoqFoX
 OdJqi507bprhT6vmHfLBClLu271nM1+Y/ml8s+PidptYSS1Gw5/iAXHW9813JhHJPOyP
 fq82r4Tw2B/tMNAums87l4mHKszcWOLddVCcBSoeGL6iaFQWS3dmbZUfv+cu8C6+Z979
 0pj4R/sOnSZObLskZ0PhvPVXNQmXljWlpd+31JhcIFVR5AsgGplK5PhcOcqgyfxn9CY8
 LktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=q1660KRXlea+tkHnI0A482rbUotIUgya/I+q885yiW8=;
 b=mjAvNGilncIoHTxYySMxVvSDfL0s3ztwg4W2PCPvJMDnfqiuJOde1s0+1PR4434pp2
 FynltxcQexbIKzVcbUAvgvV/eeN1SS+nmC3mAc0Jvogk++pv0PV0LymzGoHpV7Y9nPWI
 zXjC4fW7neWNbB8W/SDAhvJiVS8nTtAgKUo33Yv7edXszyv5n8exHC/z+gznroxy+V9I
 dPH2G4QvEqhvuO8Qm5TIKAlpNZaYqpoW6qRJcOL6wzYJ7HF3llg05UphQHWMw02fDz4+
 X+QD3M9bTWiwdZx75pI8AlDNAmI1FzsijHePhL/x70Sma1vgLL2cf9r5h4F46oZ5P/PY
 RI8g==
X-Gm-Message-State: APjAAAW0rMKvxwfnYKVUgSMgqyAf8T5syRY4BR4PWymLv69RuqKLKR2S
 NwPQxwP0uXpCONshFHVfvKc=
X-Google-Smtp-Source: APXvYqzkUK5p2ym0cYJtZS5mSyOAAkyaxQ+pwkGhWLjKgeXz5AzNNGXapvX0GE6cG3lAFR4sz8n5Qg==
X-Received: by 2002:a17:906:31c9:: with SMTP id
 f9mr65686520ejf.168.1564006452604; 
 Wed, 24 Jul 2019 15:14:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id o18sm12826506edq.18.2019.07.24.15.14.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Jul 2019 15:14:11 -0700 (PDT)
Date: Wed, 24 Jul 2019 22:14:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190724221411.nbw4mmxxgrejrk5y@master>
References: <20190722075339.25121-1-richardw.yang@linux.intel.com>
 <20190722075339.25121-3-richardw.yang@linux.intel.com>
 <20190723164703.GN2719@work-vm> <20190724012007.GC2199@richard>
 <20190724121024.GH2717@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724121024.GH2717@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: extract ram_load_precopy
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

On Wed, Jul 24, 2019 at 01:10:24PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> On Tue, Jul 23, 2019 at 05:47:03PM +0100, Dr. David Alan Gilbert wrote:
>> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> >> After cleanup, it would be clear to audience there are two cases
>> >> ram_load:
>> >> 
>> >>   * precopy
>> >>   * postcopy
>> >> 
>> >> And it is not necessary to check postcopy_running on each iteration for
>> >> precopy.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  migration/ram.c | 73 +++++++++++++++++++++++++++++++------------------
>> >>  1 file changed, 46 insertions(+), 27 deletions(-)
>> >> 
>> >> diff --git a/migration/ram.c b/migration/ram.c
>> >> index 6bfdfae16e..5f6f07b255 100644
>> >> --- a/migration/ram.c
>> >> +++ b/migration/ram.c
>> >> @@ -4200,40 +4200,26 @@ static void colo_flush_ram_cache(void)
>> >>      trace_colo_flush_ram_cache_end();
>> >>  }
>> >>  
>> >> -static int ram_load(QEMUFile *f, void *opaque, int version_id)
>> >> +/**
>> >> + * ram_load_precopy: load a page in precopy case
>> >
>> >This comment is wrong - although I realise you copied it from the
>> >postcopy case; they don't just load a single page; they load 'pages'
>> >
>> 
>> Thanks for pointing out.
>> 
>> Actually, I got one confusion in these two load. Compare these two cases, I
>> found precopy would handle two more cases:
>> 
>>   * precopy:  RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>>               RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE
>>   * postcopy: RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE
>> 
>> Why postcopy doesn't need to handle the other two cases? Function
>> ram_save_target_page() does the same thing in precopy and postcopy. I don't
>> find the reason the behavior differs. Would you mind giving me a hint?
>
>Because we don't support either compression or xbzrle with postcopy.
>Compression could be fixed, but it needs to make sure it uses the
>place-page function to atomically place the page.
>

Thanks for the explanation. Sounds I missed some point.

The place-page function to use is postcopy_place_page()?

>xbzrle never gets used during the postcopy stage; it gets used
>in the precopy stage in a migration that might switch to postcopy
>though.  Since xbzrle relies on optimising differences between
>passes, it's
>   1) Not needed in postcopy where there's only one final pass
>   2) Since the destination is changing RAM, you can't transmit
>      deltas relative to the old data, since that data may have
>      changed.
>
>Dave
>
>> >Other than that, I think it's OK, so:
>> >
>> >
>> >Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

