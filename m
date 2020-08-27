Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BA0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3FE2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpiDuNHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3FE2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBKan-0006zx-Td
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBKaF-0006Zb-Sg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:17:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBKaD-0006w5-Id
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598545020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvjIJZtqLcW4H7zem9wdtUQ/NTkZKhpBp9YluL5XSWs=;
 b=BpiDuNHecm+L70nZEOUJogcIlONlK3tJMXXMJOks//31sxNpekUBba1xQf7DY/nDq1ndAo
 RZEx+mJM4SXJ28edaCCsU0MgKdvMnc6I5ivc+HCyB+0QTq1PUjU0sYTaR/aN1X7BdgJ5IE
 WMoKDINsUXkPdPy+3mBOIts0At9RR3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-_xU0mbSCNgyrN3Bwv0DhnA-1; Thu, 27 Aug 2020 12:16:57 -0400
X-MC-Unique: _xU0mbSCNgyrN3Bwv0DhnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D671DDFF;
 Thu, 27 Aug 2020 16:16:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0D1C10013D0;
 Thu, 27 Aug 2020 16:16:55 +0000 (UTC)
Subject: Re: [PATCH RFC v2 3/4] pc-bios: s390x: Save io and external new PSWs
 before overwriting them
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200827093152.3026-1-frankja@linux.ibm.com>
 <20200827093152.3026-4-frankja@linux.ibm.com>
 <c5190ed1-a4f9-45c3-97b3-4924cff5da31@redhat.com>
 <3428e0f6-43a1-b509-d804-fad083c21cb8@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <741b1d4f-1d01-2ec8-77b7-183e08a56aec@redhat.com>
Date: Thu, 27 Aug 2020 18:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3428e0f6-43a1-b509-d804-fad083c21cb8@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/08/2020 16.30, Janosch Frank wrote:
> On 8/27/20 2:52 PM, Thomas Huth wrote:
>> On 27/08/2020 11.31, Janosch Frank wrote:
>>> Currently we always overwrite the mentioned exception new PSWs before
>>> loading the enabled wait PSW. Let's save the PSW before overwriting
>>> and restore it right before starting the loaded kernel.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>
>>> Maybe we should rather statically allocate a lowcore so we don't dirty
>>> 0x0 at all.
>>>
>>> ---
>>>  pc-bios/s390-ccw/jump2ipl.c |  3 ++
>>>  pc-bios/s390-ccw/start.S    | 62 +++++++++++++++++++++++++++----------
>>>  2 files changed, 48 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
>>> index 143d027bf7..a44f3ab5b3 100644
>>> --- a/pc-bios/s390-ccw/jump2ipl.c
>>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>>> @@ -13,12 +13,15 @@
>>>  #define KERN_IMAGE_START 0x010000UL
>>>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>>>  
>>> +extern uint64_t *psw_save_io, *psw_save_ext;
>>
>> I think that should be
>>
>>  extern uint64_t psw_save_io[], psw_save_ext[];
>>
>> instead ... otherwise you'll end up with some funny bugs here, won't you?
> 
> What kind of bugs are you expecting?

Well, "extern uint64_t var[];" and "extern uint64_t *var;" are two
different kind of things. One is an array, one is a pointer variable.
Looking at your assembler code, you obviously tried to declare an array
there, not a pointer variable.

Have a try with this test program:

 #include <string.h>

 extern unsigned long *var;

 void main(void)
 {
	asm volatile (" nop ; nop ; nop "); /* marker */
	memcpy((void *)0x1f0, var, 16);
	asm volatile (" nop ; nop ; nop "); /* marker */
 }

After compiling that with -O2, and disassembling the corresponding .o
file, I get this code between the nops:

   c:	c4 18 00 00 00 00 	lgrl	%r1,c <main+0xc>
			e: R_390_PC32DBL	var+0x2
  12:	e7 00 10 00 00 06 	vl	%v0,0(%r1)
  18:	e7 00 01 f0 00 0e 	vst	%v0,496

The "lgrl %r1,var" is likely not what you wanted here.

If you now replace the "*var" with "var[]", you get this instead:

   c:	c0 10 00 00 00 00 	larl	%r1,c <main+0xc>
			e: R_390_PC32DBL	var+0x2
  12:	e7 00 10 00 00 06 	vl	%v0,0(%r1)
  18:	e7 00 01 f0 00 0e 	vst	%v0,496

"larl" looks better now, doesn't it?

>>
>>>  uint64_t *reset_psw = 0, save_psw, ipl_continue;
>>>  
>>>  static void jump_to_IPL_2(void)
>>>  {
>>>      /* Restore reset PSW and io and external new PSWs */
>>
>> Ok, now the comment makes sense :-)
>>>      *reset_psw = save_psw;
>>> +    memcpy((void *)0x1f0, psw_save_io, 16);
>>> +    memcpy((void *)0x1b0, psw_save_ext, 16);
>>
>> Could you use &lowcore->external_new_psw and &lowcore->io_new_psw
>> instead of the magic numbers?
> 
> I can, but that means that I need to declare lowcore in netmain.c as
> well as including s390-arch.h

If that does not cause any other big hurdles, I think I'd prefer that
instead of using magic numbers.

 Thanks,
  Thomas


