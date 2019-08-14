Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7569C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4522208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ov/ssR9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4522208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxvlT-0003NR-78
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 12:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1hxviP-0000dk-CU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hxviO-0001oG-7f
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:01:33 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hxviO-0001nn-1T
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:01:32 -0400
Received: by mail-ed1-x544.google.com with SMTP id w20so110323407edd.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=j66cV8/76NbbobAspWp/vhWKK1gcvOimhemLfXDXytw=;
 b=ov/ssR9PbONs9lXByoN8hbGDWciwUgCDCeR8kexiLsGusl3aLt27XBMb4+YPJwinm8
 ilHrRBsQCI89dXNyGzDtPBVXWtDw1TI0XDrg4x4zPfbz20y1xoZ9MJhzfznsJSZ6DwDE
 tth0d9MU/kS88fh59RDADmgT4xclOs9r9V0Bxzgnkfr83g1Az0dcHvUawCi1fF1XpP2E
 6gQiXgLm2uhNYQ4POLjbJ6lj6asxyZNmM4Xe6uv+TpwTdpfknqkKfNW4x/GsPoCWnGta
 Bis6V1JK2guyYFIlVKaBPlmBftPt/PnZX/8rwl88KTBRBgo3nfTIXKyLoCC9oFgYRegm
 68ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=j66cV8/76NbbobAspWp/vhWKK1gcvOimhemLfXDXytw=;
 b=itclr3VS04aE7lxw0qv1RwZoH9/YwaIu3z1TlCyXoROgj1w+iDYKCjLha+opKRp3aJ
 yLQRjkNYyCFLD6dqHLqOvZMDVR/gRVnG0yPjNvkaS0Q0bRHRG9DrzzoiywR/gq/phjuv
 Sf4dcxUWHpo5LsiRd1jiSFx1gqN4ClsV4AL9oI4nHWKa8yr3Fp9vgCj/kFOlq2FQS8Og
 PdrTC0Ys8fc6ySmCbxCcQvqg5kmQFI3guzYgxXQnBMMFuUXdjF6Po2qxMgpAVdala2mK
 NrV6g9oRFWIKymMlatUf8iwXW/tHKSRbCiLv7gyHHkfmudKssX+wwmJ1Zf85HZ02IRbA
 W8dg==
X-Gm-Message-State: APjAAAUo/ikdJ+HnCY7EXxp+BUu8yMAKpbaso5BX1jS4123prChcsP1X
 f5Tpp9lCm6amojvLw9NdbhL9BsLs
X-Google-Smtp-Source: APXvYqyctzsCO6Hf7GhVdxn0vLw4DrKypH2+rMvVKLG9hHJjKZZtafa/hidZOwO0l2kCDjjR5gtwRw==
X-Received: by 2002:aa7:d5cf:: with SMTP id d15mr313175eds.67.1565798490681;
 Wed, 14 Aug 2019 09:01:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id w3sm38812edu.4.2019.08.14.09.01.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 14 Aug 2019 09:01:29 -0700 (PDT)
Date: Wed, 14 Aug 2019 16:01:29 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190814160129.x3bhh7glunfw6rxn@master>
References: <20190814002723.5140-1-richardw.yang@linux.intel.com>
 <2ff8a0a8-f665-1bb4-5073-1697bee22bfc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff8a0a8-f665-1bb4-5073-1697bee22bfc@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] test-bitmap: test set 1 bit case for
 bitmap_set
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
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de,
 qemu-devel@nongnu.org, peterx@redhat.com, kraxel@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 14, 2019 at 02:38:24PM +0200, Paolo Bonzini wrote:
>On 14/08/19 02:27, Wei Yang wrote:
>> All current bitmap_set test cases set range across word, while the
>> handle of a range within one word is different from that.
>> 
>> Add case to set 1 bit as a represent for set range within one word.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> 
>> ---
>> Thanks for Paolo's finding.
>> 
>> ---
>>  tests/test-bitmap.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> 
>> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
>> index 18aa584591..087e02a26c 100644
>> --- a/tests/test-bitmap.c
>> +++ b/tests/test-bitmap.c
>> @@ -67,6 +67,18 @@ static void bitmap_set_case(bmap_set_func set_func)
>>  
>>      bmap = bitmap_new(BMAP_SIZE);
>>  
>> +    /* Set one bit at offset in second word */
>> +    for (offset = 0; offset <= BITS_PER_LONG; offset++) {
>> +        bitmap_clear(bmap, 0, BMAP_SIZE);
>> +        set_func(bmap, BITS_PER_LONG + offset, 1);
>> +        g_assert_cmpint(find_first_bit(bmap, 2 * BITS_PER_LONG),
>> +                        ==, BITS_PER_LONG + offset);
>> +        g_assert_cmpint(find_next_zero_bit(bmap,
>> +                                           3 * BITS_PER_LONG,
>> +                                           BITS_PER_LONG + offset),
>> +                        ==, BITS_PER_LONG + offset + 1);
>> +    }
>> +
>>      /* Both Aligned, set bits [BITS_PER_LONG, 3*BITS_PER_LONG] */
>>      set_func(bmap, BITS_PER_LONG, 2 * BITS_PER_LONG);
>>      g_assert_cmpuint(bmap[1], ==, -1ul);
>> 
>
>Queued, thanks for writing the testcase without no one asking! :)
>

My pleasure to help :)

>Paolo

-- 
Wei Yang
Help you, Help me

