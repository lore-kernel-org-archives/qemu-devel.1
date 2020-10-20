Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F24C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CEB2237B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIRGWpEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CEB2237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUlUL-0001pH-GO
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 02:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlTF-00014e-Tf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlTE-0005ne-5K
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603176607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zI61C+/cCdwJiwXyYw7kNQO38ypGGSQinuBf+hm3izw=;
 b=BIRGWpEduzydlXvdKEdroel7AXneDkqs8ylg/1wfc1r6dHiFzc5bAUHyUC8TVRZrpWPnyd
 /0x1qHhUfLGGqUlC0T8xTEk3raYp5X6ik7B9rkY0SF4Ctx34C+D96tiRiD1zY6wGJHAMtn
 Bv1HIAKCKHPCCbS2UFKw7TaaOT81wXk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-ihNBr66nP9eYJpy1mU-IaQ-1; Tue, 20 Oct 2020 02:50:05 -0400
X-MC-Unique: ihNBr66nP9eYJpy1mU-IaQ-1
Received: by mail-wm1-f69.google.com with SMTP id r7so74963wmr.5
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 23:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zI61C+/cCdwJiwXyYw7kNQO38ypGGSQinuBf+hm3izw=;
 b=Gm19OlCgfi3DstUY4Uk3NUu0GLnGapP1BLG9pCWS93OxJHN7CYZoDjuN01QxjW+B5T
 1YAhPi+ELw0Ha3iXv16LLKRakgAzfcKkIsJVKZI7vB94JrDzrlPkQs2G/zeaDR4doML3
 btMQ73HlB50OwrHprN6ARjrb4OkLUtM7E+6ANJwXWF+8GLX0kLRjToKjCU7jbrAjN8s7
 GeTw6ze8Bml1bj/IGTRgObhiTn30DYa/pO9fWQ5NkvyIdySuXht9Hw/SicDjn4HW291r
 K4QgPflfVXpDugAyQjs8zEEIMcRkquUq2xsiRftuFgh1YZSYHRtpRLbEDp30yGL3hUmD
 X1Ng==
X-Gm-Message-State: AOAM531I6IErl5PwoCUZtn7hypHzA1RuC3ShPHlE3rqQI8YUdIZqA+WT
 MTfCMU6z2FY37FlXVsllX8Ex8vnSxrylE6E4GigtHorWFAccDqtdyFdNBhuYMyZfy/5FLDFnpZg
 euDj+03Rq3nRDsrw=
X-Received: by 2002:a1c:1946:: with SMTP id 67mr1218794wmz.15.1603176603813;
 Mon, 19 Oct 2020 23:50:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwd94dY8DMmfdzMWCyQj8/wvS46+MGbTSUYMKG7JzV2+4qytNP26+4rWMZP3TonlrJzKYR2w==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr1218775wmz.15.1603176603575;
 Mon, 19 Oct 2020 23:50:03 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x81sm1180869wmb.11.2020.10.19.23.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 23:50:02 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] migration: Do not initialise statics and globals
 to 0 or NULL
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Bihong Yu <yubihong@huawei.com>
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-7-git-send-email-yubihong@huawei.com>
 <20201014192142.GL2996@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c957f13b-a2f2-3ec6-2906-a96426fdc5c5@redhat.com>
Date: Tue, 20 Oct 2020 08:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014192142.GL2996@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: alex.chen@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, zhengchuan@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:21 PM, Dr. David Alan Gilbert wrote:
> * Bihong Yu (yubihong@huawei.com) wrote:
>> Signed-off-by: Bihong Yu <yubihong@huawei.com>
>> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
> 
> OK, sometimes  I find initialisation clearer
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
>> ---
>>   migration/ram.c    | 2 +-
>>   migration/savevm.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 09178cc..2da2b62 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2743,7 +2743,7 @@ static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
>>    */
>>   static inline RAMBlock *ram_block_from_stream(QEMUFile *f, int flags)
>>   {
>> -    static RAMBlock *block = NULL;
>> +    static RAMBlock *block;

OK.

>>       char id[256];
>>       uint8_t len;
>>   
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 9e95df1..f808bc2 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -64,7 +64,7 @@
>>   #include "qemu/bitmap.h"
>>   #include "net/announce.h"
>>   
>> -const unsigned int postcopy_ram_discard_version = 0;
>> +const unsigned int postcopy_ram_discard_version;

I agree with Dave, this one is clearer initialized.

>>   
>>   /* Subcommands for QEMU_VM_COMMAND */
>>   enum qemu_vm_cmd {
>> -- 
>> 1.8.3.1
>>


