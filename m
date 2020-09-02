Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC85C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2809E207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCDWKYXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2809E207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDW3o-0005gc-CU
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDW3G-0005C0-4Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDW3D-0007rv-Q4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599065758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXJ22/S8A/3kqCg2oMCmPh+Aauizz6p2cCLVF5cd1sc=;
 b=WCDWKYXrO8hJW+QlWH6stzt0m3CEadSYMsBQ8CW6xp4GaVvG+XBDQN8GhqBOkrm9v3rkw2
 Qji9bABEYJUGu3VK5/smgRe8+YStNlSiRkm7kmkw64YEjMYdFugFYvM5BxUn9C95ZCGhk7
 hD42/qbzZcoKBSbHPReOzg/S6+frMVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-EY6r1YzIMmCHBzCgV7UKyQ-1; Wed, 02 Sep 2020 12:55:57 -0400
X-MC-Unique: EY6r1YzIMmCHBzCgV7UKyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F33E801AF5;
 Wed,  2 Sep 2020 16:55:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9FEA5D9D3;
 Wed,  2 Sep 2020 16:55:49 +0000 (UTC)
Subject: Re: [PATCH v3 4/5] pc-bios: s390x: Save io and external new PSWs
 before overwriting them
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200831150910.317171-1-frankja@linux.ibm.com>
 <20200831150910.317171-5-frankja@linux.ibm.com>
 <de13e951-212a-0a16-e50c-ceeed688f655@redhat.com>
 <c35adf44-864f-e74f-4f62-b715f7fee5ef@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <df99495f-9a30-025d-d761-083f47127bf2@redhat.com>
Date: Wed, 2 Sep 2020 18:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c35adf44-864f-e74f-4f62-b715f7fee5ef@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 12.30, Janosch Frank wrote:
> On 9/1/20 7:22 PM, Thomas Huth wrote:
>> On 31/08/2020 17.09, Janosch Frank wrote:
>>> Currently we always overwrite the mentioned exception new PSWs before
>>> loading the enabled wait PSW. Let's save the PSW before overwriting
>>> and restore it right before starting the loaded kernel.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  pc-bios/s390-ccw/jump2ipl.c |  4 +++
>>>  pc-bios/s390-ccw/netmain.c  |  3 ++
>>>  pc-bios/s390-ccw/start.S    | 62 +++++++++++++++++++++++++++----------
>>>  3 files changed, 52 insertions(+), 17 deletions(-)
>>
>> Patch looks basically fine to me, I just got some questions for my
>> understanding below...
>>
>>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
>>> index 5b8352d257..bb94ba7550 100644
>>> --- a/pc-bios/s390-ccw/jump2ipl.c
>>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>>> @@ -14,6 +14,7 @@
>>>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>>>  #define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
>>>  
>>> +extern uint64_t psw_save_io[], psw_save_ext[];
>>>  static uint64_t *reset_psw = 0, save_psw, ipl_continue;
>>>  
>>>  void write_reset_psw(uint64_t psw)
>>> @@ -59,6 +60,9 @@ void jump_to_IPL_code(uint64_t address)
>>>      /* Ensure the guest output starts fresh */
>>>      sclp_print("\n");
>>>  
>>> +    memcpy(&lowcore->io_new_psw, psw_save_io, 16);
>>> +    memcpy(&lowcore->external_new_psw, psw_save_ext, 16);
>>> +
>>>      /*
>>>       * HACK ALERT.
>>>       * We use the load normal reset to keep r15 unchanged. jump_to_IPL_2
>>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>>> index 056e93a818..74ef28fbc6 100644
>>> --- a/pc-bios/s390-ccw/netmain.c
>>> +++ b/pc-bios/s390-ccw/netmain.c
>>> @@ -32,6 +32,7 @@
>>>  #include <time.h>
>>>  #include <pxelinux.h>
>>>  
>>> +#include "s390-arch.h"
>>>  #include "s390-ccw.h"
>>>  #include "cio.h"
>>>  #include "virtio.h"
>>> @@ -43,6 +44,8 @@
>>>  extern char _start[];
>>>  void write_iplb_location(void) {}
>>>  
>>> +LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>>> +
>>>  #define KERNEL_ADDR             ((void *)0L)
>>>  #define KERNEL_MAX_SIZE         ((long)_start)
>>>  #define ARCH_COMMAND_LINE_SIZE  896              /* Taken from Linux kernel */
>>> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
>>> index ce519300a1..939aac3a7c 100644
>>> --- a/pc-bios/s390-ccw/start.S
>>> +++ b/pc-bios/s390-ccw/start.S
>>> @@ -34,7 +34,17 @@ remainder:
>>>  	larl	%r2,memsetxc
>>>  	ex	%r3,0(%r2)
>>>  done:
>>> -	j      main		/* And call C */
>>> +        /* prepare i/o call handler */
>>> +        larl  %r1, io_new_code
>>> +        larl  %r2, io_new_psw
>>> +        stg   %r1, 8(%r2)
>>> +        mvc   0x1f0(16),0(%r2)
>>> +        /* prepare external call handler */
>>> +        larl  %r1, external_new_code
>>> +        larl  %r2, external_new_psw
>>> +        stg   %r1, 8(%r2)
>>
>> Can't you specify the external_new_code and io_new_code in the
>> external_new_psw / io_new_psw directly? Or is our relocation code not
>> good enough for this?
> 
> Initially I had some problems with this. I just had another try and it
> seems to work well, but as the testing infrastructure doesn't really
> work, I can't vouch for that.

You could maybe dump the memory in both cases to see whether
external_new_psw and io_new_psw contain the same values before and after
the change?

>> In case you respin, could you maybe add some local #defines for 0x1f0
>> and 0x1b0 ?
> 
> At the top of this file?

Yes, please.

 Thomas


