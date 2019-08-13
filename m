Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6A4C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B9920663
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxrhYy0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B9920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWv3-0001rA-TM
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hxWud-0001QT-3B
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hxWuc-0004ir-0T
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:32:31 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hxWub-0004hg-Nt
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:32:29 -0400
Received: by mail-ed1-x541.google.com with SMTP id a21so4088633edt.11
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c6HzvCIAgR5fibBcG/h82UxfhxNDCHKUGzMXAb/tb+U=;
 b=mxrhYy0WNIrHz2j/pq1y7v/e0xYn6O9kkZb0mnQPuSXh0BNf2xgveS5eEE+EFHRGT6
 KQAYGP8txbNnINKQKr8rh5gm0J23yiHjLJZFE6XSFzdCSX3mTiuc1xM5jerWLytWx6mz
 Ufyi92hA6ISIlSyVuYqaMprTUF77f/Ec/BGbLFOoxIkrJSdx2vjR1iLM0GESkztifu50
 +pXSxecaHBeNlsCD6011YADKNC+0DWEaIUxmQzzq4dAYaw787X4MgSgRSSa4LlYXpGCn
 gdmmt3b+LPElG7IwKE6EjGkmK71W2sEQG1OBOAp89xSp/+xTNlmNpyqg+udnTnRxYI9p
 NhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=c6HzvCIAgR5fibBcG/h82UxfhxNDCHKUGzMXAb/tb+U=;
 b=NzsPguJy5dJBBlxwXVZdQrNRQ0OMTCKMF8oXGxNjlAukNxE6sk5yWRQfo0jq0v02sn
 icKvgIB8A407dhQVyOiaKqt67ikWZagzQ5cLQVEWxWVSjP9W+afMHVn1iD14cG7YuBI3
 c3Cxb4blEC/a5HHUNzzxVTRwP4PUh92XpiDBCb/nStb6agayGe4CHfWmMcI/Ae1TCcx3
 Q+VFT7QVkqRN88FnBsHV8rxR0BZOxfmJrBo51ficA8A5/0/2oLtZj4qxI54BxZjBXIm0
 jkXQj03EePH5NeYZgoZc4EsK9R/MyMmBF6MNOVJei8cjo1ZYQBdQ2WasYFP+FLVYv/8E
 GXUA==
X-Gm-Message-State: APjAAAXzb0wFqsvCK923KidkZPa6sQzlLUPALD8Fae8gwbeh3RVnzvmO
 JqSDG4CLQUqaXLQd0E1HXnxTbmBQ
X-Google-Smtp-Source: APXvYqy8A155AoQ9jj44/A8ES+0GUr9YXbJImmTWoyOruBZ9J8hntcUkj8Vz/RQjhUEd3QXs9O9rvQ==
X-Received: by 2002:aa7:c490:: with SMTP id m16mr42177949edq.156.1565703148500; 
 Tue, 13 Aug 2019 06:32:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id p5sm2919469edr.72.2019.08.13.06.32.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 13 Aug 2019 06:32:27 -0700 (PDT)
Date: Tue, 13 Aug 2019 13:32:27 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190813133227.6xnqw3wdz4rrwgij@master>
References: <20190718010456.4234-1-richardw.yang@linux.intel.com>
 <20190718010456.4234-2-richardw.yang@linux.intel.com>
 <9d456eac-5d7f-570a-b73e-a55f2068579f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d456eac-5d7f-570a-b73e-a55f2068579f@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v3 1/2] bitmap: get last word mask from nr
 directly
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

On Mon, Aug 12, 2019 at 06:18:43PM +0200, Paolo Bonzini wrote:
>On 18/07/19 03:04, Wei Yang wrote:
>> The value left in nr is the number of bits for the last word, which
>> could be calculate the last word mask directly.
>> 
>> Remove the unnecessary size.
>
>Hi,
>
>the value left in nr is _not_ the number of bits for the last word if
>the start and the end are in the same word.  For example, if start %
>BITS_PER_LONG was 3 and nr == 1, you'd have:
>
>- before the patch BITMAP_LAST_WORD_MASK(4)
>
>- after the patch BITMAP_LAST_WORD_MASK(1)
>

You are right. I missed this case.

Thanks for pointing out.

>Paolo
>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> 
>> ---
>> v2: refine bitmap_set_atomic too, suggested from Peter
>> ---
>>  util/bitmap.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>> 
>> diff --git a/util/bitmap.c b/util/bitmap.c
>> index 1753ff7f5b..5b15249796 100644
>> --- a/util/bitmap.c
>> +++ b/util/bitmap.c
>> @@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
>>  void bitmap_set(unsigned long *map, long start, long nr)
>>  {
>>      unsigned long *p = map + BIT_WORD(start);
>> -    const long size = start + nr;
>>      int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>>      unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>>  
>> @@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
>>          p++;
>>      }
>>      if (nr) {
>> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>>          *p |= mask_to_set;
>>      }
>>  }
>> @@ -182,7 +181,6 @@ void bitmap_set(unsigned long *map, long start, long nr)
>>  void bitmap_set_atomic(unsigned long *map, long start, long nr)
>>  {
>>      unsigned long *p = map + BIT_WORD(start);
>> -    const long size = start + nr;
>>      int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>>      unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>>  
>> @@ -208,7 +206,7 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>>  
>>      /* Last word */
>>      if (nr) {
>> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>>          atomic_or(p, mask_to_set);
>>      } else {
>>          /* If we avoided the full barrier in atomic_or(), issue a
>> @@ -221,7 +219,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>>  void bitmap_clear(unsigned long *map, long start, long nr)
>>  {
>>      unsigned long *p = map + BIT_WORD(start);
>> -    const long size = start + nr;
>>      int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>>      unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>>  
>> @@ -235,7 +232,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>>          p++;
>>      }
>>      if (nr) {
>> -        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
>> +        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
>>          *p &= ~mask_to_clear;
>>      }
>>  }
>> 
>

-- 
Wei Yang
Help you, Help me

