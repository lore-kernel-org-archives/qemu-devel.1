Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9624C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7021020768
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+pEMQfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7021020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMe0-0004RS-MJ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jwMdR-00041E-PJ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:26:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jwMdP-0003ns-8O
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594977986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H848LG1lJe2FY4DkEA0BvxO9u4iCpopusTFZAks5/7k=;
 b=I+pEMQfcDIdAYk6/3cp8Hddg8aMABawlPEPu2P/fh9yu7CahPxt13lx4cPd2m9nUyTGy+2
 ltSve6rRhtL0Cb+jUNDaluAK0FN0/Z2z9rhR42Zo8qAe0dOj+6yOd/Dz5Enie8qw+HOFLu
 v6N8xMyqG514zYJ3YgulHZjKnrHpCh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-DKMopBbJNe2nAIHNwaFavg-1; Fri, 17 Jul 2020 05:26:22 -0400
X-MC-Unique: DKMopBbJNe2nAIHNwaFavg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC9FF8015CE;
 Fri, 17 Jul 2020 09:26:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-237.ams2.redhat.com
 [10.36.114.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 994547B439;
 Fri, 17 Jul 2020 09:26:18 +0000 (UTC)
Subject: Re: [PATCH] target/i386: floatx80: avoid compound literals in static
 initializers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200716144251.23004-1-lersek@redhat.com>
 <a38a3da3-7406-0ba3-ca32-e96a99915c97@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <af008780-5207-c156-56f3-dcda95367a5a@redhat.com>
Date: Fri, 17 Jul 2020 11:26:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a38a3da3-7406-0ba3-ca32-e96a99915c97@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 03:33:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/16/20 17:09, Philippe Mathieu-Daudé wrote:
> On 7/16/20 4:42 PM, Laszlo Ersek wrote:
>> Quoting ISO C99 6.7.8p4, "All the expressions in an initializer for an
>> object that has static storage duration shall be constant expressions or
>> string literals".
>>
>> The compound literal produced by the make_floatx80() macro is not such a
>> constant expression, per 6.6p7-9. (An implementation may accept it,
>> according to 6.6p10, but is not required to.)
>>
>> Therefore using "floatx80_zero" and make_floatx80() for initializing
>> "f2xm1_table" and "fpatan_table" is not portable. And gcc-4.8 in RHEL-7.6
>> actually chokes on them:
>>
>>> target/i386/fpu_helper.c:871:5: error: initializer element is not constant
>>>      { make_floatx80(0xbfff, 0x8000000000000000ULL),
>>>      ^
> 
> This reminds me of:
> 
> commit 6fa9ba09dbf4eb8b52bcb47d6820957f1b77ee0b
> Author: Kamil Rytarowski <n54@gmx.com>
> Date:   Mon Sep 4 23:23:06 2017 +0200
> 
>     target/m68k: Switch fpu_rom from make_floatx80() to make_floatx80_init()
> 
>     GCC 4.7.2 on SunOS reports that the values assigned to array members
> are not
>     real constants:
> 
>     target/m68k/fpu_helper.c:32:5: error: initializer element is not
> constant
>     target/m68k/fpu_helper.c:32:5: error: (near initialization for
> 'fpu_rom[0]')
>     rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
> 
>     Convert the array to make_floatx80_init() to fix it.
>     Replace floatx80_pi-like constants with make_floatx80_init() as they are
>     defined as make_floatx80().
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>>
>> We've had the make_floatx80_init() macro for this purpose since commit
>> 3bf7e40ab914 ("softfloat: fix for C99", 2012-03-17), so let's use that
>> macro again.
>>
>> Fixes: eca30647fc07
>> Fixes: ff57bb7b6326
>> Link: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html
>> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04714.html
>> Cc: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Joseph Myers <joseph@codesourcery.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>
>> Notes:
>>     I can see that there are test cases under "tests/tcg/i386", but I don't
>>     know how to run them.
> 
> Yeah it is not easy to figure...
> 
> Try 'make run-tcg-tests-i386-softmmu'
> but you need docker :^)

That worked, thanks! Even without Docker: I just had to add

  --cross-cc-i386=gcc

to my ./configure flags.

Thanks,
Laszlo

> 
> (There is also 'make check-softfloat', listed in 'make check-help')
> 
>>
>>  include/fpu/softfloat.h  |   1 +
>>  target/i386/fpu_helper.c | 426 +++++++++++++++++++--------------------
>>  2 files changed, 214 insertions(+), 213 deletions(-)
>>
>> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
>> index f1a19df066b7..659218b5c787 100644
>> --- a/include/fpu/softfloat.h
>> +++ b/include/fpu/softfloat.h
>> @@ -822,6 +822,7 @@ static inline bool floatx80_invalid_encoding(floatx80 a)
>>  }
>>  
>>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
>> +#define floatx80_zero_init make_floatx80_init(0x0000, 0x0000000000000000LL)
>>  #define floatx80_one make_floatx80(0x3fff, 0x8000000000000000LL)
>>  #define floatx80_ln2 make_floatx80(0x3ffe, 0xb17217f7d1cf79acLL)
>>  #define floatx80_pi make_floatx80(0x4000, 0xc90fdaa22168c235LL)
>> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
>> index f5e6c4b88d4e..4ea73874d836 100644
>> --- a/target/i386/fpu_helper.c
>> +++ b/target/i386/fpu_helper.c
>> @@ -868,201 +868,201 @@ struct f2xm1_data {
>>  };
> ...
> 


