Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87425C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C28F2084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiY3axIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C28F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPQQ-0000k1-FV
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPPq-0000Du-Nt
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPPo-0007Cr-Ue
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599040251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HczNTIz00QQw+5LbHTmN3KunGRhURRKATgj8Mo5QUSk=;
 b=GiY3axIYG8qYYb81f1ttMF5qf4vXzC58QVEr8EHL3iuB7yl3j9tQ+htOLoBfzXyFl1Ks7e
 vFuRpFe+vadnbGMxQyWX1MIPCat3XMCC+kn0urdwC5GB6kQt2bFzqOJXPYw7UPDhvAt3ZM
 hA/1zjYexPunz3FKUAPAdGT5+ZCkZeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-m-zpBQrgMYOGKD_gqWFP_g-1; Wed, 02 Sep 2020 05:50:49 -0400
X-MC-Unique: m-zpBQrgMYOGKD_gqWFP_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CBFA8030CB;
 Wed,  2 Sep 2020 09:50:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B2E37EB8D;
 Wed,  2 Sep 2020 09:50:42 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] pc-bios: s390x: Use reset PSW if avaliable
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200831150910.317171-1-frankja@linux.ibm.com>
 <20200831150910.317171-4-frankja@linux.ibm.com>
 <b935f110-d835-e326-d7a9-60d848f970f7@redhat.com>
 <93124d79-ded4-52df-3e06-af580fe9f99a@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cda09743-5d4c-b2e9-7dbd-2595823610d3@redhat.com>
Date: Wed, 2 Sep 2020 11:50:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <93124d79-ded4-52df-3e06-af580fe9f99a@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 02/09/2020 10.46, Janosch Frank wrote:
> On 9/1/20 6:59 PM, Thomas Huth wrote:
>> On 31/08/2020 17.09, Janosch Frank wrote:
>>> If a blob provides a reset PSW then we should use it instead of
>>> branching to the PSW address and using our own mask.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  pc-bios/s390-ccw/bootmap.c  |  3 ++-
>>>  pc-bios/s390-ccw/jump2ipl.c | 22 +++++++++++++++++-----
>>>  pc-bios/s390-ccw/s390-ccw.h |  1 +
>>>  3 files changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>>> index 8747c4ea26..5a03b1eb8b 100644
>>> --- a/pc-bios/s390-ccw/bootmap.c
>>> +++ b/pc-bios/s390-ccw/bootmap.c
>>> @@ -515,7 +515,8 @@ static void zipl_run(ScsiBlockPtr *pte)
>>>      IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
>>>  
>>>      /* should not return */
>>> -    jump_to_IPL_code(entry->compdat.load_psw & PSW_MASK_SHORT_ADDR);
>>> +    write_reset_psw(entry->compdat.load_psw);
>>> +    jump_to_IPL_code(0);
>>>  }
>>>  
>>>  static void ipl_scsi(void)
>>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
>>> index b6aad32def..5b8352d257 100644
>>> --- a/pc-bios/s390-ccw/jump2ipl.c
>>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>>> @@ -12,15 +12,21 @@
>>>  
>>>  #define KERN_IMAGE_START 0x010000UL
>>>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>>> +#define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
>>>  
>>>  static uint64_t *reset_psw = 0, save_psw, ipl_continue;
>>>  
>>> +void write_reset_psw(uint64_t psw)
>>> +{
>>> +    *reset_psw = psw;
>>> +}
>>> +
>>>  static void jump_to_IPL_addr(void)
>>>  {
>>>      __attribute__((noreturn)) void (*ipl)(void) = (void *)ipl_continue;
>>>  
>>>      /* Restore reset PSW */
>>> -    *reset_psw = save_psw;
>>> +    write_reset_psw(save_psw);
>>>  
>>>      ipl();
>>>      /* should not return */
>>> @@ -43,9 +49,10 @@ void jump_to_IPL_code(uint64_t address)
>>>       * content of non-BIOS memory after we loaded the guest, so we
>>>       * save the original content and restore it in jump_to_IPL_2.
>>>       */
>>> -    save_psw = *reset_psw;
>>> -    *reset_psw = (uint64_t) &jump_to_IPL_addr;
>>> -    *reset_psw |= RESET_PSW_MASK;
>>> +    if (address) {
>>> +        save_psw = *reset_psw;
>>> +        write_reset_psw(RESET_PSW);
>>> +    }
>>>      ipl_continue = address;
>>>      debug_print_int("set IPL addr to", ipl_continue);
>>
>> In case you respin this series, I think I'd move the "ipl_continue =
>> address" into the if-statement, too, and change the debug_print_int line
>> to use address instead of ipl_continue.
> 
> Hmm, my intention was to always have something printed.
> But I guess it would make more sense to print the reset psw addr in the
> ~address case.

I meant to only move the "ipl_continue = address" line and keep the
debug_print_int() at its current place (you just have to replace
ipl_continue there). But you're right, it would make more sense to print
the PSW at address 0 in that case instead.

 Thomas


