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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15406C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE66F21849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLfxwBe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE66F21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeL0-0008FZ-63
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeKp-0007qd-LM
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeKo-0003KA-KP
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:38:51 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hoeKo-0003J5-C5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:38:50 -0400
Received: by mail-ed1-x543.google.com with SMTP id p15so35899467eds.8
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6G/0+KXXLfFDkZLwx2cItQ0E4YneyRwbrLbxVCEUIDw=;
 b=NLfxwBe22/iadgYSk7xv0+eAE4oa6fr0iBF0/oTuhLQkPOzu0foaY8xiIeo/nNidmL
 MhHcx0+esxl1PEXCHDNiALFap3wjwt/bSsyIiVYvynXUw9f2fwJUe7mbI03ZAm1ljqfz
 2pScL8hSOn5lA6nENKrG8TdWFxj5X92Opg1hhYZ0lv28f/ZrthMMOYQ54iE7iG6z+mxR
 qjRedDQdzKJB/BqZmTJWW9eEFCu1CeCWwx6oQLjAh0CKalLib0KsTKiCNEucIpAb+gHm
 iAWpBLXqV1TDmGfzno7k1VfZa5ckvb5XuV8++ZWUe+j6VEDHAqVHEIiZZ47O00rlzZeg
 +g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=6G/0+KXXLfFDkZLwx2cItQ0E4YneyRwbrLbxVCEUIDw=;
 b=Ikh9ACI24/v7g4yLk71HadxP3wIW4oIKWXjpC1oWQiGiGYRRiGlaRD2eJoD5US1gYc
 xhEKz2tHleJKMFiadN1oJJWNge0ibqfKmKlWMMtDfyFoDJcT/PsmLCuWku+1f0L++wwh
 CriOV5EipoSDaMEdFzUxSoHPZ8yaSpWiaJPz3iJcILmA8ooMLDY5DDuyWs8UXrNyL2+u
 nATGy8p3WDyAOQ7PUFPUlPyFW0tJ9HJsSR9NNk+S8LAZ3W4jwGL9rc9rtZa1vX3/CS4v
 PuiL36sNhFR8PA6JTxD+1yUy8jWkv2Rg+5//urdX6OWnGmbQ7wrKADXKRs/sUJDg/Avv
 Ct1w==
X-Gm-Message-State: APjAAAWX/1WT+WowtEdhpxK2dgmAvR5uLJK0Ull9EOfKBpcQfOcA3mbp
 IH2WqwOwrh21ktlZO9H5ZwnZcirg
X-Google-Smtp-Source: APXvYqy8q1bUITnGIKqtlUfyzAZdAy+QcpIKt9RINYmIzQE4SHLtlXp6Fbn8gvjefUjENK+wbTc1CA==
X-Received: by 2002:a17:906:8386:: with SMTP id
 p6mr42873545ejx.139.1563586729031; 
 Fri, 19 Jul 2019 18:38:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id z9sm9207440edd.53.2019.07.19.18.38.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jul 2019 18:38:48 -0700 (PDT)
Date: Sat, 20 Jul 2019 01:38:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190720013847.svmol4mlfosf3oy3@master>
References: <20190709140924.13291-1-richardw.yang@linux.intel.com>
 <20190709140924.13291-2-richardw.yang@linux.intel.com>
 <20190719164759.GF3000@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719164759.GF3000@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 1/3] migration/savevm: flush file for
 iterable_only case
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

On Fri, Jul 19, 2019 at 05:47:59PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> It would be proper to flush file even for iterable_only case.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>OK, I don't think this is actually necessary; but it's safe.
>We only really need the flush at the end of the file, and in the
>non-iterable-only case it's not the end of the file.
>
>Since it makes your next change simpler,

Yep, you are so kind.

>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>  migration/savevm.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index c0e557b4c2..becedcc1c6 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1292,7 +1292,7 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
>>      }
>>  
>>      if (iterable_only) {
>> -        return 0;
>> +        goto flush;
>>      }
>>  
>>      vmdesc = qjson_new();
>> @@ -1353,6 +1353,7 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
>>      }
>>      qjson_destroy(vmdesc);
>>  
>> +flush:
>>      qemu_fflush(f);
>>      return 0;
>>  }
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

