Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA35C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E7B2068E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjhiLHBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E7B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfzC-0006jZ-Jk
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 05:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjfyd-0005dK-Ae
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 05:27:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjfya-0004ZQ-Ns
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 05:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591954070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/0gvwKjXYyuXUi96UBTWcxIAQBaGxOdnPZ29mvjKFc=;
 b=LjhiLHBpm/axEaMZ5QUcNsdDpjGTDdjTXPR9SUTC7dDDBVOJBDXuX7Dl8ecYlpUJTca6qe
 iNV1IIUVWURbajr5fBqHeIV98uMzPDbBaey+Mdd5tUWA2MnwIDN2vUk/tJARAcERfLvDeu
 oRjyu4FO6xcgurw5bbz+Oy8PHHPimuc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-KuctwWQ-PiO7SJOO3Qd7BA-1; Fri, 12 Jun 2020 05:27:39 -0400
X-MC-Unique: KuctwWQ-PiO7SJOO3Qd7BA-1
Received: by mail-wm1-f72.google.com with SMTP id q7so1700965wmj.9
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 02:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x/0gvwKjXYyuXUi96UBTWcxIAQBaGxOdnPZ29mvjKFc=;
 b=pqyL05RGoqAyXpkvWoSbOxy0nB3r1dXMmwCwgnGl1Ih1GwdMjQFTbHFceFCyI3ySv7
 3cgMw6pCwNkxJBhxsVUcPbIj9Ni2vvAQJb2yYq5yK2jCvSgAO99b9FBKDzCRBRfZgR7g
 lYHXV4sIUmkbipew9uBwYuJVeGbTA+wIp3PMlVXSG3rI5JN1Gv/mIA4O7NIbiNZvmFp4
 uAQVFzAj9ZNZMU2Sy3xOB3DwIae/LNyjf0XwTMiDoelOGew/QfnP9AYQU/bvAk4sSmog
 iIt1whZ2l9PU+IUBSdzRc0c4k3XMpYeUSnLcdAYC/Q/+0kSZd50LKEEWW/Zbl6KH2mrR
 GBEQ==
X-Gm-Message-State: AOAM5309f1usJV9fGIgTbT1OWU16F7oSpc7suczDQMOOBBPoky0AUqes
 +rF+h3TYuDFtw4cuhI3uT+lxCXotZpRe1+cmF4xfntMNWxkb/NjP41igWxjXVBmf1fIdWQ2+j68
 qlLeMz79bDlrIONY=
X-Received: by 2002:a1c:6744:: with SMTP id b65mr12333777wmc.170.1591954058123; 
 Fri, 12 Jun 2020 02:27:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1TdB3aObx0TxkjqRsA3kfSJo0pyan9ZuQJmK8siJXSnxD1AHCmUf9T8+ialj2bEgzPj+sQQ==
X-Received: by 2002:a1c:6744:: with SMTP id b65mr12333750wmc.170.1591954057816; 
 Fri, 12 Jun 2020 02:27:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d?
 ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
 by smtp.gmail.com with ESMTPSA id o82sm8119838wmo.40.2020.06.12.02.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 02:27:37 -0700 (PDT)
Subject: Re: [PATCH] kvm: support to get/set dirty log initial-all-set
 capability
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20200304025554.2159-1-jianjay.zhou@huawei.com>
 <18e7b781-8a52-d78a-a653-898445a5ee53@redhat.com>
 <B2D15215269B544CADD246097EACE7474BD26B9F@dggemm508-mbx.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5346f621-6792-21fe-5030-fcf104345813@redhat.com>
Date: Fri, 12 Jun 2020 11:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7474BD26B9F@dggemm508-mbx.china.huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:54:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Liujinsong \(Paul\)" <liu.jinsong@huawei.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>, "Wangxin \(Alexander,
 Cloud Infrastructure Service Product Dept.\)" <wangxinxin.wang@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/20 05:01, Zhoujian (jay) wrote:
> 
> 
>> -----Original Message-----
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> Sent: Wednesday, March 18, 2020 6:48 PM
>> To: Zhoujian (jay) <jianjay.zhou@huawei.com>; qemu-devel@nongnu.org;
>> kvm@vger.kernel.org
>> Cc: mst@redhat.com; cohuck@redhat.com; peterx@redhat.com; wangxin (U)
>> <wangxinxin.wang@huawei.com>; Huangweidong (C)
>> <weidong.huang@huawei.com>; Liujinsong (Paul) <liu.jinsong@huawei.com>
>> Subject: Re: [PATCH] kvm: support to get/set dirty log initial-all-set capability
>>
>> On 04/03/20 03:55, Jay Zhou wrote:
>>> Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
>>> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced in the kernel,
>>> tweak the userspace side to detect and enable this capability.
>>>
>>> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
>>> ---
>>>  accel/kvm/kvm-all.c       | 21 ++++++++++++++-------
>>>  linux-headers/linux/kvm.h |  3 +++
>>>  2 files changed, 17 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>>> 439a4efe52..45ab25be63 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -100,7 +100,7 @@ struct KVMState
>>>      bool kernel_irqchip_required;
>>>      OnOffAuto kernel_irqchip_split;
>>>      bool sync_mmu;
>>> -    bool manual_dirty_log_protect;
>>> +    uint64_t manual_dirty_log_protect;
>>>      /* The man page (and posix) say ioctl numbers are signed int, but
>>>       * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
>>>       * unsigned, and treating them as signed here can break things */
>>> @@ -1882,6 +1882,7 @@ static int kvm_init(MachineState *ms)
>>>      int ret;
>>>      int type = 0;
>>>      const char *kvm_type;
>>> +    uint64_t dirty_log_manual_caps;
>>>
>>>      s = KVM_STATE(ms->accelerator);
>>>
>>> @@ -2007,14 +2008,20 @@ static int kvm_init(MachineState *ms)
>>>      s->coalesced_pio = s->coalesced_mmio &&
>>>                         kvm_check_extension(s,
>> KVM_CAP_COALESCED_PIO);
>>>
>>> -    s->manual_dirty_log_protect =
>>> +    dirty_log_manual_caps =
>>>          kvm_check_extension(s,
>> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
>>> -    if (s->manual_dirty_log_protect) {
>>> -        ret = kvm_vm_enable_cap(s,
>> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0, 1);
>>> +    dirty_log_manual_caps &=
>> (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
>>> +                              KVM_DIRTY_LOG_INITIALLY_SET);
>>> +    s->manual_dirty_log_protect = dirty_log_manual_caps;
>>> +    if (dirty_log_manual_caps) {
>>> +        ret = kvm_vm_enable_cap(s,
>> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0,
>>> +                                   dirty_log_manual_caps);
>>>          if (ret) {
>>> -            warn_report("Trying to enable
>> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 "
>>> -                        "but failed.  Falling back to the legacy mode. ");
>>> -            s->manual_dirty_log_protect = false;
>>> +            warn_report("Trying to enable capability %"PRIu64" of "
>>> +                        "KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2
>> but failed. "
>>> +                        "Falling back to the legacy mode. ",
>>> +                        dirty_log_manual_caps);
>>> +            s->manual_dirty_log_protect = 0;
>>>          }
>>>      }
>>>
>>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>>> index 265099100e..3cb71c2b19 100644
>>> --- a/linux-headers/linux/kvm.h
>>> +++ b/linux-headers/linux/kvm.h
>>> @@ -1628,4 +1628,7 @@ struct kvm_hyperv_eventfd {
>>>  #define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
>>>  #define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
>>>
>>> +#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
>>> +#define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
>>> +
>>>  #endif /* __LINUX_KVM_H */
>>>
>>
>> Queued, thanks.
>>
> 
> Hi Paolo,
> 
> It seems that this patch isn't included in your last pull request...
> If there's something else to be done, please let me know.

Sorry, I thought mistakenly that it was a 5.8 feature (so it would have
to wait for the 5.8-rc1 release and header update).  It's still queued
though.

Paolo


