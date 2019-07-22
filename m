Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84371C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 00:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E3320828
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 00:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeEuF9gW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E3320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpMDJ-0003qf-CW
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 20:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hpMD8-0003SP-N7
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 20:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hpMD7-00019C-Hq
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 20:29:50 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:46368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hpMD7-00017l-7H
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 20:29:49 -0400
Received: by mail-ed1-x543.google.com with SMTP id d4so39094789edr.13
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2019 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jJwRRGQVF6TwpiTpbzehvCNVUV83Eqvra2kDYU4yAPs=;
 b=FeEuF9gWndSuvnT3+uLTHh57xoQyEptgtLunOsybzpaDb+i8tJypNsE/M2hSGLGxnM
 VzXeBHyQBi7jV+5CVdA7XsxjxrLuQeN9bR+QjuZHSir4l1upeJF1Vmqh9AkUc6+FHj6o
 w6jBg+ROAF8mYi7wEvdviHo+LydLtipmSlHN9B/n9iTNrV/k+U+2FDsDp6RZMF2r4aXx
 dktsdp8uFWoKhrXewPn6n5MMoDtfey0wu7to7upbimUhl4TtLoCojMSxpig/HCIk/jTP
 VIGmdxz8iwFXqSFsqCzfg4JDmGf8TpYck8cyS8nEBNJVGYoTusyC5ZuAK8AyUqLgSotk
 MRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=jJwRRGQVF6TwpiTpbzehvCNVUV83Eqvra2kDYU4yAPs=;
 b=VxqK/qh5Y73OlGyT+sqW6nmbXBbCqWOjJp6eXCirzJJgljxh86Xhzz+XrL0MpmnmQR
 oQMmHoozG7rkh2Vyvs+8h6ttySa/uC2iQr5hZZiXlt1FvD2/dM99LvPEH4YoaiaA1qei
 3EbCbDzbTvbcthlPj4bu1DR0W8JQte6dxVtjB+Pgo6avlSvj30XxzN8w/7dMVJ/GsyhC
 xFD64cGuFzd6C2JrNyWQ91em8/vJiLHSc+GQ58h+Q9m6u4eYsS8BiV5OW3KEqjmQfz6f
 sf7ADcLGCt5ri++M3W209IE17K1EsB6o4+wygXJiVrWBrkm0MzBmNmswOFGUZL543Tvq
 RJXw==
X-Gm-Message-State: APjAAAU7ukv0yX2x+36BHcXJ9ACIqB2J1MNhhyANcKS4XWAxIEou8neM
 a5y5EB4r/++fdf+Nrk4D+S4=
X-Google-Smtp-Source: APXvYqyRiuy9K6a9pBZ2wX15ctreEiXgBBNVykyo4rQ3NeVDi7g96eJVSKJmhl1Qk0vXfMUnzrC3mg==
X-Received: by 2002:a05:6402:6d0:: with SMTP id
 n16mr57228568edy.168.1563755387934; 
 Sun, 21 Jul 2019 17:29:47 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id 43sm10605459edz.87.2019.07.21.17.29.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 21 Jul 2019 17:29:46 -0700 (PDT)
Date: Mon, 22 Jul 2019 00:29:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190722002945.iur4iu4nxployiss@master>
References: <20190718010456.4234-1-richardw.yang@linux.intel.com>
 <20190718010456.4234-2-richardw.yang@linux.intel.com>
 <20190721003316.dosnhlbawuezpryb@master>
 <796ed0ca-ecd7-9f18-71fa-59b94c403cbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796ed0ca-ecd7-9f18-71fa-59b94c403cbc@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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
 qemu-devel@nongnu.org, peterx@redhat.com, Wei Yang <richard.weiyang@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 21, 2019 at 07:27:14PM +0200, Paolo Bonzini wrote:
>On 21/07/19 02:33, Wei Yang wrote:
>> On Thu, Jul 18, 2019 at 09:04:55AM +0800, Wei Yang wrote:
>>> The value left in nr is the number of bits for the last word, which
>>> could be calculate the last word mask directly.
>>>
>>> Remove the unnecessary size.
>>>
>> 
>> May I ask why Patch 2 is picked up, but this one is not?
>
>Tests are always good to have, this cleanup will wait for 4.2 but it's
>in the queue.
>

Thanks :-)

>Paolo
>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>
>>> ---
>>> v2: refine bitmap_set_atomic too, suggested from Peter
>>> ---
>>> util/bitmap.c | 9 +++------
>>> 1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/util/bitmap.c b/util/bitmap.c
>>> index 1753ff7f5b..5b15249796 100644
>>> --- a/util/bitmap.c
>>> +++ b/util/bitmap.c
>>> @@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
>>> void bitmap_set(unsigned long *map, long start, long nr)
>>> {
>>>     unsigned long *p = map + BIT_WORD(start);
>>> -    const long size = start + nr;
>>>     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>>>     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>>>
>>> @@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
>>>         p++;
>>>     }
>>>     if (nr) {
>>> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>>> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>>>         *p |= mask_to_set;
>>>     }
>>> }
>>> @@ -182,7 +181,6 @@ void bitmap_set(unsigned long *map, long start, long nr)
>>> void bitmap_set_atomic(unsigned long *map, long start, long nr)
>>> {
>>>     unsigned long *p = map + BIT_WORD(start);
>>> -    const long size = start + nr;
>>>     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>>>     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>>>
>>> @@ -208,7 +206,7 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>>>
>>>     /* Last word */
>>>     if (nr) {
>>> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>>> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>>>         atomic_or(p, mask_to_set);
>>>     } else {
>>>         /* If we avoided the full barrier in atomic_or(), issue a
>>> @@ -221,7 +219,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>>> void bitmap_clear(unsigned long *map, long start, long nr)
>>> {
>>>     unsigned long *p = map + BIT_WORD(start);
>>> -    const long size = start + nr;
>>>     int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>>>     unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>>>
>>> @@ -235,7 +232,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>>>         p++;
>>>     }
>>>     if (nr) {
>>> -        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
>>> +        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
>>>         *p &= ~mask_to_clear;
>>>     }
>>> }
>>> -- 
>>> 2.17.1
>>>
>> 

-- 
Wei Yang
Help you, Help me

