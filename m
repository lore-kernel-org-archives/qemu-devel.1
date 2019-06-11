Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614BC31E44
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 22:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCF32086D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 22:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHUlxY9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCF32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hap2C-0001N1-O9
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 18:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43554)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hap1I-0000pv-Cs
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 18:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1haoyj-0004Vt-HW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 18:10:54 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1haoyj-0004V0-9L
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 18:10:53 -0400
Received: by mail-ed1-x543.google.com with SMTP id p26so18349674edr.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zAd2fiGqRvSwFElrXovuzCyn22sZ6q3jnT4yrYXEAOA=;
 b=nHUlxY9hAElkjuKnfakHvoFWt76ZCQg7oALyI/Qo9ZUUAP8isjU4qTcnpezf148tJU
 q6GB//jG0l9NfGPtq8qmVPoB7sTG4L4vBtqs2jF1X7MA7poh/MyRqcLz+QwP2x5zxhM/
 o3OCib0i1o8a3ubNX0lAsLrZotL/zkE0zoNNZUfjGnqdE1eTVWQB2+Pg1/KNxEqhK1wV
 u1yPIfgZ+pYNez/ZZVSnGedto+VUWS0sUTwQWg6vhPACku+DfJuly/x4rTm2tYwoS6Gr
 vtR/eGFqS+l8dujuWGMFoFuwfSObq0JC26BvneSlbRle6QP61M2izpc+NNwfxS+GyHYp
 OD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=zAd2fiGqRvSwFElrXovuzCyn22sZ6q3jnT4yrYXEAOA=;
 b=YlOOpPjU7CT9Hnb7xLpxiMb1R8f3JEID2GtnziEjIIceIFZYCNWVx96HKNCKNl+aOz
 KSbXcCBFpKU9ByIlIsFCFiPsItSI5+8r0uiQWNSk8rpXuyoJxAPYZ1ErSN7/HuaoQ7Ol
 CNQkxVVJuJDu5/BuGGSYtjhuENISjBnp7BrGoxjbUzRpiJvX2tpfA51pPCWslVCnEKet
 P9+klUvxzGi7A1VIY/4Gzt7ZEz9gmY83W6vtPSyTWAN9sqjixif5+ZMuCt7dpqxiRPQV
 sC/Lz2dqNebOcqMljARZarFg8Rdn8qtvx/ay6JPQmsP/CGNrdcd9DevK1uygn/Jt4Du9
 Vssg==
X-Gm-Message-State: APjAAAV7sxriNXOwBvRPWzGLlzvo6c8WL/64OI1Px/uaIZhO5v73WToU
 aaQa76lAgiH0b3u4RdAy7u4=
X-Google-Smtp-Source: APXvYqxkNGlCZ7U15L5jXBdXYJ23NWVizgFfPc/6eEDy4NZSL4Hb6zpphuGvMpVVcSZATu1C19/sMw==
X-Received: by 2002:a50:d2d3:: with SMTP id q19mr6638322edg.64.1560291051869; 
 Tue, 11 Jun 2019 15:10:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id k62sm4109830edc.70.2019.06.11.15.10.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Jun 2019 15:10:50 -0700 (PDT)
Date: Tue, 11 Jun 2019 22:10:50 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190611221050.cvhyl2dypkw7d53s@master>
References: <20190610030852.16039-1-richardw.yang@linux.intel.com>
 <20190610030852.16039-2-richardw.yang@linux.intel.com>
 <20190611174954.GI2777@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611174954.GI2777@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 1/2] cutils: remove one unnecessary pointer
 operation
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

On Tue, Jun 11, 2019 at 06:49:54PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> Since we will not operate on the next address pointed by out, it is not
>> necessary to do addition on it.
>> 
>> After removing the operation, the function size reduced 16/18 bytes.
>
>For me with a -O3 it didn't make any difference - the compiler was
>already smart enough to spot it, but it is correct.
>

Ah, you are right.

>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  util/cutils.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 9aacc422ca..1933a68da5 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -754,11 +754,11 @@ int uleb128_encode_small(uint8_t *out, uint32_t n)
>>  {
>>      g_assert(n <= 0x3fff);
>>      if (n < 0x80) {
>> -        *out++ = n;
>> +        *out = n;
>>          return 1;
>>      } else {
>>          *out++ = (n & 0x7f) | 0x80;
>> -        *out++ = n >> 7;
>> +        *out = n >> 7;
>>          return 2;
>>      }
>>  }
>> @@ -766,7 +766,7 @@ int uleb128_encode_small(uint8_t *out, uint32_t n)
>>  int uleb128_decode_small(const uint8_t *in, uint32_t *n)
>>  {
>>      if (!(*in & 0x80)) {
>> -        *n = *in++;
>> +        *n = *in;
>>          return 1;
>>      } else {
>>          *n = *in++ & 0x7f;
>> @@ -774,7 +774,7 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n)
>>          if (*in & 0x80) {
>>              return -1;
>>          }
>> -        *n |= *in++ << 7;
>> +        *n |= *in << 7;
>>          return 2;
>>      }
>>  }
>> -- 
>> 2.19.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

