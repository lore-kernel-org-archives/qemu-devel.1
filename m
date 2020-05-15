Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF32C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2D8206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnI+GsAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2D8206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdPK-0003ls-Sv
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdOT-0002qt-88
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:41:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdOR-00067W-KR
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589560862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0jc6kvrG1qb0t2FDy4CQvHWnlvkF27saPyypDMkG+Y=;
 b=BnI+GsAN4k/A0Ho8WdUT43MIQe0AlshqUUk6G1jpKtIPMwHeWGoKkhQUw/oOKmtOmSMhOQ
 Q91TWKMBFBa8rdbHCxa03DzRSBaVjReGTuBBLNSWFyDlhy5zQcTYQF500AYEZye+RbGttP
 HxdE85AatmZbgfTCWiOFotaXQRrHj2c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-san9x72OMr603LDofE5xIg-1; Fri, 15 May 2020 12:41:00 -0400
X-MC-Unique: san9x72OMr603LDofE5xIg-1
Received: by mail-wm1-f71.google.com with SMTP id 23so1425621wma.8
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 09:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t0jc6kvrG1qb0t2FDy4CQvHWnlvkF27saPyypDMkG+Y=;
 b=rCh/w8pRu9NczMkKj32nbP0eiH/L1GPZ8bteZo0Mde8nKUT5q0D5n+q0QIzl4xgkFg
 dnBh6P9A9nhBIixUxOuYGIy+KOaklQz3ywDW67izpeLnVJIkvmY8CwK6W8pds6wIDKka
 vMI7EsP+Hqm4dvUQK4cRwCMEM6Xii1y202KVvTN0SC25Ocu4ekERfOZXyWhGhG8P0aNm
 WUDqk8HxbJjIumn0gkry/MoglqTZ4KQ7saqV+sWcNrSMYhAmY6G2v5Agt21/NmOfnsqm
 lM4smwM8Q5vTDZz6GGt8Vb3iqyHgPD23QcJN2MQlMkLF6tawotfhfLeKj/g/lYYJNHRJ
 fYeg==
X-Gm-Message-State: AOAM530XxPLeQlrN955nKMh6ed/xKIf8/UnnlS5D8lVaCsxl1cGBcNz3
 uPwoeabbdDZosrBG74BUlfPZLAoL32te6zXtPPBn9SeikJYMTPmk15pf8SmgoudEwYJpzDAq3rS
 ssZnWodzSpKLjLLk=
X-Received: by 2002:a5d:480d:: with SMTP id l13mr5072777wrq.49.1589560859203; 
 Fri, 15 May 2020 09:40:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNmIBc2Ju0ZVqEpGO6fPRBOzdzzjDwF/jtP3DO+PrRlfVV1ukecKIT5RI2DEaK4xYV2j+IkA==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr5072753wrq.49.1589560858962; 
 Fri, 15 May 2020 09:40:58 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n9sm4416453wrv.43.2020.05.15.09.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 09:40:58 -0700 (PDT)
Subject: Re: [PATCH 0/6] tests/fuzz: Review notes
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200514143433.18569-1-philmd@redhat.com>
 <20200515151036.e5h26s65fokygbvr@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d4344cda-4e0a-1e55-b984-4190be2398a5@redhat.com>
Date: Fri, 15 May 2020 18:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515151036.e5h26s65fokygbvr@mozz.bu.edu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 5:10 PM, Alexander Bulekov wrote:
> On 200514 1634, Philippe Mathieu-Daudé wrote:
>> I took some code notes while testing Alex's toy.
>> Sending them as patches.
> 
> Thank you for these! I'd send my review tags, if they weren't already
> pulled.

The series is queued but not pulled. Review tags are always welcome, and 
maintainers might add them after-queue before-pull when they have time.

> 
>> Alex, I had theses issues while building following
>> docs/devel/fuzzing.txt:
>>
>>      CC      nbd/server.o
>>    nbd/server.c:1937:1: error: unused function 'glib_listautoptr_cleanup_NBDExtentArray' [-Werror,-Wunused-function]
>>    G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
>>    ^
>>    /usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>>      static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l) { g_list_free_full (*_l, (GDestroyNotify) func); } \
>>                         ^
>>    /usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro '_GLIB_AUTOPTR_LIST_FUNC_NAME'
>>    #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) glib_listautoptr_cleanup_##TypeName
>>                                                   ^
>> Solved by using './configure ... --extra-cflags=-Wno-unused-function'
> 
> Interesting that this doesn't show up for standard builds. I'll have to
> look into this more.

I don't think it is related to your work.

> 
>>      LINK    i386-softmmu/qemu-fuzz-i386
>>    /usr/lib64/clang/9.0.1/lib/linux/libclang_rt.asan-aarch64.a(asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfork' overridden by definition
>>    /usr/lib64/clang/9.0.1/lib/linux/libclang_rt.asan-aarch64.a(asan_interceptors.cc.o): warning: defined here
>>
>> I simply ignore this warning.
> 
> Yes, I get the same warning with this:
> 
> cat << EOF | clang-9 -Wl,--warn-common  -fsanitize=fuzzer,address -x c -
> #include <sys/types.h>
> #include <stdint.h>
> int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0; }
> EOF
> 
> Might report this to the LLVM/compiler-rt folks.
> 
>> Alex, could you provide few more examples (in particular about
>> instantiating devices, or useful libfuzzer arguments)?
> 
> Yes - I'll send this out with my next fuzzing patches.
> 
>> Also, I suppose you are using a script to generate the bug reports:
>>
>>    I can reproduce it in qemu 5.0 using:
>>
>>    cat << EOF | qemu-system ...
>>    outl 0xcf8 ...
>>    outl 0xcfc ...
>>    ...
>>    EOF
>>
>> Is this script available in the QEMU repository? I couldn't find it.
> 
> Right now I just added some unbuffered writes to qtest.c. I'll try to
> find a clean way of doing this and I'll add a way to automatically
> convert a crashing input to qemu arguments + qtest command sequence.
> 
> Thanks again!

You are welcomed, waiting for your following series :)

> -Alex
> 
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (6):
>>    tests/fuzz/Makefile: Do not link code using unavailable devices
>>    Makefile: List fuzz targets in 'make help'
>>    tests/fuzz: Add missing space in test description
>>    tests/fuzz: Remove unuseful/unused typedefs
>>    tests/fuzz: Extract pciconfig_fuzz_qos() method
>>    tests/fuzz: Extract ioport_fuzz_qtest() method
>>
>>   Makefile                          |  6 +++-
>>   tests/qtest/fuzz/i440fx_fuzz.c    | 47 ++++++++++++++++++++-----------
>>   tests/qtest/fuzz/Makefile.include |  6 ++--
>>   3 files changed, 38 insertions(+), 21 deletions(-)
>>
>> -- 
>> 2.21.3
>>
> 


