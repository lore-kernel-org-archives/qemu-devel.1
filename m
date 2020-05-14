Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2198AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAECB20657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZQF/cmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAECB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZI1W-00041u-1U
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 13:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZI0u-0003Zm-NS
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:51:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZI0s-0003Uw-JK
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589478676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qa20nHTJDbAydpwpo44PiiSeQuV5VNwv6uBL6FlPDhc=;
 b=GZQF/cmkUH5r+qaZmVLneEcxIa3Dnha/aSon0c9pf6IsGHwte4YO5PqQJtRNhEOzL31WFv
 FAuQRqHf74bEHRXOWdvXtueUb+FRb5i9a6vvv4ykVUUVt3JRj+PPWN/47H/FK/DRSL8bsH
 DP/D5UWtW+FZJ5JI8rdq6DWUxaHUhto=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-cOCM-jdGP1uOwCUU5qXHFg-1; Thu, 14 May 2020 13:51:15 -0400
X-MC-Unique: cOCM-jdGP1uOwCUU5qXHFg-1
Received: by mail-wr1-f69.google.com with SMTP id p2so1934675wrm.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 10:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qa20nHTJDbAydpwpo44PiiSeQuV5VNwv6uBL6FlPDhc=;
 b=TTjlJVI+WAaBmeQgPqhiyL+lcskFOVwxG6VawumSkqde9QSa8fjzIlTQm4FAlN8Bsi
 FNBM1vmfHqt7LXKOZpEC1oJqQPl3RmTNAvJSvlVMMx1mAa3n+nXV8JlbtA8/YzfWlm2G
 6aAANBo3Ju5ZI/1HnzU6C8WmUHgOXk0Ix8yUb4pyNz9jyO6jkZxExOrrooxJpDGLqqbR
 pniMwV91N4OwsaspmRsrLLR908sBo3siT6fYaLCqlPpzdrqXe6d2mXvobJXShHtHClTf
 7PrH0BLoauXMbk2jhGO3Eodz/l1cP8XCGXu3Q8ZGgQUxrsokdsycXSelgD6RxXL7600j
 Ir/Q==
X-Gm-Message-State: AGi0PuaDd1dVTS7w805znmkMWePUduPOHLfvwQLWRgGGNcVQNKZpdT7x
 PrU8ZaA26y88EU/z27Osj2rafEaIcnCcQFy7mpUxHihS4SgaT0gSya6RQM4paqR80pGhWReCL7O
 6LTzcljt+MmueGH4=
X-Received: by 2002:a1c:bbc5:: with SMTP id
 l188mr29079709wmf.163.1589478673732; 
 Thu, 14 May 2020 10:51:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypJozDXVExZJuu49wNv3EcmH+TwsLU9aIQ1Y+5sQbbc7ak/zOKmmqpW1NWH7beQtyiXm+8ULfw==
X-Received: by 2002:a1c:bbc5:: with SMTP id
 l188mr29079689wmf.163.1589478673430; 
 Thu, 14 May 2020 10:51:13 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w82sm12660026wmg.28.2020.05.14.10.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 10:51:12 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] riscv/boot: Add a missing header include
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair23@gmail.com>
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <dc10c6b220154fd448630ef7a790e5d7e59ab45a.1588878756.git.alistair.francis@wdc.com>
 <CAEUhbmVMu4hov1WxafL9+8kET_Q_Q2hMi8JTnbKE78EhU4kaHQ@mail.gmail.com>
 <CAKmqyKP6khvkjPbYuth3cXgyS6Zed8S29tfwW1Yv_x1MmxG4sw@mail.gmail.com>
 <CAEUhbmWoT0oBszNsY7mPHD+nkY0pOXwN-M0q-AZS45_6p5vG4Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81488a39-a2b0-b9c7-59a6-233052aaa4f6@redhat.com>
Date: Thu, 14 May 2020 19:51:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmWoT0oBszNsY7mPHD+nkY0pOXwN-M0q-AZS45_6p5vG4Q@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:31:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 5:46 PM, Bin Meng wrote:
> On Thu, May 14, 2020 at 11:38 PM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Thu, May 14, 2020 at 8:34 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>
>>> On Fri, May 8, 2020 at 3:24 AM Alistair Francis
>>> <alistair.francis@wdc.com> wrote:
>>>>
>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>> ---
>>>>   include/hw/riscv/boot.h | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
>>>> index 474a940ad5..9daa98da08 100644
>>>> --- a/include/hw/riscv/boot.h
>>>> +++ b/include/hw/riscv/boot.h
>>>> @@ -21,6 +21,7 @@
>>>>   #define RISCV_BOOT_H
>>>>
>>>>   #include "exec/cpu-defs.h"
>>>> +#include "hw/loader.h"
>>>
>>> Why is this needed? Currently this does not break build.
>>
>> Currently every c file that includes boot.h also includes loader.h
>> before it. Which is why the build works fine. We should be able to
>> include just boot.h though so this is a small fixup to allow that.
>>
> 
> I wonder if this is a required convention to make the header file
> self-contained? The only thing that is offending seems to be the
> symbol_fn_t typedef.

Indeed the use of the symbol_fn_t typedef justifies including its 
declaration :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Regards,
> Bin
> 


